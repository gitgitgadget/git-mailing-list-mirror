From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http.proxy: also mention https_proxy and all_proxy
Date: Sat, 03 Mar 2012 14:22:39 -0800
Message-ID: <7v399p72a8.fsf@alter.siamese.dyndns.org>
References: <20120303145053.GA29948@ecki>
 <20120303174252.GC28602@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 03 23:22:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3xLk-0003WR-Gb
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 23:22:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905Ab2CCWWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 17:22:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37722 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752892Ab2CCWWn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 17:22:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A7E55047;
	Sat,  3 Mar 2012 17:22:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pd6faBbgMW5ZDiPKDbyUrPvWS+g=; b=URg1On
	0jn5dUTnfBltS+ISa6hmnafhUYQADDl97iVp9IeL/bi2Q9cQ9SWzfAt3jAj0hhqh
	DVDDKuHu7p3343P0IDHjqA79tt/Vsbd/NEp79cKACiJAYm91bZGmrTkA9yDvZpAK
	jddgKygz9t+Pl2GafOXq6zhmHuoSSSEcAanGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X+Fy1XPYR1IHhQriBm62Q1Mf2iY99myj
	cRrV7QV/HUhpUSvQRCUsWxfB7boEY34y+wmLQS0PGVuJ7J1K8lHe6mLXyn1Jqm2L
	ypJlomwuuNWxl3X3NWnbMjqbPpZR9B/K/Mba0BZ/H0C34EFsic6g7+LuMj6+vmgk
	4A5q4kgrcAY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 127045046;
	Sat,  3 Mar 2012 17:22:42 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E1EA5044; Sat,  3 Mar 2012
 17:22:41 -0500 (EST)
In-Reply-To: <20120303174252.GC28602@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 3 Mar 2012 12:42:52 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 64305918-657F-11E1-9520-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192140>

Jeff King <peff@peff.net> writes:

> On Sat, Mar 03, 2012 at 03:50:53PM +0100, Clemens Buchacher wrote:
>
>> The current wording of the http.proxy documentation suggests that
>> http_proxy is somehow equivalent to http.proxy. However, while
>> http.proxy (by the means of curl's CURLOPT_PROXY option) overrides the
>> proxy for both HTTP and HTTPS protocols, the http_proxy environment
>> variable is used only for HTTP. But since the docs mention only
>> http_proxy, a user might expect it to apply to all HTTP-like protocols.
>
> Hmm, I didn't know that. This certainly adds an interesting twist to the
> patch in a nearby thread to start reading http_proxy ourselves.

Yeah, I too had an "Ahhhh" moment.

I recall that I was frustrated more than 10 years ago when I had to point
at our company proxy with many *_proxy variables in my .login and ended up
writing a shell script (and placed it under source control) that generates
dot files from a single source (which of course is under source control).

The manual page for curl seems to say that they have separate HTTPS_PROXY
and friends all in caps, and http_proxy is left lowercase for historical
reasons [*1*].

As to the way forward, I suspect that http.proxy was a mistake to begin
with, considering the structure of namespace our configuration variables
fit in.  Shouldn't they be proxy.http, proxy.https, etc.?

And if we were to map curl's HTTPS_PROXY to proxy.https to fix this
namespace gotha, we could treat http.proxy as a historical mistake, and
introduce proxy.http as what matches curl's http_proxy.

Then the change proposed in the nearby thread can notice http_proxy and
behave as if proxy.http is set, which would only affect http but not
https.  When http.proxy is set, we still let it affect anything curl
handles.


[Footnote]

*1* Come to think of it, the alleged Mac OS X breakage I mentined may
merely be a second-hand rumor of a misdiagnosed user error---the user
might have been trying to reach https:// resource with only http_proxy
set.
