From: Alex Riesen <raa.lkml@gmail.com>
Subject: Yet another Perforce importer
Date: Tue, 22 May 2007 23:13:34 +0200
Message-ID: <20070522211334.GC30871@steel.home>
References: <20070505224805.GD2898@steel.home> <81b0412b0705100637g1072f5c7y54f781b67a569690@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 22 23:13:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hqbfx-0003bJ-KP
	for gcvg-git@gmane.org; Tue, 22 May 2007 23:13:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756017AbXEVVNn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 17:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756660AbXEVVNn
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 17:13:43 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:33927 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756017AbXEVVNl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 17:13:41 -0400
Received: from tigra.home (Fc8ee.f.strato-dslnet.de [195.4.200.238])
	by post.webmailer.de (fruni mo31) (RZmta 6.5)
	with ESMTP id A025b6j4MIQY5L for <git@vger.kernel.org>;
	Tue, 22 May 2007 23:13:35 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 36A3A277BD
	for <git@vger.kernel.org>; Tue, 22 May 2007 23:13:35 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 0D422D195; Tue, 22 May 2007 23:13:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <81b0412b0705100637g1072f5c7y54f781b67a569690@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWow37lQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48116>

- primitive export support with --p4-edit-changed[=branch]

  If no branch given the HEAD is assumed; this is useful when HEAD is
  updated, but index and working directory are not. This is the case
  after a remote repo does a push into a p4 mirroring repo. This has
  its problems (only one commit will be described in p4 changelist),
  but it has its uses too (default clone creates a push configuration
  which modifies the master of the source repo), so it was left in.
  The working directory of the p4 mirroring repo must be kept clean
  (no changes not registered in the index. It's somewhat problematic
  on cygwin - it keeps changing filemodes). Also, p4 cannot have
  non-linear history (they wouldn't admit this, but they don't have
  non-linear history, branching, merging and they are very slow), so
  the branch to be exported is expected to fast-forward from the
  mirroring branch (this probably can be changed, but it would be nice
  to know in advance which files will be changed after the merge: to
  checkout them from p4).

  The workflow is like this:

    $ git clone p4-mirror working
    $ cd working; edit ...; git commit ...
    $ git push origin +master:refs/remotes/working/master
    $ cd ../p4-mirror
    $ git-p4-import --p4-edit-changed=working/master
    The state of working/master(123847298742...) is checked out
    A p4 changelist 1234567 is prepared
    $ p4 submit 1234567
    Changelist 1234567 renamed 8375983 and submitted
    $ git-p4-import -y -C 8375983

  The --p4-edit-changed call will checkout the changed p4 files for
  edit, addition and deletion, prepare submission by populating it
  with commit descriptions, und update the files with the state from
  the working branch. Addition of new files can be very problematic:
  client view must be configured so that p4 knows where to places them
  on server.
  Submission left to the user: with that piece of sh%t the p4 is most
  of us probably have to follow some special procedure for submission
  anyway (I have to).
  If someone else changes p4 repo and you import the changes, don't
  forget to rebase your working branches: the current code blocks
  export if there are changes between the working branch and mirroring
  branch. This is the line where rev-list is called. Feel free to fix
  that. I didn't because I just had enough of p4 stupidity for that day.

- Add --diffs to show changes between filesystem, index and HEAD
  Useful after a "blind push" (the one which happens by default) on
  the mirror branch: to see where was changed.

- Allow running the script without any description. Either a
  description or --edit must be given: for mirroring branch commit.
  A "-m" for message like in git commit should be a good idea,
  perhaps: most descriptions of p4 submissions are useless and the
  "spaghetti" of a p4 checkout seldom can be defined with one
  changelist.

- Diverse small and large fixes, for instance a problem with creation
  of empty commits which removed all files was fixed

It is still untested on Linux.

@rem = 'NT: CMD.EXE vim: syntax=perl noet sw=4
@perl -x -s %0 -- %*
@exit
@rem ';
#!perl -w
#line 7

local $VERBOSE = 0;
local $DRYRUN = 0;
local $SHOW_DIFFS = 0;
local $AUTO_COMMIT = 0;
local $JUST_COMMIT = 0;
local $P4CLIENT = undef;
local @EDIT_COMMIT = 0;
local @FULL_IMPORT = 0;
local @DESC = ();
local $SPEC = undef;
local @P4ARGS = ();
local $P4HAVE_FILE = undef;
local %P4USERS = ();
local $FULL_DESC = 1;
local $HEAD_FROM_P4 = 0;
local $P4_EDIT_CHANGED = 0;
local $P4_EDIT_HEAD = undef;

push(@P4ARGS, '-P', $ENV{P4PASSWD})
    if defined($ENV{P4PASSWD}) and length($ENV{P4PASSWD});
use Cwd;
local $start_dir = cwd();

sub read_args {
    my ($in_client, $in_cl, $in_fi, $in_p4, $no_opt) = (0,0,0,0,0);
    foreach my $f ( @_ ) {
	goto _files if $no_opt;
	if ($in_client) { $in_client = 0; $P4CLIENT = $f; next }
	if ($in_cl) { $in_cl=0; push(@DESC,"c$f"); next }
	if ($in_fi) { $in_fi=0; push(@DESC,"f$f"); next }
	if ($in_p4) { $in_p4=0; push(@DESC,"4$f"); next }
	$no_opt=1, next if $f eq '--';
	$DRYRUN=1, next if $f eq '-n' or $f eq '--dry-run';
	$SHOW_DIFFS=$DRYRUN=1, next if $f eq '--diffs';
	$AUTO_COMMIT=1, next if $f eq '-y' or $f eq '--yes';
	$JUST_COMMIT=1, next if $f eq '--just-commit';
	$EDIT_COMMIT=1, next if ($f eq '-e') or ($f eq '--edit');
	$FULL_IMPORT=1, next if $f eq '--full';
	$FULL_DESC++, next if $f eq '--p4-desc';
	$P4_EDIT_CHANGED=1, next if $f eq '--p4-edit-changed';
	if ($f =~ /^--p4-edit-changed=(.*)/) {
	    $P4_EDIT_CHANGED=1;
	    $P4_EDIT_HEAD=$1;
	    next 
	}
	$VERBOSE++, next if $f eq '-v' or $f eq '--verbose';
	$in_client = 1, next if $f eq '--client';
	$P4CLIENT = $1, next if $f =~ /^--client=(.*)/;
	$in_cl = 1, next if $f eq '-C';
	push(@DESC,"c$1"), next if $f =~ /^--changelist=(.*)/;
	$in_fi = 1, next if $f eq '-F';
	push(@DESC,"f$1"), next if $f =~ /^--file=(.*)/;
	$in_p4 = 1, next if ($f eq '--ptr') or ($f eq '--p4');
	push(@DESC,"4$2"), next if $f =~ /^--(p4|ptr)=(.*)/;

	if ($f eq '--help' or $f eq '-h') {
	    print <<EOF;
$0 [-n|--dry-run] [-y|--yes] [--client <client-name>] [--diffs] \
[-e|--edit] [--just-commit] [--full] [-v|--verbose] [-C <change-number>] \
[-F <filename>] [--ptr|--p4 <p4-path-and/or-revision>] [--p4-desc] \
[--] [<specification>] 

Perforce client state importer. Creates a git commit on the current
branch from a state the given p4 client and working directory hold.

<specification> must be given and is expected to be a file which will be
stored on the side branch under the name "spec".
Remote-to-local mapping and the revisions of files are stored in "have",
and the client definition - in "client".

--client client Specify client name (saved in .git/p4/client for the next time)
--full          Perform full import, don't even try to figure out what changed
-y|--yes        Commit automatically (by default only index updated)
--just-commit   To be used after you forgot to run with --yes first time
-n|--dry-run    Do not update the index and do not commit
-e|--edit       Edit commit description before committing
-v|--verbose    Be more verbose. Can be given many times, increases verbosity

--file=file
-F file         Take description for the commit from a file in the
                next parameter

--changelist=change
-C change       Take description for the commit from this p4 change

--p4|--ptr p4-path-and/or-revision
--p4|--ptr=p4-path-and/or-revision
                Take description for the commit from the p4 change described
                by this p4 path, possibly including revision specification

--p4-desc       Increase amount of junk from p4 change description

--diffs         Show files which are different between local filesystem, index,
                and the current HEAD. Does not do anything else

--p4-edit-changed
--p4-edit-changed=sha1
                Merge with the given sha1 and prepare a p4 submission.
                Current HEAD must fast-forward to sha1. If sha1 is omited,
                the current HEAD is assumed. The working directory must
                have no local changes.

The descriptions taken from p4 changes given by -C and --p4 will
be concatenated if the options given multiple times.
"--" can be used to separate options from description files.

EOF
	    exit(0);
	}
	die "$0: unknown option $f\n" if $f =~ /^-/;
    _files:
	warn "$0: spec was already set, $SPEC ignored\n" if defined($SPEC);
	$SPEC = $f;
    }
}
read_args(@ARGV);

local ($GIT_DIR) = qx{git rev-parse --git-dir};
$GIT_DIR =~ s/\r?\n$//s if defined($GIT_DIR);
die "$0: git directory not found\n" if !defined($GIT_DIR) or !-d $GIT_DIR;

local $editor = $ENV{VISUAL};
$editor = $ENV{EDITOR} unless defined($editor);
$editor = 'd:/Programs/Vim/vim70/gvim.exe' unless defined($editor);
die "$0: no editor defined\n" unless defined($editor);

if ($SHOW_DIFFS) {
    my $sep = $/;
    $/="\0";
    my ($show, $cnt) = (0, 0);
    if (open(F, '-|', 'git diff-files -r --name-only -z')) {
	while (<F>) {
	    my $c = chop;
	    $_ .= $c if $c ne "\0";
	    print "Changed files:\n" if !$show;
	    print " $_\n";
	    $show = 1;
	    $cnt++;
	}
	close(F);
    }
    if (open(F, '-|', 'git diff-index --cached -r -z HEAD')) {
	$show = 0;
	my ($diff, $info) = (0, 1);
	while (<F>) {
	    my $c = chop;
	    $_ .= $c if $c ne "\0";
	    if ($info) {
		next if !/^:(\d{6}) (\d{6}) ([0-9a-f]{40}) ([0-9a-f]{40}) ./o;
		# show only content changes, p4 does not support exec-bit anyway
		$diff = $3 ne $4;
	    } elsif ($diff) {
		print "Changes between index and HEAD:\n" if !$show;
		print " $_\n";
		$show = 1;
		$cnt++;
	    }
	    $info = !$info;
	}
	close(F);
    }
    $/ = $sep;
    exit($cnt ? 1: 0);
}

# P4 client was given in command-line. Store it
if ( defined($P4CLIENT) ) {
    mkdir "$GIT_DIR/p4", 0777;
    if ( open(F, '>', "$GIT_DIR/p4/client") ) {
	print F "$P4CLIENT\n";
	close(F);
    } else {
	die "$0: cannot store client name: $!\n"
    }
} else {
    if ( open(F, '<', "$GIT_DIR/p4/client") ) {
	($P4CLIENT) = <F>;
	close(F);
	$P4CLIENT =~ s/^\s*//,$P4CLIENT =~ s/\s*$// if defined($P4CLIENT);
    }
}
die "P4 client not defined\n" if !defined($P4CLIENT) or !length($P4CLIENT);
print "reading P4 client $P4CLIENT\n" if $VERBOSE;
local ($P4ROOT, $p4clnt, $P4HOST);
open(my $fdo, '>', "$GIT_DIR/p4/client.def") or die "p4/client.def: $!\n";
binmode($fdo);
open(my $fdi, '-|', "p4 client -o $P4CLIENT") or die "p4 client: $!\n";
binmode($fdi);
my $last_line_len = 0;
while (<$fdi>) {
    next if /^#/o;
    if ( m/^\s*Root:\s*(\S+)[\\\/]*\s*$/so ) { $P4ROOT = $1 }
    elsif ( m/^\s*Client:\s*(\S+)/o ) { $p4clnt = $1 }
    elsif ( m/^\s*Host:\s*(\S+)/o ) { $P4HOST = $1 }
    ($VERBOSE and print), next if /^(Access|Update):/;
    s/\r?\n$//so;
    my $len = length($_);
    print $fdo "$_\n" if $len or $len != $last_line_len;
    $last_line_len = $len;
}
close($fdi);
close($fdo);

die "Client root not defined\n" unless defined($P4ROOT);
if ( $VERBOSE ) {
    print "GIT_DIR: $GIT_DIR\n";
    print "Root: $P4ROOT (cwd: $start_dir)\n";
    print "Host: $P4HOST\n";
    print "Client: $p4clnt\n" if $p4clnt ne $P4CLIENT;
}

if ($P4_EDIT_CHANGED) {
    my $rc = system('git', 'diff-files', '--quiet');
    exit(127) if $rc & 0xff; # error starting the program
    die "$0: there are changes in $P4ROOT. Import them first.\n" if $rc;
    $P4_EDIT_HEAD = 'HEAD' if !defined($P4_EDIT_HEAD);
    my ($mergehead) = qx{git rev-parse $P4_EDIT_HEAD};
    exit(127) if $?;
    exit(1) if !defined($mergehead);
    $mergehead =~ s/\r?\n//gs;
    exit(1) if !length($mergehead);
    print "Checking out $P4_EDIT_HEAD ($mergehead) for p4 edit\n" if $VERBOSE;
    # Check if the give reference is a direct descendant of current branch
    if ($P4_EDIT_HEAD ne 'HEAD') {
	my ($sha1) = qx{git rev-list --max-count=1 $mergehead..HEAD};
	exit(127) if $?;
	die "$0: HEAD does not fast-forward to $P4_EDIT_HEAD\n"
	    if defined($sha1) and $sha1 =~ /^[0-9a-f]{40}\b/;
    }
    my $cnt;
    my @files = ();
    my $sep = $/;
    $/="\0";
    if (open(F, '-|', "git diff-index -R --cached -r -z $mergehead")) {
	my ($diff, $info, $M) = (0, 1, '');
	while (<F>) {
	    my $c = chop;
	    $_ .= $c if $c ne "\0";
	    if ($info) {
		next if !/^:\d{6} \d{6} ([0-9a-f]{40}) ([0-9a-f]{40}) (\w+)/o;
		# use only content changes, p4 does not support exec-bit
		$diff = $1 ne $2;
		$M = $3; # change type marker
	    } elsif ($diff) {
		print "$M $_\n" if $VERBOSE;
		die "File contains characters which p4 cannot support\n"
		    if /[\n@#%*]/s;
		push @files, "$M$_";
		$cnt++;
	    }
	    $info = !$info;
	}
	close(F);
    }
    $/ = $sep;
    if (!$cnt) {
	warn "$0: No content changes found between HEAD and $P4_EDIT_HEAD";
	exit(0);
    }
    # Create a new changelist
    my $p4;
    open($p4, "p4 -c $P4CLIENT -H $P4HOST -d $P4ROOT change -o|") or
	die "$0: failed to create changelist\n";
    my @desc = map {s/\r?\n//so; $_} <$p4>;
    close($p4);
    open($p4, '>', "$GIT_DIR/p4/changelist") or
	die "$GIT_DIR/p4/changelist: $!\n";
    foreach (@desc) {
	print $p4 "$_\n";
	if (/^Description:/o) {
	    my $range = "..$mergehead";
	    $range = "${mergehead}^..$mergehead" if $P4_EDIT_HEAD eq 'HEAD';
	    if (open(my $fd, '-|', "git log $range")) {
		while(<$fd>) {
		    # I believe it is not possible to save this information
		    # in Perforce.
		    next if /^(commit |Author:|Date:)/;
		    s/\r?\n$//so;
		    next if !length($_);
		    s/^\s+//o;
		    print $p4 " $_\n";
		}
		close($fd);
	    }
	}
    }
    close($p4);
    open(STDIN, '<', "$GIT_DIR/p4/changelist") or
	die "$GIT_DIR/p4/changelist: $!\n";
    open($p4, "p4 -c $P4CLIENT -H $P4HOST -d $P4ROOT change -i|") or
	die "$0: failed to create changelist\n";
    my ($newchange) = grep {s/^Change (\d+) created\b.*/$1/so} <$p4>;
    close($p4);
    print "Checking out P4 files in changelist $newchange\n" if $VERBOSE;
    # open files for edit
    $cnt = 0;
    open($p4, '>', "$GIT_DIR/p4/files") or die "$GIT_DIR/p4/files: $!\n";
    print $p4 "-c\n$newchange\n";
    print $p4 (map {++$cnt; substr($_,1)."\n"} grep {/^M/} @files);
    close($p4);
    sub runp4 {
	return system('p4','-c',$P4CLIENT,'-H',$P4HOST,'-d',$P4ROOT,@_);
    }
    runp4('-x',"$GIT_DIR/p4/files", 'edit') if $cnt;

    $cnt = 0;
    open($p4, '>', "$GIT_DIR/p4/files") or die "$GIT_DIR/p4/files: $!\n";
    print $p4 "-c\n$newchange\n";
    print $p4 (map {++$cnt; substr($_,1)."\n"} grep {/^A/} @files);
    close($p4);
    runp4('-x',"$GIT_DIR/p4/files", 'add') if $cnt;

    $cnt = 0;
    open($p4, '>', "$GIT_DIR/p4/files") or die "$GIT_DIR/p4/files: $!\n";
    print $p4 "-c\n$newchange\n";
    print $p4 (map {++$cnt; substr($_,1)."\n"} grep {/^D/} @files);
    close($p4);
    runp4('-x',"$GIT_DIR/p4/files", 'delete') if $cnt;

    # p4 modifies working directory on checkout, stupid thing
    system('git', 'update-index', '--refresh');
    $rc = system('git', 'read-tree', '-m', '-u', $mergehead);
    exit(127) if $rc & 0xff;
    exit(1) if $rc;
    print "The state of $P4_EDIT_HEAD($mergehead) is checked out.\n";
    print "A p4 changelist $newchange is prepared.\n";
    exit(0);
}

my ($git_head,$git_p4_head,$git_p4_have) = &git_p4_init;

if ($JUST_COMMIT) {
    git_p4_commit($git_head, $git_p4_head);
    exit 0;
}

local %gitignore_dirs = ();
$gitignore_dirs{'/'} = read_filter_file("$GIT_DIR/info/exclude");
push(@{$gitignore_dirs{'/'}}, @{read_filter_file('.gitignore')});

my %git_index = ();
$/ = "\0";
my @git_X = ();
print "Reading git file list(git ls-files @git_X --cached -z)...\n" if $VERBOSE;
foreach ( qx{git ls-files @git_X --cached -z} ) {
    chop; # chop \0
    next if m/^\.gitignore$/o;
    next if m/\/\.gitignore$/o;
    next if filtered($_);
    $git_index{$_} = 1;
}

my @git_add = ();
my @git_addx = ();
my @git_del = ();
my @git_upd = ();

print "Reading P4 file list...\n" if $VERBOSE;
local ($Conflicts,$Ignored,$Added,$Deleted,$Updated) = (0,0,0,0,0);
$/ = "\n";
my $in_name = 0;
my @root = split(/[\/\\]+/, $P4ROOT);
my %p4_index = ();
my %p4_a_lc = ();
my %lnames = ();
my %lconflicts = ();
if (opendir(DIR, '.')) {
    $lnames{'.'} = [grep {$_ ne '.' and $_ ne '..'} readdir(DIR)];
    closedir(DIR);
    #print "read $start_dir (",scalar(@{$lnames{'.'}}),")\n";
}
open(my $have, "p4 -G @P4ARGS -c $P4CLIENT -H $P4HOST -d $P4ROOT have |") or
    die "$0: failed to start p4: $!\n";
binmode($have);
$P4HAVE_FILE = "$GIT_DIR/p4/have";
open(my $storedhave, '>', $P4HAVE_FILE) or die "$P4HAVE_FILE: $!\n";
binmode($storedhave);
my $ent;
while (defined($ent=read_pydict_entry($have))) {
    next if !defined($ent->{depotFile}) or !defined($ent->{clientFile});
    my $a = $ent->{depotFile};
    $ent->{clientFile} =~ m!^//[^/]+/(.*)!o;
    my $b = $1;
    my @bb = split(/\/+/, $b);
    print $storedhave "$a\0$ent->{clientFile}\0$ent->{haveRev}\0\n";

    if ( $^O eq 'MSWin32' ) {
	# stupid windows, daft activestate, dumb P4
	# This piece below is checking for file name conflicts
	# which happen on windows because of it mangling the names.
	my $blc = lc $b;
	if ( $#bb > 0 ) {
	    my $path = '.';
	    foreach my $n (@bb[0 .. $#bb -1]) {
		my @conflicts =
		    grep {lc $_ eq lc $n and $_ ne $n} @{$lnames{$path}};
		if (@conflicts and !exists($lconflicts{"$path/$n"})) {
		    warn "warning: $a -> $b\n".
			 "warning: conflict between path \"$path/$n\" and ".
			 "local filesystem in \"@conflicts\"\n";
		    $Conflicts++;
		    $lconflicts{"$path/$n"} = 1;
		}
		$path .= "/$n";
		if (!exists($lnames{$path})) {
		    if (opendir(DIR, $path)) {
			$lnames{$path} =
			    [grep {$_ ne '.' and $_ ne '..'} readdir(DIR)];
			closedir(DIR);
			#print "read $path (",scalar(@{$lnames{$path}}),")\n";
		    }
		}
	    }
	}
	if (!exists($p4_a_lc{$blc})) {
	    $p4_a_lc{$blc} = [$a, $b];
	} else {
	    warn("warning: $a -> $b\n".
		 "warning: conflicts with ".
		 $p4_a_lc{$blc}->[0]." -> ".
		 $p4_a_lc{$blc}->[1]."\n");
	    $Conflicts++;
	    next;
	}
    }

    my $i;
    for ($i = 0; $i < $#bb; ++$i) {
	my $bdir = join('/',@bb[0 .. $i]) . '/';
	if ( !exists($gitignore_dirs{$bdir}) ) {
	    $gitignore_dirs{$bdir} = read_filter_file("$bdir.gitignore");
	}
    }
    if (filtered($b)) {
	print " i $b\n" if $VERBOSE > 3;
	$Ignored++;
	next
    }
    $p4_index{$b} = $a;
    if ( exists($git_index{$b}) ) {
	my $needup = 1;
	if (defined($git_p4_have)) {
	    $prev = $git_p4_have->{$a};
	    if (defined($prev)) {
		$prev->[0] =~ m!^//[^/]+/(.*)!o;
		$needup = 0 if ($b eq $1) and ($prev->[1] eq $ent->{haveRev});
		if ($needup and $VERBOSE > 1) {
		    my $reason;
		    $reason = 'local file' if $b ne $1;
		    $reason = 'revision' if $prev->[1] ne $ent->{haveRev};
		    print "$a ($reason changed)\n";
		}
	    }
	}
	if ($needup) {
	    $Updated++;
	    push(@git_upd, $b);
	}
    } else {
	$Added++;
	if ( $b =~ m/\.(bat|cmd|pl|sh|exe|dll)$/io )
	{ push(@git_addx, $b) } else { push(@git_add, $b) }
    }
}
close($storedhave);
close($have);
undef %p4_a_lc;

@git_del = grep { !exists($p4_index{$_}) } keys %git_index;
$Deleted = $#git_del + 1;

#foreach (keys %git_index)
#{ push(@git_del, $_) if !exists($p4_index{$_}) }

if ( $DRYRUN ) {
    print($#git_add+$#git_addx+ 2," files to add\n") if $VERBOSE;
    print map {" a $_\n"} @git_add if $VERBOSE > 2;
    print map {" a $_\n"} @git_addx if $VERBOSE > 2;
    print($#git_del+1," files to unreg\n") if $VERBOSE;
    print map {" d $_\n"} @git_del if $VERBOSE > 2;
    print($#git_upd+1," files to update\n") if $VERBOSE;
    print map {" u $_\n"} @git_upd if $VERBOSE > 2;
    print "added: $Added, unregd: $Deleted, updated: $Updated, ignored: $Ignored";
    print ", conflicts: $Conflicts" if $Conflicts;
    print "\n";
} else {
    if (@git_add || @git_addx) {
	print($#git_add+$#git_addx+ 2,
	      " files | git update-index --add -z --stdin\n")
	    if $VERBOSE;
	if (@git_add) {
	    open(GIT, '| git update-index --add --chmod=-x -z --stdin') or
		die "$0 git-update-index(add): $!\n";
	    print GIT map {print " a $_\n" if $VERBOSE > 1; "$_\0"} @git_add;
	    close(GIT);
	}
	if (@git_addx) {
	    open(GIT, '| git update-index --add --chmod=+x -z --stdin') or
		die "$0 git-update-index(add): $!\n";
	    print GIT map {print " a $_\n" if $VERBOSE > 1; "$_\0"} @git_addx;
	    close(GIT);
	}
    }

    if (@git_del) {
	print($#git_del+1," files | git update-index --remove -z --stdin\n")
	    if $VERBOSE;
	open(GIT, '| git update-index --force-remove -z --stdin') or
	    die "$0 git-update-index(del): $!\n";
	print GIT map {print " d $_\n" if $VERBOSE > 1; "$_\0"} @git_del;
	close(GIT);
    }

    if (@git_upd) {
	print($#git_upd+1," files | git update-index -z --stdin\n")
	    if $VERBOSE;
	open(GIT, '| git update-index -z --stdin') or
	    die "$0 git-update-index(upd): $!\n";
	print GIT map {print " u $_\n" if $VERBOSE > 1; "$_\0"} @git_upd;
	close(GIT);
    }
    
    print "added: $Added, unregd: $Deleted, updated: $Updated, ignored: $Ignored";
    print ", conflicts: $Conflicts" if $Conflicts;
    print "\n";
    git_p4_commit($git_head, $git_p4_head) if $AUTO_COMMIT;
}

exit 0;

sub filtered {
    my $name = shift;
    study($name);
    my @path = split(/\/+/o, $name);
    my $dir = '';
    $name = '';
    
    foreach my $d (@path) {
	$name .= $d;
#	print STDERR "$dir: $name $d\n" if $v;
	foreach my $re (@{$gitignore_dirs{'/'}}) {
	    return 1 if $name =~ m/$re/;
	    return 1 if $d =~ m/$re/;
	}
	if ( length($dir) and exists($gitignore_dirs{$dir}) ) {
	    foreach my $re (@{$gitignore_dirs{$dir}}) {
		return 1 if $name =~ m/$re/;
		return 1 if $d =~ m/$re/;
	    }
	}
	$name .= '/';
	$dir = $name;
    }
#    print STDERR "$name not filtered\n" if $v;
    return 0;
}

sub read_filter_file {
    my @filts = ();
    my $file = shift;
    if ( open(my $if, '<', $file) ) {
	print "added ignore file $file\n" if $VERBOSE;
	$/ = "\n";
	while (my $l = <$if>) {
	    next if $l =~ /^\s*#/o;
	    next if $l =~ /^\s*$/o;
	    $l =~ s/[\r\n]+$//so;
	    $l =~ s/\./\\./go;
	    $l =~ s/\*/.*/go;
	    if ( $l =~ m/\// ) {
		$l = "^$l($|/)";
	    } else {
		$l = "(^|/)$l\$";
	    }
	    print " filter $l\n" if $VERBOSE > 1;
	    push(@filts, qr/$l/);
	}
	close($if);
    }
    return \@filts;
}

sub r_pystr
{
    my $fd = shift;
    my ($len,$str)=('','');
    my ($c,$rd,$b) = (4,0,'');
    while ($c > 0) {
	$rd = sysread($fd,$b,$c);
	warn("failed to read len: $!"), return undef if !defined($rd);
	warn("not enough data for len"), return undef if !$rd;
	$len .= $b;
	$c -= $rd;
    }
    $len = unpack('V',$len);
    while ($len > 0) {
	$rd = sysread($fd,$b,$len);
	warn("failed to read data: $!"), return undef if !defined($rd);
	warn("not enough data"), return undef if !$rd;
	$str .= $b;
	$len -= $rd;
    }
    return $str;
}

sub read_pydict_entry
{
    my $f = shift;
    my ($buf,$rd);
    FIL: while (1) {
	# object type identifier
	$rd = sysread($f, $buf, 1);
	last FIL if $rd == 0;
	warn("object type: $!\n"),last if $rd != 1;
	# '{' is a python marshalled dict
	warn("object type: not {\n"),last if $buf ne '{';
	my $ent = {};
	PAIR: while (1) {
	    my ($b,$key);
	    # key type identifier
	    $rd = sysread($f, $b, 1);
	    warn("key type: $!\n"),last FIL if $rd != 1;
	    if ($b eq 's') { # length-prefixed string
		$key = r_pystr($f);
		warn("key: $!\n"),last FIL if !defined($b);
	    } elsif ($b eq '0') { # NULL-element, end of entry
		last PAIR;
	    } else {
		warn("key type: not s");
		last FIL;
	    }
	    # value type identifier
	    $rd = sysread($f, $b, 1);
	    warn("$key value type: $!\n"),last FIL if $rd != 1;
	    if ($b eq 's') { # length-prefixed string
		$b = r_pystr($f);
		warn("$key value: $!"),last FIL if !defined($b);
		$ent->{$key} = $b;
	    } else {
		warn("$key value type: not s ($b)");
		last FIL;
	    }
	}
	return $ent;
    }
    return undef;
}

sub cl2msg {
    my $cl = shift;
    my($o1,$o2,$i);
    if(!open($o1, '>>', "$GIT_DIR/p4/msg")) {
	warn "p4/msg: $!\n";
	return;
    }
    binmode($o1);
    if(!open($o2, '>>', "$GIT_DIR/p4/p4msg")) {
	warn "p4/p4msg: $!\n";
	close($o1);
	return
    }
    binmode($o2);
    if(!open($i, '-|', "p4 describe -s $cl")){
	warn "p4 describe: $!\n";
	close($o1);
	close($o2);
	return
    }
    binmode($i);
    print $o1 "$cl: " if $FULL_DESC;
    print $o2 "$cl: ";
    my @a;
    my $u = undef;
    while (my $l = <$i>) {
	if ($l =~ /^Change \d+ by (\S+)@[^ ]* on ([^\r\n]*)/so) {
	    $u = $1;
	    $ENV{GIT_AUTHOR_DATE} = $2 if length($2);
	}
	last if $FULL_DESC < 2 and $l =~ /^\s*Affected files \.{3}\s*$/so;
	$l =~ s/\r?\n$//so;
	push @a, $l;
    }
    close($i);
    print $o2 substr($a[2],1),"\n"; # p4 side-branch commit description
    close($o2);
    # import branch commit description
    if ($FULL_DESC > 1) {
	# desc level 2+: keep the Change line
	print $o1 map {"$_\n"} (substr($a[2],1),"\n",@a);
    } else {
	# levels 0 and 1: remove the Change line
	print $o1 map { (length($_) ? substr($_,1):'')."\n" } @a[2..$#a];
    }
    close($o1);
    if (defined($u)) {
	if (!exists($P4USERS{$u})) {
	    my ($mail,$name) = grep {/^(Email|FullName):/} qx{p4 user -o $u};
	    if ($? == 0 and defined($mail) and defined($name)) {
		s/^\S+:	([^\r\n]*)\r?\n$/$1/so for ($mail,$name);
		if (length($name) and length($mail)) {
		    $P4USERS{$u} = {name=>$name, email=>$mail};
		}
	    }
	}
	if ($P4USERS{$u}) {
	    $p4u = $P4USERS{$u};
	    $ENV{GIT_AUTHOR_NAME}  = $p4u->{name};
	    $ENV{GIT_AUTHOR_EMAIL} = $p4u->{email};
	}
    }
}

sub git_p4_init {
    my ($commit,$parent,$p4commit,$p4parent);
    my ($HEAD) = qx{git rev-parse HEAD};
    $HEAD = '' if $?;
    my ($p4head) = qx{git rev-parse refs/p4import/$P4CLIENT};
    $p4head = '' if $?;
    s/\r?\n//gs for ($HEAD, $p4head);
    die "No HEAD commit! Refusing to import.\n" if !length($HEAD);
    if (length($p4head)) {
	($commit,$p4parent) =
	    grep { s/^parent (.{40}).*/$1/s }
	    qx{git cat-file commit $p4head};
	$commit = $p4parent = '' if $?;
	$p4parent = '' if !defined($p4parent);
    } else {
	$commit = $p4parent = '';
    }
    while (($commit ne $HEAD) and length($p4parent)) {
	$p4head = $p4parent;
	($commit,$p4parent) =
	    grep { s/^parent (.{40}).*/$1/s }
	    qx{git cat-file commit $p4head};
	$commit = $p4parent = '' if $?;
	$p4parent = '' if !defined($p4parent);
	if ($VERBOSE and ($HEAD eq $commit)) {
	    print "found p4 import commit ";
	    system('git','name-rev',$p4head);
	}
    }
    if ($HEAD ne $commit) {
	$HEAD_FROM_P4 = 0;
	warn "Current HEAD is not from $P4CLIENT, doing full import\n";
    } else {
	$HEAD_FROM_P4 = 1;
    }
    my $p4have = undef;
    if (!$FULL_IMPORT and ($HEAD eq $commit) and length($p4head)) {
	if (open(my $f, '-|', "git cat-file blob $p4head:have")) {
	    my $old = $/;
	    $/ = "\0";
	    my $cnt = 0;
	    while(1) {
		my $p4name = <$f>;
		last if !defined($p4name);
		$p4name =~ s/^.//so if $cnt; # remove \n
		my $name = <$f>;
		my $rev = <$f>;
		last if !defined($name) or !defined($rev);
		chop($p4name,$name,$rev);
		++$cnt;
		if (defined($p4have)) {
		    $p4have->{$p4name} = [$name,$rev];
		} else {
		    $p4have = {$p4name=>[$name,$rev]};
		}
	    }
	    $/ = $old;
	    close($f);
	    print "loaded $cnt revisions from $p4head\n" if $VERBOSE;
	}
    }
    return ($HEAD, $p4head, $p4have);
}

sub git_p4_commit {
    my ($HEAD, $p4head) = @_;
    my ($commit,$parent,$p4commit,$p4parent);

    my ($fdo,$fdi,$rc);
    $rc = system('git','diff-index','--exit-code','--quiet','--cached','HEAD');
    if ($rc == 0) {
	warn("No changes\n");
	return;
    }

    return if $DRYRUN;

    if (!@DESC && !$EDIT_COMMIT) {
	warn "$0: no commit description given\n";
	return;
    }

    my $p4x = "$GIT_DIR/p4/idx.tmp";
    unlink($p4x);

    $ENV{PAGER} = 'cat';

    if (!defined($SPEC) or !open(STDIN, '<', $SPEC)) {
	if ( $^O eq 'MSWin32' ) {
	    open(STDIN, '<', 'NUL') or die "$SPEC: $!\n";
	} else {
	    open(STDIN, '<', '/dev/null') or die "$SPEC: $!\n";
	}
    }
    my ($p4spec) = qx{git hash-object -t blob -w --stdin};
    die "Failed to store $SPEC in git repo\n" if $?;

    open(STDIN, '<', "$GIT_DIR/p4/client.def") or die "cldef: $!\n";
    my ($p4clnt) = qx{git hash-object -t blob -w --stdin};
    die "Failed to save mappings of $P4CLIENT in git repo" if $?;

    if (!defined($P4HAVE_FILE)) {
	print "reading state of $P4CLIENT\n" if $VERBOSE;
	$P4HAVE_FILE = "$GIT_DIR/p4/have"; 
	open($fdo, '>', $P4HAVE_FILE) or die "p4/have: $!\n";
	binmode($fdo);
	open($fdi, "p4 -G @P4ARGS -c $P4CLIENT -H $P4HOST -d $P4ROOT have|") or
	    die "p4 have: $!\n";
	binmode($fdi);
	my $ent;
	while (defined($ent=read_pydict_entry($fdi))) {
	    next if !defined($ent->{depotFile});
	    next if !defined($ent->{clientFile});
	    print $fdo "$ent->{depotFile}\0",
		       "$ent->{clientFile}\0",
		       "$ent->{haveRev}\0\n";
	}
	close($fdi);
	close($fdo);
    }

    open(STDIN, '<', $P4HAVE_FILE) or die "$P4HAVE_FILE: $!\n";
    my ($p4have) = qx{git hash-object -t blob -w --stdin};
    die "Failed to save state of $P4CLIENT in git repo" if $?;

    #
    # Prepare commit messages
    #
    unlink("$GIT_DIR/p4/msg", "$GIT_DIR/p4/p4msg");
    open($fdo, '>', "$GIT_DIR/p4/msg"); close($fdo);
    open($fdo, '>', "$GIT_DIR/p4/p4msg"); close($fdo);

    foreach my $i (@DESC) {
	$i =~ s/^(.)//o;
	if ('c' eq $1) {
	    print "reading changes for $i\n" if $VERBOSE;
	    cl2msg($i);
	} elsif ('f' eq $1) {
	    my($o1,$o2,$i);
	    if (open($o1, '>>', "$GIT_DIR/p4/msg")) {
		if (open($o2, '>>', "$GIT_DIR/p4/p4msg")) {
		    if (open($i, '<', $i)) {
			my $n = 0;
			while(<$i>) {
			    $n++;
			    print $o1 $_;
			    print $o2 $_ if $n == 1;
			}
			close($i);
		    }
		    close($o2);
		}
		close($o1);
	    }
	} elsif ('4' eq $1) {
	    print "reading changes for $i\n" if $VERBOSE;
	    my ($change)=qx{p4 changes -m1 $i};
	    if (!defined($change) or $change !~ m/\s+(\d+)\s/) {
		die "$i does not resolve into a change number\n";
	    }
	    cl2msg($1);
	}
    }
    system("$editor $GIT_DIR/p4/msg") if $EDIT_COMMIT;

    # copy mirror-branch commit message into side-branch
    # commit message if no other description were given.
    if (!-s "$GIT_DIR/p4/p4msg") {
	open($fdi, '<', "$GIT_DIR/p4/msg") or die "$GIT_DIR/p4/msg: $!\n";
	sysread($fdi,$buf,-s "$GIT_DIR/p4/msg");
	close($fdi);
	open($fdo, '>>', "$GIT_DIR/p4/p4msg") or die "$GIT_DIR/p4/p4msg: $!\n";
	syswrite($fdo,$buf);
	close($fdo);
    }

    #
    # Store the imported file data
    #

    if ($VERBOSE < 2) {
	if ( $^O eq 'MSWin32' ) { open(STDERR, "NUL") }
	else { open(STDERR, "/dev/null") }
    }

    my ($tree) = qx{git write-tree};
    die "Failed to write current tree\n" if $?;
    $parent = length($HEAD) ? "-p $HEAD": '';
    open(STDIN, '<', "$GIT_DIR/p4/msg") or die "p4/msg: $!\n";
    $tree =~ s/\r?\n//gs;
    ($commit)=qx{git commit-tree $tree $parent};
    die "failed to commit current tree\n" if $?;
    s/\r?\n//gs for ($commit);
    print "current tree stored in commit $commit\n" if $VERBOSE;

    #
    # Storing import control data
    #
    $ENV{GIT_INDEX_FILE} = $p4x;
    open($fdo, '|-', 'git update-index --add --index-info') or
	die "could not start git update-index\n";
    binmode($fdo);
    s/\r?\n//gs for ($p4spec,$p4clnt,$p4have);
    print $fdo "100644 $p4spec\tspec\n";
    print $fdo "100644 $p4clnt\tclient\n";
    print $fdo "100644 $p4have\thave\n";
    close($fdo);
    if($?) {
	die "Failed to store $SPEC in p4import index and git repo\n".
	    "Failed to save mappings of $P4CLIENT in p4import index and git repo\n".
	    "Failed to save state of $P4CLIENT in p4import index and git repo\n"
    }
    my ($p4tree)=qx{git write-tree};
    die "Failed to store $SPEC (tree) in git repo\n" if $?;

    # Bind import control data to the file data
    $p4parent="-p $commit";
    $p4parent="$p4parent -p $p4head" if length($p4head);
    open(STDIN, '<', "$GIT_DIR/p4/p4msg") or die "p4/p4msg: $!\n";
    $p4tree =~ s/\r?\n//gs;
    ($p4commit)=qx{git commit-tree $p4tree $p4parent};
    die "Failed to store $SPEC (commit) in git repo\n" if $?;
    $p4commit =~ s/\r?\n//gs;

    # Finishing touches: update references
    system('git','update-ref','-m','backup ref of current branch',
	   'p4/backup-HEAD','HEAD');
    system('git','update-ref','-m','backup ref of p4import',
	   'p4/backup-p4import',"refs/p4import/$P4CLIENT");
    $rc = system('git','update-ref','-m','data of p4import','HEAD',$commit);
    die "Failed to update HEAD\n" if $rc;
    $rc = system('git','update-ref','-m','p4import',"refs/p4import/$P4CLIENT",$p4commit);
    die "Failed to store $SPEC (reference) in git repo\n" if $rc;

    if ($VERBOSE) {
	print STDOUT (grep {s/\r?\n//gs;s/.*?\s//} qx{git name-rev refs/p4import/$P4CLIENT}), ":\n";
	system('git','log','--max-count=1','--pretty=format:%h %s%n',$p4commit);
    }
    print STDOUT (grep {s/\r?\n//gs;s/.*?\s//} qx{git name-rev HEAD}), ":\n";
    system('git','log','--max-count=1','--pretty=format:%h %s%n',$commit);
}
