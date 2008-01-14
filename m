From: Jeff King <peff@peff.net>
Subject: Re: Digging through old vendor code
Date: Mon, 14 Jan 2008 07:08:07 -0500
Message-ID: <20080114120807.GB12723@coredump.intra.peff.net>
References: <20080113162806.13991.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jonsmirl@gmail.com,
	torvalds@linux-foundation.org
To: linux@horizon.com
X-From: git-owner@vger.kernel.org Mon Jan 14 13:08:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEO7N-0007RM-1Y
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 13:08:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755183AbYANMIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 07:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754953AbYANMIL
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 07:08:11 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2050 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754598AbYANMIK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 07:08:10 -0500
Received: (qmail 6370 invoked by uid 111); 14 Jan 2008 12:08:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 14 Jan 2008 07:08:08 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Jan 2008 07:08:07 -0500
Content-Disposition: inline
In-Reply-To: <20080113162806.13991.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70455>

On Sun, Jan 13, 2008 at 11:28:06AM -0500, linux@horizon.com wrote:

> Maybe a real git wizard will show me how to insert the index entries
> directly without ever doing anything as pedestrian as extracting, hashing,
> and then deleting the files, but it's still not that bad.

git-read-tree?  Unfortunately it has no option to insert only a subset
of the tree. But you can make do with git-ls-tree piped to
git-update-index.

Using the script below, Jon's sample file seems to be

  v2.6.15-rc6-81-g0b57ee9:drivers/serial/amba-pl010.c

and it runs in about 8 seconds on v2.6.13..v2.6.15. I think it might be
more intuitive to just diff a temporary index against each tree, but I
don't think there's a way to say "find copies harder, but use only this
subset of files as the source" which makes it less efficient.

Jon, you might try playing around with different ranges. I get a
different answer for v2.6.13..v2.6.16.

-- >8 --
SRC=drivers/serial

echo >&2 Cleaning up after old runs...
rm -f tmpindex
git branch -D tmpbranch

echo >&2 Creating giant source commit...
for i in `git rev-list v2.6.13..v2.6.15 -- $SRC`; do
  git ls-tree -r $i -- $SRC |
    # note the whitespace is a literal tab
    sed "s,	,	$i/," |
    GIT_INDEX_FILE=tmpindex git update-index --index-info
done
tree=`GIT_INDEX_FILE=tmpindex git write-tree`
commit=`echo source | git commit-tree $tree`
git update-ref refs/heads/tmpbranch $commit

echo >&2 Creating updated index...
GIT_INDEX_FILE=tmpindex git add candidate.c
echo >&2 Diffing...
GIT_INDEX_FILE=tmpindex git diff-index --cached -l0 -M1% -C1% --find-copies-harder tmpbranch

# now you should manually git-describe the winner
