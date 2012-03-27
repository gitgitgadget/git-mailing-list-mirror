From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 2/4] remote-curl: send the refs to fetch-pack on
 stdin
Date: Tue, 27 Mar 2012 10:18:04 -0700
Message-ID: <7v8vimj73n.fsf@alter.siamese.dyndns.org>
References: <loom.20120318T083216-96@post.gmane.org>
 <m3fwd550j3.fsf@localhost.localdomain>
 <20120318190659.GA24829@sigill.intra.peff.net>
 <CACsJy8BNT-dY+wDONY_TgLnv0135RZ-47BEVMzX6c3ddH=83Zw@mail.gmail.com>
 <20120319024436.GB10426@sigill.intra.peff.net> <4F69B5F0.2060605@gmx.net>
 <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com>
 <20120321171423.GA13140@sigill.intra.peff.net> <4F715CF7.5070903@gmx.net>
 <4F715D91.5070901@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Ivan Todoroski <grnch@gmx.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 19:18:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCa2H-000605-Gb
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 19:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755270Ab2C0RSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 13:18:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50842 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755266Ab2C0RSH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 13:18:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1D625B0D;
	Tue, 27 Mar 2012 13:18:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N5hxcA2U6G3A9FfIVqn3Oh0xKAo=; b=u5Ol74
	Yg6Hk9ZAj6usm8aLq0FeQX2D5hUN+LdmWqifTda5bE3eDQJd/8CNSprnrriIfwVJ
	fGMMxMMHTD47c5RpuybORIqBaTGs6A5c6UYZo1RBEDyB4rc45musr5EIXF5BPbED
	rVqC2/TBXgL1MmqUqHG3AUJvAhrUyi4Ag8Iz4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DRjhPveccgcN9/8QYJUsaMT62xBeRtCm
	zv+yTSGlTbrCLeAOCDE9Mwic1WdkVoNMs7Krg08SEPCxiozyALXr0vhoToSGSJnO
	5aoNRbQp+QA/kuRyQiJ5cN3H/eSh37TY2sFiJ+DCCaxF+bBnf4NN7TxqyhkQz0A5
	Qa+mjRXAqPQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E92695B0C;
	Tue, 27 Mar 2012 13:18:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F1305B0B; Tue, 27 Mar 2012
 13:18:06 -0400 (EDT)
In-Reply-To: <4F715D91.5070901@gmx.net> (Ivan Todoroski's message of "Tue, 27
 Mar 2012 08:26:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D15471D2-7830-11E1-9B0D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194059>

Ivan Todoroski <grnch@gmx.net> writes:

> If a remote repo has too many tags (or branches), cloning it over the
> smart HTTP transport can fail because remote-curl.c puts all the refs
> from the remote repo on the fetch-pack command line. This can make the
> command line longer than the global OS command line limit, causing
> fetch-pack to fail.
>
> This is especially a problem on Windows where the command line limit is
> orders of magnitude shorter than Linux. There are already real repos out
> there that msysGit cannot clone over smart HTTP due to this problem.
>
> To solve this problem we teach remote-curl.c to pipe the refs to
> fetch-pack using the new --stdin option, instead of on the fetch-pack
> command line.
>
> For a more detailed discussion of the problem see the parent of this
> commit, titled "fetch-pack: new --stdin option to read refs from stdin".

Thanks.  As there is no way for this single commit to be applied without
the previous step, you could have just said:

	Now we can throw arbitrary number of refs at fetch-pack using
        its --stdin option, use it in remote-curl helper to lift the
        command line length limit.

or something ;-).

> @@ -626,6 +630,7 @@ static int fetch_git(struct discovery *heads,
>  	int nr_heads, struct ref **to_fetch)
>  {
>  	struct rpc_state rpc;
> +	struct strbuf preamble;
>  	char *depth_arg = NULL;
>  	const char **argv;
>  	int argc = 0, i, err;
> @@ -633,6 +638,7 @@ static int fetch_git(struct discovery *heads,
>  	argv = xmalloc((15 + nr_heads) * sizeof(char*));
>  	argv[argc++] = "fetch-pack";
>  	argv[argc++] = "--stateless-rpc";
> +	argv[argc++] = "--stdin";
>  	argv[argc++] = "--lock-pack";
>  	if (options.followtags)
>  		argv[argc++] = "--include-tag";
> @@ -651,23 +657,28 @@ static int fetch_git(struct discovery *heads,
>  		argv[argc++] = depth_arg;
>  	}
>  	argv[argc++] = url;
> +	argv[argc++] = NULL;
> +
> +	strbuf_init(&preamble, 4);

Curious.

If "4" does not really matter, I would drop this and use STRBUF_INIT at
the beginning instead.

>  	for (i = 0; i < nr_heads; i++) {
>  		struct ref *ref = to_fetch[i];
>  		if (!ref->name || !*ref->name)
>  			die("cannot fetch by sha1 over smart http");
> -		argv[argc++] = ref->name;
> +		packet_buf_write(&preamble, "%s\n", ref->name);
>  	}
> -	argv[argc++] = NULL;
> +	packet_buf_flush(&preamble);
>  
>  	memset(&rpc, 0, sizeof(rpc));
>  	rpc.service_name = "git-upload-pack",
>  	rpc.argv = argv;
> +	rpc.stdin_preamble = &preamble;
>  	rpc.gzip_request = 1;
>  
>  	err = rpc_service(&rpc, heads);
>  	if (rpc.result.len)
>  		safe_write(1, rpc.result.buf, rpc.result.len);
>  	strbuf_release(&rpc.result);
> +	strbuf_release(&preamble);
>  	free(argv);
>  	free(depth_arg);
>  	return err;
