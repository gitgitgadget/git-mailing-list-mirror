From: Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] http-push: refactor request url creation
Date: Mon, 26 Jan 2009 09:52:22 +0800
Message-ID: <be6fef0d0901251752p5b34c053pb24dce8a35b06fce@mail.gmail.com>
References: <be6fef0d0901242208p635264e5jc1f95d784cd51450@mail.gmail.com>
	 <7vpribdszr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 02:53:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRGfd-0002iM-Lu
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 02:53:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbZAZBwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 20:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbZAZBwY
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 20:52:24 -0500
Received: from rv-out-0506.google.com ([209.85.198.231]:24245 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbZAZBwX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 20:52:23 -0500
Received: by rv-out-0506.google.com with SMTP id k40so5640798rvb.1
        for <git@vger.kernel.org>; Sun, 25 Jan 2009 17:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=w8vAY6GekAJLX65oZXjmuIgMOGbScYnwqbc9jZuY7Ec=;
        b=WPB3RybNE1XVNlPuTrY1OrPEf7nAl11AmeZb4Zlt8Unq721QuNNThM4MXAkj3zY1Vz
         8hNPhcV3DpBqiN9s3FNrXf7j+lmWeWJvA4BLNP6H0mJ2lflfsMxjQbKEYUcCYj6KiT2M
         8sNQMRk3P1eB6X/9NWr2MWCnASzJQAlfRq2tE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=x1krku1t3IzURBAyEnAJ5NkY1z/g4Afpc2ed5Q7qQfywJp5m2eyDvVUqGHaB6CT2HD
         qD5Yp1strlPcKcdFzl1qMue6Ueu4q22x5r1Rl32ji/0mjkvKNctWpPtzPf2PyM3HuRGf
         iuVQjizPgp3hJZ+UrvIG7W+er1O+9dqnc4kTk=
Received: by 10.114.195.19 with SMTP id s19mr6620820waf.10.1232934742732; Sun, 
	25 Jan 2009 17:52:22 -0800 (PST)
In-Reply-To: <7vpribdszr.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107156>

Hi,

On Mon, Jan 26, 2009 at 4:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> @@ -304,17 +312,7 @@ static void start_fetch_loose(struct
>> transfer_request *request)
>>
>>       git_SHA1_Init(&request->c);
>>
>> -     url = xmalloc(strlen(remote->url) + 50);
>> ...
>> -     strcpy(request->url, url);
>> +     request->url = get_remote_object_url(remote->url, hex, 0);
>> ...
>> -     curl_easy_setopt(slot->curl, CURLOPT_URL, url);
>> +     curl_easy_setopt(slot->curl, CURLOPT_URL, request->url);
>
> The original code gave a separate "url" to setop() but this gives the same
> string.  Does curl_easy_setop() copies the given string away?  IOW is this
> change safe?
>

curl strdup's it, so this is safe.

The stack is like this:

curl_easy_setopt
calls Curl_setopt (at 391)
calls setstropt (at 1566)
calls strdup (at 276).

http://cool.haxx.se/cvs.cgi/curl/lib/easy.c?annotate=1.132 (for
curl_easy_setopt)
http://cool.haxx.se/cvs.cgi/curl/lib/url.c?annotate=1.782 (for
Curl_setopt, setstropt)

-- 
Cheers,
Ray Chuan
