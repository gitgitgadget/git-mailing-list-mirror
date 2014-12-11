From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] list-objects: mark fewer commits as edges for non-shallow clones
Date: Thu, 11 Dec 2014 11:26:47 -0800
Message-ID: <xmqqr3w6dm2w.fsf@gitster.dls.corp.google.com>
References: <20141211030948.GA137226@vauxhall.crustytoothpaste.net>
	<1418269615-139571-1-git-send-email-sandals@crustytoothpaste.net>
	<xmqqvblidmp1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Thu Dec 11 20:26:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xz9O3-0003kK-4b
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 20:26:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932646AbaLKT0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2014 14:26:51 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54820 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757828AbaLKT0u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2014 14:26:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 48860242D1;
	Thu, 11 Dec 2014 14:26:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i4LM6NObibotT4RrUxI8XToybzM=; b=K8AwhG
	FfJJYyaa1omRSaKR5mTs/mqKIn5Ys5fF75V62iBcdEILomqQTJvtDDaBeLPHqq+Y
	4dvbLW5NaiOL2L0fPq/ed6DcvknJY6ha3/7El9CoPdhitmR8NYhgCxtNNu+BHwqk
	lXr6XpvZfE+d+Ngo8SQEyLO7qbODqI9X4nczE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mAU2mfrGYRB55vTc6rGULjgv00vN+RjU
	ep5eS/BJoM82JFWaExXHvepQePiVubnrp/6dLDLTnY8xXRdC+XLIGXxohFvI96/z
	o1n80Bpo00Jo0/TScA1F2HSPgHsdke0Mi1cbmcTkl0MpGEy6TD9Vj8W+hRHJomRt
	gRN/D/1mTwQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B067242D0;
	Thu, 11 Dec 2014 14:26:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ACAA1242CB;
	Thu, 11 Dec 2014 14:26:48 -0500 (EST)
In-Reply-To: <xmqqvblidmp1.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 11 Dec 2014 11:13:30 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A6C2230A-816B-11E4-90EC-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261288>

Junio C Hamano <gitster@pobox.com> writes:

> This change affects non-clone/fetch uses of object listing depending
> on the shallowness of the repository, and does not even care if it
> is driven as part of the pack-object codepath, if I am reading it
> correctly.  It smells wrong.
>
> The problematic fbd4a70 already had unintended fallout that needed
> to be corrected with 200abe74 (list-objects: only look at cmdline
> trees with edge_hint, 2014-01-20).  The current code with the fix,
> the decision to use the more expensive marking is tied to
> "edge_hint". I notice that edge_hint is turned on only if the caller
> of rev-list passes the "--objects-edge" option, and currently that
> only happens in the pack-objects codepath when "thin" is given.
> Perhaps that part should decide if it really wants to do edge_hint
> depending on the shallowness of the repository perhaps?
>
> That is, something like this instead?

Eh, perhaps not like that, as that would disable milder use of
"thin" when fetching into non-shallow repository.

The right approach would be more like allocating one more bit in
struct rev_info (call that edge_hint_aggressive), give a new option
"--objects-edge-aggressive", and do something like

	if (thin) {
        	use_internal_rev_list = 1;
		argv_array_push(&rp, is_repository_shallow()
                	? "--objects-edge-aggressive"
                        : "--objects-edge");
	}

in this codepath?  I'd actually suggest is_repository_shallow()
detection to happen one level even higher (i.e. make decision at the
caller of pack-objects) and decide to pass either "--thin" or
"--thin-aggressive", so that we can make sure that the damage caused
by fbd4a70 to be limited only to fetches into shallow repository
with stronger confidence.


>
>  builtin/pack-objects.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 3f9f5c7..a9ebf56 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -2709,7 +2709,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  		usage_with_options(pack_usage, pack_objects_options);
>  
>  	argv_array_push(&rp, "pack-objects");
> -	if (thin) {
> +	if (thin && is_repository_shallow()) {
>  		use_internal_rev_list = 1;
>  		argv_array_push(&rp, "--objects-edge");
>  	} else
