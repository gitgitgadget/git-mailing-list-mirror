From: Robert Zeh <robert.allan.zeh@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Fri, 8 Feb 2013 21:36:15 -0600
Message-ID: <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com> <7vehgqzc2p.fsf@alter.siamese.dyndns.org> <7va9rezaoy.fsf@alter.siamese.dyndns.org> <7vsj56w5y9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 04:36:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U41F6-0003nd-F4
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 04:36:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760571Ab3BIDgV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 22:36:21 -0500
Received: from mail-ob0-f179.google.com ([209.85.214.179]:62954 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760513Ab3BIDgU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Feb 2013 22:36:20 -0500
Received: by mail-ob0-f179.google.com with SMTP id un3so4606172obb.10
        for <git@vger.kernel.org>; Fri, 08 Feb 2013 19:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:references:mime-version:in-reply-to:content-type
         :content-transfer-encoding:message-id:cc:x-mailer:from:subject:date
         :to;
        bh=ovVrvyp/Z3b4VfjQ0UosZrMNa9spRuZZSG1xYWtKvag=;
        b=lnXvAUJ6xHh/vnS/AW1PM3MxPutGhdUSp6zJ8Vv7/muwbEd4XkjeF0Nu/J1Jqz6X1r
         kpHNszAranh/Jae9/mPn4lME/sKmXbJqAkoAIkb1l/6Gx759Q+MeqzI71DMmk806HlBP
         EVBZ+MT91utDd7wPfDFwW6POKIpFgpuebGl8fXrhBQYPfqU9PONtRLG/kSPKfiqXBFRJ
         CFxBRgf/7A3HavuddzsGyGoqZYuObslIKgHhwxS7Mbe2jkh107rj5TczztYimKM2X0sE
         vF8N5cnmeGJjXdmpSldOkRu8w6SpzSIO5TIoZ9P+Itfs4nIfSlphYsUTzihILzTJlEvc
         zNKA==
X-Received: by 10.60.6.199 with SMTP id d7mr5740740oea.137.1360380980210;
        Fri, 08 Feb 2013 19:36:20 -0800 (PST)
Received: from [192.168.1.72] (108-90-21-196.lightspeed.cicril.sbcglobal.net. [108.90.21.196])
        by mx.google.com with ESMTPS id ee14sm40362318obb.2.2013.02.08.19.36.17
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 08 Feb 2013 19:36:18 -0800 (PST)
In-Reply-To: <7vsj56w5y9.fsf@alter.siamese.dyndns.org>
X-Mailer: iPhone Mail (10B141)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215849>

The delay for commands like git status is much worse on Windows than Linux; for my workflow I would be happy with a Windows only implementation. 

>From the description so far, I have some question: how does the daemon get started and stopped?  Is there one per repository --- this seems to be implied by putting the unix domain socket in $GIT_DIR. Could we automatically reject connections from anything other than localhost when using TCP?

Robert Zeh

On Feb 8, 2013, at 8:56 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
>> I checked read-cache.c and preload-index.c code.  To get the
>> discussion rolling, I think something like the outline below may be
>> a good starting point and a feasible weekend hack for somebody
>> competent:
>> 
>> * At the beginning of preload_index(), instead of spawning the
>>   worker thread and doing the lstat() check ourselves, we open a
>>   socket to our daemon (see below) that watches this repository and
>>   make a request for lstat update.  The request will contain:
>> 
>>    - The SHA1 checksum of the index file we just read (to ensure
>>      that we and our daemon share the same baseline to
>>      communicate); and
>> 
>>    - the pathspec data.
>> 
>>   Our daemon, if it already has a fresh data available, will give
>>   us a list of <path, lstat result>.  Our main process runs a loop
>>   that is equivalent to what preload_thread() runs but uses the
>>   lstat() data we obtained from the daemon.  If our daemon says it
>>   does not have a fresh data (or somehow our daemon is dead), we do
>>   the work ourselves.
>> 
>> * Our daemon watches the index file and the working tree, and
>>   waits for the above consumer.  First it reads the index (and
>>   remembers what it read), and whenever an inotify event comes,
>>   does the lstat() and remembers the result.  It never writes
>>   to the index, and does not hold the index lock.  Whenever the
>>   index file changes, it needs to reload the index, and discard
>>   lstat() data it already has for paths that are lost from the
>>   updated index.
> 
> I left the details unsaid in thee above because I thought it was
> fairly obvious from the nature of the "outline", but let me spend a
> few more lines to avoid confusion.
> 
> - The way the daemon "watches" the changes to the working tree and
>   the index may well be very platform dependent.  I said "inotify"
>   above, but the mechanism does not have to be inotify.
> 
> - The channel the daemon and the client communicates would also be
>   system dependent.  UNIX domain socket in $GIT_DIR/ with a
>   well-known name would be one possibility but it does not have to
>   be the only option.
> 
> - The data given from the daemon to the client does not have to
>   include full lstat() information.  They start from the same index
>   info, and the only thing preload_index() wants to know is for
>   which paths it should call ce_mark_uptodate(ce), so the answer
>   given by our daemon can be a list of paths.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
