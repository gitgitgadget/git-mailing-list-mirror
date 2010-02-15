From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3 5/6] am: Fix launching of pager
Date: Sun, 14 Feb 2010 21:25:33 -0600
Message-ID: <20100215032533.GA19230@progeny.tock>
References: <462027ff1002131314k62069160h63760fc8316aa43b@mail.gmail.com>
 <20100213235156.GA9054@coredump.intra.peff.net>
 <20100214115430.GA1849@progeny.tock>
 <20100214120731.GE3499@progeny.tock>
 <20100215025958.GB17444@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sebastian Celis <sebastian@sebastiancelis.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 15 04:25:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngraf-0006xm-CW
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 04:25:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754674Ab0BODZe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Feb 2010 22:25:34 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:42021 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754598Ab0BODZd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 22:25:33 -0500
Received: by iwn39 with SMTP id 39so1796434iwn.1
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 19:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=b+wkBupMMwwJgbXPstZLMYtxJ1MZ5lfhCmkXB489y5M=;
        b=FdPqU8HX7um8wD9mr+R2lLhbMs42laTZ7kOMgh58bnGkZKOzplhDzVYvQp75l6uv8k
         14s+6o4bt7q7mOP2hlCErcO4VsNqZ4/+fCARmN3x2YJHTUromwHIpOi0GzqOr5Xr5kff
         M/latsHQahSxDhwSoeNF72J8YvDZ6sdZtNsn4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=p5K4cuh9Bh7HkUmq71zPTyHvbI2D/ko+Iuq5Cnp/kU8isACTe8qn/9ZhTd7n2146qT
         cRauKZePSJJ0fR8klLdp5xsJwaekBShWnGWUqpqMDlH45G0y8t4dddxpV9EEz/vgQeUn
         pkTW1jRYZlg82aKxK75a7PGwH/bqu9S19WBHQ=
Received: by 10.231.161.138 with SMTP id r10mr577730ibx.34.1266204332863;
        Sun, 14 Feb 2010 19:25:32 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm5919216iwn.6.2010.02.14.19.25.31
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Feb 2010 19:25:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100215025958.GB17444@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139962>

The (v)iew command in git am -i has some problems:

 - It does not check if stdout is a tty, so it always paginates.

 - If $GIT_PAGER uses any environment variables, they are being
   ignored, since it does not run $GIT_PAGER through eval.

 - If $GIT_PAGER is set to the empty string, instead of passing
   output through to stdout, it tries to exec the patch.

=46ix them.  While at it, move the definition of git_pager() to
git-sh-setup so authors of other commands are not tempted to
reimplement it with the same mistakes.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
The previous version did not handle GIT_PAGER=3D"" properly.  Third
time=E2=80=99s the charm, I hope.

 git-am.sh       |    5 +----
 git-sh-setup.sh |   19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 3c08d53..b11af03 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -663,10 +663,7 @@ do
 		[eE]*) git_editor "$dotest/final-commit"
 		       action=3Dagain ;;
 		[vV]*) action=3Dagain
-		       : ${GIT_PAGER=3D$(git var GIT_PAGER)}
-		       : ${LESS=3D-FRSX}
-		       export LESS
-		       $GIT_PAGER "$dotest/patch" ;;
+		       git_pager "$dotest/patch" ;;
 		*)     action=3Dagain ;;
 		esac
 	    done
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index d56426d..18ad1fc 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -107,6 +107,25 @@ git_editor() {
 	eval "$GIT_EDITOR" '"$@"'
 }
=20
+git_pager() {
+	if test -z "${GIT_PAGER+set}"
+	then
+		if tty <&1 >/dev/null 2>/dev/null
+		then
+			GIT_PAGER=3D$(git var GIT_PAGER)
+		else
+			GIT_PAGER=3Dcat
+		fi
+	elif test -z "$GIT_PAGER"
+	then
+		GIT_PAGER=3Dcat
+	fi
+	: ${LESS=3D-FRSX}
+	export LESS
+
+	eval "$GIT_PAGER" '"$@"'
+}
+
 sane_grep () {
 	GREP_OPTIONS=3D LC_ALL=3DC grep "$@"
 }
--=20
1.7.0
