From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fix potential hang in https handshake.
Date: Fri, 19 Oct 2012 10:02:48 -0700
Message-ID: <7vpq4ejsxz.fsf@alter.siamese.dyndns.org>
References: <5080761e.IEDySUuQzlCwL6fM%szager@google.com>
 <7vd30fl736.fsf@alter.siamese.dyndns.org>
 <20121019103627.GA29366@sigill.intra.peff.net>
 <CAJo=hJvWV0WPN5rCYK-JxfaEPWp7syUM1H0w4=Eb27=50+pXjg@mail.gmail.com>
 <CAHOQ7J9W8FdKqzqbuDqj4bcFyN02kUigWtbL_xCen-PYWF9LUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, sop@google.com
To: Stefan Zager <szager@google.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 19:03:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPFyR-0007Sc-Qt
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 19:03:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756830Ab2JSRCw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2012 13:02:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33587 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752135Ab2JSRCv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2012 13:02:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A7D99243;
	Fri, 19 Oct 2012 13:02:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Iqr/5Ofn/ThkORNhD1gX8IAWYrY=; b=bCMNNk
	SRU7prTHbOcq/rnh9uI4duiWxCnSiyjK9gsv3ktx621cqkpesmO/b1SymK7WdZzJ
	OcVb3mklTdeqPmdPfhKO0E5jRYTQBaZa+avk62PEwT26PQyPof9iun/lLcgVagah
	yv+mVRNLDMo28yPTmohoUrOPGp6V4gkXMWRN8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n6/xpvclxiY5E68+xtSrlbGYvTHH945n
	bBCMvc/2A5Ay1JboB8/DFgkmdegg3/qLOfAH8L352qF/Hh8Xk4aRR9u8anNbVq9A
	IsRMTIJDdslVk3MuDePj0YvoSVORCQidBPmGGni2H63oaPNXnPE/SpcL+LE4LOnP
	UDfF8F/4B5g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 46AAD9242;
	Fri, 19 Oct 2012 13:02:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BB42A9240; Fri, 19 Oct 2012
 13:02:49 -0400 (EDT)
In-Reply-To: <CAHOQ7J9W8FdKqzqbuDqj4bcFyN02kUigWtbL_xCen-PYWF9LUg@mail.gmail.com> (Stefan
 Zager's message of "Fri, 19 Oct 2012 09:16:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D019D728-1A0E-11E2-B57A-9A8C2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208051>

Stefan Zager <szager@google.com> writes:

> On Oct 19, 2012 7:11 AM, "Shawn Pearce" <spearce@spearce.org> wrote:
>>
>> The issue with the current code is sometimes when libcurl is opening a
>> CONNECT style connection through an HTTP proxy it returns a crazy high
>> timeout (>240 seconds) and no fds. In this case Git waits forever.
>> Stefan observed that using a timeout of 50 ms in this situation to
>> poll libcurl is better, as it figures out a lot more quickly that it
>> is connected to the proxy and can issue the request.
>
> Correct.  Anecdotally, the zero-file-descriptor situation happens only once
> per process invocation, so the risk of passing a too-long timeout to
> select() is small.

Thanks.
