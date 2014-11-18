From: Jason Woodward <woodwardj@jaos.org>
Subject: [PATCH/RFC] Add contrib Clearcase Base import utility
Date: Mon, 17 Nov 2014 23:15:14 -0500
Message-ID: <1416284114-9111-1-git-send-email-woodwardj@jaos.org>
Cc: Jason Woodward <woodwardj@jaos.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 18 05:20:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqaHX-000869-V8
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 05:20:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953AbaKREUo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 23:20:44 -0500
Received: from 75-146-71-113-Pennsylvania.hfc.comcastbusiness.net ([75.146.71.113]:47932
	"EHLO jaos.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751499AbaKREUm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 23:20:42 -0500
X-Greylist: delayed 319 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Nov 2014 23:20:42 EST
Received: from jaosbookpro.jaos.hub (jaosbookpro.jaos.hub [10.1.1.139])
	by jaos.org (8.14.4/8.14.4/Debian-4) with ESMTP id sAI4FGmh000698;
	Mon, 17 Nov 2014 23:15:17 -0500
X-Mailer: git-send-email 2.1.3
X-Scanned-By: MIMEDefang 2.71 on 10.1.1.69
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a simple perl script that dumps the history of a Base Clearcase
VOB and then walks this history retrieving the file contents, version, and
branch information.  Equivalent git commits are created from the Clearcase
history via git-fast-import(1).

This does not support Clearcase UCM.

Signed-off-by: Jason Woodward <woodwardj@jaos.org>
---
 contrib/cc-base-import/cc-base-import     | 579 ++++++++++++++++++++++++++++++
 contrib/cc-base-import/cc-base-import.txt | 111 ++++++
 2 files changed, 690 insertions(+)
 create mode 100755 contrib/cc-base-import/cc-base-import
 create mode 100644 contrib/cc-base-import/cc-base-import.txt

diff --git a/contrib/cc-base-import/cc-base-import b/contrib/cc-base-import/cc-base-import
new file mode 100755
index 0000000..4a89703
--- /dev/null
+++ b/contrib/cc-base-import/cc-base-import
@@ -0,0 +1,579 @@
+#!/usr/bin/perl
+use strict;
+use warnings;
+use POSIX qw/mktime/;
+use File::Spec qw/splitdir catdir join splitpath curdir rel2abs/;
+use IPC::Open3 qw/open3/;
+use Getopt::Long qw/GetOptions/;
+
+=head1 NAME
+
+cc-base-import - Import a ClearCase VOB into git
+
+=head1 SYNOPSIS
+
+cc-base-import [command] [option(s)]
+
+commands: init --vob <path> | fetch | commit
+
+options: [--verbose | --savetemps]
+
+example:
+
+ $ mkdir /tmp/project
+ $ cd /tmp/project
+ $ git cc-base-import init --vob /view/view_main/vobs/vob1 --verbose
+Initialized empty Git repository in /tmp/project/.git/
+ $ git cc-base-import fetch --verbose
+Fetching clearcase events
+ $ git cc-base-import commit
+... [generates git commits from clearcase events]
+ $ git checkout master
+ $ ls
+...
+
+=head1 DESCRIPTION
+
+This utility walks the history of a ClearCase VOB creating equivalent commits
+in git.  Branch names, commit messages, and author information is preserved.
+
+The only requirement is the B<cleartool> utility must be present in the current
+PATH.
+
+B<NOTE> this does not work with ClearCase UCM, only base ClearCase.
+
+
+=head2 Error Handling
+
+Certain data loss messages are currently ignored, such as the following:
+
+  cleartool: Error: Operation "file copy" failed: No such device or address.
+
+This implies that for some reason a version of the file in question is not available.
+This is ignored in hopes that a later version is available from Clearcase.
+
+Other errors are not, such as:
+
+  cleartool: Error: Operation "file copy" failed: Input/output error.
+
+This error implies some underlying issue such as MVFS communication errors.
+
+  cleartool: Error: Operation "get cleartext" failed: not a ClearCase object.
+
+This error indicates a file was deleted during a long running import.
+
+=head2 Deficiencies
+
+There is no attempt to handle tracking branch renames in clearcase.
+
+File deletions are also not handled.  Some info can be gleamed from the directory
+history but that information is not enforced and can be overridden.  This is
+also true for file moves.
+
+A suggested strategy is to run the conversion and enforce no file moves,
+deletions, or branch renames during a set window.
+
+Merge arrows and related clearcase meta data are not preserved in the conversion,
+only the file contents.
+
+Labels are not yet accounted for.  Since labels do not represent an atomic operation
+in clearcase, there is not a general way to represent a git tag as a clearcase label.
+
+=head1 COMMANDS
+
+=head2 init --vob <path>
+
+Initialize the current working directory as a git repository and setup the
+configuration for the B<VOB> to be imported.  The results of this are a .git
+directory within the current working directory.
+
+=head2 fetch
+
+Retrieve the clearcase history for the previously configured B<VOB>.  The first
+time this is run, the entire history is logged using the following clearcase
+format (cleartool man fmt_ccase):
+
+%o%m#1#%Nd#1#%Fu <%u>#1#%En#1#%Vn#1#%[slink_text]p#1#%Nc\n
+
+  %o  | Operation kind (checkin, lock, mkelem, and so on)
+  %m  | Object kind (version, derived object, and so on)
+      | (modifiers: K)
+  %Nd | (Numeric) Date and time in numeric form -- yyyymmdd.time
+      | (time reported in 24-hour format).
+  %Fu | Full name of the user. This information is taken from
+      | the password database.
+  %u  | User/group information associated with the object's
+      | creation event (modifiers: F, G, L); see also %[owner]p and
+      | %[group]p.
+  %En | Element name: For a file system object, its standard file
+      | or element name, or its path name; for a type object, its
+      | name.
+  %Vn | Version ID: For a version or derived object, the version
+      | ID; for other objects, the null string.
+  %Nc | comment string. No newline. Do not append a newline character to
+      | the comment string.
+ %[slink_text]p | VOB symbolic links | Target of symbolic link, as
+                |                    | displayed by cleartool ls.
+
+Subsequent runs only pull in the changes since the last run.
+
+=head2 commit
+
+This generates git commits from the clearcase event history fetched via the
+B<fetch> command.
+
+=head1 OPTIONS
+
+=head2 --vob <path>
+
+Specify the path to the B<VOB>.
+
+=head2 --verbose
+
+Emit extra and informational messages during normal operation.
+
+=head2 --savetemps
+
+Do not discard temporary files during the import.
+
+=head1 AUTHOR
+
+Jason Woodward <woodwardj@jaos.org>
+
+=cut
+
+sub usage
+{
+print "Usage:
+  cc-base-import [command] [option(s)]
+
+  commands: init --vob <path> | fetch | commit
+
+  options: [--verbose | --savetemps]
+\n";
+}
+
+sub cc_time_to_epoch
+{
+	my ($date) = @_;
+	my ($year,$mon,$day,$dot,$hour,$min,$sec) = unpack ("A4A2A2aA2A2A2", $date);
+	return mktime ($sec, $min, $hour, $day, $mon - 1, $year - 1900);
+}
+
+
+sub _increment_by_one_second
+{
+	my ($t) = @_;
+	if ($t && $t =~ m/.*?([0-9][0-9])$/) {
+		my $sec = $1;
+		$sec++;
+		$t =~ s/$1$/$sec/;
+	}
+	return $t;
+}
+
+sub gen_cc_history_journal
+{
+	my ($config) = @_;
+
+	lockme ($config);
+
+	chdir ($config->{vob});
+
+	my $redir_opt = '>';
+	# caching, use last commit time
+	my $last_commit_ftimetstamp = $config->{last_commit_ftimestamp};
+	# try to only fetch what we haven't already
+	if ( -e $config->{journal_file}) {
+		my $data;
+		open (my $fh, '<', $config->{journal_file}) or die "Failed to open $config->{journal_file}: $!";
+		seek ($fh, -512, 2);  # seek to the end
+		read $fh, $data, 512; # read a chunk
+		close ($fh);
+		my @timestamps = ($data =~ m/#([0-9]+\.[0-9]+)#/gs); # extract timestamps
+		if ($timestamps[-1]) { # use the last one... this way we optimize our fetch time
+			($last_commit_ftimetstamp = $timestamps[-1]) =~ s/\./T/;
+			$redir_opt = '>>';
+		}
+	}
+
+	$last_commit_ftimetstamp = _increment_by_one_second($last_commit_ftimetstamp);
+
+	my $since_opt = $last_commit_ftimetstamp ? "-since $last_commit_ftimetstamp" : '';
+	print "Fetching clearcase events", $since_opt ? " since $last_commit_ftimetstamp" : ''," (this may take a while)...\n";
+	$@ = undef;
+	eval {
+		my $fmt = '%o%m#1#%Nd#1#%Fu <%u>#1#%En#1#%Vn#1#%[slink_text]p\\n';
+		execcmd ( "cleartool lsh -fmt '$fmt' -recurse $since_opt $config->{vob} | perl -e 'print reverse <>' $redir_opt $config->{journal_file}" );
+	};
+	if ($@) {
+		chdir ($config->{dest});
+		die "$@";
+	}
+
+	execcmd ("echo \$(wc -l $config->{journal_file}) events logged");
+
+	chdir ($config->{dest});
+	unlockme ($config);
+}
+
+
+sub execcmd
+{
+	my $opts;
+	# options hashref passed at the end
+	if (ref $_[-1] eq 'HASH') {
+		$opts = pop;
+	}
+
+	my ($w, $r, $e); # write fd, read fd, and err fd
+	my $pid = open3($w, $r, $e, @_);
+	waitpid ($pid, 0);
+	my $exit_status = $? >> 8; # get child exit status
+	my $output;
+	read ($e ? $e : $r, $output, 512); # cleartool writes errors to stdout instead of stderr
+
+	unless ($opts->{nooutput}) {
+		print $output;
+	}
+	if (exists $opts->{saveout} ) { # pass back output if we need it captured
+		${$opts->{saveout}} = $output;
+	}
+
+	if ($exit_status != 0) {
+		die "$output"; # raise
+	}
+	return $exit_status;
+}
+
+sub commit
+{
+	my ($config, $commit, $fds) = @_;
+
+	# full paths
+	my $dest      = "dest_tmp.$$";
+	my $src       = File::Spec->join ($config->{vob}, $commit->{file});
+	my $src_ver   = $src . '@@' . $commit->{ver}; # XXX portability?  Does windows expose file@@version?
+
+	my $mode      = '100644';  # normal file, see git-fast-import(1)
+	my $branch    = $commit->{branch} || 'master';
+
+	# duplex if necessary
+	my $_printf = sub {
+		my ($fds, $format, @args) = @_;
+		for my $fd (@$fds) {
+			printf $fd $format, @args;
+		}
+	};
+
+	$@ = undef;
+	eval {
+		execcmd ( "cleartool get -to '$dest' \"$src_ver\"" ) if $commit->{event} !~ m/mkslinksymbolic/;
+	};
+	if ($@) { # catch
+		unlink $dest if ( -e $dest );
+		if ($@ =~ m/cleartool: .*No such device or address/) {
+			warn "*** ignoring missing clearcase data" if $config->{verbose};
+			return;
+		}
+		unlockme ($config);
+		die "UNHANDLED: $@\n$commit->{rawline}\n"; # raise
+	}
+
+	# here we generate the git fast-export format
+	$config->{mark}++;
+	$_printf->($fds, "blob\n");
+	$_printf->($fds, "mark :%d\n", $config->{mark}++);
+
+	# file data
+	if ($commit->{event} =~ m/mkslinksymbolic/) {
+		$mode = '120000'; # git symlink mode, see git-fast-import(1)
+		$_printf->($fds, "data %d\n", length $commit->{symlink});
+		$_printf->($fds, "%s\n", $commit->{symlink});
+		$branch = $config->{last_branch}; # symlinks do not have branch entries in clearcase, reuse prior branch
+	} else {
+		$mode = '100755' if ( -x $dest ); # git executable, see git-fast-import(1)
+		my $data_size = (stat $dest)[7];
+		$_printf->($fds, "data %d\n", $data_size);
+		{ open (my $fh, '<', $dest) or die $!; $_printf->($fds, "%s", $_) while (<$fh>); close($fh); $_printf->($fds,"\n"); }
+		unlink $dest if ( -e $dest );
+	}
+
+	# commit info
+	$_printf->($fds, "progress %s: %s @@ %s\n", $commit->{date}, $commit->{file}, $commit->{ver});
+	$_printf->($fds, "commit refs/heads/%s\n", $branch);
+	$_printf->($fds, "mark :%d\n", $config->{mark});
+	$_printf->($fds, "author %s %d -0500\n", $commit->{user}, cc_time_to_epoch($commit->{date}));
+	$_printf->($fds, "committer %s %d -0500\n", $commit->{user}, cc_time_to_epoch($commit->{date}));
+
+	# commit message
+	my $msg;
+	execcmd( "cleartool desc -fmt '%Nc' \"$src_ver\"", { nooutput => 1, saveout=> \$msg } );
+	if ($msg) {
+		my $msg_size = length $msg;
+		$_printf->($fds, "data %d\n", $msg_size);
+		$_printf->($fds, "%s\n", $msg);
+	} else {
+		$_printf->($fds, "data 0\n");
+	}
+
+	# parent commit
+	my $from_mark = $config->{branch_marks}->{$branch};
+	if ($from_mark) {
+		$_printf->($fds, "from :%d\n", $from_mark);
+	} else { # ask git if we have an existing sha1 for this branch to parent our commit on
+		undef $@;
+		eval {
+			my $from_ref;
+			execcmd ("git show-ref -s $branch", { nooutput => 1, saveout => \$from_ref } );
+			chomp $from_ref;
+			$from_ref =~ s/\n.*//ms; # in case we get multiple lines
+			$_printf->($fds, "from %s\n", $from_ref);
+		};
+		if ($@) {
+			# if we have gotten here, we don't know where to parent from a previous branch
+			# which means this must be the first commit of the branch.  We need to set
+			# from to be the tip of master
+			if ($branch ne 'master') {
+				my $master_mark = $config->{branch_marks}->{master};
+				if ($master_mark) {
+					$_printf->($fds, "from :%d\n", $master_mark);
+				} else {
+					undef $@;
+					eval {
+						my $from_ref;
+						execcmd ("git show-ref -s master", { nooutput => 1, saveout => \$from_ref } );
+						chomp $from_ref;
+						$from_ref =~ s/\n.*//ms; # in case we get multiple lines
+						$_printf->($fds, "from %s\n", $from_ref);
+					};
+				}
+			}
+		}
+	}
+	# final stanza
+	$_printf->($fds, "M %d :%d %s\n\n", $mode, $config->{mark}-1, $commit->{file});
+
+	# store our "mark" counter for parent reference of future commits in the current branch
+	$config->{branch_marks}->{$branch} = $config->{mark};
+	# store this for symlink entries
+	$config->{last_branch} = $branch;
+
+	log_last_event ($config, $commit->{date});
+}
+
+sub walk_journal
+{
+	my ($config) = @_;
+
+	open (my $journal,'<', $config->{journal_file}) or die "Nothing to commit. Try running fetch.\n";
+
+	my $journal_loc;
+	if ( -e $config->{journal_file_loc} ) {
+		open( $journal_loc, '+<', $config->{journal_file_loc}) or die $!; # r/w
+		read $journal_loc, my $seek, 64;
+		seek $journal, $seek, 0 if $seek;
+	} else {
+		open( $journal_loc, '>', $config->{journal_file_loc}) or die $!; # create if necessary
+	}
+	select((select($journal_loc), $|=1)[0]); # unbuffered
+
+	lockme ($config);
+
+	# open a git fast-import pipe
+	my @fds;
+	open ($fds[0], '| git fast-import --quiet') or die $!;
+	select((select($fds[0]), $|=1)[0]); # unbuffered
+	if ($config->{savetemps}) {
+		# store what we write to the pipe in a local cache file
+		warn "*** Saving fast-import data to $config->{fast_import}\n" if $config->{verbose};
+		open ($fds[1], '>>', $config->{fast_import}) or die $!;
+		select((select($fds[1]), $|=1)[0]); # unbuffered
+	}
+
+	while (my $line = <$journal>) {
+		chomp $line;
+		next if $line =~ m/^\s*$/;
+		$line =~ s/\015//;
+
+		my $commit = {};
+		@{$commit}{ qw/event date user file ver symlink/ } = split '#1#', $line;
+
+		# only want specific events
+		if (!grep { m/^(?:(checkinversion|mkslinksymbolic|checkinderived))/; } ($commit->{event})) {
+			log_last_event ($config, $commit->{date});
+			warn "*** Discarding event $commit->{event}\n" if $config->{verbose};
+			next;
+		}
+
+		# forget about lost+found
+		if ($commit->{file} =~ m/lost\+found/) {
+			warn "*** Discarding lost+found file: $commit->{file}\n" if $config->{verbose};
+			next;
+		}
+
+		# branch logic
+		if ($commit->{event} =~ m/checkinversion/) { # no version on symlink entry
+			if ($commit->{ver} =~ m/\/main\/(.*?)\/[0-9]$/) {
+				$commit->{branch} = $1; # store the branch
+			}
+		}
+
+		# cleanup
+		$commit->{formatted_date} = cc_time_to_epoch ($commit->{date});
+		#$commit->{file} =~ s|\$|\\\$|g;
+		$commit->{file} =~ s|\`|\\\`|g; # ` unwanted in file name
+		$commit->{file} =~ s|$config->{vob}/*||;
+		$commit->{rawline} = $line;
+
+		commit ($config, $commit, \@fds);
+		seek $journal_loc, 0, 0;
+		print $journal_loc tell $journal;
+
+	}
+
+	# setup HEAD
+	if ($config->{mark} > 0) {
+		my $head_from;
+		if ($config->{branch_marks}->{'master'}) {
+			$head_from = sprintf ("from :%d\n\n", $config->{branch_marks}->{'master'});
+		} else { # load master ref
+			my $from_ref;
+			execcmd ("git show-ref -s master", { nooutput => 1, saveout => \$from_ref } );
+			chomp $from_ref;
+			$from_ref =~ s/\n.*//ms; # in case we get multiple lines
+			$head_from = sprintf ("from %s\n\n", $from_ref);
+		}
+		for my $fd (@fds) {
+			printf $fd "reset refs/heads/master\n";
+			printf $fd $head_from;
+		}
+	}
+
+	close ($journal);
+	close ($journal_loc);
+	close ($fds[0]);
+	close ($fds[1]) if $fds[1];
+	unlink ($config->{journal_file}) unless $config->{savetemps};
+	unlink ($config->{journal_file_loc}) unless $config->{savetemps};
+	unlockme ($config);
+}
+
+# we store the timestamp of the last clearcase event so later we can use "-since"
+sub log_last_event
+{
+	my ($config, $timestamp) = @_;
+	return if !$timestamp;
+
+	open (my $logfh, '>', $config->{last_commit_file}) or die "Failed to open $config->{last_commit_file} or writing: $!";
+	print $logfh $timestamp;
+	close ($logfh);
+}
+
+sub cc_base_import_init
+{
+	my ($config) = @_;
+
+	if (!$config->{vob}) {
+		printf "You must specify --vob with init\n";
+		exit (-1);
+	}
+
+	if ( -d '.git' ) {
+		die "This directory already has a .git subdirectory!\n";
+	}
+
+	execcmd ('git init');
+
+	my $config_file = File::Spec->join ($config->{dest}, '.git', 'cc-base-import.config');
+	open (my $config_fh, '>', $config_file) or die "Failed to write $config_file: $!";
+	print $config_fh $config->{vob};
+	close ($config_fh);
+
+}
+
+sub lockme   { my $config = shift; mkdir $config->{lock_file} or die "Process already running"; }
+sub unlockme { my $config = shift; rmdir $config->{lock_file} or die "Unable to remove lock directory"; }
+
+sub load_config
+{
+	my ($config) = @_;
+	my $f;
+	my $err = "Unable to read configuration, perhaps you want to run 'init' first?\n";
+
+	$config->{git_dir}          = File::Spec->catdir ($config->{dest},  '.git');
+	$config->{last_commit_file} = File::Spec->join ($config->{git_dir}, 'cc-base-import.last-commit-time');
+	$config->{journal_file}     = File::Spec->join ($config->{git_dir}, 'cc-base-import.journal');
+	$config->{journal_file_loc} = File::Spec->join ($config->{git_dir}, 'cc-base-import.journal.location');
+	$config->{config_file}      = File::Spec->join ($config->{git_dir}, 'cc-base-import.config');
+	$config->{lock_file}        = File::Spec->join ($config->{git_dir}, 'cc-base-import.lock');
+	$config->{fast_import}      = File::Spec->join ($config->{git_dir}, 'cc-base-import.fast-import');
+
+	if ( ! -d '.git' && ! -e $config->{config_file}) {
+		printf $err; exit (-1);
+	}
+
+	open ($f, '<', $config->{config_file}) or die "Failed to open $config->{config_file}: $!";
+	read $f, $config->{vob}, 4096;
+	close ($f);
+
+	if (!$config->{vob}) {
+		printf $err; exit (-1);
+	}
+
+	chomp $config->{vob};
+
+	if ( -e $config->{last_commit_file} ) {
+		open ($f, '<', $config->{last_commit_file}) or die "Failed to open $config->{last_commit_file}: $!";
+		read $f, $config->{last_commit_timestamp}, 4096;
+		close ($f);
+		chomp $config->{last_commit_timestamp};
+		($config->{last_commit_ftimestamp} = $config->{last_commit_timestamp}) =~ s/\./T/g;
+	}
+
+}
+
+
+# The main meat of this utility... parse the arguments and dispatch
+
+my $config = {
+	'dest'        => File::Spec->rel2abs ( File::Spec->curdir () ),
+	'mark'        => 0,
+	'branch_mark' => {},
+};
+my $command = shift;
+my $result = GetOptions (
+	"vob=s" => \$config->{vob},
+	"verbose" => \$config->{verbose},
+	"savetemps" => \$config->{savetemps},
+);
+if (!$result || !$command) {
+	usage ();
+	exit (-1);
+}
+
+my $commands = {
+	'init'    => sub {
+		cc_base_import_init ($config);
+	},
+	'fetch'  => sub {
+		load_config ($config);
+		gen_cc_history_journal ($config);
+	},
+	'commit'  => sub {
+		load_config ($config);
+		walk_journal ($config);
+	},
+	'unlock'  => sub {
+		load_config ($config);
+		unlockme ($config);
+	},
+};
+
+if (! exists $commands->{$command} ) {
+	usage ();
+	exit (-1);
+}
+$SIG{INT} = sub { unlockme ($config); exit (-1); };
+$commands->{$command}->();
+
diff --git a/contrib/cc-base-import/cc-base-import.txt b/contrib/cc-base-import/cc-base-import.txt
new file mode 100644
index 0000000..0d83889
--- /dev/null
+++ b/contrib/cc-base-import/cc-base-import.txt
@@ -0,0 +1,111 @@
+cc-base-import(1)
+=================
+
+NAME
+----
+cc-base-import - Import a ClearCase VOB into git
+
+SYNOPSIS
+--------
+[verse]
+cc-base-import [command] [option(s)]
+
+commands: init --vob <path> | fetch | commit
+
+options: [--verbose | --savetemps]
+
+example:
+
+[verse]
+$ mkdir /tmp/project
+$ cd /tmp/project
+$ git cc-base-import init --vob /view/view_main/vobs/vob1 --verbose
+Initialized empty Git repository in /tmp/project/.git/
+$ git cc-base-import fetch --verbose
+Fetching clearcase events
+$ git cc-base-import commit
+... [generates git commits from clearcase events]
+ $ git checkout master
+ $ ls
+...
+
+DESCRIPTION
+-----------
+
+This utility walks the history of a ClearCase VOB creating equivalent
+commits in git. Branch names, commit messages, and author information is
+preserved.
+
+The only requirement is the cleartool utility must be present in the
+current PATH.
+
+*NOTE* this does not work with ClearCase UCM, only base ClearCase.
+
+Error Handling
+~~~~~~~~~~~~~~
+Certain data loss messages are currently ignored, such as the following:
+
+'cleartool: Error: Operation "file copy" failed: No such device or address.'
+
+Other errors are not, such as:
+
+'cleartool: Error: Operation "file copy" failed: Input/output error.'
+
+Deficiencies
+~~~~~~~~~~~~
+
+There is no attempt to handle tracking branch renames in clearcase.
+
+File deletions are also not handled.  Some info can be gleamed from the directory
+history but that information is not enforced and can be overridden.  This is
+also true for file moves.
+
+A suggested strategy is to run the conversion and enforce no file moves,
+deletions, or branch renames during a set window.
+
+Merge arrows and related clearcase meta data are not preserved in the conversion,
+only the file contents.
+
+Labels are not yet accounted for.  Since labels do not represent an atomic operation
+in clearcase, there is not a general way to represent a git tag as a clearcase label.
+
+COMMANDS
+--------
+
+init --vob <path>
+~~~~~~~~~~~~~~~~~
+
+Initialize the current working directory as a git repository and setup
+the configuration for the VOB to be imported. The results of this are a
+.git directory within the current working directory.
+
+fetch
+~~~~~
+
+Retrieve the clearcase history for the previously configured VOB. The
+first time this is run, the entire history is logged.
+
+commit
+~~~~~~
+
+This generates git commits from the clearcase event history fetched via
+the fetch command.
+
+OPTIONS
+-------
+--vob:: <path>
+  Specify the path to the VOB.
+
+--verbose::
+  Emit extra and informational messages during normal operation.
+
+--savetemps::
+  Do not discard temporary files during the import.
+
+AUTHOR
+------
+Jason Woodward <woodwardj@jaos.org>
+
+GIT
+---
+Part of the linkgit:git[1] suite
-- 
2.1.3
