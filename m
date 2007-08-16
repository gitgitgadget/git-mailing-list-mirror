From: arjen@yaph.org (Arjen Laarhoven)
Subject: Re: [PATCH] t1301-shared-repo.sh: fix 'stat' portability issue
Date: Fri, 17 Aug 2007 00:02:17 +0200
Message-ID: <20070816220217.GH25161@regex.yaph.org>
References: <1187277663740-git-send-email-arjen@yaph.org> <7v3ayjjnz7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 00:02:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILnQX-0000Kr-0B
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 00:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753663AbXHPWCT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 18:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754002AbXHPWCT
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 18:02:19 -0400
Received: from regex.yaph.org ([193.202.115.201]:50599 "EHLO regex.yaph.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753074AbXHPWCS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 18:02:18 -0400
Received: by regex.yaph.org (Postfix, from userid 1000)
	id BA90B5B7D2; Fri, 17 Aug 2007 00:02:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v3ayjjnz7.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56033>

The t1301-shared-repo.sh testscript uses /usr/bin/stat to get the file
mode, which isn't portable.  Implement the test in shell using 'ls' as
shown by Junio.

Signed-off-by: Arjen Laarhoven <arjen@yaph.org>
---
 t/t1301-shared-repo.sh |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index bb5f302..6bfe19a 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -21,7 +21,16 @@ test_expect_success 'update-server-info honors core.sharedRepository' '
 	git commit -m a1 &&
 	umask 0277 &&
 	git update-server-info &&
-	test 444 = $(stat -c %a .git/info/refs)
+	actual="$(ls -l .git/info/refs)" &&
+	case "$actual" in
+	-r--r--r--*)
+		: happy
+		;;
+	*)
+		echo Oops, .git/info/refs is not 0444
+		false
+		;;
+	esac
 '
 
 test_done
-- 
1.5.3.rc4.67.gf9286

> > -	test 444 = $(stat -c %a .git/info/refs)
> > +	$(perl -e '\''exit !(((stat ".git/info/refs")[2] & 0777) == 0444)'\'')
> >  '
> 
> Why is this inside a $()?

Bah.

> I am just wondering if this is more portable and readable...
> 
> 	... &&
> 	current="$(ls -l .git/info/refs)" &&
> 	case "$current" in
>         -r--r--r--*)
>         	: happy
>                 ;;
> 	*)
>         	echo Oops, .git/info/refs is not 0444
>                 false
>                 ;;
> 	esac
