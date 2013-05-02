From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] lookup_object: prioritize recently found objects
Date: Thu, 02 May 2013 08:46:08 -0700
Message-ID: <7vzjwd1j27.fsf@alter.siamese.dyndns.org>
References: <20130501203449.GA12535@sigill.intra.peff.net>
	<51820B37.8010503@viscovery.net>
	<20130502064630.GA15208@sigill.intra.peff.net>
	<5182101D.4050807@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Duy Nguyen <pclouds@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 02 17:46:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXvi3-0001vc-Ui
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 17:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758155Ab3EBPqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 11:46:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39475 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755626Ab3EBPqL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 11:46:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3C6319C30;
	Thu,  2 May 2013 15:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Svx2Qv6qQZ7y/zKChM2u12ToyNY=; b=afyY4H
	6p2qXBtyQXWDOjORMo1p67whCzQ5CKT80T4or89DkKmolVYXc2R5jAWWlsXdiB44
	vhUHbIuUa3cufkFg+OfYqYKlhKDlHQipq0FC6i6JZd3sqE4Gi7U0YqNtA0BjhZ5M
	SFhNCc8eWqY1kH24In+PUH/6s5PPJzhvGvIpw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hN5GEFT5of8A9TMZ4rkhL1eCV3AmfJrf
	SUVOZh8AM3B4lvCKa+7wE01ineLXQ/Pl5KpdMS7/pRL1G4sCx0rdUsAxaCPgACag
	dR00KT0UldKNlGaSN+c+Thqgt51T+g5xk8awYmHo/4A+Zt0eEXCEMuUYA+WyZB1t
	yi5AyFSwC9Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA19B19C2F;
	Thu,  2 May 2013 15:46:10 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2736119C2E;
	Thu,  2 May 2013 15:46:10 +0000 (UTC)
In-Reply-To: <5182101D.4050807@viscovery.net> (Johannes Sixt's message of
	"Thu, 02 May 2013 09:05:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 69133E64-B33F-11E2-95E4-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223215>

Johannes Sixt <j.sixt@viscovery.net> writes:

> BTW, do you notice that the function is now modifying an object (the hash
> table) even though this is rather unexpected from a "lookup" function?

At the philosophical level, "lookup" ought to be operating on a
"const" table.  But at the implementation level, the table does not
have to be "const" in the sense the implemenation language and data
structure defines.

I think this patch is a good example of that.

I am kind of surprised that Jeff's attempt to do a full LRU made
things worse, though.  The only additional code compared to swap is
a single memmove(): are we colliding too often (having to move a
lot)?
