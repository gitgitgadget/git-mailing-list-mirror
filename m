From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] lazily load commit->buffer
Date: Sat, 26 Jan 2013 21:32:07 -0800
Message-ID: <7vtxq3xkbs.fsf@alter.siamese.dyndns.org>
References: <51013FDD.5030004@atlas-elektronik.com>
 <CACsJy8CEofqi9S8-SDx_O+Ko0i56aRZ4KEJrVnbFum6zzsJrJg@mail.gmail.com>
 <20130124232721.GA16036@sigill.intra.peff.net>
 <7va9ry87a0.fsf@alter.siamese.dyndns.org>
 <7vzjzx7w01.fsf@alter.siamese.dyndns.org>
 <20130125055331.GC26524@elie.Belkin>
 <FE6CC927-1915-4486-BBB8-4C109F7B5295@me.com>
 <7vip6l5l71.fsf@alter.siamese.dyndns.org>
 <20130126094026.GA9646@sigill.intra.peff.net>
 <7v8v7f1vqa.fsf@alter.siamese.dyndns.org>
 <20130126221400.GA13827@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathon Mah <jmah@me.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan =?utf-8?Q?N=C3=A4we?= <stefan.naewe@atlas-elektronik.com>,
	Armin <netzverweigerer@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 27 06:32:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzKr2-0008Ct-3o
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 06:32:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695Ab3A0FcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 00:32:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58920 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751575Ab3A0FcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 00:32:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 356FF8D20;
	Sun, 27 Jan 2013 00:32:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qEuE62FHj1C6fn2vHu8aGh3msec=; b=LSPzZu
	HcYDxXcWc7T6Kt31MeBDvR3aToqoCk1ayPSth/TsSeiShmD3n7do/3kD6xVJcmdo
	nSkjlmmABhWeRvaPyPnFI0dxM/qV+O7Sxj7y2Bhv54f0y2EEnk+GRwqg5xHcImj/
	zmb5pbIdCApCi1R49RnD/0H60fJWzTcjPYb6I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gSb1ROreYoTBa90SQTVZPCvqht8BbVmY
	+RGxcrdW0sH3OC6EDli27IoNwJD7YAplcN/tHcbV9/6cZSAwN3wCOrxe8ERlLQYC
	bqwmRIi4MpNT4QyTn7hhyogAxyYhB+OXMF9OLFh6BvOIiljv8JxATZjhfjAY1S5R
	5BYa417FARs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 291028D1F;
	Sun, 27 Jan 2013 00:32:09 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A0C848D1B; Sun, 27 Jan 2013
 00:32:08 -0500 (EST)
In-Reply-To: <20130126221400.GA13827@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 26 Jan 2013 17:14:01 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E4A25B2A-6842-11E2-8A92-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214680>

Jeff King <peff@peff.net> writes:

> My HEAD has about 400/3000 non-unique commits, which matches your
> numbers percentage-wise. Dropping the lines above (and always freeing)
> takes my best-of-five for "git log -g" from 0.085s to 0.080s. Which is
> well within the noise.  Doing "git log -g Makefile" ended up at 0.183s
> both before and after.
>
> ... I'd be in favor of
> dropping the lines just to decrease complexity of the code.

I think we are in agreement, then.
