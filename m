From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] verify-tag: allow to verify signed blob objects
Date: Wed, 15 Jun 2016 21:07:15 +0200
Message-ID: <9b700254-23b1-286c-70e6-68d484e9c4e8@drmicha.warpmail.net>
References: <a6557333316c6f7996fa54eebc75abdf988ed9f9.1465991212.git.git@drmicha.warpmail.net>
 <xmqq8ty670v2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 21:07:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDG9v-0002LG-Sl
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 21:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789AbcFOTHX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 15:07:23 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:52636 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752061AbcFOTHX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jun 2016 15:07:23 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 25B6221F21;
	Wed, 15 Jun 2016 15:07:17 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Wed, 15 Jun 2016 15:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=OG89rpsR/Ixa0AQHCW+cRdVpxiw=; b=BoC/y9
	SnGVFsgzD15NEh3Qw9WPU8UtAjne3aB0pdxYk6fjypSqsPrFK+uK8Iw4MQc1b4zz
	Z5ODZuTAMpdGKv7TxSbY85DbuFNRXS27f1Il0dvP1DFSqpJVnVcrUJfDeQOyTMxE
	guHbmWw1LC5DkLxEgT46SqhdZShRd9XkO92BI=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=OG89rpsR/Ixa0AQ
	HCW+cRdVpxiw=; b=MhxdGemPjBmVT8jMmKr9yc0+OWIF+VdNwnl3/a5+sXUKc3v
	Xn0IaoLZvZUzCflI4KFXV6QwK66A6FslrqU8tIaQoYwZEAjJZI1WZn3Id88GPJFX
	g+8njORAfSGIaFJCedwal3iYHOGHf5gbt2Hn6YrB2ytdPZS/YjasI4pAeOzg=
X-Sasl-enc: uBXZiNrPOn/mXfCpML1hDfib8r7EpjJgH9NpcWom3x4C 1466017636
Received: from UltraSam.fritz.box (dslb-092-076-178-152.092.076.pools.vodafone-ip.de [92.76.178.152])
	by mail.messagingengine.com (Postfix) with ESMTPA id 6FBBBF2022;
	Wed, 15 Jun 2016 15:07:16 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
In-Reply-To: <xmqq8ty670v2.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297392>

Junio C Hamano venit, vidit, dixit 15.06.2016 20:39:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> diff --git a/tag.c b/tag.c
>> index d1dcd18..d5f090b 100644
>> --- a/tag.c
>> +++ b/tag.c
>> @@ -39,7 +39,7 @@ int gpg_verify_tag(const unsigned char *sha1, const char *name_to_report,
>>  	int ret;
>>  
>>  	type = sha1_object_info(sha1, NULL);
>> -	if (type != OBJ_TAG)
>> +	if ((type != OBJ_TAG) && ((type != OBJ_BLOB) || !(flags & GPG_VERIFY_BLOB)))
>>  		return error("%s: cannot verify a non-tag object of type %s.",
>>  				name_to_report ?
>>  				name_to_report :
> 
> The double negation is very hard to read.  I wonder
> 
> 	if ((type != OBJ_TAG) &&
>             !((type == OBJ_BLOB) && (flags & GPG_VERIFY_BLOB)))
> 
> is easier to follow?  "It is not a tag object, and it's not like we
> were asked to verify blob and the user gave us a blob, either, so
> let's complain" is easier to follow, at least for me.

As a further exercise in boolean algebra, you can pull out the negation
completely:

if (!( (type == OBJ_TAG) || ((type == OBJ_BLOB) && (flags &
GPG_VERIFY_BLOB)) ))

> Or even
> 
> 	if ((flags & GPG_VERIFY_BLOB) && (type != OBJ_BLOB))
>                	"you told me to check blob but didn't give me one";
> 	} else if (type != OBJ_TAG)
> 		"you didn't give me a tag";
> 

I just tried to stay as close to the original as possible, but I don't
care either way. Your latter version is more strict and would require a
slight documentation change, but would be fine, too.

Michael
