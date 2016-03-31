From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] submodule--helper clone: remove double path checking
Date: Thu, 31 Mar 2016 09:44:25 -0700
Message-ID: <xmqqh9fmppg6.fsf@gitster.mtv.corp.google.com>
References: <1459383457-6848-1-git-send-email-sbeller@google.com>
	<1459383457-6848-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, norio.nomura@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 18:44:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alfi5-0008QX-2q
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 18:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbcCaQoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 12:44:30 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:62643 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932223AbcCaQo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 12:44:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 45E1851069;
	Thu, 31 Mar 2016 12:44:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pZQIKATbofgr6I3b0BFUKHQUauY=; b=rddWRH
	5vy14QjfIOklNYOeIZ8V33ZWfTmB3niV6TB4HAOWLRBedvXpQOhvYnS46KvvOTwJ
	d+B7FShHiDEgRTwY7+1Y4gZpBw3a4vqTKZ6S84IwCf7CKJzHgdInkBc6CDfJd35j
	xlO3+t443YpdewG3JFN9ShTtjVP6JQ2CcXwLs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jYtnTSxCK7BnBDFuhnVbbDQX66BlvNmz
	BtBKQgxBBOa3sLpFtc6QBswkU77RXF/D0gT4nn9jsrEWroXV6k0DjxqR/AwCu863
	ZTJpdcs73a4DI49BvP+IIhapAsiKsK/lK4dsqkSntOgArjqLcQmtN+f9SqsATtKT
	4lKSdgjr+Cg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3C4BC51064;
	Thu, 31 Mar 2016 12:44:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9E18251063;
	Thu, 31 Mar 2016 12:44:26 -0400 (EDT)
In-Reply-To: <1459383457-6848-4-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Wed, 30 Mar 2016 17:17:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D4AB0D70-F75F-11E5-B5EC-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290416>

Stefan Beller <sbeller@google.com> writes:

> Just a few lines after the deleted code we call
>
>   safe_create_leading_directories_const(path + "/.git")
>
> so the check is done twice without action in between.
> Remove the first check.

I am hesitant to call the call to this function a "check".  If you
do not yet have the leading directories, they get created.

    We make sure that the parent directory of path exists (or create it
    otherwise) and then do the same for path + "/.git".

    That is equivalent to just making sure that the parent directory of
    path + "/.git" exists (or create it otherwise).

Perhaps?

>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/submodule--helper.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 88002ca..914e561 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -212,11 +212,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	/* Write a .git file in the submodule to redirect to the superproject. */
> -	if (safe_create_leading_directories_const(path) < 0)
> -		die(_("could not create directory '%s'"), path);
> -
>  	strbuf_addf(&sb, "%s/.git", path);
> -
>  	if (safe_create_leading_directories_const(sb.buf) < 0)
>  		die(_("could not create leading directories of '%s'"), sb.buf);
>  	submodule_dot_git = fopen(sb.buf, "w");
