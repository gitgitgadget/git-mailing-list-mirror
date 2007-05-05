From: Alex Riesen <raa.lkml@gmail.com>
Subject: Yet another Perforce importer
Date: Sun, 6 May 2007 00:48:05 +0200
Message-ID: <20070505224805.GD2898@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 06 00:48:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkT31-0002IV-2d
	for gcvg-git@gmane.org; Sun, 06 May 2007 00:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754565AbXEEWsL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 18:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934030AbXEEWsL
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 18:48:11 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:43240 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754565AbXEEWsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2007 18:48:09 -0400
Received: from tigra.home (195.4.202.37)
	by post.webmailer.de (klopstock mo53) (RZmta 5.9)
	with ESMTP id E042e9j45ISAGM for <git@vger.kernel.org>;
	Sun, 6 May 2007 00:48:05 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 8D5D7277BD
	for <git@vger.kernel.org>; Sun,  6 May 2007 00:48:05 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 61AD2D171; Sun,  6 May 2007 00:48:05 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTl9Ag==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46290>

I was unhappy with the existing importer because it did not allow to
commit the current state of a client, and did not allow to find out
how this client state was produced. This script does this and also
allows for updating git repo incrementally (so that the files which
"officially" did not change will not be reupdated. Active by default,
but can be switched off to do a complete import, see --full).

It is a perl script again, sorry. This one is developed and tested
with ActiveState Perl (which explains the binmode after each and every
open), so use with caution. If you're lucky to use Perforce in a POSIX
environment - remove the binmodes and windows-related hack to detect
case-sensitivity problems in filenames. I have no idea what would they
break there.

The script has some provisions for Windows Maloperating System:
it tries to figure out the conflicts caused by disability in its
filesystems with regard to case insensitivity. It is enabled
automatically for ActiveState Perl. If you see warnings about some
conflicts it usually means that the state in the working directory
cannot be trusted anymore (and is a fairly typical error in
environments contaminated with windows).  The script does not reread
the files from p4 server (I admit being lazy), it just trusts the
working directory and will do in such a case an untrustworthy commit.
(the reason behind this is that at work, where I have to use perforce,
I had to give up arguing with everyone about this problem. The people
who could do something about it just don't care about the fact that
the stupid thing they've chosen has very non-windows rules regarding
filenames. Either they are deaf, or dumb, or both).

The client definition, the state and the information how you got the
state are saved in a side branch (refs/p4import/<client-name>), which
references the previous imported state (if any) and the git commit
just made (if --yes passed). The result looks funny in gitk but works
good enough for incremental imports (see the first while in git_p4_init).

"The information how you got the client state" must be given and is
expected to be a file which will be stored on the side branch under
the name "spec". The story behind this is that Perforce was so bad for
the workflow we have here at work, that direct use of the system is
discouraged (like in "made impossible") and IT&Tooling Department
"provided" us with a program which can take a configuration file which
has mapping and revision information. So now you can bind the history
of a project in one place: the linear history of this configuration
file. Good idea, if you're stuck with Perforce (and good job by
Perforce to have us stuck with them), if implemented rightly. It
wasn't of course, but this is another long and depressing story.
Remote-to-local mapping and the revisions of files are stored in "have",
and the client definition - in "client" on that side branch.

Being work in progress, the script does not commit anything by
default (use -y|--yes to commit), just updates the index.

Probably, wont work without initial commit. Can't remember testing
that.

Does not touch your Perforce client (except for reading). Don't forget
to log in, though. I found that environment variables (P4SERVER or
P4PASSWD) sometimes work (they stopped recently).

Expects to find P4 and Git tools in path (p4 and git, specifically).

Not tested in POSIX environment (I'm not allowed to have any at work,
and I promise to kill anyone who tries to install Perforce in my home
network).

Quite memory hungry. Slow (but Git works so much faster than perforce
so I really couldn't care less: I sync with central server one-two
times a day).

On windows: will have problems with long pathnames (can break on w2k,
try using wxp).

On windows: avoid Ctrl-C or closing the console window while the
script is running.  Interrupted script shouldn't corrupt anything but
the act can take your whole system down (happened to me twice or
trice).

The script:


#!/usr/bin/perl -w

local $VERBOSE = 0;
local $DRYRUN = 0;
local $AUTO_COMMIT = 0;
local $JUST_COMMIT = 0;
local $P4CLIENT = undef;
local @EDIT_COMMIT = 0;
local @FULL_IMPORT = 0;
local @DESC = ();
local $SPEC = undef;
local @P4ARGS = ();
local $P4HAVE_FILE = undef;
push(@P4ARGS, '-P', $ENV{P4PASSWD})
    if defined($ENV{P4PASSWD}) and length($ENV{P4PASSWD});
use Cwd;
local $start_dir = cwd();

sub read_args {
    my ($in_client, $in_cl, $in_fi, $in_p4) = (0,0,0,0);
    foreach my $f ( @_ ) {
	if ($in_client) { $in_client = 0; $P4CLIENT = $f; next }
	if ($in_cl) { $in_cl=0; push(@DESC,"c$f"); next }
	if ($in_fi) { $in_fi=0; push(@DESC,"f$f"); next }
	if ($in_p4) { $in_p4=0; push(@DESC,"4$f"); next }
	$DRYRUN=1, next if $f eq '-n' or $f eq '--dry-run';
	$AUTO_COMMIT=1, next if $f eq '-y' or $f eq '--yes';
	$JUST_COMMIT=1, next if $f eq '--just-commit';
	$EDIT_COMMIT=1, next if ($f eq '-e') or ($f eq '--edit');
	$FULL_IMPORT=1, next if $f eq '--full';
	$VERBOSE++, next if $f eq '-v' or $f eq '--verbose';
	$in_client = 1, next if $f eq '--client';
	$in_cl = 1, next if $f eq '-C';
	$in_fi = 1, next if $f eq '-F';
	$in_p4 = 1, next if ($f eq '--ptr') or ($f eq '--p4');
	if ($f eq '--help' or $f eq '-h') {
	    print <<EOF;
$0 <specification> [-n|--dry-run] [-y|--yes] [--client <client-name>] \
[-e|--edit] [--just-commit] [--full] [-v|--verbose] [-C <change-number>] \
[-F <filename>] [--ptr|--p4 <p4-path-and/or-revision>]

Perforce client state importer. Creates a git commit on the current
branch from a state the given p4 client and working directory hold.

<specification> must be given and is expected to be a file which will be
stored on the side branch under the name "spec".
Remote-to-local mapping and the revisions of files are stored in "have",
and the client definition - in "client".

--client client	Specify client name (saved in .git/p4/client for the next time)
--full		Perform full import, don't even try to figure out what changed
-y|--yes	Commit automatically (by default only index updated)
--just-commit	To be used after you forgot to run with --yes first time
-n|--dry-run	Do not update the index and do not commit
-e|--edit	Edit commit description before committing
-v|--verbose	Be more verbose. Can be given many times, increases verbosity
-F file		Take description for the commit from a file in the
		next parameter
-C change	Take description for the commit from this p4 change
--p4|--ptr p4-path-and/or-revision Take description for the commit from the p4
		change described by this p4 path, possibly including revision
		specification

The descriptions taken from p4 changes given by -C and --p4 will
be concatenated if the options given multiple times.

EOF
	    exit(0);
	}
	warn("$0: spec already set, $f ignored\n"),next if defined($SPEC);
	$SPEC = $f;
    }
}
read_args(@ARGV);

local ($GIT_DIR) = qx{git rev-parse --git-dir};
$GIT_DIR =~ s/\r?\n$//s if defined($GIT_DIR);
die "$0: git directory not found\n" if !defined($GIT_DIR) or !-d $GIT_DIR;
$ENV{VISUAL} = 'vim' unless defined($ENV{VISUAL});
local $editor = $ENV{VISUAL};
$editor = $ENV{EDITOR} unless defined($editor);
die "$0: no editor defined\n" unless defined($editor);
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
    print $o1 "$cl: ";
    print $o2 "$cl: ";
    my @a;
    while (my $l = <$i>) {
	last if $l =~ /^\s*Affected files \.{3}\s*$/so;
	$l =~ s/\r?\n$//so;
	push @a, $l;
    }
    close($i);
    print $o2 substr($a[2],1),"\n";
    close($o2);
    print $o1 map {"$_\n"} (substr($a[2],1),"\n",@a);
    close($o1);
}

sub git_p4_init {
    my ($commit,$parent,$p4commit,$p4parent);
    my ($HEAD, $p4head) = qx{git rev-parse HEAD refs/p4import/$P4CLIENT};
    $HEAD = $p4head = '' if $?;
    s/\r?\n//gs for ($HEAD, $p4head);
    if (length($p4head)) {
	($commit,$p4parent) =
	    grep { s/^parent (.{40}).*/$1/s }
	    qx{git cat-file commit $p4head};
	$commit = $p4parent = '' if $?;
    } else {
	$commit = $p4parent = '';
    }
    while (($commit ne $HEAD) and length($p4parent)) {
	$p4head = $p4parent;
	($commit,$p4parent) =
	    grep { s/^parent (.{40}).*/$1/s }
	    qx{git cat-file commit $p4head};
	$commit = $p4parent = '' if $?;
	if ($VERBOSE and $HEAD eq $commit) {
	    print "found p4 import commit ";
	    system('git','name-rev',$p4head);
	}
    }
    warn "Current HEAD was not imported from $P4CLIENT\n" if $HEAD ne $commit;
    my $p4have = undef;
    if (!$FULL_IMPORT and $HEAD eq $commit) {
	if (open(my $f, '-|', "git cat-file -p $p4head:have")) {
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

    my $p4x = "$GIT_DIR/p4/idx.tmp";
    unlink($p4x);
    my $oldidx = $ENV{GIT_INDEX_FILE};

    $ENV{PAGER} = 'cat';
    $ENV{GIT_INDEX_FILE} = $p4x;

    open(STDIN, '<', $SPEC) or die "$SPEC: $!\n";
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

    unlink("$GIT_DIR/p4/msg", "$GIT_DIR/p4/p4msg");
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
    system($editor, "$GIT_DIR/p4/msg") if $EDIT_COMMIT;

    #
    # Store the imported file data
    #
    if (defined($oldidx)) { $ENV{GIT_INDEX_FILE} = $oldidx }
    else { delete $ENV{GIT_INDEX_FILE} }

    if ( $^O eq 'MSWin32' ) { open(STDERR, "NUL") }
    else { open(STDERR, "/dev/null") }

    my ($tree) = qx{git write-tree};
    die "Failed to write current tree\n" if $?;
    $parent = length($HEAD) ? "-p $HEAD": '';
    open(STDIN, '<', "$GIT_DIR/p4/msg") or die "p4/msg: $!\n";
    $tree =~ s/\r?\n//gs;
    ($commit)=qx{git commit-tree $tree $parent};
    die "failed to commit current tree\n" if $?;
    s/\r?\n//gs for ($commit);

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
    $rc = system('git','update-ref','-m','data of p4import','HEAD',$commit);
    die "Failed to update HEAD\n" if $rc;
    $rc = system('git','update-ref','-m','p4import',"refs/p4import/$P4CLIENT",$p4commit);
    die "Failed to store $SPEC (reference) in git repo\n" if $rc;

    print STDOUT (grep {s/\r?\n//gs;s/.*?\s//} qx{git name-rev refs/p4import/$P4CLIENT}), ":\n";
    system('git','log','--max-count=1','--pretty=format:%h %s%n',$p4commit);
    print STDOUT (grep {s/\r?\n//gs;s/.*?\s//} qx{git name-rev HEAD}), ":\n";
    system('git','log','--max-count=1','--pretty=format:%h %s%n',$commit);
}
