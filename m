From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 06/10] send-pack/receive-pack: Allow server to refuse
 pushes with too many commits
Date: Mon, 23 May 2011 16:39:42 -0700
Message-ID: <7vpqn9rnpd.fsf@alter.siamese.dyndns.org>
References: <1306111923-16859-1-git-send-email-johan@herland.net>
 <1306111923-16859-7-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue May 24 01:39:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOej7-0002aV-O1
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 01:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757863Ab1EWXjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 19:39:53 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46261 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757807Ab1EWXjw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 19:39:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 04B394EAD;
	Mon, 23 May 2011 19:42:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=pcgVk8EzsFPHLxsZYO7VwkhAKjE=; b=hlONYuMEN4wUBp1Dq063
	ZFXSPE2zUfr1uaftZ1H/3MhXWGrMDxIklN3IMizSWGrMh0/Q0WCiFNpLeCmDovye
	KdD6B+UhbuEYaNrOYn4fgmrk3ULLKwkkKBFhggwVHcL/ZjUbNVQmdF7cwn/vvs5F
	WOB11eHw5ByaYC9GgNOERBw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=WpSJvdAShDGCdeEsVrGs7+wLmTMtu+mQuZfzYgE7T8rBTI
	C76oQ8HCmeLSo2nTokRibjDAO2RVO7KakXUAUsEARxQw03Giwcd6jw0tTrDzgDw2
	HSyw4VgMUSlYJRd0pqfDNiDMCNSfRQC9VIjEoXBegEqLeqikulyIdDan/WOGg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C780A4EA0;
	Mon, 23 May 2011 19:41:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6F1BC4E9F; Mon, 23 May 2011
 19:41:52 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3EDAE5DA-8596-11E0-B1F2-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174293>

Johan Herland <johan@herland.net> writes:

> However, older clients that do not understand the capability will not check
> their pack against the limit, and will end up pushing the pack to the server.
> Currently there is no extra check on the server to detect a push that exceeds
> receive.commitCountLimit. However, such a check could be done in a pre-receive
> or update hook.

I found the above a reasonable thing to do. In other words, this is an
advisory configuration at this point (and from a cursory scanning of the
rest of the series, throughout the series), and that is OK.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1a060ec..c18faac 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1592,6 +1592,15 @@ receive.unpackLimit::
>  	especially on slow filesystems.  If not set, the value of
>  	`transfer.unpackLimit` is used instead.
>  
> +receive.commitCountLimit::
> +	If the number of commits received in a push exceeds this limit,
> +	then the entire push will be refused. This is meant to prevent
> +	an unintended large push (typically a result of the user not
> +	being aware of exactly what is being pushed, e.g. pushing a
> +	large rewritten history) from entering the repo. If not set,
> +	there is no upper limit on the number of commits transferred
> +	in a single push.

But then it may probably be a good idea to reword this a bit, to clarify
the refusal happens voluntarily by the pusher.  E.g.

	Tell "git push" not to push more than this many commits at once
        into this repository. This is meant to prevent ... in a single
        push. Note that older versions of "git push" may ignore this
        advisory, so if you really want to refuse such a push, you would
        need to arrange to do so in either the pre-receive hook or the
        update hook.

> diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
> index 11849a3..0240967 100644
> --- a/Documentation/technical/protocol-capabilities.txt
> +++ b/Documentation/technical/protocol-capabilities.txt
> @@ -205,5 +205,7 @@ the server. If the check fails, the client must abort the upload, and
>  report the reason for the aborted push back to the user.
>  The following "limit-*" capabilites are recognized:
>  
> + - limit-commit-count=<num> (Maximum number of commits in a pack)
> +

I think s/in a pack/to transfer/ is more appropriate.

It is a non-essential detail that the current implementation carries only
one pack in a single session between send-pack and receive-pack.  When we
update the protocol (with another capability) so that we can send more
than one packs in a single session, we would want the maximum number of
commits to be honored.

Come to think of it, I do not necessarily agree with the earlier "max
commit count can only be used with max pack size"; I can accept it if the
statement is qualified with "for now", though.

It is entirely reasonable to say that I want to split packs in 2GB chunks,
and I want to keep the number of commits in the resulting packs (notice
the plural) under this fixed ceiling to avoid mistakes, no?

> @@ -112,6 +118,9 @@ static const char *capabilities()
>  	int ret = snprintf(buf, sizeof(buf),
>  			   " report-status delete-refs side-band-64k%s",
>  			   prefer_ofs_delta ? " ofs-delta" : "");
> +	if (limit_commit_count > 0)
> +		ret += snprintf(buf + ret, sizeof(buf) - ret,
> +				" limit-commit-count=%lu", limit_commit_count);
>  	assert(ret < sizeof(buf));

Hmm, at this point wouldn't it become attractive to stop using the static
fixed sized buffer and instead start using a strbuf or something?

> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> index 5ba5262..f91924f 100644
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -49,9 +49,11 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
>  		NULL,
>  		NULL,
>  		NULL,
> +		NULL,
>  	};
>  	struct child_process po;
>  	int i;
> +	char buf[40];

40 is 19 plus terminating NUL plus 20-decimal digits to hold the count?

>  	i = 4;
>  	if (args->use_thin_pack)
> @@ -62,6 +64,11 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
>  		argv[i++] = "-q";
>  	if (args->progress)
>  		argv[i++] = "--progress";
> +	if (args->max_commit_count > 0) {
> +		snprintf(buf, sizeof(buf), "--max-commit-count=%lu",
> +			 args->max_commit_count);
> +		argv[i++] = buf;
> +	}
>  	memset(&po, 0, sizeof(po));
>  	po.argv = argv;
>  	po.in = -1;
> @@ -253,6 +260,7 @@ int send_pack(struct send_pack_args *args,
>  	unsigned cmds_sent = 0;
>  	int ret = 0;
>  	struct async demux;
> +	const char *p;
>  
>  	/* Does the other end support the reporting? */
>  	if (server_supports("report-status"))
> @@ -263,6 +271,8 @@ int send_pack(struct send_pack_args *args,
>  		args->use_ofs_delta = 1;
>  	if (server_supports("side-band-64k"))
>  		use_sideband = 1;
> +	if ((p = server_supports("limit-commit-count=")))
> +		args->max_commit_count = strtoul(p, NULL, 10);

If we find garbage in *p, we would just run with a random limit, which may
cause the pack-objects to abort, but that still is a controlled failure
and is acceptable.
