From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 4/5] branch.c: replace `git_config()` with `git_config_get_string()
Date: Wed, 30 Jul 2014 18:23:26 +0200
Message-ID: <vpqr412q0ht.fsf@anie.imag.fr>
References: <1406727549-22334-1-git-send-email-tanayabh@gmail.com>
	<1406727549-22334-5-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 18:23:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCWfT-0002Ic-3r
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 18:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755195AbaG3QXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 12:23:51 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56859 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754901AbaG3QXu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 12:23:50 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6UGNPao004418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 30 Jul 2014 18:23:25 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6UGNQiW015220;
	Wed, 30 Jul 2014 18:23:26 +0200
In-Reply-To: <1406727549-22334-5-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Wed, 30 Jul 2014 06:39:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 30 Jul 2014 18:23:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6UGNPao004418
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407342209.03115@IxxO915rE6XGGWxQcYcZrg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254498>

Tanay Abhra <tanayabh@gmail.com> writes:

>  int read_branch_desc(struct strbuf *buf, const char *branch_name)
>  {
> -	struct branch_desc_cb cb;
> +	char *v = NULL;
>  	struct strbuf name = STRBUF_INIT;
>  	strbuf_addf(&name, "branch.%s.description", branch_name);
> -	cb.config_name = name.buf;
> -	cb.value = NULL;
> -	if (git_config(read_branch_desc_cb, &cb) < 0) {
> +	if (git_config_get_string(name.buf, &v)) {
>  		strbuf_release(&name);
>  		return -1;
>  	}
> -	if (cb.value)
> -		strbuf_addstr(buf, cb.value);
> +	strbuf_addstr(buf, v);
> +	free(v);
>  	strbuf_release(&name);
>  	return 0;
>  }

I think this is a behavior change. if (git_config(read_branch_desc_cb,
&cb) < 0) was never true in practice, so the "return -1" was essentially
dead code. You now return -1 when no value is found.

It probably doesn't matter, since all caller except
fmt-merge-msg.c:add_branch_desc() ignore the return value, and if I read
correctly, add_branch_desc does not need the test on the return value,
as the then branch of the if does nothing if no value is found anyway.

But here again, I have to wonder why the function does not just return
void.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
