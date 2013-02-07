From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH 1/4] show: obey --textconv for blobs
Date: Thu, 07 Feb 2013 10:05:26 +0100
Message-ID: <51136E56.7060703@drmicha.warpmail.net>
References: <cover.1360162813.git.git@drmicha.warpmail.net> <883f0163cb732932061a368ea9bc187c13e4ecca.1360162813.git.git@drmicha.warpmail.net> <20130206220644.GB27507@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 07 10:05:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3NQW-0000rf-Qj
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 10:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754522Ab3BGJFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 04:05:30 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:57268 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751962Ab3BGJF1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Feb 2013 04:05:27 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 644C020AC6;
	Thu,  7 Feb 2013 04:05:26 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 07 Feb 2013 04:05:26 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=3L4aUo5i1m3iegrqPdgcUQ
	RexHg=; b=Qx3eAQ4T9InBqfn5pu8DlV166xByPZKVrBIhBmatr1TBnaSU5gRdbc
	mmIEZCjahZAlMG70r6mUnfxutFGBKXTEbcSwT28BMKGsYR/4b5Dx0H2s4XpS0MLU
	9i5OWe2n+a1VK43zIiRVUPZ4+Dx3HmwELfTgRmRWw7mAJjIvFbtXQ=
X-Sasl-enc: w0fBwUs/YvsO2JRJMOs0Z7AQBEWE/hG9i3yEBvtvxLlB 1360227926
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id AC9DC482524;
	Thu,  7 Feb 2013 04:05:25 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <20130206220644.GB27507@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215680>

Jeff King venit, vidit, dixit 06.02.2013 23:06:
> On Wed, Feb 06, 2013 at 04:08:50PM +0100, Michael J Gruber wrote:
> 
>> diff --git a/builtin/log.c b/builtin/log.c
>> index 8f0b2e8..f83870d 100644
>> --- a/builtin/log.c
>> +++ b/builtin/log.c
>> @@ -402,10 +402,28 @@ static void show_tagger(char *buf, int len, struct rev_info *rev)
>>  	strbuf_release(&out);
>>  }
>>  
>> -static int show_blob_object(const unsigned char *sha1, struct rev_info *rev)
>> +static int show_blob_object(const unsigned char *sha1, struct rev_info *rev, const char *obj_name)
> 
> Should this maybe just take the whole object_array_entry as a cleanup?

It's just a question of one or two/three pointers (I can't count), but
yes, that would be possible.

>>  {
>> +	unsigned char sha1c[20];
>> +	struct object_context obj_context;
>> +	char *buf;
>> +	unsigned long size;
>> +
>>  	fflush(stdout);
>> -	return stream_blob_to_fd(1, sha1, NULL, 0);
>> +	if (!DIFF_OPT_TST(&rev->diffopt, ALLOW_TEXTCONV))
>> +		return stream_blob_to_fd(1, sha1, NULL, 0);
>> +
>> +	if (get_sha1_with_context(obj_name, 0, sha1c, &obj_context))
>> +		die("Not a valid object name %s", obj_name);
> 
> It seems a little hacky that we have to look up the sha1 again. What
> should happen in the off chance that "hashcmp(sha1, sha1c) != 0" due to
> a race with a simultaneous update of a ref?

I thought about a check here but didn't bother to because I knew the
refactoring would come up again...

> Would it be better if object_array_entry replaced its "mode" member with
> an object_context?

Do all callers/users want to deal with object_context?

I'm wondering why o_c has a mode at all, since it is mostly used in
conjunction with an object, isn't it?

> The only downside I see is that we might waste a
> significant amount of memory (each context has a PATH_MAX buffer in it).

That's why I used a reference to the struct, see my other reply.

Michael
