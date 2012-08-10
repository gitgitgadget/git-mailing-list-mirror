From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] do not send client agent unless server does first
Date: Fri, 10 Aug 2012 12:45:19 -0700
Message-ID: <7vd32yjzu8.fsf@alter.siamese.dyndns.org>
References: <20120810075342.GA30072@sigill.intra.peff.net>
 <20120810075743.GB8399@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 10 21:45:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szv9K-0007Df-Dm
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 21:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758050Ab2HJTpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 15:45:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59714 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752664Ab2HJTpX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 15:45:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 339298EBD;
	Fri, 10 Aug 2012 15:45:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tEIxncUceJxSlT4/kwsCGJOXUVk=; b=muCQ9x
	5mLlNG7Z40eod5NvC+vr1hixYaKXv3qiTuqdR6mSJEyNdFgSLtI2i+GUjBYjoiek
	JINAgPdeeMOjfAH0ksZNwwcdkKKhTzDJc5ZvOZPA1UUBuVpghzkhV1B4TDAz0m08
	qsLS3g3sDqNFHdsa03+nkjQpnErroSRS2QzQE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BOc+HQI4UKRFColF9hFYi5/xbpVqqGYG
	B9BENiP5QMslzN1uDf/OKGBh7BFymlco+FkUeL2rsUBoXhBBgj92QXgFwtYyCZ/w
	EBuwBvDcSKpuzYJJuAlbV+l7FGgNGWrIDGRQQqgnsoYY0vZTwqF7T0QlxPSSdwPB
	4D28+WfGZQA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2236B8EBC;
	Fri, 10 Aug 2012 15:45:22 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 779448EBB; Fri, 10 Aug 2012
 15:45:20 -0400 (EDT)
In-Reply-To: <20120810075743.GB8399@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 10 Aug 2012 03:57:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EB117C9C-E323-11E1-A540-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203252>

Jeff King <peff@peff.net> writes:

> Instead, each client must record whether we saw an agent
> string from the server, and respond with its agent only if
> the server mentioned it first.

Just a couple of minor comments.

> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> index fe56596..bc7a0f9 100644
> --- a/builtin/fetch-pack.c
> +++ b/builtin/fetch-pack.c
> @@ -19,6 +19,7 @@ static int prefer_ofs_delta = 1;
>  static int no_done;
>  static int fetch_fsck_objects = -1;
>  static int transfer_fsck_objects = -1;
> +static int agent_supported;
>  static struct fetch_pack_args args = {
>  	/* .uploadpack = */ "git-upload-pack",
>  };

This is only set to false once per process invocation.  We do not
currently talk with more than one remote from the same process in
the "fetch" codepath, and we must maintain that. This fix will be
broken otherwise ("recursive submodule fetch" comes to mind; one
more reason it should do its submodule business in a separate
process).

> @@ -328,7 +329,8 @@ static int find_common(int fd[2], unsigned char *result_sha1,
>  			if (args.no_progress)   strbuf_addstr(&c, " no-progress");
>  			if (args.include_tag)   strbuf_addstr(&c, " include-tag");

This codepath still forgets to check if the other side advertised
"thin-pack", "no-progress", and "include-tag", no?

>  			if (prefer_ofs_delta)   strbuf_addstr(&c, " ofs-delta");
> -			strbuf_addf(&c, " agent=%s", git_user_agent_sanitized());
> +			if (agent_supported)    strbuf_addf(&c, " agent=%s",
> +							    git_user_agent_sanitized());
> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> index 5c69995..7d05064 100644
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -252,6 +252,7 @@ int send_pack(struct send_pack_args *args,
>  	int status_report = 0;
>  	int use_sideband = 0;
>  	int quiet_supported = 0;
> +	int agent_supported = 0;
>  	unsigned cmds_sent = 0;
>  	int ret;
>  	struct async demux;

This is initialied to 0 per communication, so having multiple
remote.$there.pushURL configuration variables will work correctly.
