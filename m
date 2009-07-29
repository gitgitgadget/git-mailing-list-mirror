From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 5/5] unpack_trees(): add support for sparse checkout
Date: Thu, 30 Jul 2009 09:32:01 +1000
Message-ID: <fcaeb9bf0907291632n418508ccke6ad274211690e59@mail.gmail.com>
References: <1248850154-5469-1-git-send-email-pclouds@gmail.com> 
	<1248850154-5469-2-git-send-email-pclouds@gmail.com> <1248850154-5469-3-git-send-email-pclouds@gmail.com> 
	<1248850154-5469-4-git-send-email-pclouds@gmail.com> <1248850154-5469-5-git-send-email-pclouds@gmail.com> 
	<1248850154-5469-6-git-send-email-pclouds@gmail.com> <m3zlan1zhv.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 01:32:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWIdJ-0000Ku-MD
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 01:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755185AbZG2XcW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jul 2009 19:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754869AbZG2XcV
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 19:32:21 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:20533 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754826AbZG2XcV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 19:32:21 -0400
Received: by an-out-0708.google.com with SMTP id d40so1330622and.1
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 16:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=q3nblUdxLdWB3AQ/i2diS2msJpcIrQfO5B61Nw9FHyo=;
        b=NLK6iRGZDdqms9kikoOxRegImza1a0kLSSBW7sbxD8wkRLo6YBxYzYlG8nl5IkQ9ai
         B0JyqKFmWbF5fTalHeOvQwF9PfKZ3CotsL1mxbnaFQmDgla33EAnBp1A7cKvD8Nnl7YL
         N9aIoE0zo7vGIqwOw12FLaN5CK74ghsRzOarI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=OBsaamYM0+0ONW85xJcXjECWT+osKzWxTZbS7m4h+hSfKypkqfq2sjd5EdULs23a98
         WjHsbkJTgvB8F/+WsxzEiYmc9INj8CPUOtLvp+Ca3hcgFl5MR4XP+QCEkO6LvR4wsZa0
         nBzxYSOQ4Tts9jpvUgyQlZb24S1gwGqgs2G+4=
Received: by 10.100.44.4 with SMTP id r4mr632610anr.13.1248910341124; Wed, 29 
	Jul 2009 16:32:21 -0700 (PDT)
In-Reply-To: <m3zlan1zhv.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124411>

2009/7/29 Jakub Narebski <jnareb@gmail.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0 =C2=A0<pclouds@gmail=
=2Ecom> writes:
>
>> This patch teaches unpack_trees() to checkout/remove entries
>> on working directories appropriately when sparse checkout area is
>> changed. A helper "git shape-workdir" is needed to help determine
>> which entry will be checked out, which will be not.
>
> Wouldn't "git update-index --index-info" (perhaps extended) be enough=
?

It's a bit more complicated because the in-memory index is filled with
various information and can't just be dumped out to be manipulated
with "git update-index".

>>
>> "git shape-workdir" will receive from stdin in this format
>>
>> X\tpathname
>>
>> where X is either
>> =C2=A0- '!' current entry is already CE_VALID
>> =C2=A0- 'N' current entry is "new" (it has not been in index before)
>> =C2=A0- '-' current entry is "normal" entry
>>
>> "git shape-workdir" is expected to return either "1" or "0"
>> immediately. "1" means the entry should be in workdir. "0" means
>> setting CE_VALID and get rid of it from workdir.
>
> Just in case it would be better IMVHO if it returned "1\tpathname" or
> "2\tpathname". =C2=A0By the way, is 'pathname' quoted if necessary, a=
nd
> does git-shape-workdir support -z/--null option?

It doesn't currently. Thanks for the suggestion.

> Signoff (also in some other patches in this series)?

This series is mainly for taking input on how git-shape-workdir should
behave, what format is good... That's why I did not sign off. Anyway
the series is not really well tested (and obvious lacks tests)
--=20
Duy
