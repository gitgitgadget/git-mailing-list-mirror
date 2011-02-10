From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Sanity-check config variable names
Date: Thu, 10 Feb 2011 14:49:05 -0800
Message-ID: <7v7hd733q6.fsf@alter.siamese.dyndns.org>
References: <20110111055922.GD10094@sigill.intra.peff.net>
 <20110119100105.GB8034@fm.suse.cz> <20110119141112.GD8034@fm.suse.cz>
 <20110120232232.GA9442@sigill.intra.peff.net>
 <20110121100212.GE19715@fm.suse.cz> <20110121102339.GG19715@fm.suse.cz>
 <20110121162318.GC21840@sigill.intra.peff.net>
 <20110127142815.GC6312@fm.suse.cz> <7voc72ge4j.fsf@alter.siamese.dyndns.org>
 <20110128145323.GE1849@fm.suse.cz> <20110130194041.GA25033@fm.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Libor Pechacek <lpechacek@suse.cz>
X-From: git-owner@vger.kernel.org Thu Feb 10 23:49:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnfKC-0000HU-MZ
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 23:49:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757230Ab1BJWtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 17:49:15 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61759 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756890Ab1BJWtO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 17:49:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 79FB331C4;
	Thu, 10 Feb 2011 17:50:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=INtv22HjZ1XBs+xTxFUnwp5y3xc=; b=NBhFS9yWhxzXM0kc7hAFOSC
	z/yGM2/QfFBKS5EwRrYMjCFzUESHY89R3w94ekTbZUmfO54CgDg1u/vPEFby0aSt
	kvzg+WivgJuMI8QnlwMnTUo0HfundACbWynwK1TFfyG4t1NjH1aMlDmjvkA3Kgxg
	9kg6OWiEHeCswwtUsu5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=WEUN2OnlBDjRTwbBR/FvWr8NVWBF04mL8Z//5QCg+O2WLmqWf
	3u/3XLWiGf6ueEs5JoJYybExRBO96glqRgpxY5fA4QtZnCj0M+SpvBYksnd7O5Na
	cVt2R6i2hmw3016nZikFkeu7lZNBd7FX/WyirPcsq4madPMfJLVXQqRSJ4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4892231C2;
	Thu, 10 Feb 2011 17:50:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E479531C1; Thu, 10 Feb 2011
 17:50:06 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1DB82206-3568-11E0-ABE5-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166509>

Libor Pechacek <lpechacek@suse.cz> writes:

> diff --git a/builtin/config.c b/builtin/config.c
> index ca4a0db..dd17029 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -168,17 +167,30 @@ static int get_value(const char *key_, const char *regex_)
> ...
>  		key_regexp = (regex_t*)xmalloc(sizeof(regex_t));
>  		if (regcomp(key_regexp, key, REG_EXTENDED)) {
>  			fprintf(stderr, "Invalid key pattern: %s\n", key_);
>  			goto free_strings;

This is not a new issue introduced by this series, but isn't this goto
leaking "key" by jumping over free(key) later in the function but before
its target?

>  		}
> +	} else {
> +		if (git_config_parse_key(key_, &key, NULL))
> +			goto free_strings;

This seemingly has the same issue but is worse than that.  You allocate
and overwrite "key" in git_config_parse_key(), so by calling the function
after allocating key in the caller, you immediately leak it.  The new copy
allocated inside the callee is freed at its end upon error return, so
jumping over free(key) in the caller does not leak, though.

> @@ -1124,59 +1187,22 @@ int git_config_set(const char *key, const char *value)
> ...
> +	ret = -git_config_parse_key(key, &store.key, &store.baselen);
> +	if (ret)
>  		goto out_free;

This '-' is very easy to miss; I'd rather see it spelled out with an
explanation.

But looking at the bigger picture, don't you think that an internal
function like git_config_set() should return negative on error, and
we should make it the caller's responsibility to turn it to a value
suitable for feeding exit(3)?  It obviously is a separate topic.


Here is a minimum fix-up on top of your patch.
Thanks.

diff --git a/builtin/config.c b/builtin/config.c
index dd17029..6754da8 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -166,8 +166,6 @@ static int get_value(const char *key_, const char *regex_)
 			system_wide = git_etc_gitconfig();
 	}
 
-	key = xstrdup(key_);
-
 	if (use_key_regexp) {
 		char *tl;
 
@@ -176,6 +174,8 @@ static int get_value(const char *key_, const char *regex_)
 		 * work for more complex patterns like "^[^.]*Foo.*bar".
 		 * Perhaps we should deprecate this altogether someday.
 		 */
+
+		key = xstrdup(key_);
 		for (tl = key + strlen(key) - 1;
 		     tl >= key && *tl != '.';
 		     tl--)
@@ -186,6 +186,7 @@ static int get_value(const char *key_, const char *regex_)
 		key_regexp = (regex_t*)xmalloc(sizeof(regex_t));
 		if (regcomp(key_regexp, key, REG_EXTENDED)) {
 			fprintf(stderr, "Invalid key pattern: %s\n", key_);
+			free(key);
 			goto free_strings;
 		}
 	} else {
diff --git a/config.c b/config.c
index fde91f5..f758734 100644
--- a/config.c
+++ b/config.c
@@ -1141,7 +1141,8 @@ int git_config_parse_key(const char *key, char **store_key, int *baselen_)
 			dot = 1;
 		/* Leave the extended basename untouched.. */
 		if (!dot || i > baselen) {
-			if (!iskeychar(c) || (i == baselen+1 && !isalpha(c))) {
+			if (!iskeychar(c) ||
+			    (i == baselen + 1 && !isalpha(c))) {
 				error("invalid key: %s", key);
 				goto out_free_ret_1;
 			}
@@ -1197,7 +1198,8 @@ int git_config_set_multivar(const char *key, const char *value,
 	else
 		config_filename = git_pathdup("config");
 
-	ret = -git_config_parse_key(key, &store.key, &store.baselen);
+	/* parse-key returns negative; flip the sign to feed exit(3) */
+	ret = 0 - git_config_parse_key(key, &store.key, &store.baselen);
 	if (ret)
 		goto out_free;
 
