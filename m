From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH/RFC] config: Give error message when not changing a multivar
Date: Tue, 17 May 2011 16:03:00 +0200
Message-ID: <4DD28014.4090505@drmicha.warpmail.net>
References: <42ab57ae5a2cb7d6860e43e7c3061f9c38cf1b99.1305632091.git.git@drmicha.warpmail.net> <20110517123840.GB13176@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 17 16:03:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMKru-0006Qk-Na
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 16:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755114Ab1EQODF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 10:03:05 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:41466 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754849Ab1EQODD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2011 10:03:03 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 20799202FF;
	Tue, 17 May 2011 10:03:03 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute5.internal (MEProxy); Tue, 17 May 2011 10:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=gUFXjwXyZs/CqrGWQlwoMoxdZN8=; b=XGGzuCs5a9+qSHs0MciWLTCqL07CMN+3Ih6EszfUVd8TutRTYWUVh07eOc6oflOcURUwdzhPA5lCQPcAbRk8/+bcsmqljiBfqE5jKTFdIKgfyjbijXDVXtnPK1qXwq8yv4hN83mBdr4bEN8GSrYRtztDTm262eyjLtHI45ebsyE=
X-Sasl-enc: e3lhtyNphQOR2bQ3h4EN+HCTAuJOSVsNtBdcBff+E7Fi 1305640982
Received: from localhost.localdomain (p54858FA7.dip0.t-ipconnect.de [84.133.143.167])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7B8F74014CC;
	Tue, 17 May 2011 10:03:02 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <20110517123840.GB13176@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173798>

Jeff King venit, vidit, dixit 17.05.2011 14:38:
> On Tue, May 17, 2011 at 01:34:58PM +0200, Michael J Gruber wrote:
> 
>> Instead, make it
>>
>> warning: remote.repoor.push has multiple values
>> error: Use a regexp, --add or --set-all to change remote.repoor.push.
>>
>> to be clear and helpful.
>>
>> Note: The "warning" is raised through other code paths also so that it
>> needs to remain a warning for these (which do not raise the error). Only
>> the caller can determine how to go on from that.
> 
> Makes sense, and I think trying to change the "warning" text is not
> worth the effort.
> 
>>  	else if (actions == ACTION_SET) {
>> +		int ret;
>>  		check_argc(argc, 2, 2);
>>  		value = normalize_value(argv[0], argv[1]);
>> -		return git_config_set(argv[0], value);
>> +		ret = git_config_set(argv[0], value);
>> +		if (ret == 5)
>> +			error("Use a regexp, --add or --set-all to change %s.", argv[0]);
>> +		return ret;
>>  	}
> 
> What the heck is this 5? In fact, what in the world is going on with the
> return values from git_config_set_multivar? It looks like we can return
> 3, 4, 5, or 6 to return various errors, but they're not documented
> anywhere. Or we can return 2, propagated from parse_key. Or we can
> return -1 (negative!) if the lock doesn't work.
> 
> I think the last one is a straight-out error. For the other ones, we
> should probably document them in git-config(1). And it would be nice to
> at least have some symbolic constants in the code.
> 
> None of these problems is introduced by your patch, of course. But it
> might be nice to at least do the symbolic constants while we're looking
> at this so that your patch can use them.

OK, makes sense, I just wanted to request for comments early enough -
someone might think we should remove the warning from the present site
and make all callers deal with the return codes. But I don't think it's
worth it, and we have other places where we warn first, then error out.

Michael
