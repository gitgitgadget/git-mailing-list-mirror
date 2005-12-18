From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-grep: convert from bash to sh
Date: Sun, 18 Dec 2005 11:37:54 -0800
Message-ID: <7vr78amc19.fsf@assigned-by-dhcp.cox.net>
References: <20051218152639.5c14bc26.tihirvon@gmail.com>
	<20051218145621.GX22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 18 20:38:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eo4M8-0006A7-LH
	for gcvg-git@gmane.org; Sun, 18 Dec 2005 20:38:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965249AbVLRTh4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Dec 2005 14:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965250AbVLRTh4
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Dec 2005 14:37:56 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:60386 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S965249AbVLRThz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Dec 2005 14:37:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051218193610.ZCOE17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 18 Dec 2005 14:36:10 -0500
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13799>

Petr Baudis <pasky@suse.cz> writes:

> I'm kind of sensitive to this stuff. I still passionately hate scp
> making me to double-quote remote filenames. It's just evil.

OK.

>  	--ignored|--exclude=*|\
>  	--exclude-from=*|\--exclude-per-directory=*)
> -		git_flags=("${git_flags[@]}" "$1")
> +		git_flags="$git_flags '$1'"

SQs in --exclude= or --exclude-from= parameter?  E.g.

	git grep --exclude-from="/cygdrive/c/pasky's patterns/cvsignore" \
		-e foobar

>  	-A|-B|-C|-D|-d|-f|-m)
> -		flags=("${flags[@]}" "$1" "$2")
> +		flags="$flags '$1' '$2'"
>  		shift

SQs in $2 for -f.  About other flags, -[ABCm] take only numbers
and -[Dd] take read/skip/recurse, so as long as your user does
not screw up you are OK.  And malicious users are shooting
themselves in the foot here so we might not care too much being
loose.

> @@ -46,5 +46,6 @@ done
>  [ "$pattern" ] || {
>  	usage
>  }
> -git-ls-files -z "${git_flags[@]}" "$@" |
> -	xargs -0 grep "${flags[@]}" -e "$pattern"
> +pattern="$(echo "$pattern" | sed 's/[\\"]/\\&/g')"
> +eval git-ls-files -z "$git_flags" '"$@"' |
> +	eval xargs -0 grep "$flags" -e '"$pattern"'

You are not expanding $pattern in the outer shell that builds
eval arguments (letting the inner shell expand "$pattern" and
use it), so I do not think you need that sed script to muck with
it there.  The eval'ed string is literally "$pattern" including
double quotes because you have sq around the last parameter to
"eval" command, and eval would do the right thing, no?

Actually the use of sed script there is actively wrong.  When a
file contains these lines:

        printf("%s is not there\n");
        printf("\"%s\" is not there\n");

the command to pick up the second line should be:

	$ git-grep -e '\\"%s\\"'

but I think your version passes \\\\\"%s\\\\\ to underlying
grep.  Removing that single line would make it do the right
thing, I think.


Enough nitpicking.  If you want to stay in shell and want to
avoid shell array, you would either need to be a bit more
careful if you are going to use eval, or do something like what
I originally did, which made Linus' brain shut down and had him
gouge his eyes with a spoon.  It is the one that this one is a
response to:

	http://marc.theaimsgroup.com/?l=git&m=112656882627760

Not that I am suggesting the latter is better than a bit more
careful 'eval' construction ;-).

I am not happy with that [@] thing either. I have the attached
laying around in my working tree --- I do not remember if I
finished it or not; it's a WIP when I thought about this issue
last time and wondered if we might be better off rewriting the
whole thing.

-- >8 --
#!/usr/bin/perl
#
# Copyright (c) 2005 Junio C Hamano
#

use strict;
my (@git_flag, @grep_flag, $pattern);
my $nargs = 100;

my (%git_ls_files_flag) =
    map { '--' . $_ => 1 }
    qw{cached deleted others kiled ignored
       exclude= exclude-from= exclude-per-directory=};

sub is_git_flag {
    my ($arg) = @_;
    $arg =~ s/^([^=]*)=/$1/;
    return (exists $git_ls_files_flag{$arg});
}

while (@ARGV) {
    my ($arg) = shift @ARGV;
    if (is_git_flag($arg)) {
	push @git_flag, $arg;
    }
    elsif ($arg eq '-e') {
	$pattern = shift @ARGV;
    }
    elsif ($arg =~ /^-[ABCDdfm]$/) {
	push @grep_flag, $arg, (shift @ARGV);
    }
    elsif ($arg =~ /^--$/) {
	shift @ARGV;
	last;
    }
    elsif ($arg =~ /^-/) {
	push @grep_flag, $arg;
    }
    elsif (! defined $pattern) {
	$pattern = $arg;
	last;
    }
    else {
	last;
    }
}

my $ih;
open $ih, '-|', qw(git-ls-files -z), @git_flag, @ARGV;
$/ = "\0";
my @args = ();
while (<$ih>) {
    chomp;
    push @args, $_;
    if ($nargs <= @args) {
	system 'grep', @grep_flag, '-e', $pattern, @args;
	@args = ();
    }
}
close $ih;
if (@args) {
    system 'grep', @grep_flag, '-e', $pattern, @args;
}
