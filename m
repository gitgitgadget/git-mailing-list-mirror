From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] use a hash of the lock token as the suffix for PUT/MOVE
Date: Sat, 14 Feb 2009 17:52:14 +0800
Message-ID: <4996944E.9000104@gmail.com>
References: <49967321.10800@gmail.com> <7vskmhwh6m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 10:54:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYHDg-0007VH-7z
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 10:53:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbZBNJw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 04:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbZBNJw1
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 04:52:27 -0500
Received: from ti-out-0910.google.com ([209.85.142.190]:22020 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbZBNJwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 04:52:25 -0500
Received: by ti-out-0910.google.com with SMTP id d10so1187305tib.23
        for <git@vger.kernel.org>; Sat, 14 Feb 2009 01:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=L9I/SRZ+XSB3kYbV64sK+LevQSgpDmgrMdxHc4tzSSQ=;
        b=R1gdSSbXPyUyDVYPBWC6kUlH58kM3KiyLMptL3XZJ39On6756/Fdl9UuOUMgym+F8X
         vMw23qh086KSzNibMqg4lTblNoI3j914kvTj5S5fcqCG7tuZmvoUxnqb7+nAOBNcjRAc
         EYHb4TmHndMhvVEFJjruBxFzvgoaWmkDHzJ1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=JhiQwcAm1BIdAEY0PUp9CMNtncB2Jj5f6JRNR5BP3ZGyqY3uiPscDDVXKvqAe5bYBp
         +KHT8vToDQwzrITPOR5htjYx4irIpSkRPT21qoZ9kPtOqmqJmVhSPXDJlqLc+b1FjHFQ
         oVaLJbVY/KDWK0QD0ELtwn1UB0PnvZPMVpXIQ=
Received: by 10.110.103.16 with SMTP id a16mr1108125tic.19.1234605143122;
        Sat, 14 Feb 2009 01:52:23 -0800 (PST)
Received: from ?116.87.149.13? ([116.87.149.13])
        by mx.google.com with ESMTPS id i9sm1317764tid.33.2009.02.14.01.52.21
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 14 Feb 2009 01:52:22 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <7vskmhwh6m.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109853>

After 753bc91 ("Remove the requirement opaquelocktoken uri scheme"),
lock tokens are in the URI forms in which they are received from the
server, eg. 'opaquelocktoken:', 'urn:uuid:'.

However, "start_put" (and consequently "start_move"), which attempts to
create a unique temporary file using the UUID of the lock token,
inadvertently uses the lock token in its URI form. These file
operations on the server may not be successful (specifically, in
Windows), due to the colon ':' character from the URI form of the lock
token in the file path.

This patch uses a hash of the lock token instead, guaranteeing only
"safe" characters (a-f, 0-9) are used in the file path.

The token's hash is generated when the lock token is received from the
server in handle_new_lock_ctx, minimizing the number of times of
hashing.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

This patch is a result of the discussion on "[PATCH] use lock token in
non-URI form in start_put"; you can read it at
http://kerneltrap.org/mailarchive/git/2009/2/7/4922094.

The decision to use a hash of the token is so that one can avoid
handling the URI scheme of the lock token, which may be a deeply
nested URI, or (the more likely scenario) contain "unsafe" characters
for a file name, such as colons, slashes and spaces.

* use tmpfile_suffix instead of token_sha1_hex in remote_lock, as
suggested by Junio, and absorb '_' as a result
* memcpy string from sha1_to_hex to tmpfile_suffix

 http-push.c          |   13 +++++++++++--
 t/t5540-http-push.sh |    7 +++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/http-push.c b/http-push.c
index eefd64c..edbff58 100644
--- a/http-push.c
+++ b/http-push.c
@@ -153,6 +153,7 @@ struct remote_lock
 	char *url;
 	char *owner;
 	char *token;
+	char tmpfile_suffix[41];
 	time_t start_time;
 	long timeout;
 	int refreshing;
@@ -557,8 +558,7 @@ static void start_put(struct transfer_request *request)
 	request->dest = strbuf_detach(&buf, NULL);

 	append_remote_object_url(&buf, remote->url, hex, 0);
-	strbuf_addstr(&buf, "_");
-	strbuf_addstr(&buf, request->lock->token);
+	strbuf_add(&buf, request->lock->tmpfile_suffix, 41);
 	request->url = strbuf_detach(&buf, NULL);

 	slot = get_active_slot();
@@ -1130,6 +1130,8 @@ static void handle_lockprop_ctx(struct xml_ctx *ctx, int tag_closed)
 static void handle_new_lock_ctx(struct xml_ctx *ctx, int tag_closed)
 {
 	struct remote_lock *lock = (struct remote_lock *)ctx->userData;
+	git_SHA_CTX sha_ctx;
+	unsigned char lock_token_sha1[20];

 	if (tag_closed && ctx->cdata) {
 		if (!strcmp(ctx->name, DAV_ACTIVELOCK_OWNER)) {
@@ -1142,6 +1144,13 @@ static void handle_new_lock_ctx(struct xml_ctx *ctx, int tag_closed)
 		} else if (!strcmp(ctx->name, DAV_ACTIVELOCK_TOKEN)) {
 			lock->token = xmalloc(strlen(ctx->cdata) + 1);
 			strcpy(lock->token, ctx->cdata);
+
+			git_SHA1_Init(&sha_ctx);
+			git_SHA1_Update(&sha_ctx, lock->token, strlen(lock->token));
+			git_SHA1_Final(lock_token_sha1, &sha_ctx);
+
+			lock->tmpfile_suffix[0] = '_';
+			memcpy(lock->tmpfile_suffix + 1, sha1_to_hex(lock_token_sha1), 40);
 		}
 	}
 }
diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index c236b5e..11b3432 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -94,6 +94,13 @@ test_expect_success 'MKCOL sends directory names with trailing slashes' '

 '

+test_expect_success 'PUT and MOVE sends object to URLs with SHA-1 hash suffix' '
+
+	grep -P "\"(?:PUT|MOVE) .+objects/[\da-z]{2}/[\da-z]{38}_[\da-z\-]{40} HTTP/[0-9.]+\" 20\d" \
+		< "$HTTPD_ROOT_PATH"/access.log
+
+'
+
 stop_httpd

 test_done
-- 
1.6.1.2.278.g9a9e.dirty
