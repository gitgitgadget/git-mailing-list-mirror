From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Tag peeling peculiarities
Date: Thu, 14 Mar 2013 08:14:32 -0700
Message-ID: <7vfvzyypwn.fsf@alter.siamese.dyndns.org>
References: <51409439.5090001@alum.mit.edu>
 <7vwqtb2ood.fsf@alter.siamese.dyndns.org>
 <20130313215800.GA23838@sigill.intra.peff.net>
 <51415516.2070702@alum.mit.edu> <20130314052448.GA2300@sigill.intra.peff.net>
 <20130314053237.GA3552@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 14 16:15:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UG9s0-0006nv-Ja
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 16:15:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755834Ab3CNPOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 11:14:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55052 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754191Ab3CNPOg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 11:14:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E63DBEB6;
	Thu, 14 Mar 2013 11:14:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xNhXiZeLJqmeP5HGP7O1mCd7QwY=; b=mHJk6/
	mlIZQoxfnzNpwVbatdW0bOU3SwIFSC+hhAFB/j6tFSMzDzDTxJ4p2w+fhc63WMZ+
	upRIcqNMYP13JFpcGz0Lj0IvLDd3vNCfzuZWpY2DVfIjAJQP3KUh4EwjH3T5yS/D
	71CojFVo5bh+JTUhw930kONp8UnwxhMNs61IA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dcPIHCMYqDX/Y2xbtks4YFNsuVw8F/QI
	iyKdoDKjQVnXAA/ZpqMFsOOZHNcm/umjEeaFfLNqHWja4Q31BzM8w/4iR8Lpn6Kp
	nBxaQPxVJWIWslYsyVJBDmD0Wl7Rj6Yqar/6agt3iTZ7bhSaat7ccJCYsuLvNYES
	tROiNQLwjdk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41A8FBEB5;
	Thu, 14 Mar 2013 11:14:35 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 632E5BEB0; Thu, 14 Mar 2013
 11:14:34 -0400 (EDT)
In-Reply-To: <20130314053237.GA3552@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 14 Mar 2013 01:32:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E0DFDA6C-8CB9-11E2-A223-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218143>

Jeff King <peff@peff.net> writes:

> On Thu, Mar 14, 2013 at 01:24:48AM -0400, Jeff King wrote:
>
>> So the only question is how much work we want to put into making sure
>> the new reader handles the old writer correctly. Doing 2c is obviously
>> more rigorous, and it is not that much work to add the fully-packed
>> flag, but I kind of wonder if anybody even cares. We can just say "it's
>> a bug fix; run `git pack-refs` again if you care" and call it a day
>> (i.e., 1b).
>
> Urgh, for some reason I kept writing "fully-packed" but obviously I
> meant "fully-peeled". Hopefully you figured it out.
>
> Just as a quick sketch of how much work is in involved in 2c, I think
> the complete solution would look like this (but note I haven't tested
> this at all):

Looks reasonable from a cursory look, and I think we cannot avoid
going with the route to add "fully-peeled" token, because we do have
to express "we know this ref outside refs/tags/ area is not an
annotated tag" by marking them as REF_KNOWS_PEELED for the peel_ref()
optimization to work.



> diff --git a/pack-refs.c b/pack-refs.c
> index f09a054..261a6a6 100644
> --- a/pack-refs.c
> +++ b/pack-refs.c
> @@ -27,6 +27,7 @@ static int handle_one_ref(const char *path, const unsigned char *sha1,
>  			  int flags, void *cb_data)
>  {
>  	struct pack_refs_cb_data *cb = cb_data;
> +	struct object *o;
>  	int is_tag_ref;
>  
>  	/* Do not pack the symbolic refs */
> @@ -39,14 +40,12 @@ static int handle_one_ref(const char *path, const unsigned char *sha1,
>  		return 0;
>  
>  	fprintf(cb->refs_file, "%s %s\n", sha1_to_hex(sha1), path);
> -	if (is_tag_ref) {
> -		struct object *o = parse_object(sha1);
> -		if (o->type == OBJ_TAG) {
> -			o = deref_tag(o, path, 0);
> -			if (o)
> -				fprintf(cb->refs_file, "^%s\n",
> -					sha1_to_hex(o->sha1));
> -		}
> +	o = parse_object(sha1);
> +	if (o->type == OBJ_TAG) {
> +		o = deref_tag(o, path, 0);
> +		if (o)
> +			fprintf(cb->refs_file, "^%s\n",
> +				sha1_to_hex(o->sha1));
>  	}
>  
>  	if ((cb->flags & PACK_REFS_PRUNE) && !do_not_prune(flags)) {
> @@ -128,7 +127,7 @@ int pack_refs(unsigned int flags)
>  		die_errno("unable to create ref-pack file structure");
>  
>  	/* perhaps other traits later as well */
> -	fprintf(cbdata.refs_file, "# pack-refs with: peeled \n");
> +	fprintf(cbdata.refs_file, "# pack-refs with: peeled fully-peeled \n");
>  
>  	for_each_ref(handle_one_ref, &cbdata);
>  	if (ferror(cbdata.refs_file))
> diff --git a/refs.c b/refs.c
> index 175b9fc..770abf4 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -808,6 +808,7 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
>  	struct ref_entry *last = NULL;
>  	char refline[PATH_MAX];
>  	int flag = REF_ISPACKED;
> +	int fully_peeled = 0;
>  
>  	while (fgets(refline, sizeof(refline), f)) {
>  		unsigned char sha1[20];
> @@ -818,13 +819,18 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
>  			const char *traits = refline + sizeof(header) - 1;
>  			if (strstr(traits, " peeled "))
>  				flag |= REF_KNOWS_PEELED;
> +			if (strstr(traits, " fully-peeled "))
> +				fully_peeled = 1;
>  			/* perhaps other traits later as well */
>  			continue;
>  		}
>  
>  		refname = parse_ref_line(refline, sha1);
>  		if (refname) {
> -			last = create_ref_entry(refname, sha1, flag, 1);
> +			int this_flag = flag;
> +			if (!fully_peeled && prefixcmp(refname, "refs/tags/"))
> +				this_flag &= ~REF_KNOWS_PEELED;
> +			last = create_ref_entry(refname, sha1, this_flag, 1);
>  			add_ref(dir, last);
>  			continue;
>  		}
>
> So it's really not that much code. The bigger question is whether we
> want to have to carry the "fully-peeled" tag forever, and how other
> implementations would treat it.
>
> -Peff
