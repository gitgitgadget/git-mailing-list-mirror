Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF9924169D
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775638728; cv=none; b=EgWCPiTK/SCuYvIKz4ku265EzbKbBh8wMvmEdVLDffIoe6xdcT6DVyjTAuJnP1+YMbAuCfMwr2GZdDHg5eaHBxtGNOpRe6barYKwhJSw4U+eewprz0N/tCaQTMQnYm5Fy0MKuPStmWt3WngghewOoPHzQTJVTeSFIp50eFaibXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775638728; c=relaxed/simple;
	bh=XSoilF4JVEmN0HR9LysCv5ob0lDNP1ZIViXf624xukc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=I4qCcWUdTWxubDbNKGuI54NL7CGr2bx/zkkgnd4ZjVJBwb++Qn80+VrQ16mWAU5wul6eVH4x6p1mMEctry8fWCsHdQEcBHQK+cDLj4r/kXFcFUV5JrhcyTNDMKLChAziWX9NeZz5m0caEzGTeX1KRD0tDMHP7+QvAF1C9Q1jVnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=2jwpU8AL; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="2jwpU8AL"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1775638722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cXfyto1hK1tsm4uXZGCzd7jfCJzefuateUvC8U1uQQc=;
	b=2jwpU8ALKsmjfHyhfm5D40/8NJdHa6TLU242+Zc42kwq+NMtRAKjXBynjPpmC23FXz/VR6
	iLblirmzyZKUTBnVJr1edC3Vaqo5/AzOBtOI5wCuLBwoD0feWFCj3rmADItLbreFCWFh6c
	EdQGPII8h8SJHHCF8+QcyssfjgQ4BcY=
From: Toon Claes <toon@iotcl.com>
Date: Wed, 08 Apr 2026 10:58:28 +0200
Subject: [PATCH] bundle-uri: drain remaining response on invalid bundle-uri
 lines
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-toon-bundle-uri-no-uri-v1-1-d4a0e3937eba@iotcl.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBCF4avIrDsQQwjRq5QuohnbEZmUxEhBv
 Hujrh7f4v07ZEpMGfpmh0QbZ45S0T4aGD9e3oQcqkErbZVRDtcYBYciYSEsiVHiNdpM1rbedM5
 7qOdvool/V/j5up3LMNO4njU4jj/MFUviegAAAA==
X-Change-ID: 20260408-toon-bundle-uri-no-uri-24f661a498aa
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

On clone, when the client sends the `bundle-uri` command, the server
might respond with invalid data. For example if it sends information
about a bundle where the 'uri' is empty, it produces the following
error:

    Cloning into 'foo'...
    error: bundle-uri: line has empty key or value
    error: error on bundle-uri response line 4: bundle.bundle-1.uri=
    error: could not retrieve server-advertised bundle-uri list

This error is bubbled up to `transport_get_remote_bundle_uri()`, which
is called by `cmd_clone()` in builtin/clone.c. Over here, the return
value of is ignored, so clone continues.

Despite this, it still dies with this error:

    fatal: expected 'packfile'

This happens because `get_remote_bundle_uri()` exited early, leaving
some unprocessed packet data behind in the read buffer. This is
misleading to the user, because it suggests a problem with the packfile
exchange, when in reality it's caused by a misconfigured bundle-URI on
the server-side.

Fix this by continuing to read packets when an error was encountered,
but without processing the remaining lines. This drains the protocol
stream so no stale data is left behind and the caller can use it if they
like.

With this, clone now continues successfully if invalid bundle-URI data
was sent by the server. This is intentional, because since the inception
of `transport_get_remote_bundle_uri()` in 0cfde740f0 (clone: request the
'bundle-uri' command when available, 2022-12-22) the return value of
that function is ignored in `cmd_clone()` so the clone can continue
without bundles.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
This patch is a leftover from [1]. In that series I've submitted two
patches. Because that series was submitted a long time ago, I'm
submitting this as a new series.

The first patch is in meantime superseded by [2], and thus is dropped
from this series.

The second patch fixes a misleading "fatal: expected 'packfile'" error
that occurs when cloning over HTTP from a server with misconfigured
bundle-URIs. It is modified to address Junio's concerns[3]:

> I tend to agree.  Instead of papering over a misconfiguration, it
> would be better to let the users know, so they have a chance to
> report and/or correct such a misconfiguration.

To reiterate, in the previous series I changed the error() to a
warning() and Justin and Junio both didn't like this. In this series I
didn't remove the error(), but instead I'm ensuring the read buffer is
flushed before get_remote_bundle_uri() exits. This leaves a clean state
behind and clone can continue. (more details in the commit message).

In reply to that other series, Justin also insisted to implement a
server-side fix when bundles are misconfigured. I'm currently on the
fence about this, because I don't have a good idea how to address this.
I see a few options:

 - Emit a warning on server-side: Personally I don't think this is a
   good idea because this might just end up in the logs somewhere, and
   no one might ever read them and they would just make the logs
   explode.

 - Exit the upload-pack process: I like this even less. Bundle-URIs are
   considered to be optional by design. Breaking clone operations
   because of a misconfiguration of something optional is too drastic.

 - On the client-side, read the return value of
   `transport_get_remote_bundle_uri()` and exit the clone in case of
   error: This would make the user a lot more aware of the error, and
   that would encourage the user to inform the server admin to fix the
   issue. But that breaks their clone, and they cannot continue doing
   whatever they wanted to do. Their only option to continue is to
   disable the config transfer.bundleURI, but that's cumbersome.

Because bundle-URIs are optional by design, I believe the changes in
this series are sufficient. Also, the series [2] takes a similar
approach: have the client gracefully continue in case of misconfigured
bundles.

[1]: <20250912-b4-toon-bundle-uri-no-uri-v1-0-f4525a406df8@iotcl.com>
[2]: <pull.2134.v2.git.git.1766160106521.gitgitgadget@gmail.com>
[3]: <xmqqbjnfmvwo.fsf@gitster.g>

Greets,
Toon
---
 connect.c                   | 10 +++++++---
 t/t5558-clone-bundle-uri.sh | 25 +++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/connect.c b/connect.c
index a02583a102..e323455d3b 100644
--- a/connect.c
+++ b/connect.c
@@ -517,7 +517,7 @@ static void send_capabilities(int fd_out, struct packet_reader *reader)
 int get_remote_bundle_uri(int fd_out, struct packet_reader *reader,
 			  struct bundle_list *bundles, int stateless_rpc)
 {
-	int line_nr = 1;
+	int line_nr = 1, err = 0;
 
 	/* Assert bundle-uri support */
 	ensure_server_supports_v2("bundle-uri");
@@ -536,10 +536,14 @@ int get_remote_bundle_uri(int fd_out, struct packet_reader *reader,
 		const char *line = reader->line;
 		line_nr++;
 
+		/* Do not parse if an error was encountered */
+		if (err)
+			continue;
+
 		if (!bundle_uri_parse_line(bundles, line))
 			continue;
 
-		return error(_("error on bundle-uri response line %d: %s"),
+		err = error(_("error on bundle-uri response line %d: %s"),
 			     line_nr, line);
 	}
 
@@ -554,7 +558,7 @@ int get_remote_bundle_uri(int fd_out, struct packet_reader *reader,
 	check_stateless_delimiter(stateless_rpc, reader,
 				  _("expected response end packet after ref listing"));
 
-	return 0;
+	return err;
 }
 
 struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index 7a0943bd36..514cc881b6 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -1302,6 +1302,31 @@ test_expect_success 'bundles with newline in target path are rejected' '
 	test_path_is_missing escape
 '
 
+test_expect_success 'bundles advertised with missing URI' '
+	git clone --no-local --mirror clone-from \
+		"$HTTPD_DOCUMENT_ROOT_PATH/no-uri.git" &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/no-uri.git" config uploadpack.advertiseBundleURIs true &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/no-uri.git" config bundle.version 1 &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/no-uri.git" config bundle.mode all &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/no-uri.git" config bundle.bundle-1.creationToken 1 &&
+
+	git -c transfer.bundleURI=true clone \
+		"$HTTPD_URL/smart/no-uri.git" target-no-uri
+'
+
+test_expect_success 'bundles advertised with empty URI' '
+	git clone --no-local --mirror clone-from \
+		"$HTTPD_DOCUMENT_ROOT_PATH/empty-uri.git" &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/empty-uri.git" config uploadpack.advertiseBundleURIs true &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/empty-uri.git" config bundle.version 1 &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/empty-uri.git" config bundle.mode all &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/empty-uri.git" config bundle.bundle-1.uri "" &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/empty-uri.git" config bundle.bundle-1.creationToken 1 &&
+
+	git -c transfer.bundleURI=true clone \
+		"$HTTPD_URL/smart/empty-uri.git" target-empty-uri
+'
+
 # Do not add tests here unless they use the HTTP server, as they will
 # not run unless the HTTP dependencies exist.
 

---
base-commit: 256554692df0685b45e60778b08802b720880c50
change-id: 20260408-toon-bundle-uri-no-uri-24f661a498aa

