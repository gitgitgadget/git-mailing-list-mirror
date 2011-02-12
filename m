From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui: give more advice when detaching HEAD
Date: Sat, 12 Feb 2011 00:42:58 -0800
Message-ID: <7voc6hy771.fsf@alter.siamese.dyndns.org>
References: <20110212070538.GA2459@sigill.intra.peff.net>
 <7v8vxlzojs.fsf@alter.siamese.dyndns.org>
 <20110212080456.GA18380@sigill.intra.peff.net>
 <7vzkq1y8dv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 12 09:43:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoB4V-0001ZT-PF
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 09:43:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932Ab1BLInM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Feb 2011 03:43:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39721 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486Ab1BLInK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Feb 2011 03:43:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1C68F2995;
	Sat, 12 Feb 2011 03:44:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HwWvlLZALUDxFKxKQ7FjmOz7X68=; b=JMvxei
	XUnYA70XGLl8yeC8C2Ciam3T3TH+dV3vnAgWUzU6JLhjJK2YEQNuBxMLaTXgmEqE
	IxJy5vo3JFvyFYTnueuc2ne0qMKCjAYwQy0C5M5Q73fTuC0B8mmCQZJ3KsaMA/pY
	zDHfeNK+GdxYckzr8E7eHD3Uq8EOM1x2CvPEM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ioBsalIUG1qsK/RproKHLIOMMvw2qd5w
	MOigHiun5Ov35vDntwRcAQINTYwaJ71BY33M40Pd5IquLkP51igJan43PDwxSJwy
	kzeo7kJThi0BtYtBfmvc29ayOrbSfcU4O1SycST85nVYOL2YyunhSlu3/E3pbgjY
	zmfX+aL+JFc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DBBC72993;
	Sat, 12 Feb 2011 03:44:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 93FD92992; Sat, 12 Feb 2011
 03:44:02 -0500 (EST)
In-Reply-To: <7vzkq1y8dv.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat\, 12 Feb 2011 00\:17\:16 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 413340E0-3684-11E0-9C79-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166605>

Junio C Hamano <gitster@pobox.com> writes:

> You only need to dig until you hit a merge base, no?
> ...
> And merge-base has an interface to compute exactly that, I think.

Ah, forget "merge-base".  In the kernel repository, the very old "v2.6.12"
will participate in the (imaginary) merge across all the refs, and
computing merge-base means we need to traverse down to it.

We only need to prime a "struct revisions" with the detached HEAD as the
sole positive, and the refs as negatives (i.e. UNINTERESTING), and walk
the history the usual way, until we either

 (1) see HEAD painted uninteresting; or
 (2) the queue becomes all uninteresting.

As soon as (1) happens, we know the HEAD is reachable from some ref, and
we can immediately stop.  When (2) happens, we inspect the HEAD again and
if it is painted uninteresting then we know HEAD is reachable from some
ref.  Otherwise HEAD will become dangling when you leave it.

That way, the traversal will terminate much sooner than computing the true
merge base.
