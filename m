From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Proper plumbing for porcelain gpg formats on git show?
Date: Mon, 19 Jan 2015 15:13:34 +0100
Message-ID: <54BD110E.2080801@drmicha.warpmail.net>
References: <EB979B4B153D49909C78239A333869FB@black><20150116192947.GD29365@google.com> <xmqqk30m1p0t.fsf@gitster.dls.corp.google.com> <6B1E582B25CD4722B8993C5A3C304ECA@black>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	jpyeron@pdinc.us
X-From: git-owner@vger.kernel.org Mon Jan 19 15:13:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDD5J-0002Ea-2A
	for gcvg-git-2@plane.gmane.org; Mon, 19 Jan 2015 15:13:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbbASONh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2015 09:13:37 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44964 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751404AbbASONg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jan 2015 09:13:36 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id C4DC6208FE
	for <git@vger.kernel.org>; Mon, 19 Jan 2015 09:13:35 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Mon, 19 Jan 2015 09:13:35 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=yEH7IqVVx5whmXbdfZMlgs
	Z6YCg=; b=EuIjmCDftMCPDI46BxvGYVDzhzjoYlQAmuFFnSQKjpi8DNxp2q2dtH
	vkd5kFVKdoSebMvluEr7CE/mlMsgWV/VMZZQkBHoTdzli4U4N/SonlEaNqitzBdC
	RT260NDv7HPCPu6UEaauYAsrDPV7c8TmFSnqErHcXzEGaRRJvbMlI=
X-Sasl-enc: Jdm7r+9+0jklg5qq9fj6eOxE9HIx8hN+fL+f2cz6RhF2 1421676815
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 0579CC00019;
	Mon, 19 Jan 2015 09:13:34 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <6B1E582B25CD4722B8993C5A3C304ECA@black>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262614>

Jason Pyeron schrieb am 16.01.2015 um 21:05:
>> -----Original Message-----
>> From: Junio C Hamano
>> Sent: Friday, January 16, 2015 14:53
>>
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>
>>>> would there be interest in accepting a patch for 
>>>>
>>>> %Gs - the raw GPG text from the commit
>>>> %Gf - the key fingerprint
>>>
>>> There may be bikeshedding on the exact format specifier, but aside
>>> from that I don't see why not. ;-)
>>
>> I was about to say "As long as the execution is good, why not?
>> Spawning an extra process 'gpg --list-packets' is not quite
>> acceptable without properly being lazy is not acceptable".
>>
>> But verify_signed_buffer() reads "gpg --status-fd=1 --verify"
>> output, it is already done lazily in format_commit_one() only when
>> the "%G?" placeholder is used, and the output we parse that are
>> prefixed by [GNUPG:] should have enough information to grab the
>> fingerprint from on the VALIDSIG line.
>>
>> So I do not see a lot of room to screw-up the execution ;-).
> 
> This kind of begs the question of extracting signatures, not in one's keyring. I was surprised to see %GK fail because it was not yet in the keyring. I would also expect a "B", not a "N" for %G?, maybe there should be a "X" for can't verify.
> 
> $ gpg --delete-keys DA0848AD
> gpg (GnuPG) 2.0.14; Copyright (C) 2009 Free Software Foundation, Inc.
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.
> 
> 
> pub  2048R/DA0848AD 2014-06-24 Jason Pyeron <jpyeron@pdinc.us>
> 
> Delete this key from the keyring? (y/N) y
> 
> $ git diff-tree -s --format=%G? HEAD
> N
> 
> $ git diff-tree -s --format=%GG HEAD
> gpg: Signature made Fri 16 Jan 2015 01:33:12 PM EST using RSA key ID DA0848AD
> gpg: Can't check signature: No public key
> 
> 
> $ git diff-tree -s --format=%GK HEAD
> 
> $ gpg --keyserver hkp://pgp.mit.edu --recv-keys 8D6B5984DA0848AD
> gpg: requesting key DA0848AD from hkp server pgp.mit.edu
> gpg: key DA0848AD: public key "Jason Pyeron <jpyeron@pdinc.us>" imported
> gpg: Total number processed: 1
> gpg:               imported: 1  (RSA: 1)
> 
> $ git diff-tree -s --format=%G? HEAD
> U
> 
> $ git diff-tree -s --format=%GG HEAD
> gpg: Signature made Fri 16 Jan 2015 01:33:12 PM EST using RSA key ID DA0848AD
> gpg: Good signature from "Jason Pyeron <jpyeron@pdinc.us>"
> gpg: WARNING: This key is not certified with a trusted signature!
> gpg:          There is no indication that the signature belongs to the owner.
> Primary key fingerprint: 8C88 9ECF 7A2F 7977 7CE9  13B4 8D6B 5984 DA08 48AD
> 
> 
> $ git diff-tree -s --format=%GK HEAD
> 8D6B5984DA0848AD

I'm not exactly sure what you are trying to extract, but "git
verify-commit -v" gives you the actual signature, which you can then
feed into gpg/gpgsplit for surgery according to taste.

As far as git goes, I think it should give you all gpg information that
it has available but not morph into a gpg frontend or trust manager.

Ultimately, signature verification in its true meaning requires human
inspection of the full gpg output.

Michael
