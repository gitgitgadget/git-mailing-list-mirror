Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA331198E99
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 12:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726748147; cv=none; b=AskBQGpfuPXqYr6fPjhMr5pG8zbOSSJXlSoPsfs3rHzARL7bmY6KvsjCoEhbAGv4iPq/2BApd0JjUcYQ3iK7rFVt2qNYrVCgpFap+e0pTBQ26pNnj44B40YIgvg6L3+uEYy7xUx5r6bLdq9qir86Qy1u+4hk06q9pV2wugV7GKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726748147; c=relaxed/simple;
	bh=lpmkYl36M/BhiLKMTnZ35nYtiyeYceuERQptkGzkCLI=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=R4oeQib8jtJP/sXxOVNnb3wk/lpraNFLdjz15r0c24sAGFWgmGE1AM7NUlM713yHsWu6FSFZI8ckKIgYnzD+j36TQXhzb+BBze0n/ZnktiQyywikZ/VeNi/ahe3qOV7QUd3e2px4rnSCBsRBx0vfRuS2jkp6wZ6BmeuYNbu7rgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=gL2ULyA0; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="gL2ULyA0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=1jztEWprNOLqjnyIyE1SXtLsdgMY9G6H9HHzQzyiI/E=;
 b=gL2ULyA01AUd20eJsc218wQJ3MiSsuVG56Gmzgb8HNfDIVM3kUGdhcEBdnjRTDfcknUiscos2Int
   cu8f4hk3RptMDqHGCYHbvlVPQG8l+goDY5sguzQFYOkcOxQGLmVbawJKkRIPhKDQIFXWrYUCNxJB
   MVqwJ/l3WrigerGXQge4bxr+fLrYajc5bxOHO3mE5KqyYn6bCOXfcokp0qhi0hN5AIjr6rml1UdS
   +7szRF/hy8BNchX06asVb16y+eKuRZ64749khbZKkf0VdMPDKc8vYSrVgJQJSS9bcsSBI/BzRjTz
   xfs/K/kkCOkmqaoVIIh21GuXXkorz0iZsaBqSw==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240709 64bit (built Jul  9
 2024))
 with ESMTPS id <0SK200EMD7E29570@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Thu, 19 Sep 2024 12:15:38 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,	Taylor Blau <me@ttaylorr.com>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v3 2/2] fetch: set remote/HEAD if it does not exist
Date: Thu, 19 Sep 2024 14:13:26 +0200
Message-id: <20240919121335.298856-3-bence@ferdinandy.com>
In-reply-to: <20240919121335.298856-1-bence@ferdinandy.com>
References: <D43G2CGX2N7L.ZRETD4HLIH0E@ferdinandy.com>
 <20240919121335.298856-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAG9xX/D4s8daHljmGGnp1CSyZk/gLIAnMTOmriCmosDcY56TjqKtj4i+RHVW197
 KJNxTvsFHA5dJAucBoNDoCNy0kBC6M5vrP0T17a/EVqRZ7/flEhDNNHfSnt1SIkA
 jEgffzE73N/zWB6SWfQh4rBTlQQ3tDClHUU2vOoJxcfVcPd9UD2EiDOqvXg2tTtU
 pjP3nsGr9V3TcUb5pPFqYrbhEN+LRUosjiq2Ek19CzED0HijP19weUimd/Wwu4cn
 xp4ZZq6TiJLvtFvkWyBFnvTkWpSFt3oqcEoGodEnQ491W9pPXMYYEC+WHZXUoeFG
 ByjGJBII5Uc/8p0FMeEZ3FfkhcooVAOg0356Hi1Zs8CVEbfIRs3ws0qJPTI9BzGw
 LXtcX9E7TvGspVlRCSB8zRldJOgXzjCB0DCzx6yWVkO9R8RBzKag6eCaa3kK85J7
 xhfYk5FpTgPu2F2GcgIMfdZ/Mv3ukhoOyBWnvR9O+gtkFiF9HHIT575g

If the user has remote/HEAD set already and it looks like it has changed
on the server, then print a message, otherwise set it if we can.

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    v3: - does not rely on remote set-head anymore so it only authenticates
        once
        - uses the new REF_CREATE_ONLY to atomically check if the ref exists
          and only write it if it doesn't
        - in all other cases the maximum it does is print a warning

 builtin/fetch.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 55f97134aa..2746d40bb5 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1577,6 +1577,70 @@ static int backfill_tags(struct display_state *display_state,
 	return retcode;
 }
 
+static const char *abbrev_ref(const char *name, const char *prefix)
+{
+	skip_prefix(name, prefix, &name);
+	return name;
+}
+#define abbrev_branch(name) abbrev_ref((name), "refs/heads/")
+
+static inline int set_head(const struct ref *remote_refs)
+{
+	int result, ref_changed = 0;
+	struct strbuf b_head = STRBUF_INIT, b_remote_head = STRBUF_INIT, b_local_head = STRBUF_INIT, b_prefix = STRBUF_INIT;
+	const char *remote = gtransport->remote->name;
+	char * head_name = NULL;
+	struct ref *ref, *matches;
+	struct ref *fetch_map = NULL, **fetch_map_tail = &fetch_map;
+	struct refspec_item refspec = {
+		.force = 0,
+		.pattern = 1,
+		.src = (char *) "refs/heads/*",
+		.dst = (char *) "refs/heads/*",
+	};
+	struct string_list heads = STRING_LIST_INIT_DUP;
+
+	get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
+	matches = guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
+				    fetch_map, 1);
+	for (ref = matches; ref; ref = ref->next)
+		string_list_append(&heads, abbrev_branch(ref->name));
+
+
+	if (!heads.nr)
+		result = 1;
+	else if (heads.nr > 1) {
+		result = 1;
+	} else
+		head_name = xstrdup(heads.items[0].string);
+	if (head_name) {
+		strbuf_addf(&b_head, "refs/remotes/%s/HEAD", remote);
+		strbuf_addf(&b_remote_head, "refs/remotes/%s/%s", remote, head_name);
+		strbuf_addf(&b_prefix, "refs/remotes/%s/", remote);
+		if (!refs_read_symbolic_ref(get_main_ref_store(the_repository),b_head.buf,&b_local_head)) {
+			ref_changed = strcmp(b_remote_head.buf,b_local_head.buf);
+			if (heads.nr == 1 && ref_changed) {
+				printf("The ref \'%s/HEAD\' has changed from the locally recorded "
+					"\'%s\' to \'%s\'.\n",remote, abbrev_ref(b_local_head.buf,b_prefix.buf), head_name);
+				printf("Run \'git remote set-head -a %s\' to set it automatically.\n", remote);
+			}
+		}
+		/* make sure it's valid */
+		if (!refs_ref_exists(get_main_ref_store(the_repository), b_remote_head.buf))
+			result = 1;
+		else if (refs_update_symref(get_main_ref_store(the_repository), b_head.buf,
+						b_remote_head.buf, REF_CREATE_ONLY, "fetch"))
+			result = 1;
+		free(head_name);
+	}
+
+	strbuf_release(&b_head);
+	strbuf_release(&b_local_head);
+	strbuf_release(&b_remote_head);
+	strbuf_release(&b_prefix);
+	return result;
+}
+
 static int do_fetch(struct transport *transport,
 		    struct refspec *rs,
 		    const struct fetch_config *config)
@@ -1646,6 +1710,8 @@ static int do_fetch(struct transport *transport,
 				    "refs/tags/");
 	}
 
+	strvec_push(&transport_ls_refs_options.ref_prefixes,"HEAD");
+
 	if (must_list_refs) {
 		trace2_region_enter("fetch", "remote_refs", the_repository);
 		remote_refs = transport_get_remote_refs(transport,
@@ -1790,6 +1856,10 @@ static int do_fetch(struct transport *transport,
 				  "you need to specify exactly one branch with the --set-upstream option"));
 		}
 	}
+	if (!set_head(remote_refs))
+		printf("Ran into issues with \'%s/HEAD\',\n"
+			"use \'git remote set-head -a %s\' to investigate",
+			gtransport->remote->name,gtransport->remote->name);
 
 cleanup:
 	if (retcode) {
@@ -2020,6 +2090,7 @@ static int fetch_multiple(struct string_list *list, int max_children,
 	return !!result;
 }
 
+
 /*
  * Fetching from the promisor remote should use the given filter-spec
  * or inherit the default filter-spec from the config.
-- 
2.46.1.546.gaa0cd55cd3.dirty

