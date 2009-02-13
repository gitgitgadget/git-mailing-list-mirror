From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] builtin-branch: improve output when displaying remote
 branches
Date: Thu, 12 Feb 2009 22:35:42 -0800
Message-ID: <7v7i3ug7y9.fsf@gitster.siamese.dyndns.org>
References: <7vhc30qki2.fsf@gitster.siamese.dyndns.org>
 <1234503271-78569-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 07:37:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXrft-0008Rj-Kh
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 07:37:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbZBMGfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 01:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbZBMGfx
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 01:35:53 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52073 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbZBMGfw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 01:35:52 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2C2E29898E;
	Fri, 13 Feb 2009 01:35:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B9B369898D; Fri,
 13 Feb 2009 01:35:43 -0500 (EST)
In-Reply-To: <1234503271-78569-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Fri, 13 Feb 2009 00:34:31 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8D470DB6-F998-11DD-8F17-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109712>

Jay Soffian <jaysoffian@gmail.com> writes:

> +	if (prefix && !prefixcmp(dst, prefix))
> +		return xstrdup(skip_prefix(dst, prefix));
> +	else
> +		return xstrdup(dst);
> +}

I wonder modern compilers are clever enough to optimze the above to
something more like:

	pfxlen = prefix ? strlen(prefix) : 0;
        if (pfxlen && !strncmp(dst, prefix, pfxlen))
        	return xstrdup(dst + pfxlen);
	else
        	return xstrdup(dst);

given that skip_prefix is an inline function but prefixcmp is not
(anymore), perhaps not.

>  static int append_ref(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
>  {
>  	struct ref_list *ref_list = (struct ref_list*)(cb_data);
>  	struct ref_item *newitem;
>  	struct commit *commit;
>  	int kind;
> -	int len;
> +	const char *prefix, *orig_refname = refname;
>  
>  	/* Detect kind */
>  	if (!prefixcmp(refname, "refs/heads/")) {
>  		kind = REF_LOCAL_BRANCH;
>  		refname += 11;
> +		prefix = "refs/heads/";
>  	} else if (!prefixcmp(refname, "refs/remotes/")) {
>  		kind = REF_REMOTE_BRANCH;
>  		refname += 13;
> +		prefix = "refs/remotes/";
>  	} else
>  		return 0;

Once you start making each case arm do more things, it might make sense to
rewrite the above unrolled loop into something like this:

	static struct {
        	int kind;
                const char *prefix;
                int pfxlen;
	} ref_kind[] = {
        	{ REF_LOCAL_BRANCH, "refs/heads/", 11 },
        	{ REF_REMOTE_BRANCH, "refs/remotes/", 13 },
	};

	for (i = 0; i < ARRAY_SIZE(ref_kind); i++) {
                prefix = ref_kind[i].prefix;
        	if (strncmp(refname, prefix, ref_kind[i].pfxlen))
			continue;
		kind = ref_kind[i].kind;
                refname += ref_kind[i].pfxlen;
                break;
	}
	if (ARRAY_SIZE(ref_kind) <= i)
		return 0;

Then we can later add new elements more easily, e.g.

                { REF_TOPGIT_BASE, "refs/top-base/", 14 },
;-)
