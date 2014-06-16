From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC] branch.c: Replace `git_config` with `git_config_get_string`
Date: Mon, 16 Jun 2014 19:29:19 +0200
Message-ID: <vpqfvj4226o.fsf@anie.imag.fr>
References: <1402908750-24851-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 19:29:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwaik-0003pd-HM
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 19:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755571AbaFPR3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 13:29:22 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46575 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755351AbaFPR3V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 13:29:21 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s5GHTHoM012976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 16 Jun 2014 19:29:17 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s5GHTJrB026605;
	Mon, 16 Jun 2014 19:29:19 +0200
In-Reply-To: <1402908750-24851-1-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Mon, 16 Jun 2014 01:52:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 16 Jun 2014 19:29:17 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251737>

> Subject: Re: [PATCH/RFC] branch.c: Replace `git_config` with `git_config_get_string`

Here and elsewhere: usually, no capital after :.

Tanay Abhra <tanayabh@gmail.com> writes:

> Original implementation uses a callback based approach which has some
> deficiencies like a convoluted control flow and redundant variables.

"deficiencies" might be a bit strong (the code did work).

> There are total 111 calls in total in all of git codebase. How should I send
> the patches, alphabetically or otherwise?

My advice would be: try as much as possible to split according to the
complexity of the patch.

As a reviewer, I find it rather easy to review a large number of trivial
and similar changes, but I hate having to switch back to "wow, the
author did something tricky, let's try to understand this" in the middle
of a trivial series.

(we had this discussion about `...` Vs $(...) and test -a Vs test ... &&
series, which were essentially very trivial changes, but with subtle
bugs introduced and hidden by the volume of trivial changes).

>  branch.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)

Removing more lines than it adds. I like the patch already ;-).

> diff --git a/branch.c b/branch.c
> index 660097b..257b1bf 100644
> --- a/branch.c
> +++ b/branch.c
[...]
>  int read_branch_desc(struct strbuf *buf, const char *branch_name)
>  {
> -	struct branch_desc_cb cb;
> +	const char *value;
> +	struct branch_desc desc;
>  	struct strbuf name = STRBUF_INIT;
>  	strbuf_addf(&name, "branch.%s.description", branch_name);
> -	cb.config_name = name.buf;
> -	cb.value = NULL;
> -	if (git_config(read_branch_desc_cb, &cb) < 0) {
> +	desc.config_name = name.buf;
> +	desc.value = NULL;
> +	value = git_config_get_string(desc.config_name);
> +	git_config_string(&desc.value, desc.config_name, value);

You're ignoring the return value of git_config_string, which is an error
code. It shouldn't harm, because the code is non-zero iff desc.value is
set to non-NULL, but you may want to write the code as

if (git_config_string(...)) {
	strbuf_release(...);
	return -1;
}

In any case, the patch sounds good to me.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
