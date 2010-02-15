From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v4 5/6] am: Fix launching of pager
Date: Sun, 14 Feb 2010 23:04:13 -0600
Message-ID: <20100215050413.GA19586@progeny.tock>
References: <462027ff1002131314k62069160h63760fc8316aa43b@mail.gmail.com>
 <20100213235156.GA9054@coredump.intra.peff.net>
 <20100214115430.GA1849@progeny.tock>
 <20100214120731.GE3499@progeny.tock>
 <20100215025958.GB17444@progeny.tock>
 <20100215032533.GA19230@progeny.tock>
 <20100215044223.GA3336@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Celis <sebastian@sebastiancelis.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 15 06:04:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngt85-0000hS-Lw
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 06:04:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289Ab0BOFEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 00:04:13 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:39701 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202Ab0BOFEM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 00:04:12 -0500
Received: by iwn39 with SMTP id 39so1848605iwn.1
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 21:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6eCfFkixXiBZIAp0N2Ufz3fQ+okMJafaXw+hwskppLM=;
        b=CGLusdG0FAqaHVfS+O26ZcramC/j1hgFn7D1w2tAvlCSmIlKRR4vQTDOeII5QUrxIo
         f9FHsQ6YkjNyu3MoLZ0wbQ8i2mmpkw1PSdYy5ro8BZDX79uIjfG5VRO17z45lGrL+I0B
         LqnIRKs7O5X4VGUZQaBaNNlqt4p8BFacqcrm0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=tbA9TJ4Z/gholQNiW+7kl9+26gmYQUmCaSPRtG/1Ag4lrTVF7FOdMw1V4TUfgN0VkT
         aQONtZ5hB8WdIqy/X21ulcra4jlfiat9tgh8Oq1HLqlUHTMnnEgONLu6P+r7WIwAlLzL
         SnvlYJ/RT+hsuZGZXotWMrVTz/mK70fIXhDuc=
Received: by 10.231.149.10 with SMTP id r10mr4225627ibv.63.1266210251138;
        Sun, 14 Feb 2010 21:04:11 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm5986119iwn.10.2010.02.14.21.04.10
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Feb 2010 21:04:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100215044223.GA3336@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139974>

The pagination functionality in git am has some problems:

 - It does not check if stdout is a tty, so it always paginates.

 - If $GIT_PAGER uses any environment variables, they are being
   ignored, since it does not run $GIT_PAGER through eval.

 - If $GIT_PAGER is set to the empty string, instead of passing
   output through to stdout, it tries to run $dotest/patch.

Fix them.  While at it, move the definition of git_pager() to
git-sh-setup so authors of other commands are not tempted to
reimplement it with the same mistakes.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jeff King wrote:
> On Sun, Feb 14, 2010 at 09:25:33PM -0600, Jonathan Nieder wrote:

>> +		if tty <&1 >/dev/null 2>/dev/null
>
> We seem to use "test -t 1" for this elsewhere, and I don't see us using
> "tty" anywhere else. It is POSIX, and I tested that even Solaris 8 and
> AIX 6.1 have it. So I don't think it is a portability issue, but others
> may know more than I.

tty is portable, but "test -t 1" is cleaner.  Thanks for the pointer.

 git-am.sh       |    5 +----
 git-sh-setup.sh |   13 +++++++++++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 3c08d53..b11af03 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -663,10 +663,7 @@ do
 		[eE]*) git_editor "$dotest/final-commit"
 		       action=again ;;
 		[vV]*) action=again
-		       : ${GIT_PAGER=$(git var GIT_PAGER)}
-		       : ${LESS=-FRSX}
-		       export LESS
-		       $GIT_PAGER "$dotest/patch" ;;
+		       git_pager "$dotest/patch" ;;
 		*)     action=again ;;
 		esac
 	    done
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index d56426d..44fb467 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -107,6 +107,19 @@ git_editor() {
 	eval "$GIT_EDITOR" '"$@"'
 }
 
+git_pager() {
+	if test -t 1
+	then
+		GIT_PAGER=$(git var GIT_PAGER)
+	else
+		GIT_PAGER=cat
+	fi
+	: ${LESS=-FRSX}
+	export LESS
+
+	eval "$GIT_PAGER" '"$@"'
+}
+
 sane_grep () {
 	GREP_OPTIONS= LC_ALL=C grep "$@"
 }
-- 
1.7.0
