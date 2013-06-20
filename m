From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] log: --author-date-order
Date: Thu, 20 Jun 2013 12:36:21 -0700
Message-ID: <7v61x8tw0a.fsf@alter.siamese.dyndns.org>
References: <1370581872-31580-1-git-send-email-gitster@pobox.com>
	<1370820277-30158-1-git-send-email-gitster@pobox.com>
	<1370820277-30158-5-git-send-email-gitster@pobox.com>
	<20130610055014.GF3621@sigill.intra.peff.net>
	<7vobbel8ib.fsf@alter.siamese.dyndns.org>
	<20130610184918.GC2084@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Elliott Cable <me@ell.io>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 20 21:36:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upkej-0000mx-Q4
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 21:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965908Ab3FTTgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 15:36:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46205 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965491Ab3FTTgY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 15:36:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F31E529638;
	Thu, 20 Jun 2013 19:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M4Q/NOKV54L0K+D2lUSs7gJvb0Y=; b=Ctu+/0
	cA1HHu4uqpwjAiTKjQmIsh+7zUMFlkMViK2fxL/aCV6uDRLG/Zg8ycJWKPnT/bOW
	kzkmFCXD7E4+RaMOpLMVRroDbzd5RbqReaSRoF6yclMOKDkKWh85ScYE2PUX0jBs
	7cWK8+L3b/RfLrN4Tx+mLUrANYk8gOBfPRVs0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iej2b67LgkEAeASl/k+d7IjpJFmQrXND
	3Pjl7O2V7dBag0/EwllPVVCAM9oyX+K8LpiPhi4aVeR0u1a+KppZLgM5IrCA/FF4
	5vvoj2ql/rOXtXFCnxMsmWMwEAhcC2pTqpaHOXclidfNjwdI5cFiS6aTJ5fnTTYo
	VCTFWdzSUyY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7D3C29637;
	Thu, 20 Jun 2013 19:36:23 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 68FA72962A;
	Thu, 20 Jun 2013 19:36:23 +0000 (UTC)
In-Reply-To: <20130610184918.GC2084@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 10 Jun 2013 14:49:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B0AA5056-D9E0-11E2-9431-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228526>

Jeff King <peff@peff.net> writes:

>> Or we could extend parse_commit() API to take an optional commit
>> info slab to store not just author date but other non-essential
>> stuff like people's names, and we arrange that extended API to be
>> triggered when we know --author-date-order is in effect?
>
> I like the latter option. It takes a non-trivial amount of time to load
> the commits from disk, and now we are potentially doing it 2 or 3 times
> for a run (once to parse, once to get the author info for topo-sort, and
> possibly later to show it if --pretty is given; though I did not check
> and maybe we turn off save_commit_buffer with --pretty). It would be
> nice to have an extended parse_object that handled that. I'm not sure of
> the interface. Maybe variadic with pairs of type/slab, like:
>
>   parse_commit_extended(commit,
>                         PARSE_COMMIT_AUTHORDATE, &authordate_slab,
>                         PARSE_COMMIT_DONE);
>
> ?

What I had in mind actually was a custom slab tailored for each
caller that is an array of struct.  If the caller is interested in
authordate and authorname, instead of populating two separate
authordate_slab and authorname_slab, the caller declares a

	struct {
        	unsigned long date;
                char name[FLEX_ARRAY];
	} author_info;

prepares author_info_slab, and use your commit_parser API to fill
them.
