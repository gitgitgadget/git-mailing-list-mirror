From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: [PATCH 0/3] Implement git-svn: info
Date: Tue, 20 Nov 2007 22:43:16 -0800
Message-ID: <1195627399-25209-1-git-send-email-ddkilzer@kilzer.net>
References: <20071117225402.GC28755@muzzle>
Cc: git@vger.kernel.org, "David D. Kilzer" <ddkilzer@kilzer.net>
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Nov 21 07:43:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IujJE-0003I2-PI
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 07:43:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754809AbXKUGnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 01:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754230AbXKUGnW
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 01:43:22 -0500
Received: from mail-out4.apple.com ([17.254.13.23]:55940 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbXKUGnU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 01:43:20 -0500
Received: from relay13.apple.com (relay13.apple.com [17.128.113.29])
	by mail-out4.apple.com (Postfix) with ESMTP id 2660419CCE00;
	Tue, 20 Nov 2007 22:43:20 -0800 (PST)
Received: from relay13.apple.com (unknown [127.0.0.1])
	by relay13.apple.com (Symantec Mail Security) with ESMTP id 023C02804F;
	Tue, 20 Nov 2007 22:43:20 -0800 (PST)
X-AuditID: 1180711d-9eababb0000008bf-d5-4743d387e5b0
Received: from localhost.localdomain (unknown [17.151.112.145])
	by relay13.apple.com (Apple SCV relay) with ESMTP id B27EE28058;
	Tue, 20 Nov 2007 22:43:19 -0800 (PST)
X-Mailer: git-send-email 1.5.3.4
In-Reply-To: <20071117225402.GC28755@muzzle>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65596>

I've split the original RFC patch into two patches (one for the
refactoring changes, and one for implementing the "git svn info"
command), and added a third to imlement "git svn info --url" per
Eric's request.

Eric Wong <normalperson@yhbt.net> wrote:
> "David D. Kilzer" <ddkilzer@kilzer.net> wrote:
> > Implement "git-svn info" for files and directories based on the "svn info"
> > command.  Note that the -r/--revision argument is not supported yet.
> [...]
> Wow.  I can honestly say I've never even noticed the "Schedule:" field
> in `svn info'.  I would've been perfectly happy to accept an
> implementation of `git svn info' without that :)

I never noticed it, either, until I went to implement this feature!
My goal is to stay as true to the "svn info" output as "git svn log"
has done for "svn log".

> > I've also tried to be aggressive in extracting common code into functions.
> I like it, but this should be a separate patch.

See Patch 1/3.

> camelCase variables requires more time for the brain to parse (they're
> easier to write, but take more time to read), please use snake_case like
> the rest of git-svn (and git).

I've switched all variables from camelCase to snake_case.  Sorry...old
habit.

> > +	# FIXME: We use a combination of git-diff, git-ls-files and git-cat-file
> > +	# to divine the state and type of object that was passed in as $path.
> > +	# There has to be a better way.  Note that only $diffStatus is used
> > +	# beyond setting $isDirectory below.
> 
> I agree it's pretty ugly.  You can probably expand git-runstatus to do
> this.  git-commit.sh used to use something like this until git-runstatus
> was added.  On the other hand, I'd be content if we dropped support
> for this info entirely since `git-status' is perfectly good.

I thought I saw a patch on the mailing list to remove git-runstatus
after rewriting git-status in C.  Because of that, I extracted this
code into a find_file_type_and_diff_status() function in Patch 2/3.
The logic in the function is much easier to follow now, and this also
resulted in cleaning up the cmd_info() function.

> IMNSHO, "URL:" and "Repository Root:" and occasionally "Revision:" (on the
> top-level directory) would be the only useful things this command would
> have to offer.

See above about emulating "svn info" as closely as possible.

> Being able to run something like `git svn info --url <path>'
> to get something like http://svn.foo.org/project/trunk/<path> would be
> nice, too.

See Patch 3/3.

> Please wrap lines at 80 characters.  I have a hard time following long
> lines.

Everything has been rewrapped for 80 columns.

> git ls-tree HEAD <filename> will show the mode of a deleted file

Thanks, used this with success in find_file_type_and_diff_status().

> > +	rm -rf info gitwc svnwc &&
> All git tests should start you off on a clean trash/ directory...

Removed.

> > +	touch -c -r svnwc/symlink-directory gitwc/symlink-directory
> Are -r and -c portable?  I remember writing test-chmtime to workaround
> some arguments for touch not being portable.

The touch and cp commands were removed after restructuring the
t/t9117-git-svn-info.sh script to use static expected-* files and
replacing command output using sed.

> Can we expect the output of "svn info" to not change between
> versions?  I know "svn status" has changed between versions of
> svn.  I'd prefer if we keep the expected.* files hard-coded
> in a test directory and compare those instead.  Maybe use sed
> to substitute placeholders for timestamps..

Done.

> Also, git-diff can be used against arbitrary files nowadays, no
> need to rely on a working diff command in the system :)

Done.

> > +	cp -p gitwc/added-file svnwc/added-file &&
> I can't remember if cp -p is portable, either...

Fixed (see above).

Dave
