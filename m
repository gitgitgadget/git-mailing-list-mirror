From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [BUG?] git http connection reuse
Date: Sat, 15 Feb 2014 23:16:41 -0800
Message-ID: <377DF3F4-1F9B-4CB0-A9BF-658E561F4349@gmail.com>
References: <20140216040538.GA4754@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Daniel Stenberg <daniel@haxx.se>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 16 08:16:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEvy5-0007tJ-7d
	for gcvg-git-2@plane.gmane.org; Sun, 16 Feb 2014 08:16:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbaBPHQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Feb 2014 02:16:45 -0500
Received: from mail-pb0-f49.google.com ([209.85.160.49]:56393 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbaBPHQo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Feb 2014 02:16:44 -0500
Received: by mail-pb0-f49.google.com with SMTP id up15so13978614pbc.22
        for <git@vger.kernel.org>; Sat, 15 Feb 2014 23:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=kSOvUc4izWMTNco1A8TJiW4aNs6HHhVxUB2czTtQf04=;
        b=TiFetb69SNk4KywNZxPv+omqhdfds/XcX+9FApNWDiC2fhV0Ws4a5IiF2Dp84uJbUb
         BhUSX7yxZQ5cvpZL5tPh6DLNFyE3pT9BCvFIVJY6zuE0K5Gyr+g6kmRluUUllGG7rCLc
         qxrLTwgeX8WdVbq8WJVp6caTYe5J0doPm7p6sxk56IfWX49VJII88eWOT2R0LlgPTu1v
         vH4kXa1VO/127fB5Tw5K/+ysWyzWlUTXaSrCP9fCzzjYpx9EBFBEDV3YvFkdTrElKIr+
         AzjrB5kUc5q0boocitXDr0nZETbe+S1QZqJvEROhcMjsK9IrysKuwTUyOt2sWbL4MzeY
         bpTA==
X-Received: by 10.66.25.241 with SMTP id f17mr19107858pag.127.1392535004241;
        Sat, 15 Feb 2014 23:16:44 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id g6sm85214711pat.2.2014.02.15.23.16.42
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 15 Feb 2014 23:16:43 -0800 (PST)
In-Reply-To: <20140216040538.GA4754@sigill.intra.peff.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242215>

On Feb 15, 2014, at 20:05, Jeff King wrote:
> I've noticed that git does not reuse http connections when fetching,  
> and
> I'm trying to figure out why. It seems related to our use of two curl
> features:
>
>  1. If we use the curl_multi interface (even though we are doing the
>     requests sequentially), we do not get reuse.

Take a look at the curl_multi_setopt page [1].  I think these explain  
the curl_multi issue:

> CURLMOPT_PIPELINING
>
> Pass a long set to 1 to enable or 0 to disable. Enabling pipelining  
> on a multi handle will make it attempt to perform HTTP Pipelining as  
> far as possible for transfers using this handle. This means that if  
> you add a second request that can use an already existing  
> connection, the second request will be "piped" on the same  
> connection rather than being executed in parallel. (Added in 7.16.0)
>
>
> CURLMOPT_MAX_TOTAL_CONNECTIONS
>
> Pass a long. The set number will be used as the maximum amount of  
> simultaneously open connections in total. For each new session,  
> libcurl will open a new connection up to the limit set by  
> CURLMOPT_MAX_TOTAL_CONNECTIONS. When the limit is reached, the  
> sessions will be pending until there are available connections. If  
> CURLMOPT_PIPELINING is 1, libcurl will try to pipeline if the host  
> is capable of it.
>
> The default value is 0, which means that there is no limit. However,  
> for backwards compatibility, setting it to 0 when  
> CURLMOPT_PIPELINING is 1 will not be treated as unlimited. Instead  
> it will open only 1 connection and try to pipeline on it.
>
> (Added in 7.30.0)

If pipelining is off (the default) and total connections is not 1 it  
sounds to me from the description above that the requests will be  
executed on separate connections until the maximum number of  
connections is in use and then there might be some reuse.  That might  
not be what's actually going on with multi, but that's my guess and I  
think setting CURLMOPT_PIPELINING to to 1 and then also setting  
CURLMOPT_MAX_TOTAL_CONNECTIONS to a non-zero value might be what you  
want.

>  2. If we set CURLOPT_HTTPAUTH to CURLAUTH_ANY, we do not get reuse.
[snip]
> My curl version is 7.35.0, if that makes a difference.

And that is explained by this from the CHANGES file:

> Daniel Stenberg (7 Jan 2014)
> - ConnectionExists: fix NTLM check for new connection
>
>   When the requested authentication bitmask includes NTLM, we cannot
>   re-use a connection for another username/password as we then risk
>   re-using NTLM (connection-based auth).
>
>   This has the unfortunate downside that if you include NTLM as a  
> possible
>   auth, you cannot re-use connections for other usernames/passwords  
> even
>   if NTLM doesn't end up the auth type used.
>
>   Reported-by: Paras S
>   Patched-by: Paras S
>   Bug: http://curl.haxx.se/mail/lib-2014-01/0046.html

Looks like you're just lucky as that above change first appears in  
7.35.0.  But it seems there are some patches for older versions so  
they might be affected as well [2].

Adjusting your test program to leave the first connection set to  
CURLAUTH_ANY, but then setting the second one to CURLAUTH_ANY with the  
two NTLM bits turned off (CURLAUTH_NTLM and CURLAUTH_NTLM_WB) results  
in the connection being reused for me. :)

With the older cURL versions I already had installed, the second  
connection is always reused.  I didn't see the non-reuse with your  
sample code until I fetched 7.35.0.

--Kyle

[1] http://curl.haxx.se/libcurl/c/curl_multi_setopt.html
[2] http://curl.haxx.se/docs/adv_20140129.html
