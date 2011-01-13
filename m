From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Applying .gitattributes text/eol changes
Date: Thu, 13 Jan 2011 15:30:30 -0800
Message-ID: <7vd3o01iw9.fsf@alter.siamese.dyndns.org>
References: <4D220500.2000104@syntevo.com>
 <4D2C4902.4010705@drmicha.warpmail.net> <4D2C62DF.20706@syntevo.com>
 <4D2EFCBD.4020402@drmicha.warpmail.net> <4D2F0BF3.2000808@syntevo.com>
 <4D2F0E3A.8090108@drmicha.warpmail.net> <4D2F12EE.4020400@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Marc Strapetz <marc.strapetz@syntevo.com>
X-From: git-owner@vger.kernel.org Fri Jan 14 00:30:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdWcz-0004fw-DE
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 00:30:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757313Ab1AMXao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jan 2011 18:30:44 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33399 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756916Ab1AMXam (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jan 2011 18:30:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D972E4C59;
	Thu, 13 Jan 2011 18:31:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g8Dv9A5W/THmBwz3Y1qyUq70MCw=; b=LWSTXk
	wcgAN8DAlGBoORyb8dbfXmgYL/PLi3fKwB0OAvJ0iGogN7bRXJKFCbA5ZyILRTmX
	3ZrqP1Nsl7lkvd5LzaGXrSLwM2Fy+DDPHrmbQ3mDMJo/n41LGeeDMGm+MlXO80JF
	OTB31laesbRoQJhlbuHjsqRgbaxMT7lqiSX+g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nINf84FFsTa6Xrt6eP56LAvwQthkg5nG
	i8I16Uxp6PaaYxS7F/ryq2JmuIezYlkm+dYyM+Cs9aXfQHkkPc3h4R+0FZn/1Swp
	sb9EjPVvxSai3DsoEgMmVrA+z2u5B9NHvzc8Owfjl+OHM/56+NThHb1ENaeYsfWh
	/hdvAUtrZQo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A98DF4C57;
	Thu, 13 Jan 2011 18:31:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3B1A14C56; Thu, 13 Jan 2011
 18:31:13 -0500 (EST)
In-Reply-To: <4D2F12EE.4020400@syntevo.com> (Marc Strapetz's message of
 "Thu\, 13 Jan 2011 15\:57\:50 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 38C7EA38-1F6D-11E0-B18E-94B21C7297B3-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165068>

Marc Strapetz <marc.strapetz@syntevo.com> writes:

> So your suggestion is to fix "git update-index --really-refresh", so

The option is about telling git: "Earlier I promised I wouldn't touch
these paths by setting their assume-unchanged bit, but I touched them.
Please refresh the cached stat information in the index, ignoring the
promise I didn't keep."

I do not think it is a good idea to conflate your "Everything is suspect
because smudge filter has changed; please recompute all" request into the
same option.  People who use assume-unchanged would probably want "Please
rescan because I changed smudge filter" request to be carried out while
still honoring the assume-unchanged bit they set earlier.

> Anyway, I'm still wondering if it will resolve the "git reset --hard"
> problem of re-checking out every file, even if content is already
> identical in the working tree. I think that part has to be fixed, too.

There is not much to fix there. If you removed the index, then there is no
information to tell you that "content is already identical" unless you
actually check things out and compare.  By the time you found it out, you
already have done the checkout.

IOW, the current code does:

	open object
        read from the object
        deflate and write to the destination file

while your "fix" needs to look like this:

	open object
        read from the object
        deflate and write to a temporary file
        open the existing file
        read from the file and compare it to the temporary we just wrote
        if same, delete, otherwise rename the temporary file.

just for the rare case where there is an untracked file that the user is
willing to overwrite (we are discussing "rm .git/index && reset --hard"
here) happens to have the same contents.  Not a good enough reason to add
unwelcome complexity to the codepath.

> What do you think about "git checkout --fix-eols" option as an
> alternative? Its uses cases are more limited, though.

What does it do?  "git checkout --fix-eols $path" will overwrite $path
with the data at $path in the index?  Perhaps you can use the "-f" option.

Adding an option to "checkout" might be better than update-index from the
UI point of view, but the issue is not just "eols".  "eol" is a mere
special case of smudge filter that controls how the contents from the
repository are modified before getting written out to the working tree.
