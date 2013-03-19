From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Memory corruption when rebasing with git version 1.8.1.5 on arch
Date: Tue, 19 Mar 2013 09:02:57 -0700
Message-ID: <7vobefjs26.fsf@alter.siamese.dyndns.org>
References: <5139D76D.80703@bernhard-posselt.com>
 <20130308212831.GA9217@sigill.intra.peff.net>
 <513A7D80.5000501@bernhard-posselt.com>
 <20130309044850.GB12167@sigill.intra.peff.net>
 <513B14EC.4040504@bernhard-posselt.com>
 <20130310070505.GA15324@sigill.intra.peff.net>
 <513C7267.2090608@bernhard-posselt.com>
 <20130311051840.GB13510@sigill.intra.peff.net>
 <51484125.9000307@bernhard-posselt.com>
 <20130319134452.GA6752@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bernhard Posselt <mail@bernhard-posselt.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 19 17:03:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHz0b-0007xX-Aa
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 17:03:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755843Ab3CSQDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 12:03:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48427 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754384Ab3CSQC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 12:02:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BD80B628;
	Tue, 19 Mar 2013 12:02:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=omUeD95w6jrmirnFXMdImRA+x0w=; b=Db147m
	gYB5Sk6o5Ag5wKvavp66a6yRHdAckTfpGH9aUE5vnfOo2HYIrB05mGUchMMo5PwN
	+TGIKFdVk3wn8ilqVxZ7dnWo4i4/tzhXdt4qtjLHCevx369qurosezx+ARjVfX00
	mZRaxoDRGWAkLdzANwdkpRRA9xv7uBWYPar0w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yJTtp8b/MdhXXXOPknMvR1vjiUjJbu1Z
	6xGqtesht3js/6LUTJWYQFaU1yuhPp6wff+BPJD5x8CrgZ46UmzyThbLrF7hjmQ9
	lTBDy5J3R5pEUUAWEnfeKpOa7cb4WPrNbwFKWylqCNrZkyl/uGJ3C0mu82g8fVJg
	weDrT3YVwiw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E85EB626;
	Tue, 19 Mar 2013 12:02:59 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A4AD4B625; Tue, 19 Mar 2013
 12:02:58 -0400 (EDT)
In-Reply-To: <20130319134452.GA6752@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 19 Mar 2013 09:44:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7804BEC4-90AE-11E2-A804-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218533>

Jeff King <peff@peff.net> writes:

> and so on. I haven't quite figured out what is going on. It looks like
> we call update_pre_post_images with postlen==0, which causes it to just
> write the fixed postimage into the existing buffer. But of course the
> fixed version is bigger, because we are expanding the tabs into 8
> spaces (but it _doesn't_ break if each line starts with only one tab,
> which confuses me).

I used to be intimately familiar with the update_pre_post_images()
function, but the version after 86c91f91794c (git apply: option to
ignore whitespace differences, 2009-08-04), I won't vouch for it
doing anything sensible.  We recently had to do 5de7166d46d2
(apply.c:update_pre_post_images(): the preimage can be truncated,
2012-10-12) to fix one of its corner cases but I would not be
surprised if there are other cases the function gets it all wrong.

I'd come back to the topic after I finish other tasks on my plate,
so if somebody is inclined please go ahead digging this a bit
further; I won't have much head start to begin with in this code
X-<.
