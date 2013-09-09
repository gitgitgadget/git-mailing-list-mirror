From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 15/16] index-pack: use nr_objects_final as sha1_table size
Date: Mon, 09 Sep 2013 11:56:40 -0700
Message-ID: <xmqqwqmp3jtj.fsf@gitster.dls.corp.google.com>
References: <1378652660-6731-1-git-send-email-pclouds@gmail.com>
	<1378735087-4813-1-git-send-email-pclouds@gmail.com>
	<1378735087-4813-16-git-send-email-pclouds@gmail.com>
	<alpine.LFD.2.03.1309091047510.20709@syhkavp.arg>
	<xmqq61u94zew.fsf@gitster.dls.corp.google.com>
	<alpine.LFD.2.03.1309091441540.20709@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Sep 09 20:56:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ6do-0001ia-Ax
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 20:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753890Ab3IIS4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 14:56:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46836 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751330Ab3IIS4r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 14:56:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27BB34096C;
	Mon,  9 Sep 2013 18:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gPfr5twXGZmHRf5V+uaYSmA1jU0=; b=nXkAMu
	suGjoad8Ym5qnBJSxFY7ob2wcIW9nNkL9WmwEuRQ3rQUNFoOEDOsOCQEAKFoiqtr
	2MmaSe/UEkfjPzrVJ/YFtXn5K+/CzsQ/3tLcPobD5YjyLbYTGmgPBe8xQFupFwln
	GhdRXbd1ZCz50nFjoBVrEQRkXBC297QqEEtVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K+K7r5rT5IQ3o+14WrBBESRM5nBK99Pe
	LRZd55N37HjkalOTeKOb7859rNjR8xjVDPAHN72FAZdboAZZDf8fIi9tWhE6WFq5
	7WDZJ634Jeg4DOYD+pkEAJHna7kE9zfFqmrDzAS5fiYNllq/yT/jnDMnuUoC7JQV
	ObZRYCNu6tE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8F7A4096A;
	Mon,  9 Sep 2013 18:56:46 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 969A840955;
	Mon,  9 Sep 2013 18:56:43 +0000 (UTC)
In-Reply-To: <alpine.LFD.2.03.1309091441540.20709@syhkavp.arg> (Nicolas
	Pitre's message of "Mon, 09 Sep 2013 14:46:54 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 91A5B476-1981-11E3-9D3F-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234358>

Nicolas Pitre <nico@fluxnic.net> writes:

>> > ...  I was 
>> > wondering if some kind of prefix to the pack stream could be inserted 
>> > onto the wire when sending a pack v4.  Something like:
>> >
>> > 'T', 'H', 'I', 'N', <actual_number_of_sent_objects_in_network_order>
>> >
>> > This 8-byte prefix would simply be discarded by index-pack after being 
>> > parsed.
>> >
>> > What do you think?
>> 
>> I do not think it is _too_ bad if the meter jumped from 92% to 100%
>> when we finish reading from the other end ;-), as long as we can
>> reliably tell that we read the right thing.
>
> Sure.  but eventually people will complain about this.  So while we're 
> about to introduce a new pack format anyway, better think of this little 
> cosmetic detail now when it can be included in the pack v4 capability 
> negociation.

Oh, I completely agree on that part.  When we send a self-contained
pack, would we send nothing?  That is, should the receiving end
expect and rely on that the sending end will send a thin pack and
never a fat pack when asked to send a thin pack (and vice versa)?

Also should we make the "even though we have negotiated the protocol
parameters, after enumerating the objects and deciding what the pack
stream would look like, we have a bit more information to tell you"
the sending side gives the receiver extensible?  I am wondering if
that prefix needs something like "end of prefix" marker (or "here
comes N-bytes worth of prefix information" upfront); we probably do
not need it, as the capability exchange will determine what kind of
information will be sent (e.g. "actual objects in the thin pack data
stream").
