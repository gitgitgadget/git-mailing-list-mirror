From: Liu Yubao <yubao.liu@gmail.com>
Subject: Re: [PATCH 1/5] avoid parse_sha1_header() accessing memory out of
 bound
Date: Wed, 03 Dec 2008 11:49:50 +0800
Message-ID: <493601DE.3050107@gmail.com>
References: <493399B7.5000505@gmail.com> <7voczws3np.fsf@gitster.siamese.dyndns.org> <4934949B.70307@gmail.com> <20081202154257.GK23984@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 03 04:51:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7ilm-000389-Po
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 04:51:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591AbYLCDuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 22:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752225AbYLCDuE
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 22:50:04 -0500
Received: from ti-out-0910.google.com ([209.85.142.189]:16430 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbYLCDuC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 22:50:02 -0500
Received: by ti-out-0910.google.com with SMTP id b6so2111285tic.23
        for <git@vger.kernel.org>; Tue, 02 Dec 2008 19:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=8Af8wl/n1+ahKjZ/DrfQCIh2uAbaR85KR/yO/c2fd9w=;
        b=IYZZLmw+Kwc1JQVuDrjvsxCDo7kyJZ3YVGsLmTSzJbe7kiYau+SaGMWlOByXGLZjvF
         1ajETflY9MCPP/jtviCE8TKvz3eIDiKIURh17S/74cBz+UHv2ZfabZZmweyI7FTT5vwD
         ELw00n2H+vCzLdSnXmrraHcQ1ne2sxHEG3pyc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=gYeEpmwN0iDHJ16vkqDsCUTCqpJhWszuY3okUvuhlSObf1uIhIHjLYQy9rwt2PNHWv
         KNdSGlwwQhOXBYl3G9AJAu4Ly9Y6rRwHhYcKG7dtkj/iMl8R4BHYISDgR9tph2uGnTzn
         LeKUY+v78VH2vyxcmRAY92yDlDdaBI6JXCb20=
Received: by 10.110.62.4 with SMTP id k4mr1122476tia.17.1228276199900;
        Tue, 02 Dec 2008 19:49:59 -0800 (PST)
Received: from ?10.64.1.78? ([211.157.41.194])
        by mx.google.com with ESMTPS id b4sm3544352tic.2.2008.12.02.19.49.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Dec 2008 19:49:58 -0800 (PST)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
In-Reply-To: <20081202154257.GK23984@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102207>

Shawn O. Pearce wrote:
> Liu Yubao <yubao.liu@gmail.com> wrote:
>> diff --git a/sha1_file.c b/sha1_file.c
>> index 6c0e251..efe6967 100644
>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>> @@ -1254,10 +1255,10 @@ static int parse_sha1_header(const char *hdr, unsigned long *sizep)
>>  	/*
>>  	 * The type can be at most ten bytes (including the
>>  	 * terminating '\0' that we add), and is followed by
>> -	 * a space.
>> +	 * a space, at least one byte for size, and a '\0'.
>>  	 */
>>  	i = 0;
>> -	for (;;) {
>> +	while (hdr < hdr_end - 2) {
>>  		char c = *hdr++;
>>  		if (c == ' ')
>>  			break;
>> @@ -1265,6 +1266,8 @@ static int parse_sha1_header(const char *hdr, unsigned long *sizep)
>>  		if (i >= sizeof(type))
>>  			return -1;
> 
> That first hunk I am citing is unnecessary, because of the lines
> right above.  All of the callers of this function pass in a buffer
> that is at least 32 bytes in size; this loop aborts if it does not
> find a ' ' within the first 10 bytes of the buffer.  We'll never
> access memory outside of the buffer during this loop.
> 
> So IMHO your first three hunks here aren't necessary.
> 

Seems you missed the cover letter sent as patch 0/5, all patches are explained
in the cover letter, sorry I sent them as separate topics by mistake.

This bound check is mainly for uncompressed loose object, a loose object
that just are uncompressed:

uncompressed loose object = inflate(loose object)
loose object = deflate(typename + <space> + size + '\0' + data)

I'm doing a defensive programming, for uncompressed loose object the mmapped
memory is passed to parse_sha1_header without being checked by inflateInit() first,
so there may be a SIGSEGV crash for a corrupted uncompressed loose object.


>> @@ -1275,7 +1278,7 @@ static int parse_sha1_header(const char *hdr, unsigned long *sizep)
>>  	if (size > 9)
>>  		return -1;
>>  	if (size) {
>> -		for (;;) {
>> +		while (hdr < hdr_end - 1) {
>>  			unsigned long c = *hdr - '0';
>>  			if (c > 9)
>>  				break;
> 
> OK, there's no promise here that we don't roll off the buffer.
> 
> This can be fixed in the caller, ensuring we always have the '\0'
> at some point in the initial header buffer we were asked to parse:
> 
Isn't it easier to solve this problem in one place and maintain it? Maybe someday
someone forgets parse_sha1_header requires a null terminated buffer, and a corrupted
uncompressed loose object even doesn't have to be null terminated (if there will be
this kind of loose object).
