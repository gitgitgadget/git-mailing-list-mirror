From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] Initial import of git-archimport-script
Date: Tue, 30 Aug 2005 21:56:52 +1200
Message-ID: <1125395812179-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Tue Aug 30 11:57:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EA2ry-0007Jd-0K
	for gcvg-git@gmane.org; Tue, 30 Aug 2005 11:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbVH3J47 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Aug 2005 05:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbVH3J47
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Aug 2005 05:56:59 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7]:49344 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750868AbVH3J46 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2005 05:56:58 -0400
Received: from aporo-debian (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (Postfix) with SMTP id 44D0F8AAC3;
	Tue, 30 Aug 2005 21:56:52 +1200 (NZST)
In-Reply-To: 
X-Mailer: git-send-email-script
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7952>

Imports a project history from one or more Arch repositories, following
the branching and tagging across repositories. Note you should import 
separate projects to separate GIT repositories.

Supported
 - Imports, tags and simple commits.
 - File renames
 - Arch tags
 - Binary files
 - Large trees
 - Multiple repositories
 - Branches

TODO:
 - Allow re-running the import on an already-imported project
 - Follow merges using Arch data
 - Audit shell escaping of filenames
 - Better support for file metadata
 - Better/safer creation of temp directories

Unsupported:
 - Arch 'configuration'

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>

---

diff --git a/git-archimport-script b/git-archimport-script
new file mode 100755
--- /dev/null
+++ b/git-archimport-script
@@ -0,0 +1,593 @@
+#!/usr/bin/perl -w
+#
+# This tool is copyright (c) 2005, Martin Langhoff.
+# It is released under the Gnu Public License, version 2.
+#
+# The basic idea is to walk the output of tla abrowse, 
+# fetch the changesets and apply them. 
+#
+=head1 Invocation
+
+    git-archimport-script -i <archive>/<branch> [<archive>/<branch>]
+    [ <archive>/<branch> ]
+
+    The script expects you to provide the key roots where it can start the
+    import from an 'initial import' or 'tag' type of Arch commit. It will
+    then follow all the branching and tagging within the provided roots.
+
+    It will die if it sees branches that have different roots. 
+
+=head2 TODO
+
+ - keep track of merged patches, and mark a git merge when it happens
+ - smarter rules to parse the archive history "up" and "down"
+ - be able to continue an import where we left off
+ - audit shell-escaping of filenames
+
+=head1 Devel tricks
+
+Add print in front of the shell commands invoked via backticks. 
+
+=cut
+
+use strict;
+use warnings;
+use Getopt::Std;
+use File::Spec;
+use File::Temp qw(tempfile);
+use File::Path qw(mkpath);
+use File::Basename qw(basename dirname);
+use String::ShellQuote;
+use Time::Local;
+use IO::Socket;
+use IO::Pipe;
+use POSIX qw(strftime dup2);
+use Data::Dumper qw/ Dumper /;
+use IPC::Open2;
+
+$SIG{'PIPE'}="IGNORE";
+$ENV{'TZ'}="UTC";
+
+our($opt_h,$opt_v, $opt_T,
+    $opt_C,$opt_t, $opt_i);
+
+sub usage() {
+    print STDERR <<END;
+Usage: ${\basename $0}     # fetch/update GIT from Arch
+       [ -h ] [ -v ] [ -i ] [ -T ] 
+       [ -C GIT_repository ] [ -t tempdir ] 
+       repository/arch-branch [ repository/arch-branch] ...
+END
+    exit(1);
+}
+
+getopts("hviC:t:") or usage();
+usage if $opt_h;
+
+@ARGV >= 1 or usage();
+my @arch_roots = @ARGV;
+
+my $tmp = $opt_t;
+$tmp ||= '/tmp';
+$tmp .= '/git-archimport/';
+
+my $git_tree = $opt_C;
+$git_tree ||= ".";
+
+
+my @psets  = ();                # the collection
+
+foreach my $root (@arch_roots) {
+    my ($arepo, $abranch) = split(m!/!, $root);
+    open ABROWSE, "tla abrowse -f -A $arepo --desc --merges $abranch |" 
+        or die "Problems with tla abrowse: $!";
+    
+    my %ps        = ();         # the current one
+    my $mode      = '';
+    my $lastseen  = '';
+    
+    while (<ABROWSE>) {
+        chomp;
+        
+        # first record padded w 8 spaces
+        if (s/^\s{8}\b//) {
+            
+            # store the record we just captured
+            if (%ps) {
+                my %temp = %ps; # break references
+                push (@psets, \%temp);
+                %ps = ();
+            }
+            
+            my ($id, $type) = split(m/\s{3}/, $_);
+            $ps{id}   = $id;
+            $ps{repo} = $arepo;
+
+            # deal with types
+            if ($type =~ m/^\(simple changeset\)/) {
+                $ps{type} = 's';
+            } elsif ($type eq '(initial import)') {
+                $ps{type} = 'i';
+            } elsif ($type =~ m/^\(tag revision of (.+)\)/) {
+                $ps{type} = 't';
+                $ps{tag}  = $1;
+            } else { 
+                warn "Unknown type $type";
+            }
+            $lastseen = 'id';
+        }
+        
+        if (s/^\s{10}//) { 
+            # 10 leading spaces or more 
+            # indicate commit metadata
+            
+            # date & author 
+            if ($lastseen eq 'id' && m/^\d{4}-\d{2}-\d{2}/) {
+                
+                my ($date, $authoremail) = split(m/\s{2,}/, $_);
+                $ps{date}   = $date;
+                $ps{date}   =~ s/\bGMT$//; # strip off trailign GMT
+                if ($ps{date} =~ m/\b\w+$/) {
+                    warn 'Arch dates not in GMT?! - imported dates will be wrong';
+                }
+            
+                $authoremail =~ m/^(.+)\s(\S+)$/;
+                $ps{author} = $1;
+                $ps{email}  = $2;
+            
+                $lastseen = 'date';
+            
+            } elsif ($lastseen eq 'date') {
+                # the only hint is position
+                # subject is after date
+                $ps{subj} = $_;
+                $lastseen = 'subj';
+            
+            } elsif ($lastseen eq 'subj' && $_ eq 'merges in:') {
+                $ps{merges} = [];
+                $lastseen = 'merges';
+            
+            } elsif ($lastseen eq 'merges' && s/^\s{2}//) {
+                push (@{$ps{merges}}, $_);
+            } else {
+                warn 'more metadata after merges!?';
+            }
+            
+        }
+    }
+
+    if (%ps) {
+        my %temp = %ps;         # break references
+        push (@psets, \%temp);
+        %ps = ();
+    }    
+    close ABROWSE;
+}                               # end foreach $root
+
+## Order patches by time
+@psets = sort {$a->{date}.$b->{id} cmp $b->{date}.$b->{id}} @psets;
+
+#print Dumper \@psets;
+
+##
+## TODO cleanup irrelevant patches
+##      and put an initial import
+##      or a full tag
+
+if ($opt_i) {                   # initial import 
+    if ($psets[0]{type} eq 'i' || $psets[0]{type} eq 't') {
+        print "Starting import from $psets[0]{id}\n";
+    } else {
+        die "Need to start from an import or a tag -- cannot use $psets[0]{id}";
+    }
+    `git-init-db`;
+    die $! if $?;
+}
+
+# process
+my $lastbranch = branchname($psets[0]{id}); # only good for initial import
+my $importseen = $opt_i ? 0 : 1; # start at 1 if opt_i
+
+foreach my $ps (@psets) {
+
+    $ps->{branch} =  branchname($ps->{id});
+
+    #
+    # ensure we have a clean state 
+    # 
+    if (`git diff-files`) {
+        die "Unclean tree when about to process $ps->{id} " .
+            " - did we fail to commit cleanly before?";
+    }
+    die $! if $?;
+
+    # 
+    # create the branch if needed
+    #
+    if ($ps->{type} eq 'i' && $importseen) {
+        die "Should not have more than one 'Initial import' per GIT import";
+    }
+
+    unless ($opt_i && !$importseen) { # skip for first commit
+        if ( -e ".git/refs/heads/$ps->{branch}") {
+            # we know about this branch
+            `git checkout    $ps->{branch}`;
+        } else {
+            # new branch! we need to verify a few things
+            die "Branch on a non-tag!" unless $ps->{type} eq 't';
+            my $branchpoint = ptag($ps->{tag});
+            die "Tagging from unknown id unsupported: $ps->{tag}" 
+                unless $branchpoint;
+            
+            # find where we are supposed to branch from
+            `git checkout -b $ps->{branch} $branchpoint`;
+        } 
+        die $! if $?;
+    } 
+
+        
+    #
+    # Apply the import/changeset/merge into the working tree
+    # 
+    if ($ps->{type} eq 'i' || $ps->{type} eq 't') {
+        $importseen = 1;
+        apply_import($ps) or die $!;
+    } elsif ($ps->{type} eq 's') {
+        apply_cset($ps);
+    }
+
+    #
+    # prepare update git's index, based on what arch knows
+    # about the pset, resolve parents, etc
+    #
+    my $tree;
+    
+    my $commitlog = `tla cat-archive-log -A $ps->{repo} $ps->{id}`; 
+    die "Error in cat-archive-log: $!" if $?;
+        
+    # parselog will git-add/rm files
+    # and generally prepare things for the commit
+    # NOTE: parselog will shell-quote filenames! 
+    my ($sum, $msg, $add, $del, $mod, $ren) = parselog($commitlog);
+    my $logmessage = "$sum\n$msg";
+
+
+    # imports don't give us good info
+    # on added files. Shame on them
+    if ($ps->{type} eq 'i' || $ps->{type} eq 't') { 
+        `find . -type f -print0 | grep -zv '^./.git' | xargs -0 -l100 git-update-cache --add`;
+        `git-ls-files --deleted -z | xargs --no-run-if-empty -0 -l100 git-update-cache --remove`; 
+    }
+
+    if (@$add) {
+        while (@$add) {
+            my @slice = splice(@$add, 0, 100);
+            my $slice = join(' ', @slice);          
+            `git-update-cache --add $slice`;
+            die "Error in git-update-cache --add: $!" if $?;
+        }
+    }
+    if (@$del) {
+        foreach my $file (@$del) {
+            unlink $file or die "Problems deleting $file : $!";
+        }
+        while (@$del) {
+            my @slice = splice(@$del, 0, 100);
+            my $slice = join(' ', @slice);
+            `git-update-cache --remove $slice`;
+            die "Error in git-update-cache --remove: $!" if $?;
+        }
+    }
+    if (@$ren) {                # renamed
+        if (@$ren % 2) {
+            die "Odd number of entries in rename!?";
+        }
+        ;
+        while (@$ren) {
+            my $from = pop @$ren;
+            my $to   = pop @$ren;           
+
+            unless (-d dirname($to)) {
+                mkpath(dirname($to)); # will die on err
+            }
+            #print "moving $from $to";
+            `mv $from $to`;
+            die "Error renaming $from $to : $!" if $?;
+            `git-update-cache --remove $from`;
+            die "Error in git-update-cache --remove: $!" if $?;
+            `git-update-cache --add $to`;
+            die "Error in git-update-cache --add: $!" if $?;
+        }
+
+    }
+    if (@$mod) {                # must be _after_ renames
+        while (@$mod) {
+            my @slice = splice(@$mod, 0, 100);
+            my $slice = join(' ', @slice);
+            `git-update-cache $slice`;
+            die "Error in git-update-cache: $!" if $?;
+        }
+    }
+
+    # warn "errors when running git-update-cache! $!";
+    $tree = `git-write-tree`;
+    die "cannot write tree $!" if $?;
+    chomp $tree;
+        
+    
+    #
+    # Who's your daddy?
+    #
+    my @par;
+    if ( -e ".git/refs/heads/$ps->{branch}") {
+        if (open HEAD, "<.git/refs/heads/$ps->{branch}") {
+            my $p = <HEAD>;
+            close HEAD;
+            chomp $p;
+            push @par, '-p', $p;
+        } else { 
+            if ($ps->{type} eq 's') {
+                warn "Could not find the right head for the branch $ps->{branch}";
+            }
+        }
+    }
+    
+    my $par = join (' ', @par);
+
+    #    
+    # Commit, tag and clean state
+    #
+    $ENV{TZ}                  = 'GMT';
+    $ENV{GIT_AUTHOR_NAME}     = $ps->{author};
+    $ENV{GIT_AUTHOR_EMAIL}    = $ps->{email};
+    $ENV{GIT_AUTHOR_DATE}     = $ps->{date};
+    $ENV{GIT_COMMITTER_NAME}  = $ps->{author};
+    $ENV{GIT_COMMITTER_EMAIL} = $ps->{email};
+    $ENV{GIT_COMMITTER_DATE}  = $ps->{date};
+
+    my ($pid, $commit_rh, $commit_wh);
+    $commit_rh = 'commit_rh';
+    $commit_wh = 'commit_wh';
+    
+    $pid = open2(*READER, *WRITER, "git-commit-tree $tree $par") 
+        or die $!;
+    print WRITER $logmessage;   # write
+    close WRITER;
+    my $commitid = <READER>;    # read
+    chomp $commitid;
+    close READER;
+    waitpid $pid,0;             # close;
+
+    if (length $commitid != 40) {
+        die "Something went wrong with the commit! $! $commitid";
+    }
+    #
+    # Update the branch
+    # 
+    open  HEAD, ">.git/refs/heads/$ps->{branch}";
+    print HEAD $commitid;
+    close HEAD;
+    unlink ('.git/HEAD');
+    symlink("refs/heads/$ps->{branch}",".git/HEAD");
+
+    # tag accordingly
+    ptag($ps->{id}, $commitid); # private tag
+    if ($opt_T || $ps->{type} eq 't' || $ps->{type} eq 'i') {
+        tag($ps->{id}, $commitid);
+    }
+    print " * Committed $ps->{id}\n";
+    print "   + tree   $tree\n";
+    print "   + commit $commitid\n";
+    # print "   + commit date is  $ps->{date} \n";
+}
+
+sub branchname {
+    my $id = shift;
+    $id =~ s#^.+?/##;
+    my @parts = split(m/--/, $id);
+    return join('--', @parts[0..1]);
+}
+
+sub apply_import {
+    my $ps = shift;
+    my $bname = branchname($ps->{id});
+
+    `mkdir -p $tmp`;
+
+    `tla get -s --no-pristine -A $ps->{repo} $ps->{id} $tmp/import`;
+    die "Cannot get import: $!" if $?;    
+    `rsync -v --archive --delete --exclude '.git' --exclude '.arch-ids' --exclude '{arch}' $tmp/import/* ./`;
+    die "Cannot rsync import:$!" if $?;
+    
+    `rm -fr $tmp/import`;
+    die "Cannot remove tempdir: $!" if $?;
+    
+
+    return 1;
+}
+
+sub apply_cset {
+    my $ps = shift;
+
+    `mkdir -p $tmp`;
+
+    # get the changeset
+    `tla get-changeset  -A $ps->{repo} $ps->{id} $tmp/changeset`;
+    die "Cannot get changeset: $!" if $?;
+    
+    # apply patches
+    if (`find $tmp/changeset/patches -type f -name '*.patch'`) {
+        # this can be sped up considerably by doing
+        #    (find | xargs cat) | patch
+        # but that cna get mucked up by patches
+        # with missing trailing newlines or the standard 
+        # 'missing newline' flag in the patch - possibly
+        # produced with an old/buggy diff.
+        # slow and safe, we invoke patch once per patchfile
+        `find $tmp/changeset/patches -type f -name '*.patch' -print0 | grep -zv '{arch}' | xargs -iFILE -0 --no-run-if-empty patch -p1 --forward -iFILE`;
+        die "Problem applying patches! $!" if $?;
+    }
+
+    # apply changed binary files
+    if (my @modified = `find $tmp/changeset/patches -type f -name '*.modified'`) {
+        foreach my $mod (@modified) {
+            chomp $mod;
+            my $orig = $mod;
+            $orig =~ s/\.modified$//; # lazy
+            $orig =~ s!^\Q$tmp\E/changeset/patches/!!;
+            #print "rsync -p '$mod' '$orig'";
+            `rsync -p $mod ./$orig`;
+            die "Problem applying binary changes! $!" if $?;
+        }
+    }
+
+    # bring in new files
+    `rsync --archive --exclude '.git' --exclude '.arch-ids' --exclude '{arch}' $tmp/changeset/new-files-archive/* ./`;
+
+    # deleted files are hinted from the commitlog processing
+
+    `rm -fr $tmp/changeset`;
+}
+
+
+# =for reference
+# A log entry looks like 
+# Revision: moodle-org--moodle--1.3.3--patch-15
+# Archive: arch-eduforge@catalyst.net.nz--2004
+# Creator: Penny Leach <penny@catalyst.net.nz>
+# Date: Wed May 25 14:15:34 NZST 2005
+# Standard-date: 2005-05-25 02:15:34 GMT
+# New-files: lang/de/.arch-ids/block_glossary_random.php.id
+#     lang/de/.arch-ids/block_html.php.id
+# New-directories: lang/de/help/questionnaire
+#     lang/de/help/questionnaire/.arch-ids
+# Renamed-files: .arch-ids/db_sears.sql.id db/.arch-ids/db_sears.sql.id
+#    db_sears.sql db/db_sears.sql
+# Removed-files: lang/be/docs/.arch-ids/release.html.id
+#     lang/be/docs/.arch-ids/releaseold.html.id
+# Modified-files: admin/cron.php admin/delete.php
+#     admin/editor.html backup/lib.php backup/restore.php
+# New-patches: arch-eduforge@catalyst.net.nz--2004/moodle-org--moodle--1.3.3--patch-15
+# Summary: Updating to latest from MOODLE_14_STABLE (1.4.5+)
+# Keywords:
+#
+# Updating yadda tadda tadda madda
+sub parselog {
+    my $log = shift;
+    #print $log;
+
+    my (@add, @del, @mod, @ren, @kw, $sum, $msg );
+
+    if ($log =~ m/(?:\n|^)New-files:(.*?)(?=\n\w)/s ) {
+        my $files = $1;
+        @add = split(m/\s+/s, $files);
+    }
+       
+    if ($log =~ m/(?:\n|^)Removed-files:(.*?)(?=\n\w)/s ) {
+        my $files = $1;
+        @del = split(m/\s+/s, $files);
+    }
+    
+    if ($log =~ m/(?:\n|^)Modified-files:(.*?)(?=\n\w)/s ) {
+        my $files = $1;
+        @mod = split(m/\s+/s, $files);
+    }
+    
+    if ($log =~ m/(?:\n|^)Renamed-files:(.*?)(?=\n\w)/s ) {
+        my $files = $1;
+        @ren = split(m/\s+/s, $files);
+    }
+
+    $sum ='';
+    if ($log =~ m/^Summary:(.+?)$/m ) {
+        $sum = $1;
+        $sum =~ s/^\s+//;
+        $sum =~ s/\s+$//;
+    }
+
+    $msg = '';
+    if ($log =~ m/\n\n(.+)$/s) {
+        $msg = $1;
+        $msg =~ s/^\s+//;
+        $msg =~ s/\s+$//;
+    }
+
+
+    # cleanup the arrays
+    foreach my $ref ( (\@add, \@del, \@mod, \@ren) ) {
+        my @tmp = ();
+        while (my $t = pop @$ref) {
+            next unless length ($t);
+            next if $t =~ m!\{arch\}/!;
+            next if $t =~ m!\.arch-ids/!;
+            next if $t =~ m!\.arch-inventory$!;
+            push (@tmp, shell_quote($t));
+        }
+        @$ref = @tmp;
+    }
+    
+    #print Dumper [$sum, $msg, \@add, \@del, \@mod, \@ren]; 
+    return       ($sum, $msg, \@add, \@del, \@mod, \@ren); 
+}
+
+# write/read a tag
+sub tag {
+    my ($tag, $commit) = @_;
+    $tag =~ s|/|--|g; 
+    $tag = shell_quote($tag);
+    
+    if ($commit) {
+        open(C,">.git/refs/tags/$tag")
+            or die "Cannot create tag $tag: $!\n";
+        print C "$commit\n"
+            or die "Cannot write tag $tag: $!\n";
+        close(C)
+            or die "Cannot write tag $tag: $!\n";
+        print "Created tag '$tag' on '$commit'\n" if $opt_v;
+    } else {                    # read
+        open(C,"<.git/refs/tags/$tag")
+            or die "Cannot read tag $tag: $!\n";
+        $commit = <C>;
+        chomp $commit;
+        die "Error reading tag $tag: $!\n" unless length $commit == 40;
+        close(C)
+            or die "Cannot read tag $tag: $!\n";
+        return $commit;
+    }
+}
+
+# write/read a private tag
+# reads fail softly if the tag isn't there
+sub ptag {
+    my ($tag, $commit) = @_;
+    $tag =~ s|/|--|g; 
+    $tag = shell_quote($tag);
+    
+    unless (-d '.git/archimport/tags') {
+        mkpath('.git/archimport/tags');
+    }
+
+    if ($commit) {              # write
+        open(C,">.git/archimport/tags/$tag")
+            or die "Cannot create tag $tag: $!\n";
+        print C "$commit\n"
+            or die "Cannot write tag $tag: $!\n";
+        close(C)
+            or die "Cannot write tag $tag: $!\n";
+    } else {                    # read
+        # if the tag isn't there, return 0
+        unless ( -s ".git/archimport/tags/$tag") {
+            warn "Could not find tag $tag -- perhaps it isn't in the repos we have?\n" 
+                if $opt_v;
+            return 0;
+        }
+        open(C,"<.git/archimport/tags/$tag")
+            or die "Cannot read tag $tag: $!\n";
+        $commit = <C>;
+        chomp $commit;
+        die "Error reading tag $tag: $!\n" unless length $commit == 40;
+        close(C)
+            or die "Cannot read tag $tag: $!\n";
+        return $commit;
+    }
+}
