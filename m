From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] send-pack: use buffered I/O to talk to pack-objects
Date: Thu, 9 Jun 2016 15:34:59 +0100
Message-ID: <57597E93.9040808@ramsayjones.plus.com>
References: <20160606151340.22424-1-william.duclot@ensimag.grenoble-inp.fr>
 <20160606151340.22424-4-william.duclot@ensimag.grenoble-inp.fr>
 <xmqqvb1mxmk4.fsf@gitster.mtv.corp.google.com>
 <20160606203901.GA7667@Messiaen>
 <xmqqfusquedk.fsf@gitster.mtv.corp.google.com>
 <20160606225847.GA22756@sigill.intra.peff.net>
 <xmqqbn3dvr22.fsf@gitster.mtv.corp.google.com>
 <20160607090653.GA4665@Messiaen> <575845D9.2010604@alum.mit.edu>
 <20160608191918.GB19572@sigill.intra.peff.net>
 <20160608194216.GA3731@sigill.intra.peff.net> <vpqwplypnpr.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	Johannes.Schindelin@gmx.de, mh@glandium.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 09 16:36:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB14a-00034w-AB
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 16:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546AbcFIOfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 10:35:16 -0400
Received: from avasout04.plus.net ([212.159.14.19]:42150 "EHLO
	avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014AbcFIOfN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 10:35:13 -0400
Received: from [10.0.2.15] ([84.92.139.254])
	by avasout04 with smtp
	id 4eb01t00D5VX2mk01eb1o3; Thu, 09 Jun 2016 15:35:06 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=K//fZHiI c=1 sm=1 tr=0
 a=RCQFcU9wfaUQolwYLdiqXg==:117 a=RCQFcU9wfaUQolwYLdiqXg==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=N659UExz7-8A:10
 a=PKzvZo6CAAAA:8 a=0Z7gmsLigoNx275oVM4A:9 a=pILNOxqGKmIA:10
 a=q92HNjYiIAC_jH7JDaYf:22
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <vpqwplypnpr.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296888>



On 09/06/16 13:10, Matthieu Moy wrote:
> Jeff King <peff@peff.net> writes:
> 
>> --- a/send-pack.c
>> +++ b/send-pack.c
>> @@ -36,18 +36,15 @@ int option_parse_push_signed(const struct option *opt,
>>  	die("bad %s argument: %s", opt->long_name, arg);
>>  }
>>  
>> -static int feed_object(const unsigned char *sha1, int fd, int negative)
>> +static void feed_object(const unsigned char *sha1, FILE *fh, int negative)
>>  {
>> -	char buf[42];
>> -
>>  	if (negative && !has_sha1_file(sha1))
>> -		return 1;
>> +		return;
> [...]
>> @@ -97,21 +95,22 @@ static int pack_objects(int fd, struct ref *refs, struct sha1_array *extra, stru
> [...]
>>  	for (i = 0; i < extra->nr; i++)
>> -		if (!feed_object(extra->sha1[i], po.in, 1))
>> -			break;
>> +		feed_object(extra->sha1[i], po_in, 1);
> 
> I may have missed the obvious, but doesn't this change the behavior when
> "negative && !has_sha1_file(sha1)" happens? I understand that you don't
> need write_or_whine anymore, but don't understand how you get rid of the
> "return 1" here.

Just FYI, this patch removes the last use of write_or_whine() - should it
be removed?

ATB,
Ramsay Jones
