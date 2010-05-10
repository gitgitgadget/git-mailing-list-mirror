From: Alex Vandiver <alex@chmrr.net>
Subject: Re: avoiding anonymous commits from root/shared accounts
Date: Mon, 10 May 2010 17:11:23 -0400
Message-ID: <1273525498-sup-6628@utwig>
References: <4BE83CCD.2090505@letterboxes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 10 23:36:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBadq-00081q-5t
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 23:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756199Ab0EJVfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 17:35:53 -0400
Received: from chmrr.net ([209.67.253.66]:50660 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756069Ab0EJVfw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 17:35:52 -0400
X-Greylist: delayed 1469 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 May 2010 17:35:52 EDT
Received: from chmrr by utwig.chmrr.net with local (Exim 4.71)
	(envelope-from <chmrr@chmrr.net>)
	id 1OBaG3-0003B5-7J
	for git@vger.kernel.org; Mon, 10 May 2010 17:11:23 -0400
In-reply-to: <4BE83CCD.2090505@letterboxes.org>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146856>

At Mon May 10 13:05:17 -0400 2010, Nick wrote:
> [snip]
> The best idea I've come across seems to be some sort of wrapper for git, which
> if no $GIT_USER_* is defined, can use $SUDO_USER and/or `who am i` to identify
> the original log-in account, and sets $GIT_AUTHOR_NAME etc. - else if it can't
> do this, it refuses to commit.  Or perhaps it would be a script which spawns a
> shell with the right environment to invoke git commands from, after successfully
> determining the identity.

At work, we have a number of repositories which we store server
configurations in, most of which are only writable as root.  We use
the script below to ensure that git mostly doesn't lie about the
authors of commits.  This won't solve your problem of people logging
in under shared credentials -- and it also _does_ allow commits as
'root' if you logged in directly as root -- but it's perhaps a partial
solution for you.

 - Alex

-------------------->8--------------------
#!/usr/bin/perl

use strict;
use warnings;
use constant EMAIL_DOMAIN => "example.com";

setenv( get_user($$) );
exec("/usr/bin/git", @ARGV);

sub setenv {
    my $user = shift;

    # If they're _really_ _really_ root, just bail now
    return if $user eq "root";

    # Ditto if we can't find the user (?!)
    my @getpw = getpwnam($user);
    return unless @getpw;

    my $name;
    my $email;

    # See if we can pull from the user's config
    my $gitconfig = "$getpw[7]/.gitconfig";
    if (-r $gitconfig) {
        $name  = `/usr/bin/git config --file $gitconfig user.name`;
        chomp $name;
        $email = `/usr/bin/git config --file $gitconfig user.email`;
        chomp $email;
    }

    # Fall back to getent
    $name  ||= $getpw[6] || $user;
    $email ||= $user . '@' . EMAIL_DOMAIN;

    $ENV{GIT_AUTHOR_NAME} = $name;
    $ENV{GIT_AUTHOR_EMAIL} = $email;
}

sub get_user {
    my $pid = shift;

    # See if the PID is bogus
    return "root" unless $pid and kill 0, $pid;

    # Pull out the env from it
    my %env = getenv($pid);

    # Simplest case -- check USER first
    if ($env{USER} and $env{USER} ne "root") {
        return $env{USER};
    }

    # Or we're running under sudo
    if ($env{SUDO_USER} and $env{SUDO_USER} ne "root") {
        return $env{SUDO_USER};
    }

    # They did something like `sudo su -`
    return get_user(parent_pid($pid));
}

sub getenv {
    my $pid = shift;
    my $env = do {local @ARGV = ("/proc/$pid/environ"); local $/; <>};
    my @lines = split /\0/, $env;
    return () unless grep {/=/} @lines;
    my %env = map {split /=/, $_, 2} @lines;
    return %env;
}

sub parent_pid {
    my $pid = shift;
    my $stat = do {local @ARGV = ("/proc/$pid/stat"); local $/; <>};
    my (undef, undef, undef, $ppid) = split ' ', $stat;
    return $ppid;
}
-- 
Networking -- only one letter away from not working
