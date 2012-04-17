From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gc --aggressive
Date: Tue, 17 Apr 2012 15:34:42 -0700
Message-ID: <7vmx6am1h9.fsf@alter.siamese.dyndns.org>
References: <CAG+J_DzO=UZ56PjnSCRaTdj8pBSYc5PFofw1QHy42c5pHMK_HQ@mail.gmail.com>
 <20120417220838.GB10797@sigill.intra.peff.net>
 <7vr4vmm29z.fsf@alter.siamese.dyndns.org>
 <20120417221849.GA11936@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 00:34:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKGz4-00070K-Ad
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 00:34:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018Ab2DQWep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 18:34:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53427 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751152Ab2DQWep (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 18:34:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77C457EEB;
	Tue, 17 Apr 2012 18:34:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eon9xyLZ41YOivkoY+8UrpLrH5Q=; b=ZGr44z
	5oz+GjUHBSJznax5NJfMUrPqshYwbR1Lxm34e4Ki68WPETUCtZGnzL3YGvExcFUQ
	Og8AGz7Kk19Khp/1nlusY2i6BMyuWNOK+/wUDSJ8h59Lp1qoHcCsWuHfVRdQXAb4
	o6VBsu6qFxVYn1l2nQdy7qK1OQCfDrL81nIUo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xxFWLp/aMe/dsapVncsOrdchviyKhE8y
	GrXy/KaQnZHvXH0tq9lZrUdah3p17k/vSCDI14Aoc3CTJZ+KH2GXC59gd1FHJiQO
	wNclRXLmL/JQcIrHhDRJWNvOtw/MC6xJn1r+9u0pOvau+3phcEjThybfMEVDfKyB
	EFdEefjaocE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6ED397EEA;
	Tue, 17 Apr 2012 18:34:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0166A7EE9; Tue, 17 Apr 2012
 18:34:43 -0400 (EDT)
In-Reply-To: <20120417221849.GA11936@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 17 Apr 2012 15:18:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 877E56C8-88DD-11E1-B5CB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195823>

Jeff King <peff@peff.net> writes:

> On Tue, Apr 17, 2012 at 03:17:28PM -0700, Junio C Hamano wrote:
>
>> > How many cores are there on this box? Have you tried setting
>> > pack.windowMemory to (12 / # of cores) or thereabouts?
>> 
>> Hrm, from the end-user's point of view, it appears that pack.windowMemory
>> ought to mean the total without having to worry about the division of it
>> across threads (which the implementation should be responsible for).
>
> Agreed. I had to look in the code to check which it meant. I'm not sure
> we can change it without regressing existing users, though.

This is a tangent, but I noticed that the canned settings for "aggressive"
use an arbitrarily hardcoded value of depth=250 and window=250 (tweakable
with gc.aggressiveWindow).

Even though a shallower depth does cause base candidates with too long a
chain hanging to be evicted prematurely while it is still in window and
will lead to smaller memory consumption, I do not think the value of
"depth" affects the pack-time memory consumption too much.  But the
runtime performance of the resulting pack may not be great (in the worst
case you would have to undelta 249 times to get to the object data).  We
may want to loosen it a bit.

Also it might make sense to make the window size a bit more flexible
depending on the nature of your history (you would get bigger benefit with
larger window when your history has fine grained commits; if there are not
many few-liner commits, larger window may not help you that much).
