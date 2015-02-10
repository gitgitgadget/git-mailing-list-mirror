From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH] config: add show_err flag to git_config_parse_key()
Date: Wed, 11 Feb 2015 01:15:05 +0530
Message-ID: <54DA5FC1.9010707@gmail.com>
References: <20150206124528.GA18859@inner.h.apk.li> <20150206193313.GA4220@peff.net> <xmqqbnl6hljt.fsf@gitster.dls.corp.google.com> <20150206203902.GB10857@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Andreas Krey <a.krey@gmx.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 20:45:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLGkO-0001mD-BX
	for gcvg-git-2@plane.gmane.org; Tue, 10 Feb 2015 20:45:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753616AbbBJTpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2015 14:45:19 -0500
Received: from mail-pd0-f171.google.com ([209.85.192.171]:43516 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282AbbBJTpS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2015 14:45:18 -0500
Received: by pdev10 with SMTP id v10so18641274pde.10
        for <git@vger.kernel.org>; Tue, 10 Feb 2015 11:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=CZMrBPTycFAMxL6TENXC3h56IEtSsIrypkTZhasSafs=;
        b=fwAGnAI3SE3T3uc/PvDJemhWqwkTEH6N53vOXfGEqvIWpTDV75iCVIXKUXgMuimKOP
         YPeO+WQUYsS/82SINmilq737FnMRrp8eeZ4pdFrvl7AbHKmqoeqtkJg6SrmR6vSZWVM/
         LT8+ROAULGByMsHvv08PK2nApTBecm16nD2rirP05fHB8rqtmi7gL9khh7A1s+zZYgo/
         PsW6tuefxCgKoBzRW5nOu2rADAMWXdUfM9toc7fDAjfsVUssQ03yFXS2Q7hkp8aS03/8
         kBNiLtH/bPG1nMAiiczXxXrEwsY7XzHPJlNtsHhJwfGuwzOQFkiqeGnGL4LDL5ZVYGDz
         FUjQ==
X-Received: by 10.70.134.9 with SMTP id pg9mr40312718pdb.28.1423597517453;
        Tue, 10 Feb 2015 11:45:17 -0800 (PST)
Received: from [100.109.49.138] ([223.176.183.171])
        by mx.google.com with ESMTPSA id th8sm20123439pbc.38.2015.02.10.11.45.13
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 10 Feb 2015 11:45:16 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20150206203902.GB10857@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263645>

`git_config_parse_key()` is used to sanitize the input key.
Some callers of the function like `git_config_set_multivar_in_file()`
get the per-sanitized key directly from the user so it becomes
necessary to raise an error specifying what went wrong when the entered
key is defective.

Other callers like `configset_find_element()` get their keys from
the git itself so a return value signifying error would be enough.
The error output shown to the user is useless and confusing in this
case so add a show_err flag to suppress errors in such cases.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---

Hi,

I just saw your mail late in the night (I didn't had net for a week).
This patch just squelches the error message, I will take a better
look tomorrow morning.

-Tanay

 builtin/config.c |  2 +-
 cache.h          |  2 +-
 config.c         | 19 ++++++++++++-------
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 15a7bea..d5070d7 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -200,7 +200,7 @@ static int get_value(const char *key_, const char *regex_)
 			goto free_strings;
 		}
 	} else {
-		if (git_config_parse_key(key_, &key, NULL)) {
+		if (git_config_parse_key(key_, &key, NULL, 1)) {
 			ret = CONFIG_INVALID_KEY;
 			goto free_strings;
 		}
diff --git a/cache.h b/cache.h
index f704af5..1c0914d 100644
--- a/cache.h
+++ b/cache.h
@@ -1358,7 +1358,7 @@ extern int git_config_string(const char **, const char *, const char *);
 extern int git_config_pathname(const char **, const char *, const char *);
 extern int git_config_set_in_file(const char *, const char *, const char *);
 extern int git_config_set(const char *, const char *);
-extern int git_config_parse_key(const char *, char **, int *);
+extern int git_config_parse_key(const char *, char **, int *, int);
 extern int git_config_set_multivar(const char *, const char *, const char *, int);
 extern int git_config_set_multivar_in_file(const char *, const char *, const char *, const char *, int);
 extern int git_config_rename_section(const char *, const char *);
diff --git a/config.c b/config.c
index 752e2e2..074a671 100644
--- a/config.c
+++ b/config.c
@@ -1309,7 +1309,7 @@ static struct config_set_element *configset_find_element(struct config_set *cs,
 	 * `key` may come from the user, so normalize it before using it
 	 * for querying entries from the hashmap.
 	 */
-	ret = git_config_parse_key(key, &normalized_key, NULL);
+	ret = git_config_parse_key(key, &normalized_key, NULL, 0);

 	if (ret)
 		return NULL;
@@ -1842,8 +1842,9 @@ int git_config_set(const char *key, const char *value)
  *             lowercase section and variable name
  * baselen - pointer to int which will hold the length of the
  *           section + subsection part, can be NULL
+ * show_err - toggle whether the function raises an error on a defective key
  */
-int git_config_parse_key(const char *key, char **store_key, int *baselen_)
+int git_config_parse_key(const char *key, char **store_key, int *baselen_, int show_err)
 {
 	int i, dot, baselen;
 	const char *last_dot = strrchr(key, '.');
@@ -1854,12 +1855,14 @@ int git_config_parse_key(const char *key, char **store_key, int *baselen_)
 	 */

 	if (last_dot == NULL || last_dot == key) {
-		error("key does not contain a section: %s", key);
+		if (show_err)
+			error("key does not contain a section: %s", key);
 		return -CONFIG_NO_SECTION_OR_NAME;
 	}

 	if (!last_dot[1]) {
-		error("key does not contain variable name: %s", key);
+		if (show_err)
+			error("key does not contain variable name: %s", key);
 		return -CONFIG_NO_SECTION_OR_NAME;
 	}

@@ -1881,12 +1884,14 @@ int git_config_parse_key(const char *key, char **store_key, int *baselen_)
 		if (!dot || i > baselen) {
 			if (!iskeychar(c) ||
 			    (i == baselen + 1 && !isalpha(c))) {
-				error("invalid key: %s", key);
+				if (show_err)
+					error("invalid key: %s", key);
 				goto out_free_ret_1;
 			}
 			c = tolower(c);
 		} else if (c == '\n') {
-			error("invalid key (newline): %s", key);
+			if (show_err)
+				error("invalid key (newline): %s", key);
 			goto out_free_ret_1;
 		}
 		(*store_key)[i] = c;
@@ -1936,7 +1941,7 @@ int git_config_set_multivar_in_file(const char *config_filename,
 	char *filename_buf = NULL;

 	/* parse-key returns negative; flip the sign to feed exit(3) */
-	ret = 0 - git_config_parse_key(key, &store.key, &store.baselen);
+	ret = 0 - git_config_parse_key(key, &store.key, &store.baselen, 1);
 	if (ret)
 		goto out_free;

-- 
1.9.0.GIT
