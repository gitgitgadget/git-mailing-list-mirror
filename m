From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 3/7] show: honor --textconv for blobs
Date: Sat, 11 May 2013 12:54:27 -0700
Message-ID: <7vhai9wavg.fsf@alter.siamese.dyndns.org>
References: <7vy5c1l6nb.fsf@alter.siamese.dyndns.org>
	<c4ed1e0b67877e6453b8c269290e09e1672ce37d.1368197380.git.git@drmicha.warpmail.net>
	<7vy5bm22f8.fsf@alter.siamese.dyndns.org>
	<20130510173434.GA3154@sigill.intra.peff.net>
	<7vfvxu1zla.fsf@alter.siamese.dyndns.org>
	<20130511002504.GA4849@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 11 21:54:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbFsU-0000Mf-U8
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 21:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753831Ab3EKTyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 15:54:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56593 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753471Ab3EKTya (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 15:54:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E35E01EDC0;
	Sat, 11 May 2013 19:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ocyrqHf3P9ADy6OgIJcA5XTcmlE=; b=w3Ynj+
	heRbRlmr6PEWlUFCbpeQO/NXzUrKsp0LffdV6ZDkahw8AoCa/nEBgr8CQQFCzMcM
	dQQCDMtvMGhn01y/GCCDCpoWQGtevBr/w/wjSYJmgxWK4ZSSZksdsptRGVAJjI2k
	Ynl0EizAbGF13JIhbcQm2QXtaV/DZ8DzS4pFI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qypPrnrq+4Ft5M7uP6IiyavajGomBcDk
	AABTphdLChaeOwGluwPntZ3/0C29aJXbvUcGh6qaBLNALDHWVUE64mO/d1T3q0zE
	fE2Dbzb+BqA96pXU9SQD5QjPdz4cAzLP94r+ldmtVhzpwCuCKM+Asp2Rp8EqBMT2
	OQK4uoFVHzI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D71C31EDBF;
	Sat, 11 May 2013 19:54:29 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 53DC81EDBE;
	Sat, 11 May 2013 19:54:29 +0000 (UTC)
In-Reply-To: <20130511002504.GA4849@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 11 May 2013 02:25:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9765F25C-BA74-11E2-9AC0-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224005>

Jeff King <peff@peff.net> writes:

> On Fri, May 10, 2013 at 11:04:01AM -0700, Junio C Hamano wrote:
>
>> One thing to notice is that those accessing rev->pending before
>> calling prepare_revision_walk(), as opposed to those receiving
>> objects in rev->commits via get_revision(), are the only ones that
>> care about the context and wants to act differently depending on
>> where these came from and how they were specified.
>> 
>> That suggests at least two possibilities to me:
>> 
>>  - Perhaps we can place the context in rev->pending and clear them
>>    when prepare_revision_walk() moves them to rev->commits, without
>>    introducing rev->keep_object_context?
>> 
>>  - Perhaps instead of extending object-array, we can move this kind
>>    of information to rev_cmdline and enrich that structure?
>
> Without looking too closely to see whether it is feasible, I would think
> the latter would end up being much more elegant, since I think it
> already deals with some allocation issues already.

Yeah. I am fairly reluctant to apply a change that makes entries in
object-array larger.
