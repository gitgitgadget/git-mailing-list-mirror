From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] request-pull: protect against OPTIONS_KEEPDASHDASH
 from environment
Date: Sat, 24 Apr 2010 07:15:37 -0500
Message-ID: <20100424121537.GB12312@progeny.tock>
References: <20100424120437.GA12237@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 24 14:15:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5eGR-0006ly-4h
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 14:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258Ab0DXMPH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Apr 2010 08:15:07 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:49652 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619Ab0DXMPF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 08:15:05 -0400
Received: by gwj19 with SMTP id 19so3160908gwj.19
        for <git@vger.kernel.org>; Sat, 24 Apr 2010 05:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=TAwvgbQWPd+5Z/l+kndJJp7pu4+NPQKLcI0WNOKhpjQ=;
        b=woR0iRzYYNUTP+SMnjKrO0IAq+YN9q6K3A2+pT7kKFHsY3MU3cDj2j1k6cQecGijpq
         5Jfl0MK2E5set6Ditq0Le0+vQegm9KXuNtYFyBV1jywJizqShsQmWtD0FUBAPGLOxlTo
         20ZdwdYZIIxTilKnEQm3lkLOh+/+Qm5RqhZGg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=geIe38jTSbb0Uok8jocVE0YtRM9qN+OU+XbjbS9BpA4ktAEYpqHc45ET0ziHwZ2nVT
         2PBoJpwsNFX1JPGcjUjoH/jFTznWPpVYjaYg+W2VN3eIWI5mRejK0OMh1LXa4Q2EQpZw
         yNAxqf/Ko7pTvqX0OYObdjHhPMiEaGUV2mE1E=
Received: by 10.101.162.19 with SMTP id p19mr1360923ano.267.1272111303575;
        Sat, 24 Apr 2010 05:15:03 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm1457322iwn.6.2010.04.24.05.15.02
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Apr 2010 05:15:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100424120437.GA12237@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145670>

Like most git commands, request-pull supports a -- delimiter to allow
callers to pass arguments that would otherwise be treated as an option
afterwards.  The internal OPTIONS_KEEPDASHDASH variable is passed
empty to git-sh-setup to indicate that request-pull itself does not
care about the position of the -- delimiter.  But if the user has
that variable in her environment, request-pull will see the =E2=80=9C--=
=E2=80=9D and
fail.

Empty it explicitly to guard against this.  While at it, make the
corresponding fix to git-resurrect, too (all other scripts in git.git
already protect themselves).

Cc: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
=46orgot to mention: this series is against maint.  For master, the tes=
t
needs a fixup to pass with v1.7.1-rc0~144^2 (request-pull: avoid
mentioning that the start point is a single commit, 2010-01-29), which
I=E2=80=99ll send as a reply.

Thanks for reading.  As always, thoughts and simplifying suggestions
are welcome.

 contrib/git-resurrect.sh |    1 +
 git-request-pull.sh      |    1 +
 t/t5150-request-pull.sh  |   14 ++++++++++++++
 3 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/contrib/git-resurrect.sh b/contrib/git-resurrect.sh
index c364dda..a4ed4c3 100755
--- a/contrib/git-resurrect.sh
+++ b/contrib/git-resurrect.sh
@@ -9,6 +9,7 @@ other/Merge <other> into <name> (respectively) commit s=
ubjects, which
 is rather slow but allows you to resurrect other people's topic
 branches."
=20
+OPTIONS_KEEPDASHDASH=3D
 OPTIONS_SPEC=3D"\
 git resurrect $USAGE
 --
diff --git a/git-request-pull.sh b/git-request-pull.sh
index 630cedd..b0a0311 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -8,6 +8,7 @@ USAGE=3D'<start> <url> [<end>]'
 LONG_USAGE=3D'Summarizes the changes between two commits to the standa=
rd output,
 and includes the given URL in the generated summary.'
 SUBDIRECTORY_OK=3D'Yes'
+OPTIONS_KEEPDASHDASH=3D
 OPTIONS_SPEC=3D'git request-pull [options] start url [end]
 --
 p    show patch text as well
diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index e012a36..4c7f48a 100644
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -211,4 +211,18 @@ test_expect_success 'pull request format' '
=20
 '
=20
+test_expect_success 'request-pull ignores OPTIONS_KEEPDASHDASH poison'=
 '
+
+	(
+		cd local &&
+		OPTIONS_KEEPDASHDASH=3DYes &&
+		export OPTIONS_KEEPDASHDASH &&
+		git checkout initial &&
+		git merge --ff-only master &&
+		git push origin master:for-upstream &&
+		git request-pull -- initial "$downstream_url" >../request
+	)
+
+'
+
 test_done
--=20
1.7.1.rc1
