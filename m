From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] connect: simplify check_ref() using skip_prefix() and starts_with()
Date: Sat, 30 Aug 2014 11:46:54 +0200
Message-ID: <54019D8E.8020309@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 30 11:47:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNfFs-0001gp-DJ
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 11:47:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbaH3Jr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2014 05:47:28 -0400
Received: from mout.web.de ([212.227.17.11]:50557 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751137AbaH3Jr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 05:47:27 -0400
Received: from [192.168.178.27] ([79.253.135.121]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0Lcxxc-1Y5Ydu0uW0-00iCXt; Sat, 30 Aug 2014 11:47:22
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
X-Provags-ID: V03:K0:mmNZBV1lcRiVG9h4nCtsNb0x8sa9Owly6cDQXsL0AB7OSet2MnG
 iA3vbwDWvWjhNuKxDQOnkpar4p+7Il7VIlaeK+3lMEdLqR1GYXSzmFDyNfDWZSgIlrJaJ5d
 Wd1NwPZ1ZjjCnn11GaoSj2O9eVylY0A3IH/pgem8gHNV9GS9uaAqjUs4Z/oz2ypBlMtfbYH
 QS/AoUtcHzAqDqHCll6Rg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256244>

Both callers of check_ref() pass in NUL-terminated strings for name.
Remove the len parameter and then use skip_prefix() and starts_with()
instead of memcmp() to check if it starts with certain strings.  This
gets rid of several magic string length constants and a strlen() call.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 connect.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/connect.c b/connect.c
index 5047402..34193e5 100644
--- a/connect.c
+++ b/connect.c
@@ -13,28 +13,24 @@
 static char *server_capabilities;
 static const char *parse_feature_value(const char *, const char *, int *);
 
-static int check_ref(const char *name, int len, unsigned int flags)
+static int check_ref(const char *name, unsigned int flags)
 {
 	if (!flags)
 		return 1;
 
-	if (len < 5 || memcmp(name, "refs/", 5))
+	if (!skip_prefix(name, "refs/", &name))
 		return 0;
 
-	/* Skip the "refs/" part */
-	name += 5;
-	len -= 5;
-
 	/* REF_NORMAL means that we don't want the magic fake tag refs */
 	if ((flags & REF_NORMAL) && check_refname_format(name, 0))
 		return 0;
 
 	/* REF_HEADS means that we want regular branch heads */
-	if ((flags & REF_HEADS) && !memcmp(name, "heads/", 6))
+	if ((flags & REF_HEADS) && starts_with(name, "heads/"))
 		return 1;
 
 	/* REF_TAGS means that we want tags */
-	if ((flags & REF_TAGS) && !memcmp(name, "tags/", 5))
+	if ((flags & REF_TAGS) && starts_with(name, "tags/"))
 		return 1;
 
 	/* All type bits clear means that we are ok with anything */
@@ -43,7 +39,7 @@ static int check_ref(const char *name, int len, unsigned int flags)
 
 int check_ref_type(const struct ref *ref, int flags)
 {
-	return check_ref(ref->name, strlen(ref->name), flags);
+	return check_ref(ref->name, flags);
 }
 
 static void die_initial_contact(int got_at_least_one_head)
@@ -167,7 +163,7 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 			continue;
 		}
 
-		if (!check_ref(name, name_len, flags))
+		if (!check_ref(name, flags))
 			continue;
 		ref = alloc_ref(buffer + 41);
 		hashcpy(ref->old_sha1, old_sha1);
-- 
2.1.0
