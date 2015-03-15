From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug in fetch-pack.c, please confirm
Date: Sun, 15 Mar 2015 00:27:25 -0700
Message-ID: <xmqqa8zevhya.fsf@gitster.dls.corp.google.com>
References: <0758b2029b41448a77a4e4df1c4e406@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Git mailing list <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 08:27:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YX2xY-0006SZ-As
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 08:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbbCOH13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 03:27:29 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63319 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751180AbbCOH12 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 03:27:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9048A38A35;
	Sun, 15 Mar 2015 03:27:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=92wc8I2Gi3YLPW82LTjSy199Mb8=; b=Rblax/
	1RdbecRBrMO2cBRzYWsg8CpiFA/5pxb1VvPZjcbaZ28evZPNLCLSjvEPZuTaCAnv
	VvJ/JKX4qrcMDBhaK0vVdyEu9PLU08hQh67CawB9ucNz8OqGnlLIGku20O+FR+VR
	3/bZZLEYiw6Fn/oHUWcQ0AruW/dhflZGGtohs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TmwbDoKBKfMtVXZarLZ2xNaHJXyIlAMn
	h47QLmtFOwFeCuoQ5MPgxEcb/J/jxnz8S6kyzja6JF+vAOnJSXBDgQB4jaOGiHrh
	M436Luq2FbO8fQ9Vv5qQlK+BoeZFeyZdCVkHZYso4NT69OjV1xHjL2wIeDZeamHV
	DHtsSOvbTjY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 883D938A34;
	Sun, 15 Mar 2015 03:27:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0FE4738A33;
	Sun, 15 Mar 2015 03:27:26 -0400 (EDT)
In-Reply-To: <0758b2029b41448a77a4e4df1c4e406@74d39fa044aa309eaea14b9f57fe79c>
	(Kyle J. McKay's message of "Sat, 14 Mar 2015 23:37:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BB3F23C4-CAE4-11E4-95C6-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265484>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> Hi guys,
>
> So I was looking at fetch-pack.c (from master @ 52cae643, but I think  
> it's the same everywhere):
>
> # Lines 626-648
>

49bb805e (Do not ask for objects known to be complete., 2005-10-19)
seems to lose the assignment to local[].

> Something's very wrong here.
>
> It looks to me like the bug was introduced in 49bb805e (Do not ask for  
> objects known to be complete. 2005-10-19).

I read that "lines 626-648", stopped reading your message and did a
blame session myself, and arrived at the same culprit.

The very original code that read from the ref directly here; I do
not think it was an attempt to catch a race condition where
ref->old_sha1 got stale and the ref on the filesystem has a newer
value.  Hence, I think copying from o->sha1 like you did is a fix
that is the most faithful to the original code.

o is lookup_object(remote) which is lookup_object(ref->old_sha1);
that makes o->sha1 always be ref->old_sha1, so either would be fine,
but o->sha1 would be more appropriate in this codeflow.  We grab o,
if it is NULL or if we do not like it, we do something and continue,
otherwise we like that o so grabbing o->sha1 out of it makes the
logic look flowing right, at least to me ;-)

> -- 8< --
> Subject: [PATCH] fetch-pack.c: do not use uninitialized sha1 value
>
> Since 49bb805e (Do not ask for objects known to be complete. 2005-10-19)
> when the read_ref call was replaced with a parse_object call, the
> automatic variable 'local' containing an sha1 has been left uninitialized.
>
> Subsequently in 1baaae5e (Make maximal use of the remote refs, 2005-10-28)
> the parse_object call was replaced with a lookup_object call but still
> the 'local' variable was left uninitialized.
>
> However, it's used as the source to update another sha1 value in the case
> that we already have it and in that case the other ref will end up with
> whatever garbage was in the 'local' variable.
>
> Fix this by removing the 'local' variable and using the value from the
> result of the lookup_object call instead.
>
> Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
> ---
>  fetch-pack.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 655ee642..c0b4d84f 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -621,29 +621,28 @@ static int everything_local(struct fetch_pack_args *args,
>  		}
>  	}
>  
>  	filter_refs(args, refs, sought, nr_sought);
>  
>  	for (retval = 1, ref = *refs; ref ; ref = ref->next) {
>  		const unsigned char *remote = ref->old_sha1;
> -		unsigned char local[20];
>  		struct object *o;
>  
>  		o = lookup_object(remote);
>  		if (!o || !(o->flags & COMPLETE)) {
>  			retval = 0;
>  			if (!args->verbose)
>  				continue;
>  			fprintf(stderr,
>  				"want %s (%s)\n", sha1_to_hex(remote),
>  				ref->name);
>  			continue;
>  		}
>  
> -		hashcpy(ref->new_sha1, local);
> +		hashcpy(ref->new_sha1, o->sha1);
>  		if (!args->verbose)
>  			continue;
>  		fprintf(stderr,
>  			"already have %s (%s)\n", sha1_to_hex(remote),
>  			ref->name);
>  	}
>  	return retval;
> ---
