From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Disallow empty section and variable names
Date: Thu, 10 Feb 2011 14:49:12 -0800
Message-ID: <7v1v3f33pz.fsf@alter.siamese.dyndns.org>
References: <20110108144644.GA11019@localhost.suse.cz>
 <20110127145253.GD6312@fm.suse.cz> <20110130203445.GA9689@fm.suse.cz>
 <4D46694F.5070208@viscovery.net> <20110131091728.GB24297@fm.suse.cz>
 <4D468109.8020409@viscovery.net> <20110131130855.GC24297@fm.suse.cz>
 <4D46E7E7.4010805@web.de> <20110201071347.GH24297@fm.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Libor Pechacek <lpechacek@suse.cz>
X-From: git-owner@vger.kernel.org Thu Feb 10 23:49:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnfKM-0000Pd-TL
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 23:49:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757158Ab1BJWtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 17:49:24 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61895 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756890Ab1BJWtY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 17:49:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6F49D31C6;
	Thu, 10 Feb 2011 17:50:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=cFPpHlkO1PYQ536dvMqJV50M+Vw=; b=nteJBxwS4378onTLjh5Y93v
	gMIW1IqKCUBgF9aRDDm4N2TLabSvX/vYj8TzEX3AgTo376yuXpeJdp6jbgqaiXJB
	n1uP/6DeUGyG+iUmQCahzrY7BoXCL2Ze4Y6T1eBz1RkadR2PVhthDTJKf19ApZi9
	zg06Kb8vTHBCmxxhWAnw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=WjrHMC+il/BO1dAx2BfFxIxX9UBDykCzpt1d+CG1+QWztUC3w
	4vNd+/2JgAlU2ufHWEbUUiuK7h83b5uYt+y0x20bqONAVsGOTMK+Ew0FQjsISwjy
	coKm7xBTjWd3HqVXfHGy5Uh13cTTGYbzThmwodwusJuUit8J2trq/+VYww=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2B77431C5;
	Thu, 10 Feb 2011 17:50:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B7F0131C3; Thu, 10 Feb 2011
 17:50:13 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 226AAEE0-3568-11E0-A1B9-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166510>

Libor Pechacek <lpechacek@suse.cz> writes:

> diff --git a/config.c b/config.c
> index fde91f5..5eb89a7 100644
> --- a/config.c
> +++ b/config.c
> @@ -1113,6 +1113,7 @@ int git_config_set(const char *key, const char *value)
>  int git_config_parse_key(const char *key, char **store_key, int *baselen_)
>  {
>  	int i, dot, baselen;
> +	int keylen = strlen(key);
>  	const char *last_dot = strrchr(key, '.');
>  
>  	/*
> @@ -1120,11 +1121,16 @@ int git_config_parse_key(const char *key, char **store_key, int *baselen_)
>  	 * key name separated by a dot, we have to know where the dot is.
>  	 */
>  
> -	if (last_dot == NULL) {
> +	if (last_dot == NULL || *key == '.') {
>  		error("key does not contain a section: %s", key);
>  		return -2;
>  	}
>  
> +	if (keylen && key[keylen-1] == '.') {

Aren't these the same as saying

	if (!last_dot || last_dot == key) {
		...
        }
	if (!last_dot[1]) { /* we know last_dot is not NULL */
        	...
	}

Again, a minimum fix-up on top of your patch.
Thanks.


diff --git a/config.c b/config.c
index 75dd629..d5bb862 100644
--- a/config.c
+++ b/config.c
@@ -1113,7 +1113,6 @@ int git_config_set(const char *key, const char *value)
 int git_config_parse_key(const char *key, char **store_key, int *baselen_)
 {
 	int i, dot, baselen;
-	int keylen = strlen(key);
 	const char *last_dot = strrchr(key, '.');
 
 	/*
@@ -1121,12 +1120,12 @@ int git_config_parse_key(const char *key, char **store_key, int *baselen_)
 	 * key name separated by a dot, we have to know where the dot is.
 	 */
 
-	if (last_dot == NULL || *key == '.') {
+	if (last_dot == NULL || last_dot == key) {
 		error("key does not contain a section: %s", key);
 		return -2;
 	}
 
-	if (keylen && key[keylen-1] == '.') {
+	if (!last_dot[1]) {
 		error("key does not contain variable name: %s", key);
 		return -2;
 	}
@@ -1138,7 +1137,7 @@ int git_config_parse_key(const char *key, char **store_key, int *baselen_)
 	/*
 	 * Validate the key and while at it, lower case it for matching.
 	 */
-	*store_key = xmalloc(keylen + 1);
+	*store_key = xmalloc(strlen(key) + 1);
 
 	dot = 0;
 	for (i = 0; key[i]; i++) {
