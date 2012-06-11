From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] transport: unify ipv4 and ipv6 code paths
Date: Mon, 11 Jun 2012 11:59:19 -0700
Message-ID: <7v62ax7jzs.fsf@alter.siamese.dyndns.org>
References: <20120308124857.GA7666@burratino>
 <CABPQNSb9EGOgHb7NtsEtDh2QkjkHYn7YemYsa8Yaqyuce-aDMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Eric Wong <normalperson@yhbt.net>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Jun 11 20:59:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se9pm-0005HS-5u
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 20:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029Ab2FKS7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 14:59:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49985 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751381Ab2FKS7V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 14:59:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61E458FD5;
	Mon, 11 Jun 2012 14:59:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5XQwEMyoOnYsYplJ018IEpqOkbQ=; b=KejUqw
	fvDfyVqMx6sGFvtyeuEh9EqzvBuPB2pfGk1lnOCR5jHUOof1+MhVICIr0k1ejAwv
	zp27HSSZMwffESSNv1AHXqUfXglFBSAUAFfpgC+pZhxTPOMVf1qRcwrHTRmB3HZr
	cjI+qxicQM4tiGDV9+MQOh2OhsuT8dQs5I4dE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qq8fiFYUbZyb7MwsfcowRjCemXyo5bBu
	qMWpWot3UEPMQv3l5Ge1b76LhyBzdkG3h37LpiWiVITXIehum9/NZ+JAum6kgRll
	SGKYw0JUWRglx3hdVilwe/hjpP1GbGiEK3KK8hmQi7b6o1xg7KXyieFRrRkHIhBv
	PEOSQLUzz2M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 555868FD4;
	Mon, 11 Jun 2012 14:59:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D71328FD2; Mon, 11 Jun 2012
 14:59:20 -0400 (EDT)
In-Reply-To: <CABPQNSb9EGOgHb7NtsEtDh2QkjkHYn7YemYsa8Yaqyuce-aDMw@mail.gmail.com> (Erik
 Faye-Lund's message of "Mon, 11 Jun 2012 20:12:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8D6E2050-B3F7-11E1-B4FD-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199700>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> On Thu, Mar 8, 2012 at 1:48 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Hi,
>>
>> These patches eliminate some ifdef-ery concerning NO_IPV6.  I used
>> them when writing the SRV patch, which applies on top, but it's
>> probably best to think of it as an independent topic.
>>
>> Patch 4 is the heart of the series.  It provides an interface similar
>> to getaddrinfo that can be implemented on top of either gethostbyname
>> or getaddrinfo and puts each implementation in a separate file.  This
>> way, callers can just use the common API and they do not need to have
>> two copies of their code, one for each host resolution API.
>>
>> Patches 1-3 move code around until all the code that patch 4 touches
>> is in one place.
>>
>> Patches 5 is a potential error handling improvement noticed while
>> writing patches 1-4.  It's probably not actually needed but it was a
>> comfort to me.
>>
>> These patches have been in use in Debian since June of last year.  I'd
>> like to see this in mainline early in the 1.7.11 cycle to make coding
>> that touches this area during that cycle more pleasant.  Thoughts of
>> all kinds welcome.
>
> What happened to this series?

Yeah, what happened to it?  I was looking at the diff files Ubuntu
applies when generating its recent .deb files, and noticed these
patches today, and was wondering what was going on.
