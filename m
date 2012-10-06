From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git pull takes ~8 seconds on up-to-date Linux git tree
Date: Fri, 05 Oct 2012 22:20:37 -0700
Message-ID: <7vobkgrxay.fsf@alter.siamese.dyndns.org>
References: <20121004141454.GA246@x4>
 <20121004184314.GA15389@sigill.intra.peff.net>
 <7v391ux7im.fsf@alter.siamese.dyndns.org>
 <7vvceqvses.fsf@alter.siamese.dyndns.org>
 <7vmx01x3s4.fsf@alter.siamese.dyndns.org>
 <7vehlcu091.fsf@alter.siamese.dyndns.org>
 <20121005232108.GA7996@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Trippelsdorf <markus@trippelsdorf.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 06 07:20:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKMoq-0003tQ-V4
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 07:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008Ab2JFFUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2012 01:20:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50395 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750835Ab2JFFUk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2012 01:20:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79C724204;
	Sat,  6 Oct 2012 01:20:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Wzx3H/pUkqCFDrelG1QsZQB3dFs=; b=I3Wa2+
	0laHP86Hfum86HpBT28ov7jaUSiGUmKXJijhtiZCW/p6IlkNwRlwzfeM8oBfUPAA
	EHY66+c1ZirJL4wyAuvmNu+/6ZYHO73lWrDLPnZSkkLcT/TWKvu9yp7rHeQoLafH
	e6N8rT8LN+eO5Gp9qA8sWScRn3IJbMigeOWDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t9B+teu7CuwedQjbqb2ZD8rZi2Y7msoU
	612KgZowMxZEUNVx5OIstp/RCTVFi0zE6cTntRcrivegsmw+7OPWH2D5WW3M5L6N
	PYCOMnD4+/zin15ftegOXdXTZ1VvfILPw5ahNBiHTq8n/yNwLasQm+P7h6R6i8dZ
	HRfmwjr/HWo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6650541F0;
	Sat,  6 Oct 2012 01:20:39 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2C4A41EF; Sat,  6 Oct 2012
 01:20:38 -0400 (EDT)
In-Reply-To: <20121005232108.GA7996@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 5 Oct 2012 19:21:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 90C13F4C-0F75-11E2-ABA9-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207129>

Jeff King <peff@peff.net> writes:

>> > @@ -617,6 +618,8 @@ static struct commit_list *paint_down_to_common(struct commit *one, int n, struc
>> >  
>> >  	one->object.flags |= PARENT1;
>> >  	commit_list_insert_by_date(one, &list);
>> > +	if (!n)
>> > +		return list;
>> >  	for (i = 0; i < n; i++) {
>> >  		twos[i]->object.flags |= PARENT2;
>> >  		commit_list_insert_by_date(twos[i], &list);
>
> This seems like an obvious optimization, but does it really have
> anything to do with the patch at hand?

The function picks one and paints it against all others, but the
logic assumes there must be at least one other to paint against;
otherwise the traversal will not ever find a node that is painted
with both PARENT1 and PARENT2 to stop, leading us to traverse all
the way down to root.
