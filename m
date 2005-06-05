From: "Tommy M. McGuire" <mcguire@crsr.net>
Subject: Re: cg-init bug -- identified
Date: Sun, 5 Jun 2005 14:09:38 -0500
Message-ID: <20050605190938.GB21345@immutable.crsr.net>
References: <20050605153053.GA6890@tumblerings.org> <20050605172854.GF17462@pasky.ji.cz> <20050605175634.GB6890@tumblerings.org> <20050605181042.GH17462@pasky.ji.cz> <20050605182912.GC6890@tumblerings.org> <20050605184341.GA21345@immutable.crsr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zack Brown <zbrown@tumblerings.org>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 21:07:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Df0Sb-00054P-G5
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 21:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVFETKO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 15:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbVFETKO
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 15:10:14 -0400
Received: from [65.98.21.155] ([65.98.21.155]:50954 "EHLO immutable.crsr.net")
	by vger.kernel.org with ESMTP id S261597AbVFETKI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 15:10:08 -0400
Received: from mcguire by immutable.crsr.net with local (Exim 3.35 #1 (Debian))
	id 1Df0V8-0005as-00; Sun, 05 Jun 2005 14:09:38 -0500
To: "Tommy M. McGuire" <mcguire@crsr.net>
Content-Disposition: inline
In-Reply-To: <20050605184341.GA21345@immutable.crsr.net>
User-Agent: Mutt/1.3.28i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 05, 2005 at 01:43:41PM -0500, Tommy M. McGuire wrote:
> Adding file foo'prime
> xargs: unmatched single quote
> + cg-commit -C '-mInitial commit' -E
> 
> The error is the second-to-last line.  It partially succeeded originally
> because xargs broke off and handled parts of the input before reaching 
> the single quote.

The bug is in cg-add, which doesn't use -print0 and -0.

-- 
Tommy McGuire

diff --git a/cg-add b/cg-add
--- a/cg-add
+++ b/cg-add
@@ -20,9 +20,9 @@ USAGE="cg-add FILE..."
 [ "$1" ] || usage
 
 TMPFILE=$(mktemp -t gitadd.XXXXXX)
-find "$@" -type f > $TMPFILE || die "not all files exist, nothing added"
+find "$@" -type f -print0 > $TMPFILE || die "not all files exist, nothing added"
 
-cat $TMPFILE | awk '{print "Adding file "  $0}'
-cat $TMPFILE | xargs git-update-cache --add --
+cat $TMPFILE | xargs -0l1 echo "Adding file "
+cat $TMPFILE | xargs -0 git-update-cache --add --
 
 rm $TMPFILE
