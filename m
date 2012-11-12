From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2] replace: parse revision argument for -d
Date: Mon, 12 Nov 2012 09:51:34 +0100
Message-ID: <50A0B896.8050700@drmicha.warpmail.net>
References: <508E55B2.6060502@drmicha.warpmail.net> <24b0f81315ddab8cc37133d5b3bec8aec90ed652.1351516888.git.git@drmicha.warpmail.net> <20121109164808.GE19725@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 12 09:51:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXpkF-00038D-38
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 09:51:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559Ab2KLIvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 03:51:36 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:34213 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751489Ab2KLIvg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Nov 2012 03:51:36 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 8143620677;
	Mon, 12 Nov 2012 03:51:35 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 12 Nov 2012 03:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=UG2/2KAolnxnd0oIfpxIhI
	8U40k=; b=WJG4eCiOu872H07Sx6L1mgKa4fvzaGD7aE/ya7KeX256wqYg69Mf8u
	iujwGL5Eo1DoEw9AJ4rVjkldmt5Qm3nu4C4hVzyE7Fbo2BNXplPWL+DJpql04Gje
	pjAm4+wL0hghQd86H0CqTmWG70uXxRPa0m1tJN3BnQnt2aAyz7hk4=
X-Sasl-enc: CHxHNb/UdBcqFq685bQNIe3xExGRuDJ+5P50MignU4yE 1352710295
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 01A068E0515;
	Mon, 12 Nov 2012 03:51:34 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
In-Reply-To: <20121109164808.GE19725@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209472>

Jeff King venit, vidit, dixit 09.11.2012 17:48:
> On Mon, Oct 29, 2012 at 02:23:27PM +0100, Michael J Gruber wrote:
> 
>> 'git replace' parses the revision arguments when it creates replacements
>> (so that a sha1 can be abbreviated, e.g.) but not when deleting
>> replacements.
>>
>> Make it parse the arguments to 'replace -d' in the same way.
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>> v2 has the simplified error check as per Jeff, and a reworded message.
>> Comes with a free test case, too.
> 
> I noticed this today in my pile of "to look at" patches. Sorry for being
> slow.

No problem. This is not urgent, and it takes some effort to look at code
amongst all those black-and-white discussions. [It even takes effort to
refrain from responding when you words are being twisted around...]

>>  	for (p = argv; *p; p++) {
>> -		if (snprintf(ref, sizeof(ref), "refs/replace/%s", *p)
>> -					>= sizeof(ref)) {
>> -			error("replace ref name too long: %.*s...", 50, *p);
>> +		q = *p;
>> +		if (get_sha1(q, sha1)) {
>> +			error("Failed to resolve '%s' as a valid ref.", q);
>>  			had_error = 1;
>>  			continue;
>>  		}
> 
> Looks reasonable.
> 
>> +		q = sha1_to_hex(sha1);
>> +		snprintf(ref, sizeof(ref), "refs/replace/%s", q);
>>  		if (read_ref(ref, sha1)) {
>> -			error("replace ref '%s' not found.", *p);
>> +			error("replace ref '%s' not found.", q);
> 
> I worry a little about assuming that "q", which points to a static
> internal buffer of sha1_to_hex, is still valid after calling read_ref.
> We'll end up in resolve_ref, which might need to do considerable work
> (e.g., loading the whole packed refs file). Just grepping for
> sha1_to_hex, I don't think it is a problem currently, but it might be
> worth copying the value (you could even point into the "ref" buffer to
> avoid dealing with an extra allocation).

We could just leave '*p' as it is (after all, that was the user input),
or use 'ref+strlen("refs/replace/")'.

I wasn't aware of the volatile nature of the return value. Thanks for
spotting!

Michael
