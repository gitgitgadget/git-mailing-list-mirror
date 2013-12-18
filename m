From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log: properly handle decorations with chained tags
Date: Tue, 17 Dec 2013 16:36:06 -0800
Message-ID: <xmqq38lrknbd.fsf@gitster.dls.corp.google.com>
References: <20131217004044.GB259467@vauxhall.crustytoothpaste.net>
	<1387254501-319329-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Wed Dec 18 01:36:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vt57Z-0001Ja-Vp
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 01:36:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752304Ab3LRAgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Dec 2013 19:36:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40519 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750872Ab3LRAgM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Dec 2013 19:36:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23E6F5C0F3;
	Tue, 17 Dec 2013 19:36:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3RtUEn5MuwmFHdOGA89YDgI4XRs=; b=BD0Jnw
	XR8kclZyckdP8WEbYcRYyydiEOyJkp8pVIngQR6/LZ2FC1URli8Bj4q/b8LxJCC+
	ynVkq6DKdm1kGcjJPRwOwNt6QbSbZ24gFU+5Rc80tvH1OhUJAw/sO/qU97GW3dP9
	UYB7gCJeFUcevxxQCrU/hZwoSgGuWIrI/MFwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hFWoKPP8gn9cDi3CZ+ozVH2IxE4mEvWQ
	yqhQE4ZT83gwQzHEDcWoQfUygYNT6OpI+2Oyr1sFwZJnJc01ZVwKLGNd+xWpHeJv
	k2nKnVpnxFO7yDCxDB3gXkVfp/MDRTj8a+K/DN+6zwGlrcFKUyZKeQIMR9Vb15LN
	5s4uCzHqJ7Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D5015C0F2;
	Tue, 17 Dec 2013 19:36:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 063355C0F1;
	Tue, 17 Dec 2013 19:36:09 -0500 (EST)
In-Reply-To: <1387254501-319329-1-git-send-email-sandals@crustytoothpaste.net>
	(brian m. carlson's message of "Tue, 17 Dec 2013 04:28:21 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 63DE545A-677C-11E3-99E6-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239418>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>  		refname = prettify_refname(refname);
>  	add_name_decoration(type, refname, obj);
>  	while (obj->type == OBJ_TAG) {
> -		obj = ((struct tag *)obj)->tagged;
> -		if (!obj)
> -			break;
> +		struct object *tagged = ((struct tag *)obj)->tagged;
> +		if (!tagged) {
> +			obj = parse_object(obj->sha1);
> +			if (!obj)
> +				break;
> +			tagged = ((struct tag *)obj)->tagged;
> +			if (!tagged)
> +				break;
> +		}
> +		obj = tagged;
>  		add_name_decoration(DECORATION_REF_TAG, refname, obj);
>  	}

OK, the above is not wrong per-se but it took me three reads to
convince myself that I understood what was going on.

Before entering this loop, obj has already been parsed, it is known
to be an annotated tag object, and its obj->tagged field is valid,
but the object pointed at by the tag may still not be parsed yet.
The object given to add_name_decoration() before we enter the loop
has been parsed, but the one given at the end of this loop is not.

I think all we need to do, in addition to what the existing code
does, is to make sure that we _parse_ the object that the tag points
at, to avoid this problem.  Something like this, perhaps, instead?

diff --git a/log-tree.c b/log-tree.c
index 8534d91..1982631 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -132,10 +132,12 @@ static int add_ref_decoration(const char *refname, const unsigned char *sha1, in
 	add_name_decoration(type, refname, obj);
 	while (obj->type == OBJ_TAG) {
 		obj = ((struct tag *)obj)->tagged;
 		if (!obj)
 			break;
+		if (!obj->parsed)
+			parse_object(obj->sha1);
 		add_name_decoration(DECORATION_REF_TAG, refname, obj);
 	}
 	return 0;
 }
 
It seems to me that the above is not just sufficient, but also shows
what the breakage was really about a lot more clearly, at least to
me.

Hmm?

> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> index fb00041..2a6278b 100755
> --- a/t/t4205-log-pretty-formats.sh
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -310,4 +310,19 @@ EOF
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'log decoration properly follows tag chain' '
> +	git tag -a tag1 -m tag1 &&
> +	git tag -a tag2 -m tag2 tag1 &&
> +	git tag -d tag1 &&
> +	git commit --amend -m shorter &&
> +	git log --no-walk --tags --pretty="%H %d" --decorate=full >actual &&
> +	cat <<EOF >expected &&
> +6a908c10688b2503073c39c9ba26322c73902bb5  (tag: refs/tags/tag2)
> +9f716384d92283fb915a4eee5073f030638e05f9  (tag: refs/tags/message-one)
> +b87e4cccdb77336ea79d89224737be7ea8e95367  (tag: refs/tags/message-two)
> +EOF
> +	sort actual >actual1 &&
> +	test_cmp expected actual1
> +'
> +
>  test_done
