From: Junio C Hamano <junio@pobox.com>
Subject: [PATCH 2/3] make-static: next
Date: Sun, 11 Sep 2011 14:38:30 -0700
Message-ID: <7vaaaan4ix.fsf@alter.siamese.dyndns.org>
References: <4E6D0E3F.3090304@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Sep 11 23:38:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2rje-0004QY-Pf
	for gcvg-git-2@lo.gmane.org; Sun, 11 Sep 2011 23:38:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754865Ab1IKVie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Sep 2011 17:38:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37207 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755228Ab1IKVid (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2011 17:38:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB19A4336;
	Sun, 11 Sep 2011 17:38:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=EeWwLKqXm4rNJ96k1vu+0KONh9Y=; b=C5byOhlnCFOOAm7fg8ed
	3w740oU1MqbJDjCUmDIjCNyudxXc7qfedmV4ufC/iKlWZnWTBfHnePp/7ObHmpBM
	hHuO3c/UQXdEZVAo4ic/F/h/Kg9X0R2pEZjod5Rv3FTADaTtJx+FroylRO0Ide2y
	9MjIDvRmZFHcfEk2xx2g0JU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=e3yT0T2sKf9M7ZvLjAUEaRwmrmH9Iigg1/yFz+VLLUbbPp
	P+1jvwHJj/Hmf98shoZYXM7uWUzAg6PzwW7r4Sx5zO5VogbHdkcJIWlSHAaNc14+
	YcqCglz7ROOd9CyVXzPOZJx8Kjn9s4aL3bS91AHwV9RORByaXS4BKZB+5NWSc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1C264335;
	Sun, 11 Sep 2011 17:38:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 27EDD4334; Sun, 11 Sep 2011
 17:38:32 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 654071DE-DCBE-11E0-AAB5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181195>

Many symbols that are exported to the global scope do not have to be.

This needs to be split into separate patches and queued on top of each
individual topic.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/revert.c |    2 +-
 credential.c     |   46 +++++++++++++++++++++++-----------------------
 credential.h     |    1 -
 submodule.c      |    4 ++--
 4 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 5e97622..515f3cc 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -659,7 +659,7 @@ static void read_and_refresh_cache(struct replay_opts *opts)
  *     assert(commit_list_count(list) == 2);
  *     return list;
  */
-struct commit_list **commit_list_append(struct commit *commit,
+static struct commit_list **commit_list_append(struct commit *commit,
 					struct commit_list **next)
 {
 	struct commit_list *new = xmalloc(sizeof(struct commit_list));
diff --git a/credential.c b/credential.c
index 7a0c751..6243b03 100644
--- a/credential.c
+++ b/credential.c
@@ -171,6 +171,29 @@ static int credential_do(struct credential *c, const char *method,
 	return r;
 }
 
+static int credential_fill_gently(struct credential *c,
+				  const struct string_list *methods)
+{
+	int i;
+
+	if (c->username && c->password)
+		return 0;
+
+	if (!methods)
+		methods = &default_methods;
+
+	if (!methods->nr)
+		return credential_getpass(c);
+
+	for (i = 0; i < methods->nr; i++) {
+		if (!credential_do(c, methods->items[i].string, NULL) &&
+		    c->username && c->password)
+			return 0;
+	}
+
+	return -1;
+}
+
 void credential_fill(struct credential *c, const struct string_list *methods)
 {
 	struct strbuf err = STRBUF_INIT;
@@ -195,29 +218,6 @@ void credential_fill(struct credential *c, const struct string_list *methods)
 	die("%s", err.buf);
 }
 
-int credential_fill_gently(struct credential *c,
-			   const struct string_list *methods)
-{
-	int i;
-
-	if (c->username && c->password)
-		return 0;
-
-	if (!methods)
-		methods = &default_methods;
-
-	if (!methods->nr)
-		return credential_getpass(c);
-
-	for (i = 0; i < methods->nr; i++) {
-		if (!credential_do(c, methods->items[i].string, NULL) &&
-		    c->username && c->password)
-			return 0;
-	}
-
-	return -1;
-}
-
 void credential_reject(struct credential *c, const struct string_list *methods)
 {
 	int i;
diff --git a/credential.h b/credential.h
index 788ed8e..07541ad 100644
--- a/credential.h
+++ b/credential.h
@@ -13,7 +13,6 @@ struct string_list;
 int credential_getpass(struct credential *);
 void credential_from_config(struct credential *);
 
-int credential_fill_gently(struct credential *, const struct string_list *methods);
 void credential_fill(struct credential *, const struct string_list *methods);
 void credential_reject(struct credential *, const struct string_list *methods);
 
diff --git a/submodule.c b/submodule.c
index 38d9877..5a02890 100644
--- a/submodule.c
+++ b/submodule.c
@@ -318,7 +318,7 @@ static int has_remote(const char *refname, const unsigned char *sha1, int flags,
 	return 1;
 }
 
-int submodule_needs_pushing(const char *path, const unsigned char sha1[20], void *data)
+static int submodule_needs_pushing(const char *path, const unsigned char sha1[20], void *data)
 {
 	int *needs_pushing = data;
 
@@ -352,7 +352,7 @@ int submodule_needs_pushing(const char *path, const unsigned char sha1[20], void
 	return 1;
 }
 
-int push_submodule(const char *path, const unsigned char sha1[20], void *data)
+static int push_submodule(const char *path, const unsigned char sha1[20], void *data)
 {
 	if (add_submodule_odb(path) || !lookup_commit_reference(sha1))
 		return 1;
-- 
1.7.7.rc0.188.g3793ac
