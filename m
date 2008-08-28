From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] dir.c: avoid c99 array initialization
Date: Thu, 28 Aug 2008 13:21:42 -0700
Message-ID: <7vwsi0dh61.fsf@gitster.siamese.dyndns.org>
References: <IH0MHSTEimhAN93AedvpRKq4qfzm1QA814ZYyhbSBtSdNbq8vuE6aw@cipher.nrlssc.navy.mil> <G-ipWASixyGW7nvO1KquifehvBB7FNKwjPtIB0ukyEJ1Si1CJWM34w@cipher.nrlssc.navy.mil> <81b0412b0808281301m29830c20l3e16432ea8aef45d@mail.gmail.com> <20080828201657.GH21072@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Git Mailing List <git@vger.kernel.org>,
	davidk@lysator.liu.se, Andreas Ericsson <ae@op5.se>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 22:24:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYo1D-0007xp-De
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 22:22:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757009AbYH1UVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 16:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754988AbYH1UVz
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 16:21:55 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65306 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757009AbYH1UVy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 16:21:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 301566B260;
	Thu, 28 Aug 2008 16:21:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0CF846B25D; Thu, 28 Aug 2008 16:21:44 -0400 (EDT)
In-Reply-To: <20080828201657.GH21072@spearce.org> (Shawn O. Pearce's message
 of "Thu, 28 Aug 2008 13:16:57 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F3EE23D0-753E-11DD-8B7E-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94131>

"Shawn O. Pearce" <spearce@spearce.org> writes:

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
>> -	const char special[256] = {
>> -		[0] = 1, ['?'] = 1,
>> -		['\\'] = 1, ['*'] = 1,
>> -		['['] = 1
>> -	};
>>  	int len = -1;
>> 
>>  	for (;;) {
>>  		unsigned char c = *match++;
>>  		len++;
>> -		if (special[c])
>> +		if (!c || '?' == c || '\\' == c || '*' == c || '[' == c)
>
> I am reminded of a year old thread with my patch to this:
>
>   http://kerneltrap.org/mailarchive/git/2007/4/15/243541
>
> The patch never applied.  I wonder why.  Was it just Dscho's comment?

I think it was an unanswered question about stealing one bit from
ctype.c::sane_ctype[] that kept the discussion in limbo.
