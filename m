From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv3 3/7] show: honor --textconv for blobs
Date: Sat, 11 May 2013 10:54:25 +0200
Message-ID: <518E0741.1060008@drmicha.warpmail.net>
References: <7vy5c1l6nb.fsf@alter.siamese.dyndns.org> <c4ed1e0b67877e6453b8c269290e09e1672ce37d.1368197380.git.git@drmicha.warpmail.net> <7vy5bm22f8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 11 11:39:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub6HH-0007Yh-MR
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 11:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754007Ab3EKJj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 05:39:28 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43713 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752742Ab3EKJj1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 May 2013 05:39:27 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id E40AD20812;
	Sat, 11 May 2013 05:39:25 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute2.internal (MEProxy); Sat, 11 May 2013 05:39:25 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=anRV3zT4+J12DY93jV63+K
	+eESo=; b=sG00KJ+b2FKhq5p2Pnpdv7zmXwzOk0UpGdXk5NZT7LEsuzjAnq9ULI
	m7lKSIZa8/r/haZNGJ8mYxNFfFZoFvf955mjfkG5qg6IGYHtCIwVi0wdvWMPDMh+
	3DSJ8WgTKYpyJEnl+4p8HbzsWS/pnyd2n8xAj9U7soCo4JF/vYRDo=
X-Sasl-enc: XYnWARpeJB+85Cy/+fyVEWDqymFVSsfJ4dOIPqZXACXX 1368265165
Received: from localhost.localdomain (unknown [213.221.117.228])
	by mail.messagingengine.com (Postfix) with ESMTPA id 298DC200161;
	Sat, 11 May 2013 05:39:25 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130402 Thunderbird/17.0.5
In-Reply-To: <7vy5bm22f8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223948>

Junio C Hamano venit, vidit, dixit 10.05.2013 19:02:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Currently, "diff" and "cat-file" for blobs honor "--textconv" options
>> (with the former defaulting to "--textconv" and the latter to
>> "--no-textconv") whereas "show" does not honor this option, even though
>> it takes diff options.
>>
>> Make "show" on blobs behave like "diff", i.e. honor "--textconv" by
>> default and "--no-textconv" when given.
> 
> Hmm...

Sorry, I overlooked that ;)

>> +static int show_blob_object(const unsigned char *sha1, struct rev_info *rev, const char *obj_name)
>>  {
>> +	unsigned char sha1c[20];
>> +	struct object_context obj_context;
>> +	char *buf;
>> +	unsigned long size;
>> +
>>  	fflush(stdout);
>> -	return stream_blob_to_fd(1, sha1, NULL, 0);
>> +	if (!DIFF_OPT_TOUCHED(&rev->diffopt, ALLOW_TEXTCONV) ||
>> +	    !DIFF_OPT_TST(&rev->diffopt, ALLOW_TEXTCONV))
>> +		return stream_blob_to_fd(1, sha1, NULL, 0);
> 
> It is surprising that the necessary change is only this, but I think
> it is correct ;-).  We ignore textconv when the command line did not
> mention --[no-]textconv, or the command line said --no-textconv
> explicitly.
> 
> This (especially the first condition) may deserve an in-code comment
> for anybody who wonders where this default behaviour is implemented.

It's not as if we would document behavior by in-code comments in
general, do we? The usual answer is "git log -S" or "git blame".

> So "show" on blobs does show the raw contents by default, but the
> user can explicitly ask to enable textconv with --[no-]textconv.  Is
> the second paragraph in the log message still valid?
> 
>> +	if (get_sha1_with_context(obj_name, 0, sha1c, &obj_context))
>> +		die("Not a valid object name %s", obj_name);
> 
> This looks somewhat unfortunate.
> 
> We already have sha1[]; actually we not just know sha1[] but have
> the struct object for it.  How did we obtain it before we got here?
> 
> Will we always have a valid name in rev.pending.objects->name?  Will
> that name convert back to the same sha1 we got in sha1[]?
> 
> I think the answers are "Yes (it is a command line argument), Yes
> (that is what setup_revisions() got by feeding the name to give us
> sha1[])".
> 
> I wonder if enriching rev_info->pending with the context information
> might be a clean solution to avoid this redundant but unavoidable
> conversion, but that is a separate and future topic, I think.

Yes, I think both Jeff and I have thought it and came to the same
conclusion - "later" ;)

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
>> @@ -526,7 +545,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
>>  		const char *name = objects[i].name;
>>  		switch (o->type) {
>>  		case OBJ_BLOB:
>> -			ret = show_blob_object(o->sha1, NULL);
>> +			ret = show_blob_object(o->sha1, &rev, name);
>>  			break;
>>  		case OBJ_TAG: {
>>  			struct tag *t = (struct tag *)o;
>> diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
>> index 3950fc9..0ebb028 100755
>> --- a/t/t4030-diff-textconv.sh
>> +++ b/t/t4030-diff-textconv.sh
>> @@ -96,14 +96,14 @@ test_expect_success 'show blob produces binary' '
>>  	test_cmp expect actual
>>  '
>>  
>> -test_expect_failure 'show --textconv blob produces text' '
>> +test_expect_success 'show --textconv blob produces text' '
>>  	git show --textconv HEAD:file >actual &&
>>  	printf "0\\n1\\n" >expect &&
>>  	test_cmp expect actual
>>  '
>>  
>> -test_success 'show --no-textconv blob produces binary' '
>> -	git show --textconv HEAD:file >actual &&
>> +test_expect_success 'show --no-textconv blob produces binary' '
>> +	git show --no-textconv HEAD:file >actual &&
>>  	printf "\\0\\n\\01\\n" >expect &&
>>  	test_cmp expect actual
>>  '
