From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/9] t7006: GIT_DIR/config should be honored in subdirs of
 toplevel
Date: Mon, 12 Apr 2010 21:13:56 -0500
Message-ID: <20100413021355.GA4118@progeny.tock>
References: <20100413021153.GA3978@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 13 04:14:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1Vdg-0004hJ-FG
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 04:14:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553Ab0DMCOB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Apr 2010 22:14:01 -0400
Received: from mail-yw0-f194.google.com ([209.85.211.194]:33039 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754511Ab0DMCOA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 22:14:00 -0400
Received: by ywh32 with SMTP id 32so1938393ywh.33
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 19:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=SIGasGJ6GLlygPkGD/tkJl5zgnUEBVn0cA2cqgZP4pA=;
        b=u4uKpMwYaeYBKuokBBUH33tpJ0aA8q/JVP8R5fq/HM9lnzv6Ek0yaZsbYMIWy1pfqf
         eam57oNoLSR5PKT17Vp7V3J/6rNV7MCb31ygaavTBEZ00m4OlgcP0nBjggGOK6etoQk7
         7wZCNn6hGa8J/Q5LxvqLdGP2wyay1kuu0a0fg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=nTt+Pu4WqanoG3PVYUp3d3TK8w/pmiBKw9IyE6AxgTNSwb65vrvVq+Nd3vMSLgn6IB
         pm09QIPDkDT0eGHerjU+Y41j7DNlDF20BvpIEnSrfsKWcoAlgsSBOB6IZqJiU5lDrb7K
         MML9XfYRb4hE7nV6SKVKRxysMqGHN6/SIVgZQ=
Received: by 10.150.119.26 with SMTP id r26mr4736343ybc.60.1271124839200;
        Mon, 12 Apr 2010 19:13:59 -0700 (PDT)
Received: from progeny.tock (wireless-239-104.uchicago.edu [128.135.239.104])
        by mx.google.com with ESMTPS id 22sm4488797iwn.4.2010.04.12.19.13.58
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 12 Apr 2010 19:13:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100413021153.GA3978@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144779>

When git is passed the --paginate option, starting up a pager
requires deciding what pager to start, which requires access to the
core.pager configuration.

Unfortunately, the --paginate option is handled before git has a
chance to search for a git directory.  The effect is that with
--paginate and only with --paginate, a repository-local core.pager
setting does not take effect [*].

[*] unless the git directory is simply .git in the cwd or GIT_DIR
or GIT_CONFIG was set explicitly.

Add a test to demonstrate this counterintuitive behavior.

Noticed while reading over a patch by Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=
=8Dc Duy that
fixes it.

Cc: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t7006-pager.sh |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index d9202d5..4f804ed 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -164,6 +164,38 @@ test_expect_success TTY 'core.pager overrides PAGE=
R' '
 	test -e core.pager_used
 '
=20
+unset GIT_PAGER
+rm -f core.pager_used
+rm -fr sub
+test_expect_success TTY 'core.pager in subdir' '
+	PAGER=3Dwc &&
+	stampname=3D$(pwd)/core.pager_used &&
+	export PAGER stampname &&
+	git config core.pager "wc > \"\$stampname\"" &&
+	mkdir sub &&
+	(
+		cd sub &&
+		test_terminal git log
+	) &&
+	test -e "$stampname"
+'
+
+unset GIT_PAGER
+rm -f core.pager_used
+rm -fr sub
+test_expect_failure TTY 'core.pager in subdir with --paginate' '
+	PAGER=3Dwc &&
+	stampname=3D$(pwd)/core.pager_used &&
+	export PAGER stampname &&
+	git config core.pager "wc > \"\$stampname\"" &&
+	mkdir sub &&
+	(
+		cd sub &&
+		test_terminal git --paginate log
+	) &&
+	test -e "$stampname"
+'
+
 rm -f GIT_PAGER_used
 test_expect_success TTY 'GIT_PAGER overrides core.pager' '
 	git config core.pager wc &&
--=20
1.7.0.4
