From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] Fix 'git clean' failure on NFS.
Date: Fri, 18 Jun 2010 15:26:20 +0200
Message-ID: <AANLkTinEGpB567-v8TXFv5ghXfjY9ZtkOMYcGOhzePj3@mail.gmail.com>
References: <loom.20100618T122039-876@post.gmane.org>
	<1276859235-13534-1-git-send-email-edwintorok@gmail.com>
	<AANLkTimm1XMmDORpnezYHSNPrKFup2H5ODQLrgJivDwg@mail.gmail.com>
	<4C1B6E13.1030309@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: =?ISO-8859-1?Q?T=F6r=F6k_Edwin?= <edwintorok@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 18 15:26:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPbaX-0003Wn-46
	for gcvg-git-2@lo.gmane.org; Fri, 18 Jun 2010 15:26:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314Ab0FRN0X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jun 2010 09:26:23 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:55868 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932184Ab0FRN0W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jun 2010 09:26:22 -0400
Received: by wwb22 with SMTP id 22so145976wwb.19
        for <git@vger.kernel.org>; Fri, 18 Jun 2010 06:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=E1V3c397ybK0mBPG1tVOeCMpA4URRxFhHva6egrqVlo=;
        b=apsxtKj4qpsc0T0EkWGMfhJuiXA8axy5+UBAl9jdTTwvvrNfvttubITYxNAV1AAlBE
         Hz+jt9LEyMp1SBFT2Cp47HSwlyasuPAetvQBW6ageY2pd7AkErSmp3X2OjDXAheR9sfz
         q1VubJ+DboXb1+JadFtqdBKryY51r6Y+Jrjlk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=HVK3e3JvuFhDFY70uf7dISgS23V2WNdIHytr5KVcn56YH9GUCkYafLkZoZwJviuP7P
         TO/4WCduk7dbicQZ3IuJdHvcqzlHc0++mdDK53ebppfSltNaSDn+4N7ceZsS8L6KlYnv
         dN5X5qI0XLnOEam6Q5vIMpjYMKLqOvoAbP5Cs=
Received: by 10.216.87.130 with SMTP id y2mr840268wee.13.1276867580850; Fri, 
	18 Jun 2010 06:26:20 -0700 (PDT)
Received: by 10.216.53.132 with HTTP; Fri, 18 Jun 2010 06:26:20 -0700 (PDT)
In-Reply-To: <4C1B6E13.1030309@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149346>

2010/6/18 T=F6r=F6k Edwin <edwintorok@gmail.com>:
> On 06/18/2010 03:29 PM, Erik Faye-Lund wrote:
>> 2010/6/18 T=F6r=F6k Edwin <edwintorok@gmail.com>:
>>> readdir() used to do a single pass, which is not always enough.
>>> If you unlink some files/rmdir some subdirs then there might be som=
e
>>> files you haven't seen yet *before* the readdir cursor (files get r=
earranged
>>> in the directory, etc.).
>>>
>>> The fix is to do an additional readdir() pass if we unlinked/rmdire=
d something.
>>> This is easily accomplished by using rewinddir.
>>>
>>
>> Won't this break on Windows? mingw_readdir() doesn't seem to have a
>> maching mingw_rewinddir() in compat/mingw.c/h....
>>
>
> rewinddir() is used in ClamAV too, and it builds natively on win32.
> I think we have some compat function that map rewinddir to the Win32
> API, somebody will probably have to do that for git too.
>

There's a rewinddir function in msvcrt.dll. However, we're not using
msvcrt.dll's opendir() implementation for performance reasons, so this
patch would require a rewinddir implementation as a preparation path,
no? If such a patch could be extracted from ClamAV (and ClamAV is
license compatible with git), would you mind including such a patch
for the next round?

> Another possibility is to do closedir/opendir again on mingw.

Yes. Yet another possibility is to enable the
NO_MINGW_REPLACE_READDIR-switch, but this has negative performance
effects...

--=20
Erik "kusma" Faye-Lund
