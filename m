Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8039747F
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 00:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yUhVznTv"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3CFA91D493D;
	Thu, 11 Jan 2024 19:40:27 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=UFYjo4xDTHAQL9HiuNgu+EldPxLm2UtFVPD40m
	hh5ZQ=; b=yUhVznTvpUz3lwkqv30VehoiI2p1oY/0wjCtFQ05Nied1UWuclUUAn
	hAyiyC19pzZjZsDcSfxTYxlKwrm8xL2XgKvuLs9zgX2WkbNFhHFerZQFCEmdq2y7
	i/se7fMchJSC7XNKRTO4ukSIT9n532iy1opahC8uBKv4BJbbdA5cg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 358081D493C;
	Thu, 11 Jan 2024 19:40:27 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9B6E61D493A;
	Thu, 11 Jan 2024 19:40:26 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Lohmann <mi.al.lohmann@gmail.com>
Cc: git@vger.kernel.org,  phillip.wood123@gmail.com,
  phillip.wood@dunelm.org.uk,  wanja.hentze@bevuta.com
Subject: Re: [PATCH v3] builtin/revert.c: refactor using an enum for cmd-action
In-Reply-To: <20240111200627.64199-1-mi.al.lohmann@gmail.com> (Michael
	Lohmann's message of "Thu, 11 Jan 2024 21:06:27 +0100")
References: <xmqqsf33fy3t.fsf@gitster.g>
	<20240111200627.64199-1-mi.al.lohmann@gmail.com>
Date: Thu, 11 Jan 2024 16:40:25 -0800
Message-ID: <xmqqttnjcrk6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2DBD88F8-B0E3-11EE-B422-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Michael Lohmann <mi.al.lohmann@gmail.com> writes:

> -	if (cmd == 'c')
> +	case ACTION_CONTINUE:
>  		return sequencer_continue(the_repository, opts);
> -	if (cmd == 'a')
> +	case ACTION_ABORT:
>  		return sequencer_rollback(the_repository, opts);
> -	if (cmd == 's')
> +	case ACTION_SKIP:
>  		return sequencer_skip(the_repository, opts);
> -	return sequencer_pick_revisions(the_repository, opts);
> +	case ACTION_START:
> +		return sequencer_pick_revisions(the_repository, opts);
> +	}
>  }

This change broke the build when merged to 'seen' like so ...

builtin/revert.c: In function 'run_sequencer':
builtin/revert.c:242:1: error: control reaches end of non-void function [-Werror=return-typ ]
  242 | }
      | ^
 
... so I'm discarding
it out of my tree and redoing today's integration cycle.

Different compilers are smart in different ways, and we shouldn't
overly rely on the fact that some compilers may be happy by seeing a
switch that has all the enum values and notice that one of the return
will be triggered in its case arms.



