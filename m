From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 6/6] grep: obey --textconv for the case rev:path
Date: Sat, 20 Apr 2013 16:42:49 +0200
Message-ID: <5172A969.9000106@drmicha.warpmail.net>
References: <cover.1366389739.git.git@drmicha.warpmail.net> <717ec305e9bd056a44b1da5cc478d314db2920e5.1366389739.git.git@drmicha.warpmail.net> <20130420042445.GD24970@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 20 16:55:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTZCY-0001sz-1K
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 16:55:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755366Ab3DTOzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 10:55:40 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:38984 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755328Ab3DTOzf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Apr 2013 10:55:35 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id C9D3D203DE;
	Sat, 20 Apr 2013 10:44:30 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute4.internal (MEProxy); Sat, 20 Apr 2013 10:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=+85KSvZgG/SoAgMXuiulmj
	kZ9vk=; b=IqdyZRuf9n1M2mx9LodXONSAfYh/Y55hgudbB/FbSkJCgEogFbj9xL
	OyhkQdsoESIaxK9KhFI2Z3OcrxDkoBv5++ObYYcsR/hHAXWefHZ35c5Kz3+2kS4+
	gmIQGVtwBsak41V8JULJ2MPTmgv+WhcxwPKl7Mbhsk3XnFIfSn97Y=
X-Sasl-enc: 2u/FzR+vgLK5hqYwacZY5rMypKU0FnyPr+kxaPKc//hd 1366469070
Received: from localhost.localdomain (unknown [88.70.147.219])
	by mail.messagingengine.com (Postfix) with ESMTPA id 235D6C80004;
	Sat, 20 Apr 2013 10:44:30 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130402 Thunderbird/17.0.5
In-Reply-To: <20130420042445.GD24970@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221857>

Jeff King venit, vidit, dixit 20.04.2013 06:24:
> On Fri, Apr 19, 2013 at 06:44:49PM +0200, Michael J Gruber wrote:
> 
>> @@ -820,12 +820,13 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>>  	for (i = 0; i < argc; i++) {
>>  		const char *arg = argv[i];
>>  		unsigned char sha1[20];
>> +		struct object_context oc;
>>  		/* Is it a rev? */
>> -		if (!get_sha1(arg, sha1)) {
>> +		if (!get_sha1_with_context(arg, 0, sha1, &oc)) {
>>  			struct object *object = parse_object_or_die(sha1, arg);
>>  			if (!seen_dashdash)
>>  				verify_non_filename(prefix, arg);
>> -			add_object_array(object, arg, &list);
>> +			add_object_array_with_context(object, arg, &list, xmemdupz(&oc, sizeof(struct object_context)));
> 
> Hrm. I'm not excited about the extra allocation here. Who frees it?
> 
>> +void add_object_array(struct object *obj, const char *name, struct object_array *array)
>> +{
>> +	add_object_array_with_mode(obj, name, array, S_IFINVALID);
>> +}
>> +
>> +void add_object_array_with_mode(struct object *obj, const char *name, struct object_array *array, unsigned mode)
>> +{
>> +	add_object_array_with_mode_context(obj, name, array, mode, NULL);
>> +}
>> +
>> +void add_object_array_with_context(struct object *obj, const char *name, struct object_array *array, struct object_context *context)
>> +{
>> +	if (context)
>> +		add_object_array_with_mode_context(obj, name, array, context->mode, context);
>> +	else
>> +		add_object_array_with_mode_context(obj, name, array, S_IFINVALID, context);
>> +}
> 
> And this mass of almost-the-same functions is gross, too, especially
> given that the object_context contains a mode itself.

Well, it's just providing different ways to call into the one and only
function, in order to satisfy different callers' needs. It's not unheard
of (or rather: unseen) in our code, is it?

> Unfortunately, I'm not sure if I have a more pleasant suggestion. I seem
> to recall wrestling with this issue during the last round, too.

Yes, I think that's what we ended up with. At least it's just one
context struct per argument to grep, so it's not that bad after all.

I vaguely seem to recall we had some more general framework cooking but
I may be wrong (I was offline due to sickness for a while). It was about
attaching some additional info to something. Yes, I said "vaguely" ...

Michael
