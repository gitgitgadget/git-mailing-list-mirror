From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log-tree: fix patch filename computation in "git
 format-patch"
Date: Thu, 26 Mar 2009 21:15:39 -0700
Message-ID: <7v3acziot0.fsf@gitster.siamese.dyndns.org>
References: <20090327011301.a5185805.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Mar 27 05:17:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln3VQ-0005Ah-Pa
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 05:17:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbZC0EPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 00:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbZC0EPt
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 00:15:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60048 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbZC0EPt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 00:15:49 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B2214A5B60;
	Fri, 27 Mar 2009 00:15:45 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 45ED4A5B5C; Fri,
 27 Mar 2009 00:15:40 -0400 (EDT)
In-Reply-To: <20090327011301.a5185805.chriscool@tuxfamily.org> (Christian
 Couder's message of "Fri, 27 Mar 2009 01:13:01 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F1C1F8EC-1A85-11DE-B0F8-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114846>

Christian Couder <chriscool@tuxfamily.org> writes:

> When using "git format-patch", "get_patch_filename" in
> "log-tree.c" calls "strbuf_splice" that could die with
> the following message:
>
> "`pos + len' is too far after the end of the buffer"
>
> if you have:
>
> 	buf->len < start_len + FORMAT_PATCH_NAME_MAX
>
> but:
>
> 	buf->len + suffix_len > start_len + FORMAT_PATCH_NAME_MAX
>
> This patch tries to get rid of that bug.

hmm, tries to?

> diff --git a/log-tree.c b/log-tree.c
> index 56a3488..ade79ab 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -187,16 +187,17 @@ void get_patch_filename(struct commit *commit, int nr, const char *suffix,
>  
>  	strbuf_addf(buf, commit ? "%04d-" : "%d", nr);
>  	if (commit) {
> +		int max_len = start_len + FORMAT_PATCH_NAME_MAX;
>  		format_commit_message(commit, "%f", buf, DATE_NORMAL);
>  		/*
>  		 * Replace characters at the end with the suffix if the
>  		 * filename is too long
>  		 */
> +		if (buf->len + suffix_len > max_len) {
> +			int base = (max_len > buf->len) ? buf->len : max_len;
> +			strbuf_splice(buf, base - suffix_len, suffix_len,
> +				      suffix, suffix_len);
> +		} else
>  			strbuf_addstr(buf, suffix);

Your third argument to splice does not look right; if the existing length
is very very long, you would need to remove a lot, and if the existing
length is slightly long, you would need to remove just a little bit, but
you always seem to remove the fixed amount, to splice the suffix in.

In any case, why does this have to be so complex?

In your buffer, you originally have start_len, and would want to end up
with "%f" expansion, plus the suffix, but you are not allowed to exceed
FORMAT_PATCH_NAME_MAX to store what you add, and are only allowed to chop
the "%f" expansion if you are short of room.

Shouldn't it be just:

	size_t max_len = start_len + FORMAT_PATCH_NAME_MAX - suffix_len;
        if (max_len < buf->len)
                strbuf_setlen(buf, max_len);
	strbuf_addstr(buf, suffix);

The caller must make sure that suffix_len is sufficiently shorter than
FORMAT_PATCH_NAME_MAX; I do not know if the current code does that,
though.
