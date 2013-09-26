From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/10] clone: new option to set preferred pack version for transfer
Date: Thu, 26 Sep 2013 09:26:44 +0700
Message-ID: <1380162409-18224-6-git-send-email-pclouds@gmail.com>
References: <1380162409-18224-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 26 04:27:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VP1Il-0002jk-4L
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 04:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755393Ab3IZC1b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Sep 2013 22:27:31 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:58472 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827Ab3IZC1a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 22:27:30 -0400
Received: by mail-pa0-f44.google.com with SMTP id lf10so635263pab.31
        for <git@vger.kernel.org>; Wed, 25 Sep 2013 19:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=8ImLggFrxzc0nkirBpYoG4KDWcBCl6hQkIK5rpXMuJ0=;
        b=iBdh1PHemZkEtC4eeIcNZksVXwlqqvMeTp94dXtoozQBhlRctpeRxF4J08kt7mFaRI
         ZtF7maWVmlPGoXT4OhjczrlLS684vRcD4e0h4eqJmZ/7xYKQkzL7BizDh8OEJbPB4hov
         Ma3fI5EAy8nXlDh3PZBmOSsyNKAJJMEUDUJ/aNa/qBmeBHoUf/KowrTLKlmSUIngeGSc
         zIXKPsHTABD2WqAuWvmi3OTVk/gwP7v6Mggw37fus5Id18/JmkqBTXbXFGEfg8+bBDA3
         qVgdwa3O5caLF48xxWTk4+920DIUv7O0IYl6LCeV798Kp3zter1z7aW7Y5LzeIl9Nth5
         8Exw==
X-Received: by 10.68.196.227 with SMTP id ip3mr15301869pbc.163.1380162449937;
        Wed, 25 Sep 2013 19:27:29 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id fi4sm44947455pbc.28.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 25 Sep 2013 19:27:29 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 26 Sep 2013 09:27:24 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1380162409-18224-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235392>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-clone.txt |  4 ++++
 builtin/clone.c             | 19 +++++++++++++++++++
 t/t5601-clone.sh            | 12 ++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 450f158..6299a70 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -217,6 +217,10 @@ objects from the source repository into a pack in =
the cloned repository.
 	The result is Git repository can be separated from working
 	tree.
=20
+--pack-version=3D<n>::
+	Define the preferred pack format version for data transfer.
+	Valid values are 2 and 4. Default value is specified by
+	core.preferredPackVersion setting. See linkgit:git-config[1].
=20
 <repository>::
 	The (possibly remote) repository to clone from.  See the
diff --git a/builtin/clone.c b/builtin/clone.c
index 430307b..9c0e296 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -46,6 +46,7 @@ static const char *real_git_dir;
 static char *option_upload_pack =3D "git-upload-pack";
 static int option_verbosity;
 static int option_progress =3D -1;
+static int pack_version;
 static struct string_list option_config;
 static struct string_list option_reference;
=20
@@ -98,6 +99,8 @@ static struct option builtin_clone_options[] =3D {
 		   N_("separate git dir from working tree")),
 	OPT_STRING_LIST('c', "config", &option_config, N_("key=3Dvalue"),
 			N_("set config inside the new repository")),
+	OPT_INTEGER(0, "pack-version", &pack_version,
+		    N_("preferred pack version for transfer")),
 	OPT_END()
 };
=20
@@ -764,6 +767,11 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 		usage_msg_opt(_("You must specify a repository to clone."),
 			builtin_clone_usage, builtin_clone_options);
=20
+	if (!pack_version)
+		pack_version =3D core_default_pack_version;
+	if (pack_version !=3D 2 && pack_version !=3D 4)
+		die(_("invalid pack version %d"), pack_version);
+
 	if (option_single_branch =3D=3D -1)
 		option_single_branch =3D option_depth ? 1 : 0;
=20
@@ -794,6 +802,8 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 	is_local =3D option_local !=3D 0 && path && !is_bundle;
 	if (is_local && option_depth)
 		warning(_("--depth is ignored in local clones; use file:// instead."=
));
+	if (is_local && pack_version =3D=3D 4)
+		warning(_("--pack-version is ignored in local clones; use file:// in=
stead."));
 	if (option_local > 0 && !is_local)
 		warning(_("--local is ignored"));
=20
@@ -868,6 +878,12 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 	} else {
 		strbuf_addf(&branch_top, "refs/remotes/%s/", option_origin);
 	}
+	if (pack_version !=3D core_default_pack_version) {
+		struct strbuf sb =3D STRBUF_INIT;
+		strbuf_addf(&sb, "%d", pack_version);
+		git_config_set("core.preferredPackVersion", sb.buf);
+		strbuf_release(&sb);
+	}
=20
 	strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top.buf);
 	strbuf_addf(&key, "remote.%s.url", option_origin);
@@ -903,6 +919,9 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 			transport_set_option(transport, TRANS_OPT_UPLOADPACK,
 					     option_upload_pack);
=20
+		if (pack_version =3D=3D 4)
+			transport_set_option(transport, TRANS_OPT_PACKV4, "yes");
+
 		if (transport->smart_options && !option_depth)
 			transport->smart_options->check_self_contained_and_connected =3D 1;
 	}
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 0629149..8118524 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -285,4 +285,16 @@ test_expect_success NOT_MINGW,NOT_CYGWIN 'clone lo=
cal path foo:bar' '
 	git clone "./foo:bar" foobar
 '
=20
+test_expect_success 'clone --pack-version=3D4' '
+	git clone --pack-version=3D4 --no-local src pv4 &&
+	P=3D`ls pv4/.git/objects/pack/pack-*.pack` &&
+	# Offset 4 is pack version
+	test-dump ntohl "$P" 4 >ver.actual &&
+	echo 4 >ver.expected &&
+	test_cmp ver.expected ver.actual &&
+	git --git-dir=3Dpv4/.git config --int core.preferredPackVersion >cfgv=
er.actual &&
+	echo 4 >cfgver.expected &&
+	test_cmp cfgver.expected cfgver.actual
+'
+
 test_done
--=20
1.8.2.82.gc24b958
