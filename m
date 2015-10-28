From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add_submodule_odb: initialize alt_odb list earlier
Date: Wed, 28 Oct 2015 08:24:17 -0700
Message-ID: <xmqqa8r3m2xq.fsf@gitster.mtv.corp.google.com>
References: <5630B876.7080407@sociomantic.com> <5630BE79.40708@gmail.com>
	<5630CF1B.9000706@sociomantic.com>
	<20151028140725.GA15304@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Mathias L. Baumann" <mathias.baumann@sociomantic.com>,
	Victor Leschuk <vleschuk@gmail.com>, git@vger.kernel.org,
	vleschuk@accesssoftek.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 28 16:24:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrSaP-0003mP-HO
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 16:24:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755978AbbJ1PYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 11:24:21 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52527 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751631AbbJ1PYU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 11:24:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 76F8023404;
	Wed, 28 Oct 2015 11:24:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=20B1H4qhsnNVTvq/ZYsFRijOgfA=; b=Bt4agR
	n1PdYHYqcPmm8Vr5MhD15gHoko2RHR7XYHzQSrlApTmRwnPzW9njhI0Nc6gMz7CV
	+15f1bObxk1M6gqtZ//XvG7nnq6NmvFrwNunPMIFWhyvWtko82S8mX0st0uBSF02
	5l1zvp67H1Ro9ADVZwis/+GDpDGnAANQHcaOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MYB8W+Mvb61EegHsZvtP2u4hc91zXcve
	kVXe1FrIl+VMlRxBvilTBEiyN1xY2UcROhwBijavSuIqOpsILl/ETvCRbf5I5RDN
	lFpo1Xu+YUXTEVcVxfh5cJBWC0988cYNTn1GRNFJGtmh+ASpeEeHyb154quXVk39
	PDxUIe+oWHg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6E27D23403;
	Wed, 28 Oct 2015 11:24:19 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E8AE523402;
	Wed, 28 Oct 2015 11:24:18 -0400 (EDT)
In-Reply-To: <20151028140725.GA15304@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 28 Oct 2015 10:07:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F507FA8A-7D87-11E5-8D98-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280371>

Jeff King <peff@peff.net> writes:

> Yeah, I can reproduce it easily with that. Thanks for providing the
> repository. It takes a rather convoluted set of conditions to trigger
> the bug. :)
>
> Here's the fix:
>
> -- >8 --
> Subject: add_submodule_odb: initialize alt_odb list earlier
>
> The add_submodule_odb function tries to add a submodule's
> object store as an "alternate". It needs the existing list
> to be initialized (from the objects/info/alternates file)
> for two reasons:
>
>   1. We look for duplicates with the existing alternate
>      stores, but obviously this doesn't work if we haven't
>      loaded any yet.
>
>   2. We link our new entry into the list by prepending it to
>      alt_odb_list. But we do _not_ modify alt_odb_tail.
>      This variable starts as NULL, and is a signal to the
>      alt_odb code that the list has not yet been
>      initialized.
>
>      We then call read_info_alternates on the submodule (to
>      recursively load its alternates), which will try to
>      append to that tail, assuming it has been initialized.
>      This causes us to segfault if it is NULL.
>
> This rarely comes up in practice, because we will have
> initialized the alt_odb any time we do an object lookup. So
> you can trigger this only when:
>
>   - you try to access a submodule (e.g., a diff with
>     diff.submodule=log)
>
>   - the access happens before any other object has been
>     accessed (e.g., because the diff is between the working
>     tree and the index)
>
>   - the submodule contains an alternates file (so we try to
>     add an entry to the NULL alt_odb_tail)
>
> To fix this, we just need to call prepare_alt_odb at the
> start of the function (and if we have already initialized,
> it is a noop).
>
> Note that we can remove the prepare_alt_odb call from the
> end. It is guaranteed to be a noop, since we will have
> called it earlier.

Thanks for a quick and detailed diagnosis and a fix.

The removal is correct, but even without this fix, the order of
calls in the original should have screamed "bug" loudly at us, I
think.  We shouldn't be reading data from alternates file without
first preparing the place we read data into.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  submodule.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/submodule.c b/submodule.c
> index 5879cfb..88af54c 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -130,6 +130,7 @@ static int add_submodule_odb(const char *path)
>  		goto done;
>  	}
>  	/* avoid adding it twice */
> +	prepare_alt_odb();
>  	for (alt_odb = alt_odb_list; alt_odb; alt_odb = alt_odb->next)
>  		if (alt_odb->name - alt_odb->base == objects_directory.len &&
>  				!strncmp(alt_odb->base, objects_directory.buf,
> @@ -148,7 +149,6 @@ static int add_submodule_odb(const char *path)
>  
>  	/* add possible alternates from the submodule */
>  	read_info_alternates(objects_directory.buf, 0);
> -	prepare_alt_odb();
>  done:
>  	strbuf_release(&objects_directory);
>  	return ret;
