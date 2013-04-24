From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 2/7] show: obey --textconv for blobs
Date: Wed, 24 Apr 2013 12:09:47 +0200
Message-ID: <5177AF6B.5040102@drmicha.warpmail.net>
References: <517298D4.3030802@drmicha.warpmail.net> <c631e41a9f9b02f1ad5e40dd4bcaf18670b27c59.1366718624.git.git@drmicha.warpmail.net> <7va9opl1om.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	jeremy.rosen@openwide.fr, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 12:09:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUwe6-00084b-D7
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 12:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758176Ab3DXKJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 06:09:41 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:46789 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752487Ab3DXKJk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Apr 2013 06:09:40 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id CCD9F21375;
	Wed, 24 Apr 2013 06:09:39 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 24 Apr 2013 06:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=vt+YxQBZfQ8+rwnsRBhdQs
	pqO3I=; b=k9sFintUTUeTzbRmtP+iR7AXztocyzd519TUVmk9qB3yE6AexGHCJd
	1mctkFF/qSTYOlBPeKAhkRyPK7mOk/eAIqr3OJWswu2YqCj7bffOPgGabapg4KcW
	hNHP5HAYAunZa3epvrAYBgP8zCSwEV1D0fMNeJ+50O74cQV5cW6oc=
X-Sasl-enc: Ymf5Uq41/95mLt3+vD4vEHmA6z9zkMuPGCv+57KvBSRC 1366798179
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 0043BC80005;
	Wed, 24 Apr 2013 06:09:38 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130402 Thunderbird/17.0.5
In-Reply-To: <7va9opl1om.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222247>

Junio C Hamano venit, vidit, dixit 23.04.2013 17:14:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>>> Subject: Re: [PATCHv2 2/7] show: obey --textconv for blobs
> 
> s/obey/honor/;

I missed that one, thanks.

>> Currently, "diff" and "cat-file" for blobs honor "--textconv" options
>> (with the former defaulting to "--textconv" and the latter to
>> "--no-textconv") whereas "show" does not honor this option, even though
>> it takes diff options.
>>
>> Make "show" on blobs behave like "diff", i.e. honor "--textconv" by
>> default and "--no-textconv" when given.
> 
> It is the right thing to do to teach it to react to --[no-]textconv;
> I am not sure if the default is right, though.

That is the question ;)

>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>>  builtin/log.c            | 24 +++++++++++++++++++++---
>>  t/t4030-diff-textconv.sh |  8 +++++++-
>>  2 files changed, 28 insertions(+), 4 deletions(-)
>>
>> diff --git a/builtin/log.c b/builtin/log.c
>> index 5f3ed77..fe0275e 100644
>> --- a/builtin/log.c
>> +++ b/builtin/log.c
>> @@ -436,10 +436,28 @@ static void show_tagger(char *buf, int len, struct rev_info *rev)
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
>> @@ -525,7 +543,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
>>  		const char *name = objects[i].name;
>>  		switch (o->type) {
>>  		case OBJ_BLOB:
>> -			ret = show_blob_object(o->sha1, NULL);
>> +			ret = show_blob_object(o->sha1, &rev, name);
>>  			break;
>>  		case OBJ_TAG: {
>>  			struct tag *t = (struct tag *)o;
>> diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
>> index 260ea92..f9d55e1 100755
>> --- a/t/t4030-diff-textconv.sh
>> +++ b/t/t4030-diff-textconv.sh
>> @@ -90,12 +90,18 @@ test_expect_success 'status -v produces text' '
>>  	git reset --soft HEAD@{1}
>>  '
>>  
>> -test_expect_failure 'show blob produces text' '
>> +test_expect_success 'show blob produces text' '
>>  	git show HEAD:file >actual &&
>>  	printf "0\\n1\\n" >expect &&
>>  	test_cmp expect actual
>>  '
>>  
>> +test_expect_success 'show --no-textconv blob produces binary' '
>> +	git show --no-textconv HEAD:file >actual &&
>> +	printf "\\0\\n\\1\\n" >expect &&
>> +	test_cmp expect actual
>> +'
>> +
>>  test_expect_success 'grep-diff (-G) operates on textconv data (add)' '
>>  	echo one >expect &&
>>  	git log --root --format=%s -G0 >actual &&
