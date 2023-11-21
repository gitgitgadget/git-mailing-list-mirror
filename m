Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="REf2aalL";
	dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="PiD9+lpr"
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57AC1BC
	for <git@vger.kernel.org>; Tue, 21 Nov 2023 12:34:23 -0800 (PST)
From: "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1700598860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7jrCb8GTiQSGTaURsn+6LoQdF62l1/aJQJPfzMM80Wg=;
	b=REf2aalL/ArjYAzPydFryPUdfGZTP/JlJ68wjQDTtecd7Dax8hOMhX0pXkMSEYaKEHjkAk
	ob3pmphYkEsqfD8uBp4IP3TrH+Cwk6SGW/wIG3+y0d1YS56uPSC3Ll34X/zHsHnCQp8L6v
	KSJAzs5978aemfrg01BxFPdCtdYBOnu17hQaWxwpcPL8OMjmcqub+XA1danKreksKIaNEe
	yWtsYDuOVAHjrEllJbmF3lZ9Ie6M8z5d5gvidsn2KtJd250/t3td+kgeFG5XI+lfaCA+0q
	mjc/HLdq1piLsyNtnBMkRey7pi5td+2C7mdXVoawU1rNl2TomFfBUg70t6k4TGH3685NL6
	DpjG5PijY1LV69qxjybA8LPO0b01rPejSJQpmT5Q+nfVvqcXW5XTPM8551T6Qg7HdDS5ff
	BapdfgE9uJLN15H4HcaWXBL5jdZxwp21zZsYGSt46cuflEovg2U3EzI2vrH8SqA3TBObti
	1Q6NWB6+Fbcf1f3q6NF8EdvHBWx0q+TdPcRc+/ag0jGBrLNy1l5ElDorLn9MC3MOSowWT2
	bpBApk3nOGLTuaw2o6nXHCnCkXBk3kJAfMN/Nr4k1QM4hYbCSZjEalYriOYc+4+3LhcmEn
	7+TPTlhTq8YbGF7XZom+sXODSgVvxx5x3GDDdmL+h1cPAM66MiUJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1700598860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7jrCb8GTiQSGTaURsn+6LoQdF62l1/aJQJPfzMM80Wg=;
	b=PiD9+lprKlWEzb1QaWcvKCi1DXdZIrWFwABT+7fe/ngIA5BVS2A5tf+Cu650nxalkuDe5N
	ZcKe363V1Dp/zhAg==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=heftig smtp.mailfrom=heftig@archlinux.org
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Shourya Shukla <shouryashukla.oo@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Denton Liu <liu.denton@gmail.com>,
	"Jan Alexander Steffens (heftig)" <heftig@archlinux.org>
Subject: [PATCH v2 2/6] submodule--helper: return error from set-url when modifying failed
Date: Tue, 21 Nov 2023 21:32:43 +0100
Message-ID: <20231121203413.176414-2-heftig@archlinux.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231121203413.176414-1-heftig@archlinux.org>
References: <20231003185047.2697995-1-heftig@archlinux.org>
 <20231121203413.176414-1-heftig@archlinux.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

set-branch will return an error when setting the config fails so I don't
see why set-url shouldn't. Also skip the sync in this case.

Signed-off-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
---
 builtin/submodule--helper.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index af461ada8b..0013ea1ab0 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2889,39 +2889,41 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 
 static int module_set_url(int argc, const char **argv, const char *prefix)
 {
-	int quiet = 0;
+	int quiet = 0, ret;
 	const char *newurl;
 	const char *path;
 	char *config_name;
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("suppress output for setting url of a submodule")),
 		OPT_END()
 	};
 	const char *const usage[] = {
 		N_("git submodule set-url [--quiet] <path> <newurl>"),
 		NULL
 	};
 	const struct submodule *sub;
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
 	if (argc != 2 || !(path = argv[0]) || !(newurl = argv[1]))
 		usage_with_options(usage, options);
 
 	sub = submodule_from_path(the_repository, null_oid(), path);
 
 	if (!sub)
 		die(_("no submodule mapping found in .gitmodules for path '%s'"),
 		    path);
 
 	config_name = xstrfmt("submodule.%s.url", sub->name);
-	config_set_in_gitmodules_file_gently(config_name, newurl);
+	ret = config_set_in_gitmodules_file_gently(config_name, newurl);
 
-	repo_read_gitmodules(the_repository, 0);
-	sync_submodule(path, prefix, NULL, quiet ? OPT_QUIET : 0);
+	if (!ret) {
+		repo_read_gitmodules(the_repository, 0);
+		sync_submodule(path, prefix, NULL, quiet ? OPT_QUIET : 0);
+	}
 
 	free(config_name);
-	return 0;
+	return !!ret;
 }
 
 static int module_set_branch(int argc, const char **argv, const char *prefix)
-- 
2.43.0

