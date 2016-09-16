Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9E0B207E6
	for <e@80x24.org>; Fri, 16 Sep 2016 00:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757375AbcIPAMp (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 20:12:45 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33043 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757006AbcIPAMa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 20:12:30 -0400
Received: by mail-qk0-f195.google.com with SMTP id n66so4509981qkf.0
        for <git@vger.kernel.org>; Thu, 15 Sep 2016 17:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=6HFvVJy3GDx2JfJqOBsxFJ41Nmx5K8jDA9duXA0RO48=;
        b=WOjElycr1yBf2ZPmMIElzGdqVM8oRid8tbQd4vN1KgRNrXAPDWO0PZFAVCrMiK+Lye
         uWdfGp6rokx4BEXIU+Xc+ykGGHXcZXEGaWGRk0fRGMd/V+hQzxEwLISBvM2K79spuWHg
         cBU+sgrQnW4jFpXC7gv477gb2cLRiltqSvWn+UGl/eIC3WzvbnPEdWtyTOnpQkNgeVuo
         sFhTMQYqNHfebsyrroze8T7wSfVB3bZQoYz4PgfgVo2sUKrl94lxJH9lG3Ch24W0ystE
         s0RDN0ccomPhBdpDCaynI5JKph9LYVpTnkmp0L22LQ65mTTIfK/Zhhw7doOA8rFdKQmP
         4i3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=6HFvVJy3GDx2JfJqOBsxFJ41Nmx5K8jDA9duXA0RO48=;
        b=JhKWqcxqPGng9zVQDX2nVsgHBzoTKK/0uj+LM2P3Z66NApQ19HrcHrNG1or5/Za4Ce
         dErU91qF0GPpMYmTWWz6oLCOMNNc4jCnup2Jk0VzS+qS13zg2mKRHOBKz8YiNj6xGRao
         LyVEANHqZgX69uQKxYwLcb305ZB4PlVi4xqLWaZ8kSLDByhJg/MGhM+fv+kIYm2xzFV7
         pfbkfbl0LpW058540y4SKy0AirwL8B0XObkPC/fwObnyVvibQOaAZOWqzcMLnktSIJ/v
         MbeX+yMZpyDkVexnFrCb5dBT9pk/mMwJFJttLOfYoO/OqWD+UJ1QUE7qK2U76hsVYY0z
         YQnw==
X-Gm-Message-State: AE9vXwPflTpKeiwsrjRx3YHfK7KWAiQzSKa4uTeDB3j/ICf5J3wuKZYmEr0iYWlQMB90Tw==
X-Received: by 10.55.119.134 with SMTP id s128mr13140322qkc.39.1473984748970;
        Thu, 15 Sep 2016 17:12:28 -0700 (PDT)
Received: from localhost.localdomain (ool-457850cc.dyn.optonline.net. [69.120.80.204])
        by smtp.gmail.com with ESMTPSA id d27sm3227196qtd.37.2016.09.15.17.12.28
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Sep 2016 17:12:28 -0700 (PDT)
From:   Kevin Wern <kevin.m.wern@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 06/11] Resumable clone: implement transport_prime_clone
Date:   Thu, 15 Sep 2016 20:12:17 -0400
Message-Id: <1473984742-12516-7-git-send-email-kevin.m.wern@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
References: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create transport_prime_clone API, as well as all internal methods.
Create representations of alt_resource and prime-clone path options.

The intention of get_alt_res_helper is solely to parse the output of
remote-curl because transport-helper does not handle verbose options
or speaking to the user verbosely. Therefore, all error parsing is
done with remote-curl, and any protocol breach between remote-curl and
transport-helper will treated as a bug and result in death.

Signed-off-by: Kevin Wern <kevin.m.wern@gmail.com>
---
 transport-helper.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 transport.c        | 44 ++++++++++++++++++++++++++++++++++++++++++++
 transport.h        | 20 ++++++++++++++++++++
 3 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index b934183..eb185d5 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -28,7 +28,8 @@ struct helper_data {
 		signed_tags : 1,
 		check_connectivity : 1,
 		no_disconnect_req : 1,
-		no_private_update : 1;
+		no_private_update : 1,
+		prime_clone : 1;
 	char *export_marks;
 	char *import_marks;
 	/* These go from remote name (as in "list") to private name */
@@ -180,6 +181,8 @@ static struct child_process *get_helper(struct transport *transport)
 			data->export = 1;
 		else if (!strcmp(capname, "check-connectivity"))
 			data->check_connectivity = 1;
+		else if (!strcmp(capname, "prime-clone"))
+			data->prime_clone = 1;
 		else if (!data->refspecs && skip_prefix(capname, "refspec ", &arg)) {
 			ALLOC_GROW(refspecs,
 				   refspec_nr + 1,
@@ -248,6 +251,7 @@ static int disconnect_helper(struct transport *transport)
 }
 
 static const char *unsupported_options[] = {
+	TRANS_OPT_PRIMECLONE,
 	TRANS_OPT_UPLOADPACK,
 	TRANS_OPT_RECEIVEPACK,
 	TRANS_OPT_THIN,
@@ -1054,6 +1058,50 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 	return ret;
 }
 
+static const struct alt_resource *const get_alt_res_helper(struct transport *transport)
+{
+	struct helper_data *data = transport->data;
+	char *url = NULL, *filetype = NULL;
+	struct alt_resource *ret = NULL;
+	struct strbuf out = STRBUF_INIT;
+	struct child_process *helper = get_helper(transport);
+	int err = 0;
+
+	helper = get_helper(transport);
+	write_constant(helper->in, "prime-clone\n");
+
+	while (!recvline(data, &out)) {
+		char *space = strchr(out.buf, ' ');
+
+		if (!*out.buf)
+			break;
+
+		if (starts_with(out.buf, "error")) {
+			err = 1;
+			continue;
+		}
+
+		if (!space || strchr(space + 1, ' '))
+			die("malformed alternate resource response: %s\n",
+			    out.buf);
+
+		if ((filetype && url) || err)
+			continue;
+
+		filetype = xstrndup(out.buf, (space - out.buf));
+		url = xstrdup(space + 1);
+	}
+
+	if (filetype && url && !err) {
+		ret = xcalloc(1, sizeof(*ret));
+		ret->filetype = filetype;
+		ret->url = url;
+	}
+
+	strbuf_release(&out);
+	return ret;
+}
+
 int transport_helper_init(struct transport *transport, const char *name)
 {
 	struct helper_data *data = xcalloc(1, sizeof(*data));
@@ -1067,6 +1115,7 @@ int transport_helper_init(struct transport *transport, const char *name)
 	transport->data = data;
 	transport->set_option = set_helper_option;
 	transport->get_refs_list = get_refs_list;
+	transport->prime_clone = get_alt_res_helper;
 	transport->fetch = fetch;
 	transport->push_refs = push_refs;
 	transport->disconnect = release_helper;
diff --git a/transport.c b/transport.c
index 7bd3206..dd0d839 100644
--- a/transport.c
+++ b/transport.c
@@ -131,6 +131,9 @@ static int set_git_option(struct git_transport_options *opts,
 	} else if (!strcmp(name, TRANS_OPT_RECEIVEPACK)) {
 		opts->receivepack = value;
 		return 0;
+	} else if (!strcmp(name, TRANS_OPT_PRIMECLONE)) {
+		opts->primeclone = value;
+		return 0;
 	} else if (!strcmp(name, TRANS_OPT_THIN)) {
 		opts->thin = !!value;
 		return 0;
@@ -533,6 +536,42 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	return ret;
 }
 
+const struct alt_resource *const get_alt_res_via_connect(struct transport *transport)
+{
+	struct git_transport_data *data = transport->data;
+	const struct alt_resource *res = NULL;
+	int flags = transport->verbose > 0 ? 0 : CONNECT_SUPPRESS_ERRORS;
+
+	data->conn = git_connect(data->fd, transport->url,
+				 transport->smart_options->primeclone, flags);
+	res = get_alt_res_connect(data->fd[0], flags);
+
+	close(data->fd[0]);
+	close(data->fd[1]);
+	finish_connect(data->conn);
+	data->conn = NULL;
+
+	return res;
+}
+
+const struct alt_resource *const transport_prime_clone(struct transport *transport)
+{
+	if (transport->prime_clone && !transport->alt_res)
+		transport->alt_res = transport->prime_clone(transport);
+	if (transport->verbose > 0) {
+		if (transport->alt_res)
+			// redundant at this point, but will be
+			// more useful in future iterations with
+			// lists of potential resources
+			fprintf(stderr, "alt resource found: %s (%s)\n",
+				transport->alt_res->url,
+				transport->alt_res->filetype);
+		else
+			fprintf(stderr, "alt res not found\n");
+	}
+	return transport->alt_res;
+}
+
 static int connect_git(struct transport *transport, const char *name,
 		       const char *executable, int fd[2])
 {
@@ -691,6 +730,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		ret->set_option = NULL;
 		ret->get_refs_list = get_refs_via_connect;
 		ret->fetch = fetch_refs_via_pack;
+		ret->prime_clone = get_alt_res_via_connect;
 		ret->push_refs = git_transport_push;
 		ret->connect = connect_git;
 		ret->disconnect = disconnect_git;
@@ -713,6 +753,10 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		ret->smart_options->receivepack = "git-receive-pack";
 		if (remote->receivepack)
 			ret->smart_options->receivepack = remote->receivepack;
+		// No remote.*.primeclone config because prime-clone only
+		// applies to clone. After that, it is never used the repo
+		// again.
+		ret->smart_options->primeclone = "git-prime-clone";
 	}
 
 	return ret;
diff --git a/transport.h b/transport.h
index c681408..2bb6963 100644
--- a/transport.h
+++ b/transport.h
@@ -15,6 +15,7 @@ struct git_transport_options {
 	int depth;
 	const char *uploadpack;
 	const char *receivepack;
+	const char *primeclone;
 	struct push_cas_option *cas;
 };
 
@@ -24,11 +25,17 @@ enum transport_family {
 	TRANSPORT_FAMILY_IPV6
 };
 
+struct alt_resource {
+	char *url;
+	char *filetype;
+};
+
 struct transport {
 	struct remote *remote;
 	const char *url;
 	void *data;
 	const struct ref *remote_refs;
+	const struct alt_resource *alt_res;
 
 	/**
 	 * Indicates whether we already called get_refs_list(); set by
@@ -68,6 +75,15 @@ struct transport {
 	struct ref *(*get_refs_list)(struct transport *transport, int for_push);
 
 	/**
+	 * Returns the location of an alternate resource to fetch before
+	 * cloning.
+	 *
+	 * If the transport cannot determine an alternate resource, then
+	 * NULL is returned.
+	 **/
+	const struct alt_resource *const (*prime_clone)(struct transport *transport);
+
+	/**
 	 * Fetch the objects for the given refs. Note that this gets
 	 * an array, and should ignore the list structure.
 	 *
@@ -164,6 +180,9 @@ int transport_restrict_protocols(void);
 /* The program to use on the remote side to send a pack */
 #define TRANS_OPT_UPLOADPACK "uploadpack"
 
+/* The program to use on the remote side to check for alternate resource */
+#define TRANS_OPT_PRIMECLONE "primeclone"
+
 /* The program to use on the remote side to receive a pack */
 #define TRANS_OPT_RECEIVEPACK "receivepack"
 
@@ -208,6 +227,7 @@ int transport_push(struct transport *connection,
 		   unsigned int * reject_reasons);
 
 const struct ref *transport_get_remote_refs(struct transport *transport);
+const struct alt_resource *const transport_prime_clone(struct transport *transport);
 
 int transport_fetch_refs(struct transport *transport, struct ref *refs);
 void transport_unlock_pack(struct transport *transport);
-- 
2.7.4

