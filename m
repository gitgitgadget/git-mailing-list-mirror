From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] attr.c: respect core.ignorecase when matching
 attribute patterns
Date: Wed, 14 Sep 2011 21:06:28 -0700
Message-ID: <7vobymqwjf.fsf@alter.siamese.dyndns.org>
References: <5XXEFw0WjtXKd9dpXSxpkskCcgVyG9Db1_zzVSEBNey-kpXSBbmQfYaxZ2Szg6Pbck6hZZTQ5hHzBwG4rhKYXshrdmveEFLPZ9W0V8P_lw@cipher.nrlssc.navy.mil> <1316051979-19671-1-git-send-email-drafnel@gmail.com> <1316051979-19671-5-git-send-email-drafnel@gmail.com> <7vsjnyqws3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: peff@peff.net, git@vger.kernel.org, sunshine@sunshineco.com,
	bharrosh@panasas.com, trast@student.ethz.ch, zapped@mail.ru
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 06:06:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R43Dh-00037l-II
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 06:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836Ab1IOEGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 00:06:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38072 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750749Ab1IOEGb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 00:06:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B89265982;
	Thu, 15 Sep 2011 00:06:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eAcOlDaUhW81AoAoOGMdgaB9UpI=; b=yb2vMi
	d/+IC/8Ln19LNtiieiNcjZrpAYJ24TgQoJ7EHpWBevJ6msuEGsktD6e/+JN1Irgk
	nbxkLgj4PEbrU6wyqrI43quY4jIDp+s1mz8L/5U9ffaCE4Zvbl2wG0fWqwSl0Tba
	6S7XSWhTRdvsPDq+N6I//yi2seimk7Z+kB81c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SoN+crB9Uf/Xc+7twsU+4VK2aADQjntQ
	emAOWoE+NOUc82+YlnYRuyO3mTqmy666EKerK46ppPzK6tfUTi1U9MyQbsvDrx0D
	jkxwTqMUtrD0lUhp0ZEN0QM4CSWvbcAm4fDQ65Q20ZFZOhz+L8kfDv7mf/Q2wP/m
	sQmImlHIM1I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF8AB5981;
	Thu, 15 Sep 2011 00:06:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 156C05980; Thu, 15 Sep 2011
 00:06:30 -0400 (EDT)
In-Reply-To: <7vsjnyqws3.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 14 Sep 2011 21:01:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 173AD184-DF50-11E0-B05C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181433>

Junio C Hamano <gitster@pobox.com> writes:

> Brandon Casey <drafnel@gmail.com> writes:
>
>> It's easy to work around this issue.  I could just parse core.ignorecase
>> in git_attr_config() and set ignore_case myself like:
>>
>>    if (!strcmp(var, "core.ignorecase")) {
>>            ignore_case = git_config_bool(var, value);
>>            return 0;
>>    }
>
> I think it is immensely preferrable to do this than cascading to
> default_config like this patch does and then piling band-aid on top to fix
> the breakage caused by calling default_config.
>
> An alternative approach may be to move reading of core.attributesfile to
> default_config, and drop git_config() call from bootstrap_attr_stack(),
> getting rid of git_attr_config callback altogether.

That is, something like this on top of your patch.



 attr.c               |   15 ++-------------
 builtin/check-attr.c |    2 ++
 cache.h              |    1 +
 config.c             |    3 +++
 environment.c        |    1 +
 5 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/attr.c b/attr.c
index 79fb11e..76b079f 100644
--- a/attr.c
+++ b/attr.c
@@ -21,8 +21,6 @@ static const char git_attr__unknown[] = "(builtin)unknown";
 #define ATTR__UNSET NULL
 #define ATTR__UNKNOWN git_attr__unknown
 
-static const char *attributes_file;
-
 /* This is a randomly chosen prime. */
 #define HASHSIZE 257
 
@@ -495,14 +493,6 @@ static int git_attr_system(void)
 	return !git_env_bool("GIT_ATTR_NOSYSTEM", 0);
 }
 
-static int git_attr_config(const char *var, const char *value, void *dummy)
-{
-	if (!strcmp(var, "core.attributesfile"))
-		return git_config_pathname(&attributes_file, var, value);
-
-	return git_default_config(var, value, dummy);
-}
-
 static void bootstrap_attr_stack(void)
 {
 	if (!attr_stack) {
@@ -522,9 +512,8 @@ static void bootstrap_attr_stack(void)
 			}
 		}
 
-		git_config(git_attr_config, NULL);
-		if (attributes_file) {
-			elem = read_attr_from_file(attributes_file, 1);
+		if (git_attributes_file) {
+			elem = read_attr_from_file(git_attributes_file, 1);
 			if (elem) {
 				elem->origin = NULL;
 				elem->prev = attr_stack;
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 708988a..abb1165 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -92,6 +92,8 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 	struct git_attr_check *check;
 	int cnt, i, doubledash, filei;
 
+	git_config(git_default_config, NULL);
+
 	argc = parse_options(argc, argv, prefix, check_attr_options,
 			     check_attr_usage, PARSE_OPT_KEEP_DASHDASH);
 
diff --git a/cache.h b/cache.h
index 607c2ea..8d95fb2 100644
--- a/cache.h
+++ b/cache.h
@@ -589,6 +589,7 @@ extern int warn_ambiguous_refs;
 extern int shared_repository;
 extern const char *apply_default_whitespace;
 extern const char *apply_default_ignorewhitespace;
+extern const char *git_attributes_file;
 extern int zlib_compression_level;
 extern int core_compression_level;
 extern int core_compression_seen;
diff --git a/config.c b/config.c
index 4183f80..d3bcaa0 100644
--- a/config.c
+++ b/config.c
@@ -491,6 +491,9 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.attributesfile"))
+		return git_config_pathname(&git_attributes_file, var, value);
+
 	if (!strcmp(var, "core.bare")) {
 		is_bare_repository_cfg = git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index e96edcf..d60b73f 100644
--- a/environment.c
+++ b/environment.c
@@ -29,6 +29,7 @@ const char *git_log_output_encoding;
 int shared_repository = PERM_UMASK;
 const char *apply_default_whitespace;
 const char *apply_default_ignorewhitespace;
+const char *git_attributes_file;
 int zlib_compression_level = Z_BEST_SPEED;
 int core_compression_level;
 int core_compression_seen;
