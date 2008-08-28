From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] dir.c: avoid c99 array initialization
Date: Thu, 28 Aug 2008 22:27:10 +0200
Message-ID: <81b0412b0808281327q302da48cl9e04ce999ff33903@mail.gmail.com>
References: <IH0MHSTEimhAN93AedvpRKq4qfzm1QA814ZYyhbSBtSdNbq8vuE6aw@cipher.nrlssc.navy.mil>
	 <G-ipWASixyGW7nvO1KquifehvBB7FNKwjPtIB0ukyEJ1Si1CJWM34w@cipher.nrlssc.navy.mil>
	 <81b0412b0808281301m29830c20l3e16432ea8aef45d@mail.gmail.com>
	 <20080828201657.GH21072@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Brandon Casey" <casey@nrlssc.navy.mil>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>, davidk@lysator.liu.se,
	"Andreas Ericsson" <ae@op5.se>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 22:28:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYo6M-0001wW-36
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 22:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383AbYH1U1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 16:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752913AbYH1U1M
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 16:27:12 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:61097 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437AbYH1U1L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 16:27:11 -0400
Received: by wa-out-1112.google.com with SMTP id j37so268130waf.23
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 13:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Lj9HnIm5CBCex+HKa99J7kR1z6XZx9mPyJXujBS+6nc=;
        b=bUV8bmlSmGgjBA54RVMskPLBHRPceFnMxnUHhSz2DFlRnIGKcz66o9GYnowZRryUaZ
         WAEg2Tw9ap3AkmFwwEC/5XqH5wJUiqucWQPdSE2Nm8mrZ6Q0e/Y2867Ce+IIfQZJKSxg
         7uL3gH39gxPCIB1x20nuRtd4XP2hyTspssLi8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=xrapJHSXZTejg8eYyTeo3lo8paHanooDPHG5ZUqrVdaUof9uXC5ys9AbLX2iqdMNoE
         aAAAao88ykFu3zCl6QC2LRr3C8nDPRlBiJx2xUsjs9qsJCGKdprJr9LvuzaHnxpexuc0
         J7Qb3Nw9l2JYGDbIUZriXjsPEy7EVvLD357y0=
Received: by 10.114.13.10 with SMTP id 10mr1981362wam.106.1219955230438;
        Thu, 28 Aug 2008 13:27:10 -0700 (PDT)
Received: by 10.114.157.9 with HTTP; Thu, 28 Aug 2008 13:27:10 -0700 (PDT)
In-Reply-To: <20080828201657.GH21072@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94133>

2008/8/28 Shawn O. Pearce <spearce@spearce.org>:
> Alex Riesen <raa.lkml@gmail.com> wrote:
>>
>> For just these 5 values it is likely more effective to just use
>> a conditional statement (less stack requested, less likely
>> some stupid compiler tries to optimize it wrongly).
>> And just as readable.
>>
>> diff --git a/dir.c b/dir.c
>> index 92452eb..1cf5985 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -680,17 +680,12 @@ static int cmp_name(const void *p1, const void *p2)
>>   */
>>  static int simple_length(const char *match)
>>  {
>> -     const char special[256] = {
>> -             [0] = 1, ['?'] = 1,
>> -             ['\\'] = 1, ['*'] = 1,
>> -             ['['] = 1
>> -     };
>>       int len = -1;
>>
>>       for (;;) {
>>               unsigned char c = *match++;
>>               len++;
>> -             if (special[c])
>> +             if (!c || '?' == c || '\\' == c || '*' == c || '[' == c)
>
> I am reminded of a year old thread with my patch to this:
>
>  http://kerneltrap.org/mailarchive/git/2007/4/15/243541
>
> The patch never applied.  I wonder why.  Was it just Dscho's comment?
>

Likely. And that sane_ctype Junio mentioned, which still has 5 bits free
