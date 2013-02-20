From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 08/19] write_or_die: raise SIGPIPE when we get EPIPE
Date: Wed, 20 Feb 2013 14:19:04 -0800
Message-ID: <7vfw0qy6g7.fsf@alter.siamese.dyndns.org>
References: <20130220195147.GA25332@sigill.intra.peff.net>
 <20130220200136.GH25647@sigill.intra.peff.net>
 <20130220215043.GA24236@google.com>
 <20130220215845.GB817@sigill.intra.peff.net>
 <20130220220114.GB24236@google.com>
 <20130220220359.GA1417@sigill.intra.peff.net>
 <20130220220637.GC24236@google.com>
 <20130220221248.GC817@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 20 23:19:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8I0m-0005VC-B6
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 23:19:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658Ab3BTWTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 17:19:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64642 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751373Ab3BTWTH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 17:19:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FEBEBF3E;
	Wed, 20 Feb 2013 17:19:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p2IxBFPKBgMrjEMXyBUl8yl7sO4=; b=RMVJDI
	FKge9MDubYmNgFm2PrhcWPPkXkWy7wVkYGSgSGCKzFYxA6GLFzECU8bJOC0bG4qK
	5zEfscJ92oe17rXsamKGYTyAg+sRnYSrwCvjfl6ZsBnu6iXhIFd4KdMOSt0VO9Uj
	wpkXCl11YXI31cXF2cHD0G/9Br/6kX8HUd6L0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wzKtQzVFoihprvTN/gy9bk8tSmTVp5qD
	q8p0sShSWUID8ILPEX59TnFRBt/3HLTvcsH2JiNafs6z8lvOTA1W+WMeKUBUIbkp
	wrBAOMflG2koPcILL09EdK6JfPpjl+YWCoVmpVhb+AxPDaqA4Xibhkbvbq11q40V
	XY+ubHTPi8s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84611BF3D;
	Wed, 20 Feb 2013 17:19:06 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F20DBBF3B; Wed, 20 Feb 2013
 17:19:05 -0500 (EST)
In-Reply-To: <20130220221248.GC817@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 20 Feb 2013 17:12:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8A08FB84-7BAB-11E2-A2C1-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216744>

Jeff King <peff@peff.net> writes:

> I am more concerned that the assertion is not "oops, another thread is
> doing something crazy, and it is a bug", but rather that there is some
> weird platform where SIG_DFL does not kill the program under SIGPIPE.
> That seems pretty crazy, though. I think I'd squash in something like
> this:
>
> diff --git a/write_or_die.c b/write_or_die.c
> index b50f99a..abb64db 100644
> --- a/write_or_die.c
> +++ b/write_or_die.c
> @@ -5,7 +5,9 @@ static void check_pipe(int err)
>  	if (err == EPIPE) {
>  		signal(SIGPIPE, SIG_DFL);
>  		raise(SIGPIPE);
> +
>  		/* Should never happen, but just in case... */
> +		error("BUG: SIGPIPE on SIG_DFL handler did not kill us.");
>  		exit(141);
>  	}
>  }
>
> which more directly reports the assertion that failed, and degrades
> reasonably gracefully. Yeah, it's probably overengineering, but it's
> easy enough to do.

Yeah, that sounds like a sensible thing to do, as it is cheap even
though we do not expect it to trigger.
