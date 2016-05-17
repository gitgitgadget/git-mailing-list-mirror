From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC-PATCHv6 4/4] pathspec: allow querying for attributes
Date: Mon, 16 May 2016 21:23:17 -0700
Message-ID: <xmqqa8jpz51m.fsf@gitster.mtv.corp.google.com>
References: <20160517031353.23707-1-sbeller@google.com>
	<20160517031353.23707-5-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 17 06:23:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2WXV-0008MB-OC
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 06:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685AbcEQEXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 00:23:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61336 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752641AbcEQEXU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 00:23:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 28A771C639;
	Tue, 17 May 2016 00:23:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=84ae78bpb1IAPC/jjNnbGbj0CdI=; b=Lyr7/W
	nI914XVaH3TcERtjblrJWlR0VAhPBcBrCVBlCum9yHMpzMR7dA8mbCotSse2tZo7
	9kFLLl15eUK4D8Xc+WWuw8MFQ1hCZSw4CxCipUHwmSQ6cp0R2pwjrsWt7hDXtFvP
	b3wQ5Qcyt4NkbTFhJWuFBBgL2t0YyfgukfutM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gAqtwuYcPPMZZi9S1EmcO7mfQE/Xj+sS
	JI0zxapaXuOewBNHZTs6/nXDkQoK/qL2WhEFm16P/lMOkl5icu2x2jrxRdmDmk5o
	NZuuGeanOkJ8+E+Lt5eTWskOhTsH5lF6B6xZJEdpY3FdOxtnFUmiHBrUaG1AfiPQ
	sw9ETOQDRTE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1FB661C638;
	Tue, 17 May 2016 00:23:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 987061C637;
	Tue, 17 May 2016 00:23:19 -0400 (EDT)
In-Reply-To: <20160517031353.23707-5-sbeller@google.com> (Stefan Beller's
	message of "Mon, 16 May 2016 20:13:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 15AC35E6-1BE7-11E6-8711-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294854>

Stefan Beller <sbeller@google.com> writes:

> + * attr:+val to find value set to true
> + * attr:-val to find a value set to false
> + * attr:!val to find a value that is not set
> + *     (i.e. it is neither set as "val", "val=<empty>", nor unset as "-val")
> + * attr:val=value: to find value that have at least a and b set.

I would have expected that there won't be "attr:+val", but it is
spelled as "attr:val" instead.

> +static void parse_attr_item(struct attr_item *attr, const char *value)

Please do not call something that is not part of the attribute
infrastructure as "attr_item"; I wasted time looking for the
structure definition for "attr_item" in <attr.h>.

> +static int match_attrs(const char *name, int namelen,
> +		       const struct pathspec_item *item)
> +{
> +	char *path;
> +	int i;
> +
> +	if (!check) {
> +		check = git_attr_check_alloc();
> +		for (i = 0; i < item->attr_nr; i++)
> +			git_attr_check_append(check, item->attrs[i].attr);
> +	}
> +
> +	path = xmemdupz(name, namelen);
> +	git_all_attrs(path, check);

PLEASE DON'T.  git_all_attrs() asks for all the attribute under the
sun and has no hope to perform sensibly, especially at the very leaf
level of the pathspec logic where one call to this function is made
for each and every path in the tree.

Instead, have a pointer to "struct git_attr_check" in pathspec_item
and make a call to git_check_attr(path, item->check) here.

Which means that you would need to prepare git_attr_check around ...

> +		if (skip_prefix(copyfrom, "attr:", &body)) {
> +			ALLOC_GROW(item->attrs, item->attr_nr + 1, item->attr_alloc);
> +			parse_attr_item(&item->attrs[item->attr_nr++], body);

... HERE.
