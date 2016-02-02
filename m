From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 10/15] clone: die on config error in cmd_clone
Date: Tue, 02 Feb 2016 12:55:55 -0800
Message-ID: <xmqqwpqmrfvo.fsf@gitster.mtv.corp.google.com>
References: <1454413916-31984-1-git-send-email-ps@pks.im>
	<1454413916-31984-11-git-send-email-ps@pks.im>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Tue Feb 02 21:56:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQhzW-0005Do-Kc
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 21:56:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbcBBUz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 15:55:58 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57403 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932913AbcBBUz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 15:55:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DDC43408AF;
	Tue,  2 Feb 2016 15:55:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5FqfH1r79LM9VJqGOzrKAjUVN0M=; b=BhAeC8
	dvgQIPECKvprrSmC17fEwPkr6l/siBOmVjqd4sQO8zIKtYwopABVs/SAmsS6jd+z
	bHx79AflGluo8CuZ4xYVZp/T9rcLZurCvwoFa4P/LAHxi7SMJldmr5nRZOjOqVJK
	fr2U3pXjH3pBjSOlFPSOR4HWkEpQAvJFTMAaw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FGBf5NUdy74Y0KsQiP7vC/Ee9SdZZ6Rg
	jrI5AbD16wFpuJ+kxSPOD8mFM+YBY2D1oXvXc5jBjLKFaxfoIFDKc7jgUUVLJYI3
	DOJHGAvxQhxw9P6oqd/t4PLl0dKrDIcQMegVO5tDYYXlk073Zn2etzGNa5Phb1oI
	ZGcU+maLh34=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D4E0F408AB;
	Tue,  2 Feb 2016 15:55:56 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5525E408AA;
	Tue,  2 Feb 2016 15:55:56 -0500 (EST)
In-Reply-To: <1454413916-31984-11-git-send-email-ps@pks.im> (Patrick
	Steinhardt's message of "Tue, 2 Feb 2016 12:51:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5ADFFFC0-C9EF-11E5-B98D-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285307>

Patrick Steinhardt <ps@pks.im> writes:

> The clone command does not check for error codes returned by
> `git_config_set` functions. This may cause the user to end up
> with an inconsistent repository without any indication with what
> went wrong.
>
> Fix this problem by dying with an error message when we are
> unable to write the configuration files to disk.

When this happens, the junk_mode is still JUNK_LEAVE_NONE, so upon
hitting such an error, we'd remove everything and die.  And we
haven't wasted the effort for large object transfer yet.

Which all sounds sensible.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/clone.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 81e238f..f2a2f9a 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -786,12 +786,12 @@ static void write_refspec_config(const char *src_ref_prefix,
>  		/* Configure the remote */
>  		if (value.len) {
>  			strbuf_addf(&key, "remote.%s.fetch", option_origin);
> -			git_config_set_multivar(key.buf, value.buf, "^$", 0);
> +			git_config_set_multivar_or_die(key.buf, value.buf, "^$", 0);
>  			strbuf_reset(&key);
>  
>  			if (option_mirror) {
>  				strbuf_addf(&key, "remote.%s.mirror", option_origin);
> -				git_config_set(key.buf, "true");
> +				git_config_set_or_die(key.buf, "true");
>  				strbuf_reset(&key);
>  			}
>  		}
> @@ -949,14 +949,14 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  			src_ref_prefix = "refs/";
>  		strbuf_addstr(&branch_top, src_ref_prefix);
>  
> -		git_config_set("core.bare", "true");
> +		git_config_set_or_die("core.bare", "true");
>  	} else {
>  		strbuf_addf(&branch_top, "refs/remotes/%s/", option_origin);
>  	}
>  
>  	strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top.buf);
>  	strbuf_addf(&key, "remote.%s.url", option_origin);
> -	git_config_set(key.buf, repo);
> +	git_config_set_or_die(key.buf, repo);
>  	strbuf_reset(&key);
>  
>  	if (option_reference.nr)
