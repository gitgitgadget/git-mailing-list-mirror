From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 18/20] clone: define shallow clone boundary with --not
Date: Tue, 29 Dec 2015 19:10:41 +0700
Message-ID: <1451391043-28093-19-git-send-email-pclouds@gmail.com>
References: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 13:12:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDt8v-0007L8-04
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 13:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371AbbL2MMm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Dec 2015 07:12:42 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35405 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074AbbL2MMk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 07:12:40 -0500
Received: by mail-pf0-f171.google.com with SMTP id 78so126445517pfw.2
        for <git@vger.kernel.org>; Tue, 29 Dec 2015 04:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=upSs7CRRE137GCWy7Rfj2ARsshmiK1dZbiX2VxsmmvQ=;
        b=RdfDvLxCsISzzaqrzgBkLAx5ri+7y3br4o79653JFQVH9uT3RFex1qNgySe6sx05u9
         qNaADDHDAiwTGHcp2Byonlr2GDr4KWFvNP6wQTVsDP4lYaPge4bCwlY4oDjezpbjPR8V
         a0tfhh9cGEhugbxg5lTRVzSLDea43+YLLUto7iCJYhnzptX2FCSSuP2XahX/B1I6L3b/
         c81WCaoMjkoG7VvUb1Bh5yzGrQS45NPV1YmL7hRDoIM4+CdAy2P7ZFBSjhbOojXOGnlx
         wgWNiMz2oWGNBfz68Oe/gXBQQLPdmEw+JyIBDq2ZfK0tXADMJ7q+aKojpRMEZOUvkpgE
         UdZw==
X-Received: by 10.98.2.2 with SMTP id 2mr85049875pfc.13.1451391159975;
        Tue, 29 Dec 2015 04:12:39 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id u67sm83054856pfa.84.2015.12.29.04.12.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Dec 2015 04:12:38 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 29 Dec 2015 19:12:34 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283128>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-clone.txt |  5 +++++
 builtin/clone.c             | 18 +++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 28993c6..3589e57 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -195,6 +195,11 @@ objects from the source repository into a pack in =
the cloned repository.
 --since=3D<date>::
 	Create a 'shallow' clone with a history after the specified time.
=20
+--not=3D<revision>::
+	Create a 'shallow' clone with a history, excluding commits
+	reachable from a specified remote branch or tag.  This option
+	can be specified multiple times.
+
 --[no-]single-branch::
 	Clone only the history leading to the tip of a single branch,
 	either specified by the `--branch` option or the primary
diff --git a/builtin/clone.c b/builtin/clone.c
index 94bbfef..0e99354 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -44,6 +44,7 @@ static int deepen;
 static char *option_template, *option_depth, *option_since;
 static char *option_origin =3D NULL;
 static char *option_branch =3D NULL;
+static struct string_list option_not =3D STRING_LIST_INIT_NODUP;
 static const char *real_git_dir;
 static char *option_upload_pack =3D "git-upload-pack";
 static int option_verbosity;
@@ -52,6 +53,13 @@ static struct string_list option_config;
 static struct string_list option_reference;
 static int option_dissociate;
=20
+static int option_parse_deepen_not(const struct option *opt,
+				   const char *arg, int unset)
+{
+	string_list_append(&option_not, arg);
+	return 0;
+}
+
 static struct option builtin_clone_options[] =3D {
 	OPT__VERBOSITY(&option_verbosity),
 	OPT_BOOL(0, "progress", &option_progress,
@@ -89,6 +97,9 @@ static struct option builtin_clone_options[] =3D {
 		    N_("create a shallow clone of that depth")),
 	OPT_STRING(0, "since", &option_since, N_("time"),
 		    N_("create a shallow clone since a specific time")),
+	{ OPTION_CALLBACK, 0, "not", NULL, N_("revision"),
+		    N_("deepen history of shallow clone by excluding rev"),
+		    PARSE_OPT_NONEG, option_parse_deepen_not },
 	OPT_BOOL(0, "single-branch", &option_single_branch,
 		    N_("clone only one branch, HEAD or --branch")),
 	OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
@@ -849,7 +860,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 		usage_msg_opt(_("You must specify a repository to clone."),
 			builtin_clone_usage, builtin_clone_options);
=20
-	if (option_depth || option_since)
+	if (option_depth || option_since || option_not.nr)
 		deepen =3D 1;
 	if (option_single_branch =3D=3D -1)
 		option_single_branch =3D deepen ? 1 : 0;
@@ -980,6 +991,8 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 			warning(_("--depth is ignored in local clones; use file:// instead.=
"));
 		if (option_since)
 			warning(_("--since is ignored in local clones; use file:// instead.=
"));
+		if (option_not.nr)
+			warning(_("--not is ignored in local clones; use file:// instead.")=
);
 		if (!access(mkpath("%s/shallow", path), F_OK)) {
 			if (option_local > 0)
 				warning(_("source repository is shallow, ignoring --local"));
@@ -1001,6 +1014,9 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
 	if (option_since)
 		transport_set_option(transport, TRANS_OPT_DEEPEN_SINCE,
 				     option_since);
+	if (option_not.nr)
+		transport_set_option(transport, TRANS_OPT_DEEPEN_NOT,
+				     (const char *)&option_not);
 	if (option_single_branch)
 		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
=20
--=20
2.3.0.rc1.137.g477eb31
