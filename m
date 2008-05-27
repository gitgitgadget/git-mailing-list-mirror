From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: Gitweb caching: Google Summer of Code project
Date: Wed, 28 May 2008 00:54:39 +0200
Message-ID: <483C912F.6010802@gmail.com>
References: <483C4CFF.2070101@gmail.com> <200805272353.34319.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Hawley <warthog19@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>, Lars Hjemli <hjemli@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 28 00:55:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1854-0001I0-BP
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 00:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758272AbYE0Wym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 18:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758130AbYE0Wym
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 18:54:42 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:53145 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757570AbYE0Wyl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 18:54:41 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1630029fgg.17
        for <git@vger.kernel.org>; Tue, 27 May 2008 15:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=nRpWaDN2WYIMhXfIFOFguw/hiyNeCDYB2G0PUcUo9G0=;
        b=C9TwWkjOg1NiORWBlXTHbjVnogkq1zaBjYDoetKHxKjkacUh7/mr/dUWP7u2AbR5lMIL6barGmVa12r9n8ya1fjn7T80mz0rOs3Ap2M3Aokt2+4BLg3FiHrHMHrEl8+dW/UaAx0Basd8CHuQ2N0O8uwZf/oPl+Rui5fPlTo8Sco=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=ieJ848b6a1kxHhahqc5fjo9f9Q+6jE6NU5r5i6Xe2xKsFBS35TX+/4VBXq0b0w3gKetQ7lxz1BpSbU+Ejcj7Bh5FCpcLISO//dtIIcT6yKU5zh6+9pprrLJsOnltpA7Hqydt54Zu47Gm2334fsrhjNY4GDOsRaMnkjm+OfWrVCA=
Received: by 10.86.77.5 with SMTP id z5mr224814fga.42.1211928879778;
        Tue, 27 May 2008 15:54:39 -0700 (PDT)
Received: from ?192.168.23.50? ( [91.33.209.73])
        by mx.google.com with ESMTPS id 28sm25386990fkx.8.2008.05.27.15.54.38
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 27 May 2008 15:54:39 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <200805272353.34319.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83058>

Jakub Narebski wrote:
> Lately he posted a patch
> implementing projects list caching, in a bit different way from how it
> is done on kernel.org, namely by caching data and not final output:

Thanks for this and all the other pointers.

Caching data and not final output is actually what I'm about to try 
next.  If I'm not mistaken, the HTML output is significantly larger than 
the source (repository) data; however, kernel.org still seems to benefit 
from caching the HTML, rather than letting Linux' page cache cache the 
source data.  That leads me to think that the page cache somehow fails 
to cache the source data properly -- I'm not sure why (wild speculation: 
perhaps because of the pack format).  Anyway, I'd hope that I can 
encapsulate the 30-40 git_cmd calls in gitweb.perl and somehow cache 
their results (or, to save memory, the parts of their results that are 
actually used) and cache them using memcached.  If that works well, we 
can stop bothering about frontend (HTML) caching, unless CPU becomes an 
issue, since all HTML pages are generated from cacheable source data.

I'm *kindof* hoping that in the end there will be only few issues with 
cache expiry, since most calls are uniquely identified through hashes. 
(And the ones that are not, like getting the hash of the most recent 
commit, can perhaps be cached with some fairly low expiry time.)

So that's what I'll try next.  If you have any comments or warnings off 
the top of your heads, feel free to send email of course. :)

> the main culprit of [the fork] was splitting gitweb into many, many
> files.  While it helped John in understanding gitweb, it made it
> difficult to merge changes back to mainline.

Interesting point, thanks for letting me know.  (I might have gone ahead 
and tried to split the mainline gitweb myself... ^^)  I think it would 
be nice if gitweb.perl could be split at some point, but I assume there 
are too many patches out there for that to be worth the merge problems, 
right?

-- Lea
