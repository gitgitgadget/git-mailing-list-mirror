From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 7/7] update-server-info: respect core.bigfilethreshold
Date: Wed,  7 Mar 2012 17:54:21 +0700
Message-ID: <1331117661-19378-8-git-send-email-pclouds@gmail.com>
References: <7vty21twqc.fsf@alter.siamese.dyndns.org>
 <1331117661-19378-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 07 11:54:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5EVR-0003ls-7v
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 11:54:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755491Ab2CGKxm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Mar 2012 05:53:42 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:41429 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755433Ab2CGKxk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 05:53:40 -0500
Received: by mail-pw0-f46.google.com with SMTP id un15so415256pbc.19
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 02:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=H4coqarc7TzImuXv3Pt+10atZKbZYi4fZU31HDFOKcA=;
        b=XQZdpVUuehbPMFiFn+VPIAM3qfBEzs2a/K1PzYrgPbpYtCkCeeF7frqBNNOdjmBp8K
         /S1ubn5gjr/9vDSnrTtfQiYASV+QaLli+SzoRb+jhDy2oOTrP6VMiKoxZUuZyKPsVtKx
         QIcl/TZNm5/g9HL0jKF9JnCBVWe/mTCtG4PoWTnBnzKmS8XAhcX/FG/dPDLYphOs+z8I
         26TF/T3tdE7zyhOmw1a7Ohn6End6a7bcMDqStAq8IGQHZXMw8aHO5OyA/zGbXBodMDb+
         a5BOCjURelhAg3ESvHW6Bh0OxAoRFVaGk2vBVHc6yM+jD0FlaGNwIBbXHdtxAH0ynYRO
         85Dw==
Received: by 10.68.237.201 with SMTP id ve9mr3075605pbc.45.1331117620253;
        Wed, 07 Mar 2012 02:53:40 -0800 (PST)
Received: from tre ([115.74.59.10])
        by mx.google.com with ESMTPS id d10sm574086pbr.59.2012.03.07.02.53.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Mar 2012 02:53:39 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Wed, 07 Mar 2012 17:55:10 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1331117661-19378-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192442>

This command indirectly calls check_sha1_signature() (add_info_ref ->
deref_tag -> parse_object -> ..) , which may put whole blob in memory
if the blob's size is under core.bigfilethreshold. As config is not
read, the threshold is always 512MB. Respect user settings here.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/update-server-info.c |    1 +
 t/t1050-large.sh             |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/update-server-info.c b/builtin/update-server-info.=
c
index b90dce6..0d63c44 100644
--- a/builtin/update-server-info.c
+++ b/builtin/update-server-info.c
@@ -15,6 +15,7 @@ int cmd_update_server_info(int argc, const char **arg=
v, const char *prefix)
 		OPT_END()
 	};
=20
+	git_config(git_default_config, NULL);
 	argc =3D parse_options(argc, argv, prefix, options,
 			     update_server_info_usage, 0);
 	if (argc > 0)
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index dd1bb84..4d127f1 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -130,7 +130,7 @@ test_expect_success 'git-show a large file' '
=20
 '
=20
-test_expect_failure 'repack' '
+test_expect_success 'repack' '
 	git repack -ad
 '
=20
--=20
1.7.8.36.g69ee2
