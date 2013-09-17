From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] repack: rewrite the shell script in C
Date: Tue, 17 Sep 2013 13:25:14 -0700
Message-ID: <xmqqa9jbxkk5.fsf@gitster.dls.corp.google.com>
References: <1379259202-5042-1-git-send-email-stefanbeller@googlemail.com>
	<xmqqy56vxqhi.fsf@gitster.dls.corp.google.com>
	<5238B7E4.6060506@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 22:25:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM1ps-0007VJ-En
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 22:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753873Ab3IQUZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 16:25:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54090 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753358Ab3IQUZS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 16:25:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FFB5433B8;
	Tue, 17 Sep 2013 20:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xfJ4l2PRG9oipNbl+YatUvbCrmY=; b=Fa7Csh
	YR7TXxjNtyDW2kA518R9bXSdXfhjYJvpWN7y4yE80KW3YEjMcdi+rXMO8bayMRJl
	+NsqYh0msEzjCVLRAI7G5mKpYNRBRKyaW1/bCxlCp5ml2e6enrISm10C6QoHt2tw
	lywTSQjCP4VLYqLXfnsOkfizrx8L5R28ZL5WY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TP2/Im3KsSD5I0fWL6xvo0pfn/kr6H4U
	HDx7PENMEqeaxZotZ70y4DBXxLyy/4Wn4hRtjkP98j0UxGyRNPzbQ86IXZraS6TU
	A7mpmfkyx5uqI/1yaaRj3TGurFxasYbJQAiovPPwSSbQEMjIslBH8QxfEtmTuPfC
	RUUM7XLQnFc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 967CE433B7;
	Tue, 17 Sep 2013 20:25:17 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1EAC433B3;
	Tue, 17 Sep 2013 20:25:16 +0000 (UTC)
In-Reply-To: <5238B7E4.6060506@googlemail.com> (Stefan Beller's message of
	"Tue, 17 Sep 2013 22:13:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 43D9C956-1FD7-11E3-8A46-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234919>

Stefan Beller <stefanbeller@googlemail.com> writes:

> On 09/17/2013 08:17 PM, Junio C Hamano wrote:
>> Stefan Beller <stefanbeller@googlemail.com> writes:
>> 
>>> +	struct option builtin_repack_options[] = {
>>> +		OPT_BIT('a', NULL, &pack_everything,
>>> +				N_("pack everything in a single pack"), ALL_INTO_ONE),
>>> +		OPT_BIT('A', NULL, &pack_everything,
>>> +				N_("same as -a, and turn unreachable objects loose"),
>>> +				   LOOSEN_UNREACHABLE),
>> 
>> Micronit.
>> 
>> With the current version of the code in cmd_repack() that uses the
>> pack_everything variable this may not make a difference, but I think
>> this should logically be "LOOSEN_UNREACHABLE | ALL_INTO_ONE" instead,
>> and the code should check (pack_evertying & ALL_INTO_ONE) instead of
>> checking "!pack_everything".  You may want to add to this flag variable
>> a new bit that does _not_ cause it to pack everything into one.
>> 
>
> I do understand the "LOOSEN_UNREACHABLE | ALL_INTO_ONE" here, as that
> is the logical thing we are doing. Combined with your second idea this 
> would result in
> ---8<---
>
> From 4bbbfb312bf23efa7e702e200fbc2d4479e3477e Mon Sep 17 00:00:00 2001
> From: Stefan Beller <stefanbeller@googlemail.com>
> Date: Tue, 17 Sep 2013 22:04:35 +0200
> Subject: [PATCH 2/2] Suggestions by Junio
>
> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
> ---
>  builtin/repack.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index e5f90c6..a0ff5c7 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -143,7 +143,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  				N_("pack everything in a single pack"), ALL_INTO_ONE),
>  		OPT_BIT('A', NULL, &pack_everything,
>  				N_("same as -a, and turn unreachable objects loose"),
> -				   LOOSEN_UNREACHABLE),
> +				   LOOSEN_UNREACHABLE | ALL_INTO_ONE),
>  		OPT_BOOL('d', NULL, &delete_redundant,
>  				N_("remove redundant packs, and run git-prune-packed")),
>  		OPT_BOOL('f', NULL, &no_reuse_delta,
> @@ -197,10 +197,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	if (no_reuse_object)
>  		argv_array_pushf(&cmd_args, "--no-reuse-object");
>  
> -	if (!pack_everything) {
> -		argv_array_push(&cmd_args, "--unpacked");
> -		argv_array_push(&cmd_args, "--incremental");
> -	} else {
> +	if (pack_everything & ALL_INTO_ONE) {
>  		get_non_kept_pack_filenames(&existing_packs);
>  
>  		if (existing_packs.nr && delete_redundant) {
> @@ -212,6 +209,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  				argv_array_push(&cmd_args,
>  						"--unpack-unreachable");
>  		}
> +	} else {
> +		argv_array_push(&cmd_args, "--unpacked");
> +		argv_array_push(&cmd_args, "--incremental");
>  	}
>  
>  	if (local)
> -- 
> 1.8.4.273.ga194ead

Yes.

Above was what I would have expected from a straight *.sh to *.c
conversion.

But I didn't think about the change in the patch below.

> However I assume you mean to even ease up the conditions now, because now
> both -a as well as -A set ALL_INTO_ONE we could apply the following 
> on top of the previous.
> ---8<---
>
> From 80199368ab6c7ab72f81a5c531f79073a99d2498 Mon Sep 17 00:00:00 2001
> From: Stefan Beller <stefanbeller@googlemail.com>
> Date: Tue, 17 Sep 2013 22:11:08 +0200
> Subject: [PATCH] Further improvements by reducing nested ifs
>
> This may pass --unpacked and --unpack-unreachable to pack-objects in one
> command, which is redundant. On the other hand we may gain simplicity in
> repack.
>
> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
> ---
>  builtin/repack.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index a0ff5c7..3e56614 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -197,23 +197,23 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	if (no_reuse_object)
>  		argv_array_pushf(&cmd_args, "--no-reuse-object");
>  
> -	if (pack_everything & ALL_INTO_ONE) {
> +	if (pack_everything & ALL_INTO_ONE)
>  		get_non_kept_pack_filenames(&existing_packs);
> -
> -		if (existing_packs.nr && delete_redundant) {
> -			if (unpack_unreachable)
> -				argv_array_pushf(&cmd_args,
> -						"--unpack-unreachable=%s",
> -						unpack_unreachable);
> -			else if (pack_everything & LOOSEN_UNREACHABLE)
> -				argv_array_push(&cmd_args,
> -						"--unpack-unreachable");
> -		}
> -	} else {
> +	else {
>  		argv_array_push(&cmd_args, "--unpacked");
>  		argv_array_push(&cmd_args, "--incremental");
>  	}
>  
> +	if (existing_packs.nr && delete_redundant) {
> +		if (unpack_unreachable)
> +			argv_array_pushf(&cmd_args,
> +					"--unpack-unreachable=%s",
> +					unpack_unreachable);
> +		else if (pack_everything & LOOSEN_UNREACHABLE)
> +			argv_array_push(&cmd_args,
> +					"--unpack-unreachable");
> +	}
> +
>  	if (local)
>  		argv_array_push(&cmd_args,  "--local");
>  	if (quiet)
