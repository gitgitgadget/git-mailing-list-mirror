Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="kQz6L6fc";
	dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="8QqIaGc5"
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A598DD40
	for <git@vger.kernel.org>; Tue, 21 Nov 2023 12:34:23 -0800 (PST)
From: "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1700598859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E1RAGbdjtZ6Mbu0Oh8J4tiEHZ9glLzoef79C0N33Vdw=;
	b=kQz6L6fc9/HdBQGFGl9y2EMPDT1Hgl4RULUSWZR8AV7bfHV9gYj1yDH10XvfVX99XsKvte
	NG4wA8Y/M6aNYmIPp/N9XZQvGSvsPn2lARiPVdw4qGMXh6Vc3gRFFY8qKfnjMWu4l0XYOE
	H3Qg2oIyPUQ6kEqMAdN5v6ntDv9ouYEh29y98/jlld3B9ULP/AfPEMl7o0pxXyJyprCClP
	tGbX8AMzbL4MG5vHqCOhc9WrEpp5a7EcFyVFdI5/9nx76iLAZUF0VMYWMsfR5LQU2WbF/O
	GTPsFsTZO0K0QL+YJlAY72NSsO7O0Z8nJUk7Z4FLuRMXU3ScNxzrOq9AVuVKvKRezVc56+
	oJRThVLAwvNnPOlDe4sehjTL0QvDkF51+xg+A4A1waUVPE5d1Ko68kKEvibdTDP3PtIclB
	TexjD4G0DAw4QKZZF200VWWr0GHiR3tNxRMG0EYA+qGxRkGqpZWgGlXtpO1OptOcUz8A0y
	q99rODt/W7/uIpMFD2LgDYXCu/+/TtQOjiz4kZNocC01UYIPEyudoMNtOFDnnO6pS1F0k3
	fL90lNByNV6IV64Prl/Q6F1scMX7uu1sDHcDRk+lC8EFYcoZkSwTJYPXSl5/C3AgeoL8vu
	WXV4+r3NUG9qaPx1hHP6BI+Pma124LVlYvK5OQWnq3fAvk4hR2o58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1700598859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E1RAGbdjtZ6Mbu0Oh8J4tiEHZ9glLzoef79C0N33Vdw=;
	b=8QqIaGc5A8Mxfh5Ftn9+EPiQUNs2QLehwrDa2Hkd/L67dqaDAR7t0N/lEi0mwPdXKGBgIi
	g9kI9x5JPuiJeABg==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=heftig smtp.mailfrom=heftig@archlinux.org
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Shourya Shukla <shouryashukla.oo@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Denton Liu <liu.denton@gmail.com>,
	"Jan Alexander Steffens (heftig)" <heftig@archlinux.org>
Subject: [PATCH v2 1/6] submodule--helper: use submodule_from_path in set-{url,branch}
Date: Tue, 21 Nov 2023 21:32:42 +0100
Message-ID: <20231121203413.176414-1-heftig@archlinux.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231003185047.2697995-1-heftig@archlinux.org>
References: <20231003185047.2697995-1-heftig@archlinux.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commands need a path to a submodule but treated it as the name when
modifying the .gitmodules file, leading to confusion when a submodule's
name does not match its path.

Because calling submodule_from_path initializes the submodule cache, we
need to manually trigger a reread before syncing, as the cache is
missing the config change we just made.

Signed-off-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
---

Notes:
    v2 changes:
        - fixed code style
        - replaced potentially unsafe use of `sub->path` with `path`

 builtin/submodule--helper.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6f3bf33e61..af461ada8b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2901,19 +2901,26 @@ static int module_set_url(int argc, const char **argv, const char *prefix)
 		N_("git submodule set-url [--quiet] <path> <newurl>"),
 		NULL
 	};
+	const struct submodule *sub;
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
 	if (argc != 2 || !(path = argv[0]) || !(newurl = argv[1]))
 		usage_with_options(usage, options);
 
-	config_name = xstrfmt("submodule.%s.url", path);
+	sub = submodule_from_path(the_repository, null_oid(), path);
 
+	if (!sub)
+		die(_("no submodule mapping found in .gitmodules for path '%s'"),
+		    path);
+
+	config_name = xstrfmt("submodule.%s.url", sub->name);
 	config_set_in_gitmodules_file_gently(config_name, newurl);
+
+	repo_read_gitmodules(the_repository, 0);
 	sync_submodule(path, prefix, NULL, quiet ? OPT_QUIET : 0);
 
 	free(config_name);
-
 	return 0;
 }
 
@@ -2941,19 +2948,26 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
 		N_("git submodule set-branch [-q|--quiet] (-b|--branch) <branch> <path>"),
 		NULL
 	};
+	const struct submodule *sub;
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
 	if (!opt_branch && !opt_default)
 		die(_("--branch or --default required"));
 
 	if (opt_branch && opt_default)
 		die(_("options '%s' and '%s' cannot be used together"), "--branch", "--default");
 
 	if (argc != 1 || !(path = argv[0]))
 		usage_with_options(usage, options);
 
-	config_name = xstrfmt("submodule.%s.branch", path);
+	sub = submodule_from_path(the_repository, null_oid(), path);
+
+	if (!sub)
+		die(_("no submodule mapping found in .gitmodules for path '%s'"),
+		    path);
+
+	config_name = xstrfmt("submodule.%s.branch", sub->name);
 	ret = config_set_in_gitmodules_file_gently(config_name, opt_branch);
 
 	free(config_name);
-- 
2.43.0

