From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 11/11] branch.c: replace `git_config()` with `git_config_get_string()
Date: Thu, 07 Aug 2014 19:04:38 +0200
Message-ID: <vpqvbq4cjtl.fsf@anie.imag.fr>
References: <1407428486-19049-1-git-send-email-tanayabh@gmail.com>
	<1407428486-19049-12-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 07 19:04:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFR7R-0000S0-SJ
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 19:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbaHGREq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 13:04:46 -0400
Received: from mx1.imag.fr ([129.88.30.5]:48863 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932538AbaHGREp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 13:04:45 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s77H4acw021612
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 7 Aug 2014 19:04:36 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s77H4c10003973;
	Thu, 7 Aug 2014 19:04:38 +0200
In-Reply-To: <1407428486-19049-12-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Thu, 7 Aug 2014 09:21:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 07 Aug 2014 19:04:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s77H4acw021612
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1408035876.91124@atts2kG54B25CIheBmQEvA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254979>

Tanay Abhra <tanayabh@gmail.com> writes:

> Use `git_config_get_string()` instead of `git_config()` to take advantage of
> the config-set API which provides a cleaner control flow.
>
> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> ---
>  branch.c | 27 +++++++--------------------
>  1 file changed, 7 insertions(+), 20 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index 735767d..df6b120 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -140,30 +140,17 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
>  	return 0;
>  }
>  
> -struct branch_desc_cb {
> -	const char *config_name;
> -	const char *value;
> -};
> -
> -static int read_branch_desc_cb(const char *var, const char *value, void *cb)
> -{
> -	struct branch_desc_cb *desc = cb;
> -	if (strcmp(desc->config_name, var))
> -		return 0;
> -	free((char *)desc->value);
> -	return git_config_string(&desc->value, var, value);
> -}
> -
>  int read_branch_desc(struct strbuf *buf, const char *branch_name)
>  {
> -	struct branch_desc_cb cb;
> +	char *v = NULL;
>  	struct strbuf name = STRBUF_INIT;
>  	strbuf_addf(&name, "branch.%s.description", branch_name);
> -	cb.config_name = name.buf;
> -	cb.value = NULL;
> -	git_config(read_branch_desc_cb, &cb);
> -	if (cb.value)
> -		strbuf_addstr(buf, cb.value);
> +	if (git_config_get_string(name.buf, &v)) {
> +		strbuf_release(&name);
> +		return -1;
> +	}
> +	strbuf_addstr(buf, v);
> +	free(v);

There's a behavior change here, but I think it is the right thing to do.

It lacks a proper commit message though:

As a reminder, your patch "change `git_config()` return value to void"
in the other series did:

--- a/branch.c
+++ b/branch.c
@@ -161,10 +161,7 @@ int read_branch_desc(struct strbuf *buf, const char *branch_name)
         strbuf_addf(&name, "branch.%s.description", branch_name);
         cb.config_name = name.buf;
         cb.value = NULL;
-        if (git_config(read_branch_desc_cb, &cb) < 0) {
-                strbuf_release(&name);
-                return -1;
-        }
+        git_config(read_branch_desc_cb, &cb);
         if (cb.value)
                 strbuf_addstr(buf, cb.value);
         strbuf_release(&name);

So, before it, read_branch_desc() was returning -1 iff git_config()
failed, which essentially never happened.

Now, you're retoring a similar "if", but you strbuf_release and return
-1 if no value is found for the variable.

There are 3 callers of read_branch_desc:

builtin/branch.c:       read_branch_desc(&buf, branch_name);
builtin/fmt-merge-msg.c:        if (!read_branch_desc(&desc, name)) {
builtin/log.c:  read_branch_desc(&desc, branch_name);

Only the one in fmt-merge-msg.c uses the return value:

static void add_branch_desc(struct strbuf *out, const char *name)
{
	struct strbuf desc = STRBUF_INIT;

	if (!read_branch_desc(&desc, name)) {
		const char *bp = desc.buf;
		while (*bp) { /* (1) */
			const char *ep = strchrnul(bp, '\n');
			if (*ep)
				ep++;
			strbuf_addf(out, "  : %.*s", (int)(ep - bp), bp);
			bp = ep;
		}
		if (out->buf[out->len - 1] != '\n') /* (2) */
			strbuf_addch(out, '\n');
	}
	strbuf_release(&desc);
}

the (1) part is a no-op if no value is found, but the old code was still
adding a \n in the (2) part, even when no value was found.

So, the new code is better than the old one, but your patch does a bit
more than the commit message claims.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
