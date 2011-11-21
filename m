From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] config.c: Fix a static buffer overwrite bug by
 avoiding mkpath()
Date: Sun, 20 Nov 2011 19:32:02 -0800
Message-ID: <7v4nxyi219.fsf@alter.siamese.dyndns.org>
References: <4EC80688.609@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Nov 21 04:32:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSKcA-0007wi-Np
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 04:32:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253Ab1KUDcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Nov 2011 22:32:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43491 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751764Ab1KUDcF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2011 22:32:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8258360F2;
	Sun, 20 Nov 2011 22:32:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DV4snDZB0jp22M/6lanmoHgaHnc=; b=lBl1A5
	t2B3FewfahScG3CB8TdDzNJbv/1BolQJtVUfieVdKgSXmvbHEWzcgh3xx5xj8xhR
	n84DnbF8JQotp1HHTfNfj2tnA1DqKoAc3Sa3jBgMNVK+QhXijsDFdnsf0wRAq1FH
	1PVf5TxngSaVLScduP6uQMnGTzwsZjAw7MKWY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X0gdPU9a79rZ7cun5ppMbzGdetla/Tid
	5If5wMlO4g0pdiqFQPSzI6suoezk9iJZKaVVnUnYegN5aX2WNmK8mn8D0+Zi/nSb
	4aSCsQ0qs6VxFq72xgjPDdUjTMWpKV2/WXpYdefGyD6t0gwdKGKYnx6LAKVm70Jl
	8Qa1rJpocfM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A89460F1;
	Sun, 20 Nov 2011 22:32:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EBD0860EE; Sun, 20 Nov 2011
 22:32:03 -0500 (EST)
In-Reply-To: <4EC80688.609@ramsay1.demon.co.uk> (Ramsay Jones's message of
 "Sat, 19 Nov 2011 19:42:00 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 61633A50-13F1-11E1-802C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185730>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> In order to fix the problem, we replace the call to mkpath() with
> a call to mksnpath() and provide our own buffer.

A longer term fix might be to get rid of unwanted git_config_* call from
stat() callchain, but as a short-term fix, this patch with minor tweaks
should do.

> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>  config.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/config.c b/config.c
> index edf9914..5a9ca84 100644
> --- a/config.c
> +++ b/config.c
> @@ -851,6 +851,7 @@ int git_config_system(void)
>  
>  int git_config_early(config_fn_t fn, void *data, const char *repo_config)
>  {
> +	char buf[4096];
>  	int ret = 0, found = 0;
>  	const char *home = NULL;

Two points. (1) This buffer does not need to be inside the whole function
scope, no? (2) s/4096/PATH_MAX/ to match what get_pathname() has been
returning to the caller?

That is, something like the attached squashed in?

> @@ -865,12 +866,11 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
>  
>  	home = getenv("HOME");
>  	if (home) {
> -		char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
> +		char *user_config = mksnpath(buf, sizeof(buf), "%s/.gitconfig", home);
>  		if (!access(user_config, R_OK)) {
>  			ret += git_config_from_file(fn, user_config, data);
>  			found += 1;
>  		}
> -		free(user_config);
>  	}
>  
>  	if (repo_config && !access(repo_config, R_OK)) {

 config.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/config.c b/config.c
index 5a9ca84..b6d789a 100644
--- a/config.c
+++ b/config.c
@@ -851,7 +851,6 @@ int git_config_system(void)
 
 int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 {
-	char buf[4096];
 	int ret = 0, found = 0;
 	const char *home = NULL;
 
@@ -866,6 +865,7 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 
 	home = getenv("HOME");
 	if (home) {
+		char buf[PATH_MAX];
 		char *user_config = mksnpath(buf, sizeof(buf), "%s/.gitconfig", home);
 		if (!access(user_config, R_OK)) {
 			ret += git_config_from_file(fn, user_config, data);
