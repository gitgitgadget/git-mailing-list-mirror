From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 08/23] refactor duplicated get_local_heads() to remote.c
Date: Tue, 24 Feb 2009 04:50:56 -0500
Message-ID: <f6fd75cecc0eeeceaaf933da0fbc4b71d3f60962.1235467368.git.jaysoffian@gmail.com>
References: <cover.1235467368.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 10:54:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbtzv-0002Ej-MF
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 10:54:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754632AbZBXJvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 04:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754546AbZBXJvk
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 04:51:40 -0500
Received: from an-out-0708.google.com ([209.85.132.241]:14095 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755902AbZBXJvg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 04:51:36 -0500
Received: by an-out-0708.google.com with SMTP id c2so1048504anc.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 01:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=83UP9ugCCtkwcaylXcpU/ZTf8rBQo1AlgCs13BZFbL8=;
        b=I0aodTw/lIc8qZ21+9ECOgtFyFp1f0Yd59ljwtXg3nfTSx8i7Zw6InhTV3W+3c0IFa
         lxVYhOTu1isM6KBlM8fn2ir7Q494DGrAd2QCaOgSaOkdByQBf526rvrCUWVEUqLEPRaK
         GcPeMybDXSoW3PH4SdDhdK92UKLU4NKSDIDno=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=HcjaW8fhDbOO4hMhkxUMzRFizaMILtk67W3q8w1QQeWj7D6eNtSEhQ+2pTCt58Ayax
         TtxQNE3i3i36MzWfqHd2nBMR0jrZsqnSpMLw+mN/8DrtnP5zBCH9L94zorIS43eHI/43
         5isl9bTzYjORfHIXnYzo0wdCIPo9NBUKyrIOA=
Received: by 10.100.127.18 with SMTP id z18mr5494594anc.6.1235469094592;
        Tue, 24 Feb 2009 01:51:34 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id b37sm1463299ana.57.2009.02.24.01.51.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Feb 2009 01:51:34 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235467368.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111262>

get_local_heads() appears to have been copied from builtin-send-pack.c
to http-push.c via cut and paste. This patch moves the function and its
helper one_local_ref() to remote.c.

The two copies of one_local_ref() were not identical. I used the more
recent version from builtin-send-pack.c after confirming with Jeff King
that it was an oversight that commit 30affa1e did not update both
copies.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin-send-pack.c |   29 ++---------------------------
 http-push.c         |   23 ++---------------------
 remote.c            |   26 ++++++++++++++++++++++++++
 remote.h            |    1 +
 4 files changed, 31 insertions(+), 48 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index d65d019..2fbfc29 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -133,33 +133,8 @@ static int ref_newer(const unsigned char *new_sha1,
 	return found;
 }
 
-static struct ref *local_refs, **local_tail;
 static struct ref *remote_refs, **remote_tail;
 
-static int one_local_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
-{
-	struct ref *ref;
-	int len;
-
-	/* we already know it starts with refs/ to get here */
-	if (check_ref_format(refname + 5))
-		return 0;
-
-	len = strlen(refname) + 1;
-	ref = xcalloc(1, sizeof(*ref) + len);
-	hashcpy(ref->new_sha1, sha1);
-	memcpy(ref->name, refname, len);
-	*local_tail = ref;
-	local_tail = &ref->next;
-	return 0;
-}
-
-static void get_local_heads(void)
-{
-	local_tail = &local_refs;
-	for_each_ref(one_local_ref, NULL);
-}
-
 static int receive_status(int in, struct ref *refs)
 {
 	struct ref *hint;
@@ -387,7 +362,7 @@ static int refs_pushed(struct ref *ref)
 
 static int do_send_pack(int in, int out, struct remote *remote, const char *dest, int nr_refspec, const char **refspec)
 {
-	struct ref *ref;
+	struct ref *ref, *local_refs;
 	int new_refs;
 	int ask_for_status_report = 0;
 	int allow_deleting_refs = 0;
@@ -405,7 +380,7 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 	/* No funny business with the matcher */
 	remote_tail = get_remote_heads(in, &remote_refs, 0, NULL, REF_NORMAL,
 				       &extra_have);
-	get_local_heads();
+	local_refs = get_local_heads();
 
 	/* Does the other end support the reporting? */
 	if (server_supports("report-status"))
diff --git a/http-push.c b/http-push.c
index 30d2d34..cfeed81 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1792,21 +1792,8 @@ static int update_remote(unsigned char *sha1, struct remote_lock *lock)
 	return 1;
 }
 
-static struct ref *local_refs, **local_tail;
 static struct ref *remote_refs, **remote_tail;
 
-static int one_local_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
-{
-	struct ref *ref;
-	int len = strlen(refname) + 1;
-	ref = xcalloc(1, sizeof(*ref) + len);
-	hashcpy(ref->new_sha1, sha1);
-	memcpy(ref->name, refname, len);
-	*local_tail = ref;
-	local_tail = &ref->next;
-	return 0;
-}
-
 static void one_remote_ref(char *refname)
 {
 	struct ref *ref;
@@ -1839,12 +1826,6 @@ static void one_remote_ref(char *refname)
 	remote_tail = &ref->next;
 }
 
-static void get_local_heads(void)
-{
-	local_tail = &local_refs;
-	for_each_ref(one_local_ref, NULL);
-}
-
 static void get_dav_remote_heads(void)
 {
 	remote_tail = &remote_refs;
@@ -2195,7 +2176,7 @@ int main(int argc, char **argv)
 	int rc = 0;
 	int i;
 	int new_refs;
-	struct ref *ref;
+	struct ref *ref, *local_refs;
 	char *rewritten_url = NULL;
 
 	git_extract_argv0_path(argv[0]);
@@ -2302,7 +2283,7 @@ int main(int argc, char **argv)
 		fetch_indices();
 
 	/* Get a list of all local and remote heads to validate refspecs */
-	get_local_heads();
+	local_refs = get_local_heads();
 	fprintf(stderr, "Fetching remote heads...\n");
 	get_dav_remote_heads();
 
diff --git a/remote.c b/remote.c
index 9f22aaf..8fd8d23 100644
--- a/remote.c
+++ b/remote.c
@@ -1430,3 +1430,29 @@ const struct ref *guess_remote_head(const struct ref *refs,
 
 	return ret;
 }
+
+static int one_local_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+{
+	struct ref ***local_tail = cb_data;
+	struct ref *ref;
+	int len;
+
+	/* we already know it starts with refs/ to get here */
+	if (check_ref_format(refname + 5))
+		return 0;
+
+	len = strlen(refname) + 1;
+	ref = xcalloc(1, sizeof(*ref) + len);
+	hashcpy(ref->new_sha1, sha1);
+	memcpy(ref->name, refname, len);
+	**local_tail = ref;
+	*local_tail = &ref->next;
+	return 0;
+}
+
+struct ref *get_local_heads(void)
+{
+	struct ref *local_refs, **local_tail = &local_refs;
+	for_each_ref(one_local_ref, &local_tail);
+	return local_refs;
+}
diff --git a/remote.h b/remote.h
index 8409d42..6ff0cda 100644
--- a/remote.h
+++ b/remote.h
@@ -150,4 +150,5 @@ const struct ref *guess_remote_head(const struct ref *refs,
 				    const struct ref **remote_head_p,
 				    struct ref **all_matches_p);
 
+struct ref *get_local_heads(void);
 #endif
-- 
1.6.2.rc1.291.g83eb
