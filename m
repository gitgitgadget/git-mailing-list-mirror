From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 5/6] am: Fix launching of pager
Date: Sun, 14 Feb 2010 20:59:58 -0600
Message-ID: <20100215025958.GB17444@progeny.tock>
References: <462027ff1002131314k62069160h63760fc8316aa43b@mail.gmail.com>
 <20100213235156.GA9054@coredump.intra.peff.net>
 <20100214115430.GA1849@progeny.tock>
 <20100214120731.GE3499@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sebastian Celis <sebastian@sebastiancelis.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 15 04:00:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgrBu-0001Uq-Hi
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 04:00:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754462Ab0BOC76 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Feb 2010 21:59:58 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:53955 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754354Ab0BOC75 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 21:59:57 -0500
Received: by iwn39 with SMTP id 39so1782736iwn.1
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 18:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=cste1bW6+yCJhm0XY8vyCdxq2NRzMtPYaEwTMzKc4Kg=;
        b=hSNJmSx6xlnZ+DhnOJWCJDdgM5GI/DkiBnuzLZgDVjMEg+dnSHf0ALAsh0Vjadibid
         qvyFNIaeJwtHGyp+XhVS0i7r3n+DlSTci2jj1aSeMlBhzXsfUZWEB0XId5ae8i770oen
         OWPW+J+cDP3tx2LIGP4i6P/vebbxEyYRgkMP0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=LZ9T79GU3r8u0MjFlOgeEGqcjCxdebyTxYPQY2/20NsxK7JDsLoLvfQ96CY9uPFHCJ
         /c46DIws/roYSb4VxhBA52CRfZ9Iky1rx92Im3fmLc6ulc9BmxZE2tNFz8FDpxgpTZUb
         7Wpotu/uGw6OMG4BwfjR6RrQOwBaJaEdxa5pc=
Received: by 10.231.182.68 with SMTP id 46mr2004514ibz.45.1266202796507;
        Sun, 14 Feb 2010 18:59:56 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm145134iwn.3.2010.02.14.18.59.55
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Feb 2010 18:59:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100214120731.GE3499@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139961>

The git_pager() function used in git am has some problems:

 - It does not check if stdout is a tty, so it always paginates.

 - If $GIT_PAGER uses any environment variables, they are being
   ignored, since it does not run $GIT_PAGER through eval.

=46ix them.  While at it, move the definition of git_pager() to
git-sh-setup so authors of other commands are not tempted to
reimplement it with the same mistakes.

If GIT_PAGER is set to the empty string, pagination is disabled.  This
is different from the treatment of GIT_EDITOR by git_editor(), but
consistency with the use of GIT_PAGER by git builtins is more
important.

Acked-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jonathan Nieder wrote:

> +		if tty <&1 >/dev/null 2>/dev/null
> +		then
> +			GIT_PAGER=3Dcat
> +		else
> +			GIT_PAGER=3D$(git var GIT_PAGER)
> +		fi

This was backwards.  *sigh*

Here=E2=80=99s a tested version.  Junio, I carried over your Ack, but p=
lease
feel free to revoke it.

 git-am.sh       |    5 +----
 git-sh-setup.sh |   16 ++++++++++++++++
 2 files changed, 17 insertions(+), 4 deletions(-)

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
index d56426d..4500c12 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -107,6 +107,22 @@ git_editor() {
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
