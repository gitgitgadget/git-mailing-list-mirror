From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] silence human readable info messages going to stderr
 from git push --porcelain
Date: Fri, 05 Feb 2010 12:20:16 -0800
Message-ID: <7v1vgz5ta7.fsf@alter.siamese.dyndns.org>
References: <20100205150638.GB14116@coredump.intra.peff.net>
 <1265398462-17316-2-git-send-email-larry@elder-gods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Fri Feb 05 21:20:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdUfM-0007cZ-8f
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 21:20:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755452Ab0BEUU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 15:20:26 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42625 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755417Ab0BEUUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 15:20:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B4AE97698;
	Fri,  5 Feb 2010 15:20:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=iqWU/oFE7gdDg0Tuz/ZYyuVBqJ0=; b=qUBqnRQJdxJzIRCJJ+FnreP
	W9JQmZK4+nQxx42Frvy1UtXkVn43/DlHH93xPdS/8TYCQqMRlN96+XW8GspOBoEe
	5st8CieXVun1ZjLA0fKzW0617vCEcIDt3PH8pXSxjGkoanqSia+92mPYnMH/Gf4l
	9qgmQSWLxB8Io6k6jM5s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=YKbXRSmIDkt2e62xofMO5vgaDAn2IDwiXwN9Kpu4Kx8++SasV
	whSZHswsV2DJA/d8UTMwe/lhCsgmo4+jrrNMSG4b+y8sdC2u5Zm3gd2hjHshRauR
	Yd1R2cC0Bx2HxwX/je/W3ktIjlEt+QA+azejCo+ZHQGeqC8aZcdYW0ZnNY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1930197697;
	Fri,  5 Feb 2010 15:20:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E12697693; Fri,  5 Feb
 2010 15:20:17 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E1B59E66-1293-11DF-BC47-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139078>

Larry D'Anna <larry@elder-gods.org> writes:

> These messages are redundant information to a script that's calling git-push.

Redundant is not a reason for a change; unwanted would be.  And some of
the messages you are trying to squelch indeed look like unwanted ones, but
not all of them.

> -	if (flags & TRANSPORT_PUSH_VERBOSE)
> +	if (flags & TRANSPORT_PUSH_VERBOSE && !(flags & TRANSPORT_PUSH_PORCELAIN))
>  		fprintf(stderr, "Pushing to %s\n", transport->url);

Why should you be forbidden to expect "--porcelain -v" to give you this
message?

> @@ -123,7 +123,7 @@ static int push_with_options(struct transport *transport, int flags)
>  	if (!err)
>  		return 0;
>  
> -	if (nonfastforward && advice_push_nonfastforward) {
> +	if (!(flags & TRANSPORT_PUSH_PORCELAIN) && nonfastforward && advice_push_nonfastforward) {
>  		fprintf(stderr, "To prevent you from losing history, non-fast-forward updates were rejected\n"
>  				"Merge the remote changes before pushing again.  See the 'Note about\n"
>  				"fast-forwards' section of 'git push --help' for details.\n");

This probably is a good change; the long lines are unsightly but that is a
separate topic.

> diff --git a/transport.c b/transport.c
> index 3846aac..f707c7b 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -674,7 +674,7 @@ static void print_ok_ref_status(struct ref *ref, int porcelain)
>  
>  static int print_one_push_status(struct ref *ref, const char *dest, int count, int porcelain)
>  {
> -	if (!count)
> +	if (!count && !porcelain)
>  		fprintf(stderr, "To %s\n", dest);

I don't think this is correct.

If you have more than one remote.there.pushURL, the calling Porcelain
script of "git push --porcelain there" should be able to tell which
destination the following report is about, and without this line you
cannot tell.

I would understand if this change were to make the message go to the
standard output when operating with --porcelain option, though.

> @@ -1067,10 +1067,10 @@ int transport_push(struct transport *transport,
>  		if (!(flags & TRANSPORT_PUSH_DRY_RUN)) {
>  			struct ref *ref;
>  			for (ref = remote_refs; ref; ref = ref->next)
> -				update_tracking_ref(transport->remote, ref, verbose);
> +				update_tracking_ref(transport->remote, ref, verbose && !porcelain);

Again, why  should you be forbidden to expect "--porcelain -v" to work?

> -		if (!quiet && !ret && !refs_pushed(remote_refs))
> +		if (!quiet && !porcelain && !ret && !refs_pushed(remote_refs))
>  			fprintf(stderr, "Everything up-to-date\n");

This is a borderline.  If you are truly up-to-date, the calling script
won't get anything.  It may be easier for Porcelain scripts to see this
message on the standard output as an explicit succeses report instead.
