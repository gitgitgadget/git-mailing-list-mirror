From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git tag --contains : avoid stack overflow
Date: Wed, 23 Apr 2014 14:05:47 -0700
Message-ID: <xmqqfvl3ycwk.fsf@gitster.dls.corp.google.com>
References: <20140416141519.GA9684@camelia.ucw.cz>
	<20140416154653.GB4691@sigill.intra.peff.net>
	<alpine.DEB.1.00.1404171902010.14982@s15462909.onlinehome-server.info>
	<20140417213238.GA14792@sigill.intra.peff.net>
	<alpine.DEB.1.00.1404172347440.14982@s15462909.onlinehome-server.info>
	<20140417215817.GA822@sigill.intra.peff.net>
	<20140423075325.GA7268@camelia.ucw.cz>
	<xmqqeh0nzwq9.fsf@gitster.dls.corp.google.com>
	<20140423191628.GA20596@sigill.intra.peff.net>
	<xmqqk3afydq2.fsf@gitster.dls.corp.google.com>
	<20140423205533.GA20582@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stepan Kasal <kasal@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 23 23:05:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd4Mf-0007He-Ul
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 23:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757985AbaDWVFy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 17:05:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51671 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752767AbaDWVFx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 17:05:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74B417FA3D;
	Wed, 23 Apr 2014 17:05:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mOp4dlMN6wMbjeHQNzM2vVbrauA=; b=bTAp0t
	E4a012+JtEWTalro1lBFyGKFKa0ADTHexxpO9U+FBbwpbjjlx0mPpesyeA7Xqe5M
	bop8Gji/HhCQyYjo8u2xVkdu215CalTaAVF9ObS1NqMU5Az0VMuAG8BLe8ddgtuU
	R/5Nk6mYleKtOfFeNpKGP8DeLN+BBAP1aJAsU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HiBIbo5j1hvTP0xS4J11KdNoCu33TXV3
	rMMobVqe4ouc/tXHAmQGWwHBIatx05ybukm1/WDqasCmEvfg9AbpejF7V1BbmqC6
	XAXI4UhhnJTl+zvrfam8WAQuz2MC3RPGw5rymkFM7NUD5U3UmmLXCeroRJTBv+9o
	IdR0sjFCcOk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5865B7FA3C;
	Wed, 23 Apr 2014 17:05:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C42B7FA36;
	Wed, 23 Apr 2014 17:05:50 -0400 (EDT)
In-Reply-To: <20140423205533.GA20582@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 23 Apr 2014 16:55:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0C87746C-CB2B-11E3-83B3-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246895>

Jeff King <peff@peff.net> writes:

> On Wed, Apr 23, 2014 at 01:48:05PM -0700, Junio C Hamano wrote:
>
>> > I don't think so. The point is that we _must_ use bash here, not any
>> > POSIX shell.
>> 
>> Sorry, but I do not understand.  Isn't what you want "any POSIX
>> shell with 'ulimit -s 64' supported"?
>
> Sure, that would be fine, but the original patch which started this
> thread claimed that bash was required. I had assumed that to be true,
> but it seems like it's not:
>
>>     $ dash -c 'ulimit -s && ulimit -s 64 && ulimit -s'
>>     8192
>>     64
>
> If we are just using the same shell we are already running, then why
> invoke it by name in the first place? IOW, why not:
>
>   run_with_limited_stack () {
> 	(ulimit -s 64 && "$@")
>   }

That is certainly more preferrable than an explicit "run this piece
with $SHELL_PATH".

I think the choice between "Any bash that is on user's PATH" vs "The
shell the user told us to use when working with Git" is a trade-off
between

 - those who choose a shell that does not support "ulimit -s" to
   work with Git (which is fine, because our scripted Porcelains
   would not have any need for that); for these people, this test
   would be skipped unnecessarily if we insist on SHELL_PATH; and

 - those who run on a box without any bash on their PATH, chose a
   shell that is not bash but does support "ulimit -s" as their
   SHELL_PATH to build Git with; for these people, this test would
   be skipped unnecessarily if we insist on "bash".

and I do not think of a good reason to favor one over the other.

If I have to pick, I'd take your "don't name any shell, and let the
current one run it" approach, solely for the simplicity of the
solution (it ends up favoring the latter class of people as a
side-effect, though).
