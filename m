From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/17] cmd_diff(): use an object_array for holding trees
Date: Tue, 21 May 2013 10:30:50 -0700
Message-ID: <7v4ndwp7ed.fsf@alter.siamese.dyndns.org>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
	<1368995232-11042-6-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 21 19:31:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeqOo-0004XK-WD
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 19:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755297Ab3EURay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 13:30:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57268 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753764Ab3EURax (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 13:30:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 506E61E3D2;
	Tue, 21 May 2013 17:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BoSKSDNDzjFgU854RkTfbnrsE9M=; b=FI/Eh+
	yFt14pbkkkmtwHl+8didfuPjowKqScryu0vCqJnHfCB5pKbjcODghSShkAkHTbbr
	VflZC9fJm6mzNO9TXu8CN8TIugsjkqrCOGll8ZtcmZeeryywtyufPuigpws/gw/z
	LPD77RkVqb0drZeDeKmPTlSbfpor8jdsKJXZI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WEEIABtiZRm5Ip4ocgMoCxF25GSA+1Iw
	w0X+8l7nA/qLaqIx7HzvmrBcug6E1YywfQHXLZc172Lo+mmxo0YLRiuFKrjZ65fe
	nPDEifiKHNmCtkpgVU/iEci41ZNKVj3zT/f56efGyj3DUVt50DpNGSj8Hzj79TEG
	dnqVgd7xvBY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 455F91E3D0;
	Tue, 21 May 2013 17:30:53 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8DB321E3CD;
	Tue, 21 May 2013 17:30:52 +0000 (UTC)
In-Reply-To: <1368995232-11042-6-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Sun, 19 May 2013 22:27:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2F892F08-C23C-11E2-8A4B-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225047>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Change cmd_diff() to use a (struct object_array) for holding the trees
> that it accumulates, rather than rolling its own equivalent.
>

A significant detail missing here is that this lifts the hardcoded
100 tree limit in combined diff but that does not matter in
practice, I would suppose ;-).

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  builtin/diff.c | 37 ++++++++++++++++++-------------------
>  1 file changed, 18 insertions(+), 19 deletions(-)
>
> diff --git a/builtin/diff.c b/builtin/diff.c
> index ba68c6c..72d99c0 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -252,8 +252,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>  {
>  	int i;
>  	struct rev_info rev;
> -	struct object_array_entry ent[100];
> -	int ents = 0, blobs = 0, paths = 0;
> +	struct object_array ent = OBJECT_ARRAY_INIT;
> +	int blobs = 0, paths = 0;
>  	const char *path = NULL;
>  	struct blobinfo blob[2];
>  	int nongit;
> @@ -350,13 +350,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>  		if (obj->type == OBJ_COMMIT)
>  			obj = &((struct commit *)obj)->tree->object;
>  		if (obj->type == OBJ_TREE) {
> -			if (ARRAY_SIZE(ent) <= ents)
> -				die(_("more than %d trees given: '%s'"),
> -				    (int) ARRAY_SIZE(ent), name);
>  			obj->flags |= flags;
> -			ent[ents].item = obj;
> -			ent[ents].name = name;
> -			ents++;
> +			add_object_array(obj, name, &ent);
>  			continue;
>  		}
>  		if (obj->type == OBJ_BLOB) {
> @@ -380,7 +375,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>  	/*
>  	 * Now, do the arguments look reasonable?
>  	 */
> -	if (!ents) {
> +	if (!ent.nr) {
>  		switch (blobs) {
>  		case 0:
>  			result = builtin_diff_files(&rev, argc, argv);
> @@ -401,22 +396,26 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>  	}
>  	else if (blobs)
>  		usage(builtin_diff_usage);
> -	else if (ents == 1)
> +	else if (ent.nr == 1)
>  		result = builtin_diff_index(&rev, argc, argv);
> -	else if (ents == 2)
> -		result = builtin_diff_tree(&rev, argc, argv, &ent[0], &ent[1]);
> -	else if (ent[0].item->flags & UNINTERESTING) {
> +	else if (ent.nr == 2)
> +		result = builtin_diff_tree(&rev, argc, argv,
> +					   &ent.objects[0], &ent.objects[1]);
> +	else if (ent.objects[0].item->flags & UNINTERESTING) {
>  		/*
>  		 * diff A...B where there is at least one merge base
> -		 * between A and B.  We have ent[0] == merge-base,
> -		 * ent[ents-2] == A, and ent[ents-1] == B.  Show diff
> -		 * between the base and B.  Note that we pick one
> -		 * merge base at random if there are more than one.
> +		 * between A and B.  We have ent.objects[0] ==
> +		 * merge-base, ent.objects[ents-2] == A, and
> +		 * ent.objects[ents-1] == B.  Show diff between the
> +		 * base and B.  Note that we pick one merge base at
> +		 * random if there are more than one.
>  		 */
> -		result = builtin_diff_tree(&rev, argc, argv, &ent[0], &ent[ents-1]);
> +		result = builtin_diff_tree(&rev, argc, argv,
> +					   &ent.objects[0],
> +					   &ent.objects[ent.nr-1]);
>  	} else
>  		result = builtin_diff_combined(&rev, argc, argv,
> -					       ent, ents);
> +					       ent.objects, ent.nr);
>  	result = diff_result_code(&rev.diffopt, result);
>  	if (1 < rev.diffopt.skip_stat_unmatch)
>  		refresh_index_quietly();
