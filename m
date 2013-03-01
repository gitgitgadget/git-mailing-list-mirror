From: Junio C Hamano <gitster@pobox.com>
Subject: Re: two-way merge corner case bug
Date: Fri, 01 Mar 2013 15:49:23 -0800
Message-ID: <7va9qmel4s.fsf@alter.siamese.dyndns.org>
References: <7v7glun8kt.fsf@alter.siamese.dyndns.org>
 <20130226201820.GD13830@sigill.intra.peff.net>
 <7vwqtulplp.fsf@alter.siamese.dyndns.org>
 <20130301092201.GA17254@sigill.intra.peff.net>
 <7va9qngisg.fsf@alter.siamese.dyndns.org>
 <20130301223612.GA862@sigill.intra.peff.net>
 <7vppzien3i.fsf@alter.siamese.dyndns.org>
 <20130301230845.GA7317@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 02 00:49:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBZi4-00014O-EC
	for gcvg-git-2@plane.gmane.org; Sat, 02 Mar 2013 00:49:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957Ab3CAXt1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 18:49:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48240 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751448Ab3CAXt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 18:49:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCD78A66C;
	Fri,  1 Mar 2013 18:49:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+DJnkZP8wOxipismMF8l4I1Ne/I=; b=V7LdW/
	j42bgaTcTbex/zw/o4y5bYr73konQl+29NQF9v4mh8DNgRjHeFXHVBGlm0xdlol/
	kXi41PM+vPMfii4icSrB8SiyuubUDZsg9yJqBIMM5VDj19wJvhQmmHxWc5pdS/0c
	JhIKvUjMMqXGg7aMCVgvXq2QVLlZZNi/4I2U8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JDU2AnhivNHcb+/sFTQFIeavd9202BXe
	waI9MmMoxTSgoIMWdFw/JKqmLI4sIlpONnvGEdK67ppYb92fx4bEzOsSHCqlCcMY
	QwUp+fwdTDJgaZiYGsnRXpHNINC2gb8elcNBWUg7VvpgdnNjj8pAGv78e2sQQ59z
	XCOmPCGN1Jc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF000A66B;
	Fri,  1 Mar 2013 18:49:25 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 25EE2A669; Fri,  1 Mar 2013
 18:49:25 -0500 (EST)
In-Reply-To: <20130301230845.GA7317@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 1 Mar 2013 18:08:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A5D383A4-82CA-11E2-8EFC-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217309>

Jeff King <peff@peff.net> writes:

>> I actually was wondering if we can remove that sole uses of two-way
>> merge with --reset -u from "git am" and replace them with something
>> else.  But we do want to keep local change that existed before "am"
>> started, so we cannot avoid use of two-way merge, I guess...
>
> Yeah, I think that is a case we definitely want to keep, as it means any
> intermediate work done by the user in applying the patch is not lost.

I am not sure what you mean by "intermediate" here.  When the user
attempts to resolve conflict in a path manually and gives up, we do
want to revert changes to such a path to that of HEAD.

Clarifying the semantics of "--reset" needs to be done carefully.

I think any difference "git diff --cached" shows are fair game to
revert to HEAD.  In the earlier example, path "Z" that was created
by recursive merge in an attempt to rename "A" should be removed,
and path "A" should be recreated to that of HEAD, as we know at the
point of "am --skip/--abort" that these two paths were involved in
the recursive merge invoked by the patch application process (that
is the only possible reason why these are different in the index
from HEAD).  Also any conflicting entries can only come from
three-way merge and they should be reverted to that of HEAD.

On the other hand, the paths that appear in "git diff" (except for
those that appear in "git diff --cached", which we will revert to
HEAD following the logic of the previous paragraph) must be kept.
They are changes that were already present in the working tree
before the user decided to accept a trivial patch via "am" that does
not overlap with what the user was doing.  We allow a dirty working
tree but disallow a dirty index when "git am" starts, exactly
because we want to ensure this property.

By doing both of the above, we should be able to satisfy the user
who uses "am --abort/--skip", in order to restore paths that were
involved in the failed attempt to three-way merge to revert back to
that of HEAD, while keeping unrelated changes that were present
before "am" started.
