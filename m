From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 6/6] config: "git config --get-urlmatch" parses section.<url>.key
Date: Wed, 31 Jul 2013 16:47:08 -0700
Message-ID: <7vzjt2s35v.fsf@alter.siamese.dyndns.org>
References: <1375298768-7740-1-git-send-email-gitster@pobox.com>
	<1375298768-7740-7-git-send-email-gitster@pobox.com>
	<20130731224511.GA25882@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Kyle J. McKay" <mackyle@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 01 01:47:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4g76-0002ef-0d
	for gcvg-git-2@plane.gmane.org; Thu, 01 Aug 2013 01:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890Ab3GaXrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 19:47:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58343 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750808Ab3GaXrX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 19:47:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1CDF357D6;
	Wed, 31 Jul 2013 23:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=srNkBJ2kAh3KtghgDJYNPjNLm7U=; b=nlfIEd
	q7GHfEVVWYzvS/SCNUOvQH05Hc+W6IA+YwQKirhDeSw4kqyaPfQ7Pfu2UkiiFyEL
	DIEnFEn5mx1R233Z62yy+Z0j25E+yUB24+WTcWwOu1bydGKaB0morUesJhpbZE+A
	0KvmWqPTkkxUJPt8PdqCzxpE5DV00czs9s7OQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qMShycm0LOdquN0wNUJB6frEaStHAv7G
	NvFgqba6lDFXyEgBSlAWP65AH9CeVjIUo3D9NVSCJfjeu7sYjS1NTp8z5NgRgAxp
	rXJdj2THgJ5cYTmp4tXeZxF1Y7KPlIZ6KD5KdT6bHD3vrO10nrxNWrc8U8nEHtij
	5Xh1FM9Qj1Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4852357D5;
	Wed, 31 Jul 2013 23:47:21 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 331F6357D0;
	Wed, 31 Jul 2013 23:47:20 +0000 (UTC)
In-Reply-To: <20130731224511.GA25882@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 31 Jul 2013 15:45:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8A3E50B8-FA3B-11E2-926E-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231481>

Jeff King <peff@peff.net> writes:

>   1. Git-config expects pre-canonicalized variable names (so http.noepsv
>      instead of "http.noEPSV"). I think the "git config --get" code path
>      does this for the caller, so we should probably do the same for
>      "--get-urlmatch". And it is even easier here, because we know that
>      "http.noEPSV" does not contain a case-sensitive middle part. :)

I'll squash these in later, but here is from my working copy.
Thanks for spotting.

 builtin/config.c       | 32 +++++++++++++++++++-------------
 t/t1300-repo-config.sh |  4 ++--
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index c35c5be..c046f54 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -379,9 +379,22 @@ static int urlmatch_collect_fn(const char *var, const char *value, void *cb)
 	return 0;
 }
 
+static char *dup_downcase(const char *string)
+{
+	char *result;
+	size_t len, i;
+
+	len = strlen(string);
+	result = xmalloc(len + 1);
+	for (i = 0; i < len; i++)
+		result[i] = tolower(string[i]);
+	result[i] = '\0';
+	return result;
+}
+
 static int get_urlmatch(const char *var, const char *url)
 {
-	const char *section_tail;
+	char *section_tail;
 	struct string_list_item *item;
 	struct urlmatch_config config = { STRING_LIST_INIT_DUP };
 	struct string_list values = STRING_LIST_INIT_DUP;
@@ -393,13 +406,13 @@ static int get_urlmatch(const char *var, const char *url)
 	if (!url_normalize(url, &config.url))
 		die(config.url.err);
 
-	section_tail = strchr(var, '.');
+	config.section = dup_downcase(var);
+	section_tail = strchr(config.section, '.');
 	if (section_tail) {
-		config.section = xmemdupz(var, section_tail - var);
-		config.key = strrchr(var, '.') + 1;
+		*section_tail = '\0';
+		config.key = section_tail + 1;
 		show_keys = 0;
 	} else {
-		config.section = var;
 		config.key = NULL;
 		show_keys = 1;
 	}
@@ -425,14 +438,7 @@ static int get_urlmatch(const char *var, const char *url)
 	string_list_clear(&values, 1);
 	free(config.url.url);
 
-	/*
-	 * section name may have been copied to replace the dot, in which
-	 * case it needs to be freed.  key name is either NULL (e.g. 'http'
-	 * alone) or points into var (e.g. 'http.savecookies'), and we do
-	 * not own the storage.
-	 */
-	if (config.section != var)
-		free((void *)config.section);
+	free((void *)config.section);
 	return 0;
 }
 
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 323e880..c23f478 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1097,7 +1097,7 @@ test_expect_success 'urlmatch' '
 	EOF
 
 	echo true >expect &&
-	git config --bool --get-urlmatch http.sslverify https://good.example.com >actual &&
+	git config --bool --get-urlmatch http.SSLverify https://good.example.com >actual &&
 	test_cmp expect actual &&
 
 	echo false >expect &&
@@ -1108,7 +1108,7 @@ test_expect_success 'urlmatch' '
 		echo http.cookiefile /tmp/cookie.txt &&
 		echo http.sslverify false
 	} >expect &&
-	git config --get-urlmatch http https://weak.example.com >actual &&
+	git config --get-urlmatch HTTP https://weak.example.com >actual &&
 	test_cmp expect actual
 '
 
