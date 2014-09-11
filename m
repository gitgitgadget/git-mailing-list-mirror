From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] make config --add behave correctly for empty and NULL values
Date: Thu, 11 Sep 2014 16:35:33 -0700
Message-ID: <xmqqy4tpbuii.fsf@gitster.dls.corp.google.com>
References: <1408357077-4745-1-git-send-email-tanayabh@gmail.com>
	<xmqqvbppwtir.fsf@gitster.dls.corp.google.com>
	<20140819051732.GA13765@peff.net>
	<xmqqmwb1vwvs.fsf@gitster.dls.corp.google.com>
	<20140819062000.GA7805@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 12 01:35:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSDu1-00037R-J9
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 01:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbaIKXfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 19:35:37 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56210 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751109AbaIKXfh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 19:35:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0B5433AF03;
	Thu, 11 Sep 2014 19:35:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RhizEtbU1Oz1zXcDkUFft8a+U5g=; b=wReNAY
	EcX5hqAoHu4qCHR6/PujOpjZGVHGlmtnvCSLy03DgiwNEWiaUAusYmqGS5BCxRfm
	0G9Ho2X4+iZYeeV2+avdFNJA+QM1+EbdKWZEdK/tSyqCPbBDSuJQS7iu16FPRU7u
	7mlxAEzaeJqcOWim4cB4/XI3iMhUGG2QN+TCg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qmO5I1s0tdcsjnwZHFe2fRaXlkUH5jaU
	9IF4gFvvpSuGU0Ku7sOIzCyb9Oh6MsToAlCxSKfTkCpvgY71Q1BA3GNtFzhyGoes
	HO2vea5TQvZreOSn9uOxiIUJXZ54PAq9QK0/bioUPWkvuHbrzwBnXNIA3LYy7ADn
	sg0Zg6fs/0w=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B5FB03AF01;
	Thu, 11 Sep 2014 19:35:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E4A5C3AEFE;
	Thu, 11 Sep 2014 19:35:34 -0400 (EDT)
In-Reply-To: <20140819062000.GA7805@peff.net> (Jeff King's message of "Tue, 19
	Aug 2014 02:20:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 53E4EA2E-3A0C-11E4-AB02-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256889>

Jeff King <peff@peff.net> writes:

> Here is the patch I wrote, for reference (I also think breaking the
> "matches" function into a series of conditionals, as you showed, is way
> more readable):

OK, while reviewing the today's issue of "What's cooking" and making
topics graduate to 'master', I got annoyed that the bottom of jch
branch still needed to be kept.  Let's do this.

-- >8 --
From: Jeff King <peff@peff.net>
Date: Tue, 19 Aug 2014 02:20:00 -0400
Subject: [PATCH] config: avoid a funny sentinel value "a^"

Introduce CONFIG_REGEX_NONE as a more explicit sentinel value to say
"we do not want to replace any existing entry" and use it in the
implementation of "git config --add".

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/config.c |  3 ++-
 cache.h          |  2 ++
 config.c         | 23 +++++++++++++++++------
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 8224699..bf1aa6b 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -599,7 +599,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		check_argc(argc, 2, 2);
 		value = normalize_value(argv[0], argv[1]);
 		return git_config_set_multivar_in_file(given_config_source.file,
-						       argv[0], value, "a^", 0);
+						       argv[0], value,
+						       CONFIG_REGEX_NONE, 0);
 	}
 	else if (actions == ACTION_REPLACE_ALL) {
 		check_write();
diff --git a/cache.h b/cache.h
index c708062..8356168 100644
--- a/cache.h
+++ b/cache.h
@@ -1233,6 +1233,8 @@ extern int update_server_info(int);
 #define CONFIG_INVALID_PATTERN 6
 #define CONFIG_GENERIC_ERROR 7
 
+#define CONFIG_REGEX_NONE ((void *)1)
+
 struct git_config_source {
 	unsigned int use_stdin:1;
 	const char *file;
diff --git a/config.c b/config.c
index ffe0104..2e709bf 100644
--- a/config.c
+++ b/config.c
@@ -1230,10 +1230,15 @@ static struct {
 
 static int matches(const char *key, const char *value)
 {
-	return !strcmp(key, store.key) &&
-		(store.value_regex == NULL ||
-		 (store.do_not_match ^
-		  (value && !regexec(store.value_regex, value, 0, NULL, 0))));
+	if (strcmp(key, store.key))
+		return 0; /* not ours */
+	if (!store.value_regex)
+		return 1; /* always matches */
+	if (store.value_regex == CONFIG_REGEX_NONE)
+		return 0; /* never matches */
+
+	return store.do_not_match ^
+		(value && !regexec(store.value_regex, value, 0, NULL, 0));
 }
 
 static int store_aux(const char *key, const char *value, void *cb)
@@ -1495,6 +1500,8 @@ out_free_ret_1:
 /*
  * If value==NULL, unset in (remove from) config,
  * if value_regex!=NULL, disregard key/value pairs where value does not match.
+ * if value_regex==CONFIG_REGEX_NONE, do not match any existing values
+ *     (only add a new one)
  * if multi_replace==0, nothing, or only one matching key/value is replaced,
  *     else all matching key/values (regardless how many) are removed,
  *     before the new pair is written.
@@ -1578,6 +1585,8 @@ int git_config_set_multivar_in_file(const char *config_filename,
 
 		if (value_regex == NULL)
 			store.value_regex = NULL;
+		else if (value_regex == CONFIG_REGEX_NONE)
+			store.value_regex = CONFIG_REGEX_NONE;
 		else {
 			if (value_regex[0] == '!') {
 				store.do_not_match = 1;
@@ -1609,7 +1618,8 @@ int git_config_set_multivar_in_file(const char *config_filename,
 		if (git_config_from_file(store_aux, config_filename, NULL)) {
 			error("invalid config file %s", config_filename);
 			free(store.key);
-			if (store.value_regex != NULL) {
+			if (store.value_regex != NULL &&
+			    store.value_regex != CONFIG_REGEX_NONE) {
 				regfree(store.value_regex);
 				free(store.value_regex);
 			}
@@ -1618,7 +1628,8 @@ int git_config_set_multivar_in_file(const char *config_filename,
 		}
 
 		free(store.key);
-		if (store.value_regex != NULL) {
+		if (store.value_regex != NULL &&
+		    store.value_regex != CONFIG_REGEX_NONE) {
 			regfree(store.value_regex);
 			free(store.value_regex);
 		}
-- 
2.1.0-466-g6597b3e
