From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC PATCH] git-svn info: implement info command
Date: Sat, 17 Nov 2007 14:54:02 -0800
Message-ID: <20071117225402.GC28755@muzzle>
References: <1194884349-11504-1-git-send-email-ddkilzer@kilzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "David D. Kilzer" <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Sat Nov 17 23:54:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItWYR-0005V6-Fy
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 23:54:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974AbXKQWyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 17:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752129AbXKQWyF
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 17:54:05 -0500
Received: from hand.yhbt.net ([66.150.188.102]:33747 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751954AbXKQWyE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 17:54:04 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id DF69A7DC0FE;
	Sat, 17 Nov 2007 14:54:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1194884349-11504-1-git-send-email-ddkilzer@kilzer.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65317>

"David D. Kilzer" <ddkilzer@kilzer.net> wrote:
> Implement "git-svn info" for files and directories based on the "svn info"
> command.  Note that the -r/--revision argument is not supported yet.
> 
> Added 18 tests in t/t9117-git-svn-info.sh.
> 
> Signed-off-by: David D. Kilzer <ddkilzer@kilzer.net>
> ---
> 
> Looking for feedback on this patch.  Specifically, I'm looking for insight
> for the two FIXME comments in the cmd_info() function added to git-svn.
> (I can't help but think I'm missing a plumbing command or a basic concept.
> Pointers to code, web pages or man pages are welcome.)
> 
> Note that I've tried to cover all the bases that "svn info" does (by using
> tests), except supporting the -r/--revision argument.

Hi David,

Wow.  I can honestly say I've never even noticed the "Schedule:" field
in `svn info'.  I would've been perfectly happy to accept an
implementation of `git svn info' without that :)

> I've also tried to be aggressive in extracting common code into functions.

I like it, but this should be a separate patch.

> +sub canonicalize_path {
> +	my ($path) = @_;
> +	my $dotSlashAdded = 0;

camelCase variables requires more time for the brain to parse (they're
easier to write, but take more time to read), please use snake_case like
the rest of git-svn (and git).

> +sub cmd_info {
> +	my $path = canonicalize_path(shift or ".");
> +	unless (scalar(@_) == 0) {
> +		die "Too many arguments specified\n";
> +	}
> +
> +	# FIXME: We use a combination of git-diff, git-ls-files and git-cat-file
> +	# to divine the state and type of object that was passed in as $path.
> +	# There has to be a better way.  Note that only $diffStatus is used
> +	# beyond setting $isDirectory below.

I agree it's pretty ugly.  You can probably expand git-runstatus to do
this.  git-commit.sh used to use something like this until git-runstatus
was added.  On the other hand, I'd be content if we dropped support
for this info entirely since `git-status' is perfectly good.

IMNSHO, "URL:" and "Repository Root:" and occasionally "Revision:" (on the
top-level directory) would be the only useful things this command would
have to offer.

Being able to run something like `git svn info --url <path>'
to get something like http://svn.foo.org/project/trunk/<path> would be
nice, too.

> +
> +	my $diffStatus = (split(' ', command_oneline(qw(diff --cached --name-status --), $path) || ""))[0] || "";

Please wrap lines at 80 characters.  I have a hard time following long
lines.

> +		my $checksum;
> +		# FIXME: We fail to generate the correct checksum for deleted
> +		# symlinks here.  How do we know if a deleted file was a symlin

git ls-tree HEAD <filename> will show the mode of a deleted file

> @@ -0,0 +1,236 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2007 David D. Kilzer
> +
> +test_description='git-svn info'
> +
> +. ./lib-git-svn.sh
> +
> +test_expect_success 'setup repository and import' "
> +	rm -rf info gitwc svnwc &&

All git tests should start you off on a clean trash/ directory...

> +	mkdir info &&
> +	cd info &&
> +		echo one > file &&
> +		ln -s file symlink-file &&
> +		mkdir directory &&
> +		touch directory/.placeholder &&
> +		ln -s directory symlink-directory &&
> +		svn import -m 'initial' . $svnrepo &&
> +	cd .. &&
> +	mkdir gitwc &&
> +	cd gitwc &&
> +		git-svn init $svnrepo &&
> +		git-svn fetch &&
> +	cd .. &&
> +	svn co $svnrepo svnwc &&
> +	touch -c -r svnwc/file gitwc/file &&
> +	touch -c -r svnwc/directory gitwc/directory &&
> +	touch -c -r svnwc/symlink-file gitwc/symlink-file &&
> +	touch -c -r svnwc/symlink-directory gitwc/symlink-directory

Are -r and -c portable?  I remember writing test-chmtime to workaround
some arguments for touch not being portable.

> +test_expect_success 'info no arguments' "
> +	(cd svnwc; svn info) > expected.info-no-arguments &&
> +	(cd gitwc; git-svn info) > actual.info-no-arguments &&
> +	diff -u expected.info-no-arguments actual.info-no-arguments
> +	"

Can we expect the output of "svn info" to not change between
versions?  I know "svn status" has changed between versions of
svn.  I'd prefer if we keep the expected.* files hard-coded
in a test directory and compare those instead.  Maybe use sed
to substitute placeholders for timestamps..

Also, git-diff can be used against arbitrary files nowadays, no
need to rely on a working diff command in the system :)

> +test_expect_success 'info added-file' "
> +	echo two > gitwc/added-file &&
> +	cd gitwc &&
> +		git add added-file &&
> +	cd .. &&
> +	cp -p gitwc/added-file svnwc/added-file &&

I can't remember if cp -p is portable, either...

-- 
Eric Wong
