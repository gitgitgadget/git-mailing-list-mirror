From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: can Git encrypt/decrypt .gpg on push/fetch?
Date: Fri, 09 Sep 2011 15:36:29 +0200
Message-ID: <4E6A165D.5010703@drmicha.warpmail.net>
References: <87lityxbg7.fsf@lifelogs.com> <CAGhXAGSw3y=cjAHXtwycDifoBPr13AkYtLHRRXejRKue0vkz7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: tzz@lifelogs.com, git@vger.kernel.org
To: Aneesh Bhasin <contact.aneesh@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 15:36:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R21G0-0003SQ-4w
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 15:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759058Ab1IINge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 09:36:34 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:50630 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759053Ab1IINgb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Sep 2011 09:36:31 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 60467295A2;
	Fri,  9 Sep 2011 09:36:31 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 09 Sep 2011 09:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=yzZrsuwBzudSCAMuPExGVL
	IbPC0=; b=ba85ozGF2G2P9JQWy8vQBx3YJfAIDPnfP0B8s7MFMNtXN7MuiLyY2t
	1oNK+FWR8n9bIjcpDMwhTEyFn5kqDEJqpIpa5E6zkCraKCGR5cSM0ix2aVAlgC2A
	mjlg7UpHPsTAcoJoohOcoMJ8w7CuSuA/wXOQgtAedplGyNfSjQMHo=
X-Sasl-enc: nB1Q4FJKqlq4DEUrzDQnSgTHytNMaANmIRK4eg5S7gcA 1315575391
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B9A0BB4062A;
	Fri,  9 Sep 2011 09:36:30 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <CAGhXAGSw3y=cjAHXtwycDifoBPr13AkYtLHRRXejRKue0vkz7A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181063>

Aneesh Bhasin venit, vidit, dixit 09.09.2011 12:50:
> Hi Ted,
> 
> 
> 2011/9/9 Ted Zlatanov <tzz@lifelogs.com>
>>
>> I need to store some encrypted files in Git but for some clients with
>> the right GPG keys, decrypt them on checkout (possibly also encrypt them
>> back on commit, but that's not as important).
>>
>> diff doesn't have to work, this is just for convenience.  Can Git do
>> this (matching only .gpg files) or do I need my own command to run after
>> the checkout/fetch and before commit?  It seems pretty out of Git's
>> scope but perhaps others have done this before.
>>
> 
> Have you looked at git hooks (e.g. here : http://progit.org/book/ch7-3.html).
> 
> You could do the encryption/decryption in pre-commit and post-checkout
> hooks scripts respectively...

I'd recommend textconv for diffing and clean/smudge for plaintext
checkout. That is, there are two convenient versions:

A) Keep blobs and checkout encrypted
- Use an editor which can encrypt/decrypt on the fly (e.g. vim)
- Use "*.gpg diff=gpg" in your attributes and
[diff "gpg"]
        textconv = gpg -d
  in your config to have cleartext diffs. Use cachetextconv with caution ;)

B) Keep blobs encrypted, checkout decrypted
- Use Use "*.gpg filter=gpg" in your attributes and
[filter "gpg"]
	smudge = gpg -d
	clean = gpg -e -r yourgpgkey
  in your config.

I use A on a regular basis. B is untested (but patterned after a similar
gzip filter I use). You may or may not have better results with "gpg -ea".

On clients without the keys, you can simply leave out the diff or filter
config resp. set them to "cat".

Michael
