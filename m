From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 08/12] git-clone: support --path to do sparse clone
Date: Wed, 23 Jul 2008 21:57:18 +0700
Message-ID: <20080723145718.GA29134@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 16:59:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLfoC-0003Lc-1N
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 16:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754811AbYGWO5j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 10:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754804AbYGWO5j
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 10:57:39 -0400
Received: from ti-out-0910.google.com ([209.85.142.187]:42933 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754772AbYGWO5h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 10:57:37 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1202339tic.23
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 07:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=D73h/2SQl9NA9D1vX9GDhf3i4eWd+NG+wajL5ii8DWA=;
        b=dV5qEHX1V316Z8fhkA8NzIcwpI0hz5w+TNrzREET7Nc3lRUsIfxi1/Gz2Ro2RrHJRH
         wggBrYhQxewk6Yh1MESgS1vJTpNZVFlKXfhxYKheHieAUxwsc2hVXO06WEpGQUXeoBa8
         fLisl91mxwVexZMpCtMFuBe5yvWGugysADWjE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=lOsjb2YnTnH4BeZEwilpyADmOLYhD2xSroeswV2MBcBsmz3t/W4ZA0iGZQthzdIvkM
         PnuKwqP05YBtOf/eQBNSNkPO2Cu1eOhgiGkqcvJulwPNZL4FgVRA2WkYAHR5ERAXx7US
         HTtVzcFSEaYLNZr2UGZcHtD0Ip1ZMRcbBeYe8=
Received: by 10.110.37.3 with SMTP id k3mr114158tik.29.1216825057148;
        Wed, 23 Jul 2008 07:57:37 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.5.7])
        by mx.google.com with ESMTPS id i6sm14750159tid.17.2008.07.23.07.57.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jul 2008 07:57:35 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 23 Jul 2008 21:57:18 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89681>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-clone.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 3522245..229f2e2 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -36,6 +36,7 @@ static const char * const builtin_clone_usage[] =3D {
 static int option_quiet, option_no_checkout, option_bare;
 static int option_local, option_no_hardlinks, option_shared;
 static char *option_template, *option_reference, *option_depth;
+static char *option_sparse_prefix;
 static char *option_origin =3D NULL;
 static char *option_upload_pack =3D "git-upload-pack";
=20
@@ -43,6 +44,8 @@ static struct option builtin_clone_options[] =3D {
 	OPT__QUIET(&option_quiet),
 	OPT_BOOLEAN('n', "no-checkout", &option_no_checkout,
 		    "don't create a checkout"),
+	OPT_STRING(0, "path", &option_sparse_prefix, "prefixes",
+		    "limit checkout to specified paths (sparse checkout)"),
 	OPT_BOOLEAN(0, "bare", &option_bare, "create a bare repository"),
 	OPT_BOOLEAN(0, "naked", &option_bare, "create a bare repository"),
 	OPT_BOOLEAN('l', "local", &option_local,
@@ -364,9 +367,14 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 			die("--bare and --origin %s options are incompatible.",
 			    option_origin);
 		option_no_checkout =3D 1;
+		if (option_sparse_prefix)
+			die("--bare and --path options are incompatible.");
 		use_separate_remote =3D 0;
 	}
=20
+	if (option_no_checkout && option_sparse_prefix)
+		die("--no-checkout and --path options are incompatible.");
+
 	if (!option_origin)
 		option_origin =3D "origin";
=20
@@ -549,6 +557,11 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 		/* We need to be in the new work tree for the checkout */
 		setup_work_tree();
=20
+		if (option_sparse_prefix) {
+			git_config_set("core.sparsecheckout", option_sparse_prefix);
+			set_sparse_prefix(option_sparse_prefix);
+		}
+
 		fd =3D hold_locked_index(lock_file, 1);
=20
 		memset(&opts, 0, sizeof opts);
--=20
1.5.5.GIT
