From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] tag,verify-tag: do not trip over rfc1991 signatures
Date: Tue, 05 Oct 2010 22:42:35 +0200
Message-ID: <4CAB8DBB.3030706@drmicha.warpmail.net>
References: <4CAB46C0.9000807@drmicha.warpmail.net> <5cea498f34522d603a1561bfe69e2f92caa39ced.1286293083.git.git@drmicha.warpmail.net> <7vr5g45qqx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stephan Hugel <urschrei@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 22:42:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3ELQ-0006pu-If
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 22:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755063Ab0JEUm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 16:42:26 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:45495 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752597Ab0JEUmZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Oct 2010 16:42:25 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 87D5C685B;
	Tue,  5 Oct 2010 16:42:24 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 05 Oct 2010 16:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=nJ7qA9TjbYB054sqRgBACl88zUo=; b=UO7/f1zxNru/Kxt6fqw4LN67yIabE0D9jXxQ5Njqc/HZ5WxubYYkvIN9JcEuoAYWcROvjW2hzIvrOp2YzcZ1wSLWW75fh+GP4EOWFQq1AhkNJMQr2SmYlejXU7f8Sb5+KAq5+v85KiAz9EsDnfNwPc8cDbeJdxd4b92RnEbtokA=
X-Sasl-enc: UOvkpOkVyB3EJuFbIywQHyBgu1O8596p+vQpMJYq2l4C 1286311344
Received: from localhost.localdomain (p54858F63.dip0.t-ipconnect.de [84.133.143.99])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 75FA75E0C92;
	Tue,  5 Oct 2010 16:42:23 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100921 Fedora/3.1.4-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <7vr5g45qqx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158238>

Junio C Hamano venit, vidit, dixit 05.10.2010 22:28:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Currently, git expects "-----BEGIN PGP SIGNATURE-----" at the beginning of a
>> signature. But gpg uses "MESSAGE" instead of "SIGNATURE" when used with
>> the "rfc1991" option. This leads to git's faling to verify it's own
>> signed tags.
>>
>> Be more lenient and take "-----BEGIN PGP " as the indicator.
> 
> Thanks, but it bothers me that the patch is a bit inconsistently lenient.
> 
> How many variants of PGP implementations are there?  For example, I'd ask
> these without doing my own research because I am lazy:
> 
>  1. Does everybody place five dashes at the beginning (IOW, is there an
>     odd variant that puts four or six)?
> 
>  2. Does everybody follow the dashes immediately with "BEGIN" (IOW, is
>     there an odd variant that puts a SP between them)?
> 
>  3. Does everybody spell "BEGIN PGP " the same way, in all uppercase?
> 
>  4. Does everybody place five dashes at the end (IOW, is there an odd
>     variant that puts four or six)?
> 
>  5. Does everybody follow the "BEGIN PGP SOMETHING" immediately with
>     dashes without SP?
> 
> Your patch seem to answer <yes, yes, yes, no, no> to the above question.

On 4,5, my patch only implies that I (suggest we) don't care.

> I'd find it saner if the patched code at least checked that the line ends
> with 5 dashes.

Alternatively, we can just say we support gnupg/openpg but not pgp 2.0,
and running gpg with pgp 2.0 options is discouraged even by gpg's man page.

The main issue here is that we create a detached signature (rather than
a clear text signature) but then lump it together with the content (the
tag object sans sig). The boundary mark between the two is not
controlled by us but by gpg (and its options).

In order to verify the sig, *we* have to split the lump again but we
don't really know the boundary mark. It's insane by design. We should
have used a non-volatile boundary mark.

I'll check whether we can somehow feed the whole lump to gpg and make it
recognize the attached-detached signature. That way we'd be as
compatible as gpg.

Michael
