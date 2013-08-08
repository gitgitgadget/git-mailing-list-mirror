From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] During a shallow fetch, prevent sending over unneeded objects
Date: Thu, 08 Aug 2013 10:10:59 -0700
Message-ID: <7v1u64az18.fsf@alter.siamese.dyndns.org>
References: <20130711220127.GK10217@login.drsnuggles.stderr.nl>
	<CACsJy8CP6pGRwEn6H=cbKxTMuOjzAF3=Qh8qsLbJaw6feK3NMw@mail.gmail.com>
	<7vfvukbrqh.fsf@alter.siamese.dyndns.org>
	<CACsJy8BahoGcDcLjSaHA-62_KQE2wD-p5oeJOOA4nk8ZRfXrEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthijs Kooijman <matthijs@stdin.nl>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 19:11:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7Tk4-0008NX-K8
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 19:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758051Ab3HHRLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 13:11:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61636 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758007Ab3HHRLK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 13:11:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5719D36BDB;
	Thu,  8 Aug 2013 17:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xdBqrEJYCvCq+O3q2b8XSYN46DE=; b=AmMOEM
	GHGmIxpEdCYkJYX3jy7dKbCW+86i6/cQmfmz4z6TDwJKkoXwYzq/WDFgvXEgVOPm
	ILRWPxMnYmpdP1AKzeJYHHfj1mKmBzPQjThz2T0o9BM51LoXdUVuFPBPDpOGjUNB
	rEGV3mo9FQpqytJli+Q7fCvxDr/2k5+akGc1U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LKnQW/Z1DrOHmqJPkI8/FWnaFyWMuCi9
	+ukTq/gCobzb65AWlSQcsBEThg1xDXVomDVPxnNj6LL1wZQ/qjqTSzx9I0Tr9wT1
	1xyp0O0gNjHO5XzXMXui+L+einPAN0PZbjMsezf5U5BtnkbBe50hCRtBAjdoztoF
	AygVASIiUTs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A76D36BD7;
	Thu,  8 Aug 2013 17:11:10 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6601736BCA;
	Thu,  8 Aug 2013 17:11:09 +0000 (UTC)
In-Reply-To: <CACsJy8BahoGcDcLjSaHA-62_KQE2wD-p5oeJOOA4nk8ZRfXrEA@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 8 Aug 2013 14:21:33 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 84F3CA12-004D-11E3-93DD-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231903>

Duy Nguyen <pclouds@gmail.com> writes:

> I fail to see the point here. There are two different things: what we
> want to send, and what we can make deltas against. Shallow boundary
> affects the former. What the recipient has affects latter. What is the
> twist about?

do_rev_list() --> mark_edges_uninteresting() --> show_edge() callchain
that eventually does this:

static void show_edge(struct commit *commit)
{
	fprintf(pack_pipe, "-%s\n", sha1_to_hex(commit->object.sha1));
}

was what I had in mind.

For a non-shallow transfer, feeding "-<boundary commit>" is done for
commits that we do not send (we do not do so for all of them) and
those that we know the recipient does have.  Two different things
used to be the same, but with your suggestion they are not.  Which
is a good thing but we need to be careful to make sure existing
codepaths do not conflate them and untangle ones that do if there
are any, that's all.

> As for considering objects before shallow boundary uninteresting, I
> have a plan for it: kill upload-pack.c:do_rev_list(). The function is
> created to make a cut at shallow boundary,...

Hmph, that function is not primarily about shallow boundary but does
all packing in general.

The edge hinting in there is for thin transfer where the sender
sends deltas against base objects that are known to be present in
the receiving repository, without sending the base objects.
