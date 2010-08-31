From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC] notes: avoid recommitting identical trees
Date: Tue, 31 Aug 2010 20:45:22 +0200
Message-ID: <4C7D4DC2.4070008@drmicha.warpmail.net>
References: <4C7CD65F.10509@atlas-elektronik.com> <bc44b3393db4018487bb956d00a12fa73f04ca9e.1283267564.git.git@drmicha.warpmail.net> <20100831160145.GC11014@sigill.intra.peff.net> <4C7D2AAE.9000701@drmicha.warpmail.net> <7vfwxud94w.fsf@alter.siamese.dyndns.org> <4C7D495A.1080806@drmicha.warpmail.net> <20100831182931.GA21489@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>,
	stefan.naewe@atlas-elektronik.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 31 20:45:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqVpn-0006fH-QG
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 20:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397Ab0HaSpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 14:45:22 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33182 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752714Ab0HaSpW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 14:45:22 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A15B81AD;
	Tue, 31 Aug 2010 14:45:21 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 31 Aug 2010 14:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=fLNmG7JaonKv0R49L5QARAsKmgo=; b=TduJG+fZ0qEIB7mtZ8PW/+6hjp3M3dEU0NcMfYXFBmLwQbS/YvwIPkl6vFSsAObnIIB8mYO47WkOT9zZKR8u9S3NmzrFwfrdpOL05QEejG22ZrtAi4qctbaKGBxehHXXQayAPJ6aDpDh2/SbxZifx5xZYpfTKDOg33LlYpWZJ0o=
X-Sasl-enc: cTZUWEMNgIxGNrjJc5sZ3Q/b5WrbxmBCOOgiibhXd2tG 1283280321
Received: from localhost.localdomain (p54859079.dip0.t-ipconnect.de [84.133.144.121])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 39BBD5E5764;
	Tue, 31 Aug 2010 14:45:20 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8) Gecko/20100806 Fedora/3.1.2-1.fc13 Lightning/1.0b2pre Thunderbird/3.1.2
In-Reply-To: <20100831182931.GA21489@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154962>

Jeff King venit, vidit, dixit 31.08.2010 20:29:
> On Tue, Aug 31, 2010 at 08:26:34PM +0200, Michael J Gruber wrote:
> 
>> Junio C Hamano venit, vidit, dixit 31.08.2010 18:44:
>>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>>
>>>>>> +	if (!parent || parse_commit(parent->item) || parse_tree(parent->item->tree) ||
>>>>>> +		hashcmp(parent->item->tree->object.sha1, tree_sha1)) {
>>>>>
>>>>> I didn't check, but I can imagine you can drop the parse_tree here. We
>>>>> should know the object sha1 once the commit is parsed.
>>>>
>>>> parse_commit() does a lookup_tree() but I don't think that it parses the
>>>> tree, i.e. I don't hink it fills in tree->object.sha1.
>>>
>>> Huh?  parse_tree(tree) calls read_sha1_file(tree->object.sha1) to parse
>>> the tree.  How can it do without filling tree->object.sha1?
>>>
>>
>> Sure parse_tree() does that. That's why I call it. I never claimed it
>> doesn't.
> 
> I think the claim is that it is already parsed. Look at parse_tree. The
> first non-declaration lines are:
> 
>   if (item->object.parsed)
>           return 0;
>   buffer = read_sha1_file(item->object.sha1, &type, &size);
> 
> So _somebody_ has already filled in item->object.sha1.
> 
> -Peff

OK, now I understand Junio's answer...
...and I also see where lookup_tree() fills the sha1, which I failed to
see before.

I guess what happened was that I had the parse_tree without
parse_commit, which segfaulted, and then inserted parse_commit.

In any case, it seems Johan is going with his approach, so you can
forget about the RFC, be it with or without parse_tree.

Michael
