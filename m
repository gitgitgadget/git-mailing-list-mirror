From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2] pathspec: allow escaped query values
Date: Thu,  2 Jun 2016 14:30:15 -0700
Message-ID: <20160602213015.21712-1-sbeller@google.com>
Cc: git@vger.kernel.org, pclouds@gmail.com,
	ramsay@ramsayjones.plus.com, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 02 23:30:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8aC8-0001Zg-Jl
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 23:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932645AbcFBVaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 17:30:20 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33298 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932215AbcFBVaT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 17:30:19 -0400
Received: by mail-pa0-f50.google.com with SMTP id ec8so2585142pac.0
        for <git@vger.kernel.org>; Thu, 02 Jun 2016 14:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=TyTedF4dLeW1Zxu9jDim04G4bRJTfnT4V/ZNnlXvH28=;
        b=QCnwuthhnOdwlBKZF9fVNGIQJDe/pzgk2Q6mc+PojyFZda11T06e7j8v3AVN/HgkxX
         KEn7/GTMOH3AORwl5GVZqnldGDN9Bx4LbfLXj73Pzvm+kzZkCQ2I8sV3mg6mchJm1fuC
         BQokl+RodhuUfiuf/aRRPUJPPUFcXI2FGs9PKaLh5H5mZNvNUjd65BAniN77N9ZjLuxo
         WWGRxDM+NAUa2T5dD0YVKErh077CYWG4RxkG8vwF+EH8+J8g9pjeh+MnhtBQUSqJEJRb
         jBg5f/m7iF8vFwBJyBxMAmd9TcoJ3cdag6gQAVXN/jYxYh5DPkcoABg2TNH0RtvCN2HI
         GgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TyTedF4dLeW1Zxu9jDim04G4bRJTfnT4V/ZNnlXvH28=;
        b=V5ItjMdDDfsLkY6EGfkPxAtFR3Sz8BWt9AOvy1+66KCyAnXzy08gKuN0nfkdXR93OF
         rZJG4xHCykq0gQB1XlUAY3ZztNOGbqn028AlnQO8VYR3aMHvD5iHPWakUJx7Eos5B1fA
         7uhFE5gXeCPrR02llDNNFXqiKgTpJqrVHS0lXw1EAULk4a3Va4VkldG6PcvJ6i+tgIRF
         D5zTFM3NoexKYP4kBZKwnnHFOvCj4biOk8Q2g4WrL+csNVuhK+kI8tbqwtviJyFXQ8g8
         4zPNexbQEWICI8wyVXRZ1NfnZyJXGrIvVVxvF4V3jBk+QgUzAPteyNk68m74P82EpfDV
         hKEw==
X-Gm-Message-State: ALyK8tJN0As3b687NP39SW5sRXg0a9tjk/mMOrrrYzlAjsBR6NjnCBi+i3pEma/RDCMdlx4R
X-Received: by 10.66.62.196 with SMTP id a4mr283102pas.25.1464903018362;
        Thu, 02 Jun 2016 14:30:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:69fd:2c70:2aa5:9d28])
        by smtp.gmail.com with ESMTPSA id ih15sm513780pab.38.2016.06.02.14.30.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 02 Jun 2016 14:30:17 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.126.g9068a9d.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296239>

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
escaping from the attr value.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

So here is the "escaping only, but escaping done right" version.
(It goes on top of sb/pathspec-label)

Thanks,
Stefan

 pathspec.c                      | 44 +++++++++++++++++++++++++++++++++++++----
 t/t6134-pathspec-with-labels.sh | 23 +++++++++++++++++++++
 2 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 326863a..45bd775 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -89,6 +89,43 @@ static void prefix_short_magic(struct strbuf *sb, int prefixlen,
 	strbuf_addf(sb, ",prefix:%d)", prefixlen);
 }
 
+static size_t strcspn_escaped(const char *s, const char *reject)
+{
+	const char *i, *j;
+
+	for (i = s; *i; i++) {
+		/* skip escaped the character */
+		if (i[0] == '\\' && i[1]) {
+			i++;
+			continue;
+		}
+		/* see if any of the chars matches the current character */
+		for (j = reject; *j; j++)
+			if (!*i || *i == *j)
+				return i - s;
+	}
+	return i - s;
+}
+
+static char *attr_value_unescape(const char *value)
+{
+	char *i, *ret = xstrdup(value);
+
+	for (i = ret; *i; i++) {
+		if (i[0] == '\\') {
+			if (!i[1])
+				die(_("Escape character '\\' not allowed as "
+				      "last character in attr value"));
+
+			/* remove the backslash */
+			memmove(i, i + 1, strlen(i));
+			/* and ignore the character after that */
+			i++;
+		}
+	}
+	return ret;
+}
+
 static void parse_pathspec_attr_match(struct pathspec_item *item, const char *value)
 {
 	struct string_list_item *si;
@@ -131,10 +168,9 @@ static void parse_pathspec_attr_match(struct pathspec_item *item, const char *va
 			if (attr[attr_len] != '=')
 				am->match_mode = MATCH_SET;
 			else {
+				const char *v = &attr[attr_len + 1];
 				am->match_mode = MATCH_VALUE;
-				am->value = xstrdup(&attr[attr_len + 1]);
-				if (strchr(am->value, '\\'))
-					die(_("attr spec values must not contain backslashes"));
+				am->value = attr_value_unescape(v);
 			}
 			break;
 		}
@@ -166,7 +202,7 @@ static void eat_long_magic(struct pathspec_item *item, const char *elt,
 	for (copyfrom = elt + 2;
 	     *copyfrom && *copyfrom != ')';
 	     copyfrom = nextat) {
-		size_t len = strcspn(copyfrom, ",)");
+		size_t len = strcspn_escaped(copyfrom, ",)");
 		if (copyfrom[len] == ',')
 			nextat = copyfrom + len + 1;
 		else
diff --git a/t/t6134-pathspec-with-labels.sh b/t/t6134-pathspec-with-labels.sh
index a5c9632..cbea858 100755
--- a/t/t6134-pathspec-with-labels.sh
+++ b/t/t6134-pathspec-with-labels.sh
@@ -163,4 +163,27 @@ test_expect_success 'abort on asking for wrong magic' '
 	test_must_fail git ls-files . ":(attr:!label=foo)"
 '
 
+test_expect_success 'check attribute list' '
+	cat <<-EOF >>.gitattributes &&
+	* whitespace=indent,trail,space
+	EOF
+	cat .gitattributes &&
+	git ls-files ":(attr:whitespace=indent\,trail\,space)" >actual &&
+	git ls-files >expect &&
+	test_cmp expect actual
+'
+test_expect_success 'wrong escaping caught' '
+	# Pass one backslash to git to fail with a missing closing paren
+	test_must_fail git ls-files ":(attr:marked-with-backslash=\\)" 2>actual &&
+	test_i18ngrep Missing actual
+'
+test_expect_success 'check escaped backslash' '
+	cat <<-EOF >>.gitattributes &&
+	/sub/* marked-with-backslash=\\
+	EOF
+	git ls-files ":(attr:marked-with-backslash=\\\\)" >actual &&
+	git ls-files sub/ >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.8.2.126.gaa5c87d.dirty
