From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/11] tree-diff: consolidate code for emitting diffs and recursion in one place
Date: Thu, 13 Feb 2014 09:43:27 -0800
Message-ID: <xmqqob2alxhc.fsf@gitster.dls.corp.google.com>
References: <cover.1391794688.git.kirr@mns.spb.ru>
	<f0616720dfff7fedbd148e67909fe669834d8e6a.1391794688.git.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Thu Feb 13 18:43:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WE0KE-00048Q-R7
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 18:43:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbaBMRnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Feb 2014 12:43:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52273 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600AbaBMRnp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Feb 2014 12:43:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3DC769634;
	Thu, 13 Feb 2014 12:43:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=QON/fIH6RzJhu/VNfIfrhAOyBWU=; b=yfkXkIAANZbR6iGMh1P1
	CIbUHHfNeb77E+GestlVrbEVXjSPQk+K1fpjoVDbJIaFOutV3tUbl0owaEMM7Z/H
	cQI/pyrR0HWl12OZn3Kq9mFr8f8LjzuDSlSbvzBBrEJD6IE3X/WMgFS+rxCuoMRh
	FTed2GWXr3inp7a/e8NMX+c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=gWUAZdO67rRwQIFudp9wnMn6sqWvZFwo1LVS77PGayzzdG
	K6PmT4FHhs7O/VzFGoA2+stY3Sb50Po1c+jNWqS3Sy0lzhohoZN/5JlGqaKeoIXB
	O9URqHYur9egrgZS4DAEKIzeDOlRERfPgoqSZvK7sM7o8Fi1ueBhos4dBTM94=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DA0C69633;
	Thu, 13 Feb 2014 12:43:39 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E87746962E;
	Thu, 13 Feb 2014 12:43:35 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5D3F59DC-94D6-11E3-88A6-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242066>

Kirill Smelkov <kirr@mns.spb.ru> writes:

> +static void show_path(struct strbuf *base, struct diff_options *opt,
> +		      struct tree_desc *t1, struct tree_desc *t2)
>  {
>  	unsigned mode;
>  	const char *path;
> -	const unsigned char *sha1 = tree_entry_extract(desc, &path, &mode);
> -	int pathlen = tree_entry_len(&desc->entry);
> +	const unsigned char *sha1;
> +	int pathlen;
>  	int old_baselen = base->len;
> +	int isdir, recurse = 0, emitthis = 1;
> +
> +	/* at least something has to be valid */
> +	assert(t1 || t2);
> +
> +	if (t2) {
> +		/* path present in resulting tree */
> +		sha1 = tree_entry_extract(t2, &path, &mode);
> +		pathlen = tree_entry_len(&t2->entry);
> +		isdir = S_ISDIR(mode);
> +	}
> +	else {
> +		/* a path was removed - take path from parent. Also take
> +		 * mode from parent, to decide on recursion.
> +		 */
> +		tree_entry_extract(t1, &path, &mode);
> +		pathlen = tree_entry_len(&t1->entry);
> +
> +		isdir = S_ISDIR(mode);
> +		sha1 = NULL;
> +		mode = 0;
> +	}
> +
> +	if (DIFF_OPT_TST(opt, RECURSIVE) && isdir) {
> +		recurse = 1;
> +		emitthis = DIFF_OPT_TST(opt, TREE_IN_RECURSIVE);
> +	}
>  
>  	strbuf_add(base, path, pathlen);
> -	if (DIFF_OPT_TST(opt, RECURSIVE) && S_ISDIR(mode)) {
> -		if (DIFF_OPT_TST(opt, TREE_IN_RECURSIVE))
> -			opt->add_remove(opt, *prefix, mode, sha1, 1, base->buf, 0);
>  
> +	if (emitthis)
> +		emit_diff(opt, base, t1, t2);
> +
> +	if (recurse) {
>  		strbuf_addch(base, '/');
> -		diff_tree_sha1(*prefix == '-' ? sha1 : NULL,
> -			       *prefix == '+' ? sha1 : NULL, base->buf, opt);
> -	} else
> -		opt->add_remove(opt, prefix[0], mode, sha1, 1, base->buf, 0);
> +		diff_tree_sha1(t1 ? t1->entry.sha1 : NULL,
> +			       t2 ? t2->entry.sha1 : NULL, base->buf, opt);
> +	}


After this step, "sha1" is assigned but never gets used.  Please
double-check the fix-up I queued in the series before merging it to
'pu'.

Thanks.
