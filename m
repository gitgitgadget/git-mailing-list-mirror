From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [BUG?] HEAD detached at HEAD
Date: Mon, 21 Sep 2015 09:39:39 +0200
Message-ID: <55FFB43B.5080002@drmicha.warpmail.net>
References: <vpqk2rnirz0.fsf@anie.imag.fr>
 <CA+P7+xoeXiZd=WU460Xfjthe0U5BnAV69_KNKW39p10ZGLHx7g@mail.gmail.com>
 <vpqeghviqu1.fsf@anie.imag.fr>
 <CAGZ79kZxAwMvv6UoZLBd2wTOdj1DFWKQqSPBYL449KSokA8DQQ@mail.gmail.com>
 <vpqlhc3h7e7.fsf@anie.imag.fr> <55FFB267.3040106@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jacob Keller <jacob.keller@gmail.com>, git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Sep 21 09:39:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZdvhS-0004rd-5n
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 09:39:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755753AbbIUHjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 03:39:42 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50701 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755294AbbIUHjl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Sep 2015 03:39:41 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 4891420187
	for <git@vger.kernel.org>; Mon, 21 Sep 2015 03:39:41 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 21 Sep 2015 03:39:41 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=oUKrCVcD4IEnrWhxdNR3Nk/QdhM=; b=T77U3K
	GL4Iaww2m3DuQ5wqn6lj4n1b+cq02MMn2Z/Qpr6kzznwg356SqSdrwGORrQ2Xx9K
	DeWfOWHYuunKbgvAtBa6RVv7L5QwFLzQp8422uzqL2y32psZmQCY8WFVZ9JxCp70
	SrxG7gYen6VQNgBTgbzD39Vp/ugsT9xfSlM1Y=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=oUKrCVcD4IEnrWh
	xdNR3Nk/QdhM=; b=Wrmy1McKsrtYvuh5iHlhv9gUm0uoCsbaVDTaBBIJQCC1mLn
	Nu6VMhlDL8hvLuXweXMaqViHkQSsowZk53hjTsqS3AeUnIjjqpWepezPwyerjnJG
	TZCToQyxXJ6kVvbnukT4Ho/YsolyHJST/U7j38xYubGAy/SjZtruHZsCVFCI=
X-Sasl-enc: Erh3sb0O+zGRHugNPt0xUhgbyVKaSC3yWcWBOvPGLmA2 1442821180
Received: from localhost.localdomain (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7A590C00023;
	Mon, 21 Sep 2015 03:39:40 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <55FFB267.3040106@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278282>

... in addition to my previous reply, looking at more context:

>> --- a/wt-status.c
>> +++ b/wt-status.c
>> @@ -1319,6 +1319,13 @@ static int grab_1st_switch(unsigned char *osha1, unsigned char *nsha1,
>>         hashcpy(cb->nsha1, nsha1);
>>         for (end = target; *end && *end != '\n'; end++)
>>                 ;
>> +       if (!memcmp(target, "HEAD", end - target)) {
>> +               /* Don't say "HEAD detached at HEAD" */
>> +               unsigned char head[GIT_SHA1_RAWSZ];
>> +               get_sha1("HEAD", head);
>> +               strbuf_addstr(&cb->buf, find_unique_abbrev(head, DEFAULT_ABBREV));
>> +               return 1;
>> +       }
>>         strbuf_add(&cb->buf, target, end - target);
>>         return 1;
>>  }
>>
>> What do you think?

I think we should return (the hex repr. of) nsha1 instead of resolving
HEAD at its current state. That should solve the present problem (and
leave the more difficult reflog issue for the future).

Michael
