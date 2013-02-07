From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH 1/4] show: obey --textconv for blobs
Date: Thu, 07 Feb 2013 09:48:21 +0100
Message-ID: <51136A55.7060805@drmicha.warpmail.net>
References: <20130205201106.GA29248@sigill.intra.peff.net> <cover.1360162813.git.git@drmicha.warpmail.net> <883f0163cb732932061a368ea9bc187c13e4ecca.1360162813.git.git@drmicha.warpmail.net> <7vmwvhmli7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 09:48:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3N9y-0001VE-QI
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 09:48:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590Ab3BGIsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 03:48:23 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:46431 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752401Ab3BGIsW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Feb 2013 03:48:22 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 3B0BD21209;
	Thu,  7 Feb 2013 03:48:21 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 07 Feb 2013 03:48:21 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=haBbWjjZR+IPNunJpLqz+b
	dkCB4=; b=pPwGjM2KR04LlbflKzSHNzVQtM/tdxCiZULU2cZ/D6vhp+SrBzkD+c
	j6NQo9vPbI09qsahEvPgRBRTe21FYhcpcBm7xMdLnYLkce+AK99J8CdR5yKYYBQk
	hxTKGjbAG+76UU7FlOEWzERM06azEhYR9Ud7xZGPkVd7w12Vrw8FY=
X-Sasl-enc: V2lNZXTL8SND73CwFVSjlpLzznEefzou5/H51BcSi1IG 1360226900
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7F9AF482484;
	Thu,  7 Feb 2013 03:48:20 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <7vmwvhmli7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215679>

Junio C Hamano venit, vidit, dixit 06.02.2013 17:53:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Currently, "diff" and "cat-file" for blobs obey "--textconv" options
>> (with the former defaulting to "--textconv" and the latter to
>> "--no-textconv") whereas "show" does not obey this option, even though
>> it takes diff options.
>>
>> Make "show" on blobs behave like "diff", i.e. obey "--textconv" by
>> default and "--no-textconv" when given.
> 
> What does "log -p" do currently, and what should it do?  Does/should
> it also use --textconv?

It invokes "--textconv" by default, and allows to override with
"--no-textconv. That's what I meant to say but seem to have failed to.

I think at some point we decided to have "human output" on by default
for all things diff (porcelain only, of course) unless the diff is meant
for machine consumption, such as in the case of format-patch.

> The --textconv is a natural extension of what --ext-diff provides us,
> so I think it should trigger the same way as how --ext-diff triggers.

This series' aim is to make the textconv behavior the same for all
"human output" commands. I don't see textconv and ext-diff to be
strongly related, and if then the other way round:

textconv is about converting blobs to a (possibly lossy) human
consumable text.

ext-diff is about computing diffs with an external diff "tool" (not in
the sense of diff-tool).

One way of diffing is textconving blobs then using internal diff on the
resulting text blobs, but ext-diff is more general and, really,
orthogonal in a way. (It used to be used often for what textconv does
when that didn't exist.)

> We apply "--ext-diff" for "diff" by default but not for "log -p" and
> "show"; I suspect this may have been for a good reason but I do not
> recall the discussion that led to the current behaviour offhand.

I don't think I changed anything ext-diff related, did I? 1/4 is about
showing blobs, not diffs.

>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>>  builtin/log.c | 24 +++++++++++++++++++++---
>>  1 file changed, 21 insertions(+), 3 deletions(-)
>>
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
>> +	if (!obj_context.path[0] ||
>> +	    !textconv_object(obj_context.path, obj_context.mode, sha1c, 1, &buf, &size))
>> +		return stream_blob_to_fd(1, sha1, NULL, 0);
>> +
>> +	if (!buf)
>> +		die("git show %s: bad file", obj_name);
>> +
>> +	write_or_die(1, buf, size);
>> +	return 0;
>>  }
>>  
>>  static int show_tag_object(const unsigned char *sha1, struct rev_info *rev)
>> @@ -491,7 +509,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
>>  		const char *name = objects[i].name;
>>  		switch (o->type) {
>>  		case OBJ_BLOB:
>> -			ret = show_blob_object(o->sha1, NULL);
>> +			ret = show_blob_object(o->sha1, &rev, name);
>>  			break;
>>  		case OBJ_TAG: {
>>  			struct tag *t = (struct tag *)o;
