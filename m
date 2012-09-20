From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] remote-curl: let users turn off smart http
Date: Thu, 20 Sep 2012 11:36:34 -0700
Message-ID: <7vzk4ka6dp.fsf@alter.siamese.dyndns.org>
References: <20120920165938.GB18655@sigill.intra.peff.net>
 <20120920170517.GB18981@sigill.intra.peff.net>
 <7va9wkbmyc.fsf@alter.siamese.dyndns.org>
 <20120920181231.GA19204@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 20 20:36:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TElcE-0006GT-F9
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 20:36:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753683Ab2ITSgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 14:36:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59043 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753658Ab2ITSgh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 14:36:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37F5D9693;
	Thu, 20 Sep 2012 14:36:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y/Jigf6uYWocx2sdmws0vqIk/18=; b=rKZ5L3
	yTwsABkE4+B4p9Mn3j45hzgjidQbWvwKY+PijyVRa9lksE66Wkt+KWABNebXVcj+
	Q72m+53QHC8NCW6vmzE8McFx5jc23kB4iun2pjxU+2k8P3gggURME/vMMdj31e1A
	NcU9gTW+CSLdNEFHztxatgPsuj00Xqq4uVhWU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TwstzkbeMBt3iRN6J9BWsKuTD+vgNFL3
	hGfmHLPgLZevk1omH4MZugfNdRlmHokD90mQ7jFs4bB0syWu3mzkX/3HAcsbAQf8
	Xxq4XdozpWS0dq6It5LL8SqHM3hgPDrLzktrS9Btl+RwWWkNdARkkov8tPxtb7dO
	TEbN4FNMlH0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23FD39692;
	Thu, 20 Sep 2012 14:36:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7E301968F; Thu, 20 Sep 2012
 14:36:35 -0400 (EDT)
In-Reply-To: <20120920181231.GA19204@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 20 Sep 2012 14:12:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1B5448A0-0352-11E2-9726-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206069>

Jeff King <peff@peff.net> writes:

> On Thu, Sep 20, 2012 at 10:53:15AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > I added the config item as remote.foo.smarthttp. You could also allow
>> > "http.$url.smart" (and just "http.smart", for that matter), which could
>> > be more flexible if you have multiple remotes pointing to the same
>> > broken server.
>> 
>> What would the user experience be when we introduce "even smarter"
>> http server protocol extension?  Will we add remote.foo.starterhttp?
>
> I would hope that it would actually be negotiated reliably at the
> protocol level so we do not have to deal with this mess again.

The original dumb vs smart was supposed to be "negotiated reliably
at the protocol level", no?  Yet we need this band-aid, so...

>> Perhaps
>> 
>>     remote.$name.httpvariants = [smart] [dumb]
>> 
>> to allow users to say "smart only", "dumb only", or "smart and/or
>> dumb" might be more code but less burden on the users.
>
> I don't mind that format if we are going that direction, but is there
> anybody who actually wants to say "smart only?"

With 703e6e7 reverted, we take a failure from the initial smart
request to mean the server is simply not serving, so "smart only" to
fail quickly without trying dumb fallback is not needed.  "smart
only" to say "I wouldn't want to talk to dumb-only server---I do not
have infinite amount of time, and I'd rather try another server" is
still a possibility, but likely not worth supporting.
