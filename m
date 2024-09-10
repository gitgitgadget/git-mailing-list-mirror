Received: from aib29agh122.zrh1.oracleemaildelivery.com (aib29agh122.zrh1.oracleemaildelivery.com [192.29.178.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AD6176252
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 20:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726001080; cv=none; b=nmJVzaxX+8aqXVGNkiI5vpctBd4fix5gfe5BvsIloo4rErNegn45JPwPxRh6Y6Yw+okZvo5kLuygTHqx2EAgszDvZxZzEq1rTJJ/ni20SRShAqXEE83dT6rdlO2r/OF95pqrSUuFzVyEbdD9qHSfRi6FReOGDEmF2Oye/BpjbgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726001080; c=relaxed/simple;
	bh=QZBCqw2G82OdN2aDRIhGTS893iPwEWAjoCSNC2nDoS0=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=Y/iwyEV8bK+bEbooDG4tZ+w+gs1A7epP0E0Z+xfXwgzvfwUBSDDX3UfUVQhKK08fFtvKqVH7Nr0ZDVLd2k+RIW8HRADLrzp1RMrSJjrCsNl+G3AgLlhF7p7POf+r0+l/NHfup0It7OSWMVU7DQ3KSNfuoiXqfPUcKSFM6BRRJqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=FWRBIni0; arc=none smtp.client-ip=192.29.178.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="FWRBIni0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=R1YrB40qO3JlgrgVOKo9miaDmh2216DNGKIvrWEzizs=;
 b=FWRBIni0SLL13qloeXKjbj/5emta/gNs+K95NlY4cViAfNzWyf4KoS2sagRYUM9xvMUl1DO1ceYV
   ahV/hS/fsUYBOZeBmH5st94PuTilV3ug1k/EXscfXrqLSB05MNmZCiCHM1QGbz8gmm4JZLwzYEMN
   FHhid+c0QBUdwtavGYU5eQLMEpApIVAOnFKJoTHFlfk6eCjm+XigYKAI2jXAnSKxaHzoFL0T5+Ka
   JrYKfsLgoA0TG2rulbo6ey+J2Mlje0oZy789IPxy8OvrPWcJfmsfNU2c2S9Sn44LlbDB/5gVVgVM
   dtw5YX39QOeXBk4VCYkB6MHzDlfmYouhun63nQ==
Received: by omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240709 64bit (built Jul  9
 2024))
 with ESMTPS id <0SJM008G96PR7A30@omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Tue, 10 Sep 2024 20:39:27 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,	Taylor Blau <me@ttaylorr.com>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [RFC PATCH v2 1/2] fetch: set-head with --set-head option
Date: Tue, 10 Sep 2024 22:37:13 +0200
Message-id: <20240910203835.2288291-2-bence@ferdinandy.com>
In-reply-to: <20240910203835.2288291-1-bence@ferdinandy.com>
References: <20240910203835.2288291-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAGJ6/mkol+Ap++/pEyqGNeGu9zVxxvhfnzcW8vd2ea3WUcu9RlcMLRcPbzoE7zE
 zntPrxyZWTntUgHFoc9mRXJKx8oyEPMPhSmhjBFgMB4+Y0mzwqE5Lx6cd4A4OO3R
 k9REjBb/BwsPqgXxrR+N/2DO7NL1+lguSXSIoXmxblOuSajSnfpv2kmxWtGB4b5N
 82yRAQJCI3HOZB1619aG62Gb5dZcQ0niZT9gDVbllBvItwKjCpnLI4nMV/EksuyI
 roqewYhbsCgfPdv/BctAX3kAdKMX1S81seq9uKe2lCNASnUcQu/FKsd6wC5dLHwj
 gCgFPuCkqTQtX359u5ry3KRUT7/e1uPr0HiSXhGp/pAjxpuA5Qo1jmNbiS90utbP
 20LF19AnUmNoavCJqegNySOEfVSHU5gzFaNGKf1gV35ZBx8eyTrWHe8OsHRfgJW1
 tR0amDq2py+uWZbaCUDa+poioTNUM+sAEXr37LtWw7738Zcy9DgSYDiJ

When cloning a repository refs/remotes/origin/HEAD is set automatically.
In contrast, when using init, remote add and fetch to set a remote, one
needs to call remote set-head --auto to achieve the same result.

Add a --set-head option to git fetch to automatically set heads on
remotes.

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---
 builtin/fetch.c  | 29 ++++++++++++++++++++++++-----
 builtin/remote.c |  5 +++++
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b2b5aee5bf..6392314c6a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1961,8 +1961,19 @@ static int fetch_finished(int result, struct strbuf *out,
 	return 0;
 }
 
-static int fetch_multiple(struct string_list *list, int max_children,
-			  const struct fetch_config *config)
+static int run_set_head(const char *name)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	strvec_push(&cmd.args, "remote");
+	strvec_push(&cmd.args, "set-head");
+	strvec_push(&cmd.args, "--auto");
+	strvec_push(&cmd.args, name);
+	cmd.git_cmd = 1;
+	return run_command(&cmd);
+}
+
+static int fetch_multiple(struct string_list *list, int max_children, int set_head,
+			const struct fetch_config *config)
 {
 	int i, result = 0;
 	struct strvec argv = STRVEC_INIT;
@@ -2014,6 +2025,8 @@ static int fetch_multiple(struct string_list *list, int max_children,
 				error(_("could not fetch %s"), name);
 				result = 1;
 			}
+			if (set_head && run_set_head(name))
+				result = 1;
 		}
 
 	strvec_clear(&argv);
@@ -2062,7 +2075,7 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 }
 
 static int fetch_one(struct remote *remote, int argc, const char **argv,
-		     int prune_tags_ok, int use_stdin_refspecs,
+		     int prune_tags_ok, int set_head, int use_stdin_refspecs,
 		     const struct fetch_config *config)
 {
 	struct refspec rs = REFSPEC_INIT_FETCH;
@@ -2135,9 +2148,12 @@ static int fetch_one(struct remote *remote, int argc, const char **argv,
 	refspec_clear(&rs);
 	transport_disconnect(gtransport);
 	gtransport = NULL;
+	if (set_head && run_set_head(remote -> name))
+		exit_code = 1;
 	return exit_code;
 }
 
+
 int cmd_fetch(int argc, const char **argv, const char *prefix)
 {
 	struct fetch_config config = {
@@ -2154,6 +2170,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	struct string_list list = STRING_LIST_INIT_DUP;
 	struct remote *remote = NULL;
 	int all = -1, multiple = 0;
+	int set_head = 0;
 	int result = 0;
 	int prune_tags_ok = 1;
 	int enable_auto_gc = 1;
@@ -2171,6 +2188,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		OPT__VERBOSITY(&verbosity),
 		OPT_BOOL(0, "all", &all,
 			 N_("fetch from all remotes")),
+		OPT_BOOL(0, "set-head", &set_head,
+			 N_("auto set remote HEAD")),
 		OPT_BOOL(0, "set-upstream", &set_upstream,
 			 N_("set upstream for git pull/fetch")),
 		OPT_BOOL('a', "append", &append,
@@ -2436,7 +2455,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 			trace2_region_leave("fetch", "setup-partial", the_repository);
 		}
 		trace2_region_enter("fetch", "fetch-one", the_repository);
-		result = fetch_one(remote, argc, argv, prune_tags_ok, stdin_refspecs,
+		result = fetch_one(remote, argc, argv, prune_tags_ok, set_head, stdin_refspecs,
 				   &config);
 		trace2_region_leave("fetch", "fetch-one", the_repository);
 	} else {
@@ -2459,7 +2478,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 
 		/* TODO should this also die if we have a previous partial-clone? */
 		trace2_region_enter("fetch", "fetch-multiple", the_repository);
-		result = fetch_multiple(&list, max_children, &config);
+		result = fetch_multiple(&list, max_children, set_head, &config);
 		trace2_region_leave("fetch", "fetch-multiple", the_repository);
 	}
 
diff --git a/builtin/remote.c b/builtin/remote.c
index 0acc547d69..35c54dd103 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1536,9 +1536,12 @@ static int get_remote_default(const char *key, const char *value UNUSED,
 static int update(int argc, const char **argv, const char *prefix)
 {
 	int i, prune = -1;
+	int set_head = 0;
 	struct option options[] = {
 		OPT_BOOL('p', "prune", &prune,
 			 N_("prune remotes after fetching")),
+		OPT_BOOL(0, "set-head", &set_head,
+			 N_("auto set remote HEAD")),
 		OPT_END()
 	};
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -1552,6 +1555,8 @@ static int update(int argc, const char **argv, const char *prefix)
 
 	if (prune != -1)
 		strvec_push(&cmd.args, prune ? "--prune" : "--no-prune");
+	if (set_head)
+		strvec_push(&cmd.args, "--set-head");
 	if (verbose)
 		strvec_push(&cmd.args, "-v");
 	strvec_push(&cmd.args, "--multiple");
-- 
2.46.0

