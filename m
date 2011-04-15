From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] combine-diff: use textconv for combined diff format
Date: Fri, 15 Apr 2011 11:34:27 -0700
Message-ID: <7voc47cqj0.fsf@alter.siamese.dyndns.org>
References: <20110414213006.GA7709@sigill.intra.peff.net>
 <36a715a966a22207135f60532e723f6d87dd1ffb.1302881295.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 15 20:34:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAnqx-0003X0-7H
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 20:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804Ab1DOSel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 14:34:41 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39269 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127Ab1DOSek (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 14:34:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0977138F5;
	Fri, 15 Apr 2011 14:36:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=sspp9C+cSj+qax5Azw3oAUoweNg=; b=Y0jZL4
	/VMMEF/e9xcSAJATM2o705qj6CsW48Wo2S9LSauc7IoTLuvyT11R/Ff1hfgddq0G
	LfpknBBLDhkZ7egOXCgRPYRagOlzyixFBkNGnd/DBrHsCJdghwi/OTKgD7tM4KDk
	+yrM36p57A+SWc2suLhkpZEGNYQAosVI2l6MA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LThnInfsm/RqFeAVP3ijLzDY+VOm90Kl
	jxz5dBGe9gqNJL9SMO9wCZdijcFx6Iz+RkuO/FLIvNs+lWcJs8fgjPSu8K/aZuub
	6/MXxFwzR3jVZtmi1iYrbcV9SQveRolTDMhj4avi89e3zG7A87wm+krBbf374ZOw
	e1gf1fD0e8k=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CB2CB38F4;
	Fri, 15 Apr 2011 14:36:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8A96038F3; Fri, 15 Apr 2011
 14:36:27 -0400 (EDT)
In-Reply-To: <36a715a966a22207135f60532e723f6d87dd1ffb.1302881295.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Fri, 15 Apr 2011 17:29:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 489F724A-678F-11E0-84AB-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171628>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> git diff -m produces a combined diff!

Hmm, what is the rest of your command line?  I thought -m was a way to ask
pairwise diff with each parent.

> +static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr, int n, int num_parent, int textconv)
>  {
>  	struct diff_queue_struct *q = &diff_queued_diff;
>  	struct combine_diff_path *p;
> @@ -34,9 +34,13 @@ static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr,
>  
>  			hashcpy(p->sha1, q->queue[i]->two->sha1);
>  			p->mode = q->queue[i]->two->mode;
> +			if (textconv)
> +				p->textconv = get_textconv(q->queue[i]->two);
>  			hashcpy(p->parent[n].sha1, q->queue[i]->one->sha1);
>  			p->parent[n].mode = q->queue[i]->one->mode;
>  			p->parent[n].status = q->queue[i]->status;
> +			if (textconv)
> +				p->parent[n].textconv = get_textconv(q->queue[i]->one);

This code attempts to handle different textconv set for each different
parents.  But I have to wonder if that is really worth it.

The attribute to decide the content type of the blob is read from the same
set of .gitattributes files, regardless of which parent you are looking at
(and this is not likely to change---the exact procedure that is applied
comes from .git/config that is not even versioned, so there is not much
point in reading from the .gitattributes from the parent tree, trying to
be "precise").

If q->queue[i] is not a rename, p->textconv and p->parent[n].textconv
would be the same because one and two came from the same path.  If it is a
rename, they by definition consist of similar contents, and the user would
want the same textconv conversion applied to them to make them comparable.
Even though using p->parent[n].textconv to convert q->queue[i]->one->sha1
blob and using p->textconv to convert q->queue[i]->two->sha1 blob might be
the right thing to do in theory, doing so wouldn't make a difference in
practice.  More importantly, even if the two textconvs specify different
conversions, it is likely that it is an user error (e.g. the preimage had
"img4433.jqg" that was renamed to img4433.jpg" in the postimage, and the
attributes mechanism does not say ".jqg" is a JPEG that wants to get
"exif" run to be texualized for the purpose of diffing, or something).

Besides, if you really want to support "left hand side and right hand
side, depending on which parent we are talking about, may use different
textconv", you would need to defeat the optimization in show_patch_diff()
that calls reuse_combine_diff() when sha1 are the same from other parent
we have already compared---the parent we are looking at may be using a
different textconv procedure.  Even worse, if parent and child have the
same sha1, the result of running parent textconv on the parent blob may be
different from that of the child, which you would never even see in this
codepath.

So I suspect that using only one textconv per "struct combine_diff_path"
would make both the code simpler, and more importantly would make the
result more correct from the end user's point of view.

> @@ -777,6 +783,12 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
>  			close(fd);
>  	}
>  
> +	if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV) && elem->textconv) {
> +		struct diff_filespec *df = alloc_filespec(elem->path);
> +		fill_filespec(df, elem->sha1, elem->mode);
> +		result_size = fill_textconv(elem->textconv, df, &result);
> +	}

I suspect that these three lines have to become a small helper function to
be used to convert the final blob (done here), and parent blob (done in
combine_diff).  With the "binary" support, it would eventually need to be
enhanced to something like:

	if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV)) {
        	if (textconv) {
                	do these three lines;
		} else if (is binary) {
                	"Binary blob $SHA-1";
		}
	}

and having a small helper function early in the series would help that
process.

> +		paths = intersect_paths(paths, i, num_parent, DIFF_OPT_TST(opt, ALLOW_TEXTCONV));

As an internal API within this file, I would rather see "opt" as a whole
passed to intersect_paths().  We may probably want to determine if the
blob is binary in that function depending on other "opt" fields.
