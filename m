From: Phil Hord <phil.hord@gmail.com>
Subject: Re: https_proxy and libcurl
Date: Wed, 27 Feb 2013 16:16:29 -0500
Message-ID: <CABURp0o0+V+K90HfP4UfRFJ3s6VK-bWzWg2kwz=4XVRSMpo41Q@mail.gmail.com>
References: <CABURp0qQ6tO0B4Ya6OStX59SJqG-Jx1F4g6MUL7tVwR_6VgDhw@mail.gmail.com>
 <7v7gm0c8ub.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 22:17:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAoNI-0004bH-LV
	for gcvg-git-2@plane.gmane.org; Wed, 27 Feb 2013 22:17:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474Ab3B0VQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2013 16:16:51 -0500
Received: from mail-ve0-f178.google.com ([209.85.128.178]:55002 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248Ab3B0VQv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2013 16:16:51 -0500
Received: by mail-ve0-f178.google.com with SMTP id db10so1106494veb.9
        for <git@vger.kernel.org>; Wed, 27 Feb 2013 13:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=fBh2SWzzBWyJy1RJ9SUs9noLH3n7xWvbFHLSVucKLP8=;
        b=IDzraaTqDls9r8IILUW/h2iwRvZjm4/pKyTTq7Kor7MTSSFbl8ufoJQM7kDIwHsVQ9
         3I8IoMQwDM5p0KYs1nUopyYzHHQ49AxkQUOplOyPCpCj3bH2F242UkV3pZA/GNIcZJeY
         SUcWcC8g820mVBzlyey6N2+O4g8WV27cddePikvVpG/gDs8haMtEtunB4XaHYbjpGBst
         j+1SYEvYhFutN+EOEJMxG7dECUav0tGEKXPqzt7iLpkTg5t/71tDvHByn62b6p6I88be
         6VmLU9dsNvAvsz+XpV886/PrjNXEhHU+MpEWC22Oo9T2Zj9Q0toMZNI5IKq2zALNRJ2q
         /DEg==
X-Received: by 10.220.39.69 with SMTP id f5mr1498561vce.45.1361999810123; Wed,
 27 Feb 2013 13:16:50 -0800 (PST)
Received: by 10.58.201.103 with HTTP; Wed, 27 Feb 2013 13:16:29 -0800 (PST)
In-Reply-To: <7v7gm0c8ub.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217223>

On Fri, Feb 22, 2013 at 4:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Phil Hord <phil.hord@gmail.com> writes:
>
>> I have been unable to clone via http proxy because of a wrongly
>> configured proxy setup in my lab.
>>
>> I had this env:
>>
>>     http_proxy=http://proxy.myco.com
>>     https_proxy=https://proxy.myco.com
>>
>> The problem is that libcurl ignores the protocol part of the proxy
>> url, and it defaults to port 1080. wget honors the protocol specifier,
>> but it defaults to port 80 if none is given.
>
> IIRC, the historical norm is to set these to <host>:<port>.
>
> So many people mistakenly write them with <method>:// that some
> tools over time learned to strip and ignore that prefix, though.

On the server in question, I use wget to retrieve packages in another
script.  When our firewall was tightened in the past, this script
broke.  I fixed it by setting the https_proxy as I listed above.  This
satisfied wget and I got on with life.

I do not need git connectivity to remotes from this server very often.
 But when I tried, it failed with an error message that did not
implicate the proxy server.  But it was the proxy server that returned
the error 500.

  error: The requested URL returned error: 500 while accessing
       https://github.com/git/git/info/refs?service=git-upload-pack

>
>> The fix was to specify the port explicitly, like this:
>>
>>     http_proxy=proxy.myco.com:80
>>     https_proxy=proxy.myco.com:443
>
> Yeah, that is the correct syntax to use.  Is there anything you want
> Git to do to be more helpful?

Maybe Git can tell me more about proxy failures.  Or maybe Git doesn't
know because curl hides the knowledge.  Something like this:

  error: The proxy server at proxy.myco.com:1080
       returned error: 500 while accessing
       https://github.com/git/git/info/refs?service=git-upload-pack

Maybe Git can warn me that the protocol prefix (if provided) is going
to be ignored or that I have failed to provide a port.  Either of
these would be "above and beyond" the norm. But since curl is internal
to Git and its errors are digested by Git, it is less obvious where to
begin looking to solve such a problem; git doesn't provide the
plethora of connection-debugging output options that curl itself does.

Fwiw, the proxy info originated with our IT department who mostly had
to answer the question for Windows users and servers.  Windows appears
to default to port 8080 when no port is specified.  Port 8080 would
also have worked, but curl defaults to 1080.  It seems that the curl
default of 1080 is the only one that caused me trouble.

My basest hope is that someone suffering similar troubles will find
this thread in a search for "git proxy error".

Phil
