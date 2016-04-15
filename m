From: David Turner <dturner@twopensource.com>
Subject: [PATCH/RFC 5/6] fetch: pass refspec to http server
Date: Fri, 15 Apr 2016 15:19:08 -0400
Message-ID: <1460747949-3514-6-git-send-email-dturner@twopensource.com>
References: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 21:19:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar9HT-0006Y9-GJ
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 21:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753416AbcDOTTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 15:19:41 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:33484 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752541AbcDOTTh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 15:19:37 -0400
Received: by mail-qk0-f181.google.com with SMTP id n63so29973109qkf.0
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 12:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JK4Q2EzwLEOwtaPCJD5b6J4qT8Nk9/GcMaByY+9HQAg=;
        b=NcVXO2p8U7vH1sebkLH1Ab1ydph8STzWa+SZW3g4E0MdRKMl/4AyCsJQE/GUI2i07C
         5afPhdJrpBIePR8Fvgoz3RCJAEHv8VVtgPc4u7UrZbD4KSa/4ngoFOYAiTL9J4FkPnYi
         XGbT+JDEecfiTt9GsZJofhZcUtValWsM/sgLCfxURmdnAM9wruC/YbCDJbIQGSae68qJ
         d76A92Voa9fxkGpDFlk5DSkq0xmD56XE+dnkb+pDjvNeCBJTnaCN41xi670jPIdZPcT9
         cFP2V28P+aGhLVwuxQyyNGz76gC83rwK9t3CaoWvB4hqfj3TiqSHhnQS0e7BwxUJ4ml8
         FlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JK4Q2EzwLEOwtaPCJD5b6J4qT8Nk9/GcMaByY+9HQAg=;
        b=igDsqbftljSI4pYh3+Fnf881o2V/BAH/cOpEusL9AqeNW2Z39ME5azop6BscfU4tGi
         K+ZHswZyGp0Dcp2+WIiu9OE1BCUzwYO4/jrwYhVBJKYH0IeeDwIKIhucv8L+NaK+EkZs
         A3WZkCpm2rtEEPnwclUhdyt9NY7Y966YIoAX8ZccPk7wGabJj+KpmMOINNEuf048WVHq
         re+kjIMf/G504ApcSejVFN0RMpwlW+S7n5NCuLPrEphGWRzxVU1LDL1pq9MJp3HHb43c
         EWMTcUJAVMmaS1ezxcwDWKxmegMnUQPQVaMbq6Njc7B5gLy13Ij4sK9k8NQU05zHNK17
         /Cjg==
X-Gm-Message-State: AOPr4FVzV8d2VMx5TkCR4Qxgh6/53fWedW6sE6cr3mkkQS8yQBNeBIKhm1hCRpHanMsXJQ==
X-Received: by 10.55.18.217 with SMTP id 86mr27627260qks.99.1460747976456;
        Fri, 15 Apr 2016 12:19:36 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id c2sm21077097qkb.41.2016.04.15.12.19.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Apr 2016 12:19:35 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291641>

When fetching over http, send the requested refspec to the server.
The server will then only send refs matching that refspec.  It is
permitted for old servers to ignore that parameter, and the client
will automatically handle this.

When the server has many refs, and the client only wants a few, this
can save bandwidth and reduce fetch latency.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/technical/protocol-capabilities.txt | 23 +++++++++++++
 builtin/fetch.c                                   | 20 ++++++++++-
 remote-curl.c                                     |  7 ++++
 t/t5552-http-fetch-branch.sh                      | 42 +++++++++++++++++++++++
 transport-helper.c                                |  8 ++++-
 5 files changed, 98 insertions(+), 2 deletions(-)
 create mode 100755 t/t5552-http-fetch-branch.sh

diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index eaab6b4..8c4a0b9 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -275,3 +275,26 @@ to accept a signed push certificate, and asks the <nonce> to be
 included in the push certificate.  A send-pack client MUST NOT
 send a push-cert packet unless the receive-pack server advertises
 this capability.
+
+interesting-refs
+----------------
+
+For HTTP(S) servers only:
+
+Whether or not the upload-pack server advertises this capability,
+fetch-pack may send a "refspec" parameter in the query string of a
+fetch request.  This capability indicates that such a parameter will
+be respected, in case the client cares.
+
+Whenever the receive-pack server gets that parameter, it will not
+advertise all refs and will instead only advertise refs that match
+those listed in the header. The parameter is a space-separated list of
+refs.  A ref may optionally contain up to one wildcard.
+Advertisements will still respect hideRefs.
+
+The presence or absence of the "refspec" parameter does not affect
+what refs a client is permitted to fetch; this is still controlled in
+the normal fashion.
+
+This saves time in the presence of a large number of refs, because the
+client need not wait for the server to send the complete list of refs.
diff --git a/builtin/fetch.c b/builtin/fetch.c
index cafab37..c22a92f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -302,9 +302,27 @@ static struct ref *get_ref_map(struct transport *transport,
 
 	/* opportunistically-updated references: */
 	struct ref *orefs = NULL, **oref_tail = &orefs;
+	struct refspec *qualified_refspecs;
 	const struct ref *remote_refs;
 
-	remote_refs = transport_get_remote_refs(transport, NULL, 0);
+	qualified_refspecs = xcalloc(refspec_count, sizeof(*qualified_refspecs));
+	for (i = 0; i < refspec_count; i++) {
+		if (starts_with(refspecs[i].src, "refs/")) {
+			qualified_refspecs[i].src = xstrdup(refspecs[i].src);
+		} else {
+			struct strbuf buf = STRBUF_INIT;
+			strbuf_addf(&buf, "refs/heads/%s", refspecs[i].src);
+			qualified_refspecs[i].src = strbuf_detach(&buf, NULL);
+		}
+	}
+
+	remote_refs = transport_get_remote_refs(transport, qualified_refspecs,
+						refspec_count);
+
+	for (i = 0; i < refspec_count; i++) {
+		free(qualified_refspecs[i].src);
+	}
+	free(qualified_refspecs);
 
 	if (refspec_count) {
 		struct refspec *fetch_refspec;
diff --git a/remote-curl.c b/remote-curl.c
index b9b6a90..e914d3f 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -20,6 +20,7 @@ static struct strbuf url = STRBUF_INIT;
 struct options {
 	int verbosity;
 	unsigned long depth;
+	char *refspec;
 	unsigned progress : 1,
 		check_self_contained_and_connected : 1,
 		cloning : 1,
@@ -43,6 +44,10 @@ static int set_option(const char *name, const char *value)
 		options.verbosity = v;
 		return 0;
 	}
+	else if (!strcmp(name, "refspec")) {
+		options.refspec = xstrdup(value);
+		return 0;
+	}
 	else if (!strcmp(name, "progress")) {
 		if (!strcmp(value, "true"))
 			options.progress = 1;
@@ -269,6 +274,8 @@ static struct discovery *discover_refs(const char *service, int for_push)
 		else
 			strbuf_addch(&refs_url, '&');
 		strbuf_addf(&refs_url, "service=%s", service);
+		if (options.refspec)
+			strbuf_addf(&refs_url, "&refspec=%s", options.refspec);
 	}
 
 	memset(&get_options, 0, sizeof(get_options));
diff --git a/t/t5552-http-fetch-branch.sh b/t/t5552-http-fetch-branch.sh
new file mode 100755
index 0000000..0e905d9
--- /dev/null
+++ b/t/t5552-http-fetch-branch.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+
+test_description='fetch just one branch'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'setup repo' '
+	git init "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	(
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+		test_commit 1
+	)
+'
+
+test_expect_success 'clone http repository' '
+	git clone $HTTPD_URL/smart/repo.git clone
+'
+
+test_expect_success 'make some more commits' '
+	(
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+		test_commit 2 &&
+		git checkout -b another_branch &&
+		test_commit 3
+		git checkout -b a_third_branch &&
+		test_commit 4
+	)
+'
+
+test_expect_success 'fetch with refspec only fetches requested branch' '
+	test_when_finished "rm trace" &&
+	(
+		cd clone &&
+		GIT_TRACE_PACKET="$TRASH_DIRECTORY/trace" git fetch origin another_branch &&
+		! grep "refs/heads/master" ../trace
+	)
+'
+
+stop_httpd
+test_done
diff --git a/transport-helper.c b/transport-helper.c
index b5c91d2..7d75d64 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -40,6 +40,9 @@ struct helper_data {
 	struct git_transport_options transport_options;
 };
 
+static int set_helper_option(struct transport *transport,
+			     const char *name, const char *value);
+
 static void sendline(struct helper_data *helper, struct strbuf *buffer)
 {
 	if (debug)
@@ -109,6 +112,7 @@ static struct child_process *get_helper(struct transport *transport, const struc
 	int refspec_alloc = 0;
 	int duped;
 	int code;
+	int i;
 
 	if (data->helper)
 		return data->helper;
@@ -202,7 +206,6 @@ static struct child_process *get_helper(struct transport *transport, const struc
 		}
 	}
 	if (refspecs) {
-		int i;
 		data->refspec_nr = refspec_nr;
 		data->refspecs = parse_fetch_refspec(refspec_nr, refspecs);
 		for (i = 0; i < refspec_nr; i++)
@@ -214,6 +217,9 @@ static struct child_process *get_helper(struct transport *transport, const struc
 	strbuf_release(&buf);
 	if (debug)
 		fprintf(stderr, "Debug: Capabilities complete.\n");
+
+	for (i = 0; i < req_refspec_nr; i++)
+		set_helper_option(transport, "refspec", req_refspecs[i].src);
 	standard_options(transport);
 	return data->helper;
 }
-- 
2.4.2.767.g62658d5-twtrsrc
