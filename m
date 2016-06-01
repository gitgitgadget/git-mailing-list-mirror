From: Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH] pathspec: allow escaped query values
Date: Wed,  1 Jun 2016 16:52:33 -0700
Message-ID: <20160601235233.21040-1-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu Jun 02 01:52:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8FwT-0004no-T1
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 01:52:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbcFAXwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 19:52:43 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34970 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbcFAXwn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 19:52:43 -0400
Received: by mail-pf0-f174.google.com with SMTP id g64so23618564pfb.2
        for <git@vger.kernel.org>; Wed, 01 Jun 2016 16:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=BjMkjunGpjqZe19cAJad6OT5PER/d/smLBFpQjEeM2o=;
        b=V7hhWwWGi1peBL4amT9X5ulgN7vZlBsy0XTJ15Tm1nNBAGRS1m4kv9MMK6qqXF68oj
         JiqKQcWoN8laVmRX3t54CaFx0s7Vs+Etxs0YXI8FT0xBXDi4FBgMljmigNfwYjMN00DY
         iYGedWll6sLfqLg69c+etF//tdhNjsPngWZV/7/G8SU7vAyh6r5rs6WoFBWCqTn/8MjO
         Mx4s3seVZ+m8g9X63Yg6YEmiRzxy8dV9CmKd3Ur3dn/ARf2YIrAvQhl+up+NHSjH3eHW
         DU5g9107OP+bCt7AWE0ZTEEb5am1JU1oWaUamdcY4ok+c+3k42ZT2LID1IbqQJQ14WTJ
         PA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BjMkjunGpjqZe19cAJad6OT5PER/d/smLBFpQjEeM2o=;
        b=arziUVe/EGkXouEdADiu4++MYswuAXlFwlBg3cpPZ/NrYWcWR2uk1TdotKLRR2B19k
         FVE5Mnp3U2Kp8GF6EXJOiKaSfVrNqEADbkUFT4ylgAZ+xuBN5bADjrqXv//60dXHcsM1
         fnEIxD9pQy9KYp/yYuOT2KsTLH/hxULZqM60vKGw5zQaE9uoBXPrbcWxnju9kTsuFBX7
         mplO9gexZyCpHgxZuOhPdmwueD6ya3h4hDUxjjWSi17F7z7JjU67j6qK5KdsUk59Icox
         yKUPStHOZHcmdb8kFTmghIGf+mNh34ycm2BssTrLut1fAUB7MEIpPIZVf21LrpfnhSuw
         h8mw==
X-Gm-Message-State: ALyK8tL36F7JkknCMAI+YnntaVh37AHpgJRbLK9a600QN2YsC1qnOT8Jiz+tB9WD4/LN1vRh
X-Received: by 10.98.8.69 with SMTP id c66mr13915630pfd.47.1464825162085;
        Wed, 01 Jun 2016 16:52:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:e97f:c557:6218:1271])
        by smtp.gmail.com with ESMTPSA id zj2sm65236254pac.6.2016.06.01.16.52.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Jun 2016 16:52:41 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.124.g24a9db3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296177>

In our own .gitattributes file we have attributes such as:

    *.[ch] whitespace=indent,trail,space

When querying for attributes we want to be able to ask for the exact
value, i.e.

    git ls-files :(attr:whitespace=indent,trail,space)

should work, but the commas are used in the attr magic to introduce
the next attr, such that this query currently fails with

fatal: Invalid pathspec magic 'trail' in ':(attr:whitespace=indent,trail,space)'

This change allows escaping characters by a backslash, such that the query

    git ls-files :(attr:whitespace=indent\,trail\,space)

will match all path that have the value "indent,trail,space" for the
whitespace attribute. To accomplish this, we need to modify two places.
First `eat_long_magic` needs to not stop early upon seeing a comma or
closing paren that is escaped. As a second step we need to remove any
escaping from the attr value. For now we just remove any backslashes.

Caveat: This doesn't allow for querying for values that have backslashes
in them, e.g.

    git ls-files :(attr:backslashes=\\)

that would ask for matches that have the `backslashes` value set to '\'.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 * This applies on top of sb/pathspec-label
 * Junio does this come close to what you imagine for escaped commas?
 
 Thanks,
 Stefan
  
 pathspec.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/pathspec.c b/pathspec.c
index 0a02255..925f949 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -89,6 +89,22 @@ static void prefix_short_magic(struct strbuf *sb, int prefixlen,
 	strbuf_addf(sb, ",prefix:%d)", prefixlen);
 }
 
+static char *attr_value_unquote(const char *value)
+{
+	char *ret = xstrdup(value);
+
+	size_t value_len = strlen(ret);
+	size_t len = strcspn(ret, "\\");
+
+	while (len != value_len) {
+		memmove(ret + len, ret + len + 1, value_len - len);
+		value_len--;
+		len += strcspn(ret + len, "\\");
+	}
+
+	return ret;
+}
+
 static void parse_pathspec_attr_match(struct pathspec_item *item, const char *value)
 {
 	struct string_list_item *si;
@@ -132,7 +148,7 @@ static void parse_pathspec_attr_match(struct pathspec_item *item, const char *va
 				am->match_mode = MATCH_SET;
 			else {
 				am->match_mode = MATCH_VALUE;
-				am->value = xstrdup(&attr[attr_len + 1]);
+				am->value = attr_value_unquote(&attr[attr_len + 1]);
 				if (strchr(am->value, '\\'))
 					die(_("attr spec values must not contain backslashes"));
 			}
@@ -167,6 +183,9 @@ static void eat_long_magic(struct pathspec_item *item, const char *elt,
 	     *copyfrom && *copyfrom != ')';
 	     copyfrom = nextat) {
 		size_t len = strcspn(copyfrom, ",)");
+		while (len > 0 && copyfrom[len - 1] == '\\'
+		       && (copyfrom[len] == ',' || copyfrom[len] == ')'))
+			len += strcspn(copyfrom + len + 1, ",)") + 1;
 		if (copyfrom[len] == ',')
 			nextat = copyfrom + len + 1;
 		else
-- 
2.8.2.124.g24a9db3
