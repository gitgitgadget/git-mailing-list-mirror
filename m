From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: git status --porcelain is a mess that needs fixing
Date: Sun, 11 Apr 2010 00:56:47 +1000
Message-ID: <h2j2cfc40321004100756g15ad7f12jf37e500f924e7b96@mail.gmail.com>
References: <20100409184608.C7C61475FEF@snark.thyrsus.com>
	 <20100410040959.GA11977@coredump.intra.peff.net>
	 <9c7e1f33b7ec0dab68a92aa8f067989e@212.159.54.234>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Eric Raymond <esr@snark.thyrsus.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sat Apr 10 16:56:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0c7B-0007Uu-IH
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 16:56:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907Ab0DJO4t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Apr 2010 10:56:49 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:56399 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743Ab0DJO4s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Apr 2010 10:56:48 -0400
Received: by qyk9 with SMTP id 9so2409644qyk.1
        for <git@vger.kernel.org>; Sat, 10 Apr 2010 07:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JAzZyvXfAZ8/owZaThP3bsZhakn5dJ1y0iWdr75ddaU=;
        b=U01LwsCLcHkAiQh20QX9lC+fR7dGZcDfWf9XH8CyoSLS6J+cc28pLET0eke6/WITOw
         91bJx3L0h68udBfwpsslAtMtaWHsCZ5swze5J810vOrKpyBuYvYEbSMmlcBl4J+UQa8y
         p+FC6GBvtHaQNau3Xu5UNpHldvJ3wBFIDG9Lo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=M2a+3dH65fYk2QCYh2bSPcY1GAvj5b+4GhQpddzChvDVKCTnXfSZp1JugSOKviUJHE
         fuWxOs6dLBqxAaLSXTjKtIcueDSBqbtzGOpzDNtiMUIL2et4bDPGYdysFH3bA0YpFcfw
         fmIfexAKok71OJnkchQbH7uO7lRUJ4rxPqnCE=
Received: by 10.229.185.136 with HTTP; Sat, 10 Apr 2010 07:56:47 -0700 (PDT)
In-Reply-To: <9c7e1f33b7ec0dab68a92aa8f067989e@212.159.54.234>
Received: by 10.229.251.72 with SMTP id mr8mr2448092qcb.30.1270911407428; Sat, 
	10 Apr 2010 07:56:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144557>

On Sat, Apr 10, 2010 at 11:35 PM, Julian Phillips
<julian@quantumfyre.co.uk> wrote:
> On Sat, 10 Apr 2010 00:09:59 -0400, Jeff King <peff@peff.net> wrote:
>> Your parser is already broken if you are calling split, as the filen=
ames
>> may contain spaces (and will be quoted in that case, and you need to
>> unmangle). You should use "-z".
>>
>> You will probably then realize that the "-z" format looks like:
>>
>> =C2=A0 XY file1\0file2\0
>>
>> which still sucks. It would be more friendly as:
>>
>> =C2=A0 XY\0file1\0file2\0
>>
>> So you could split on "\0". But even with that, you can't just blind=
ly
>> split, as the column and record separators are the same, and you mig=
ht
>> have one or two filenames.
>
> Not true. =C2=A0If the second form was used, then you _can_ split on =
\0. =C2=A0It
> will tokenise the data for you, and then you consume ether two or thr=
ee
> tokens depending on the status flags. =C2=A0So it would make the pars=
ing
> simpler. =C2=A0But to make it even easier, how about adding a -Z that=
 makes the
> output format "XY\0file1\0[file2]\0" (i.e. always three tokens per re=
cord,
> with the third token being empty if there is no second filename)? =C2=
=A0Though
> if future expandability was wanted you could end each record with \0\=
0 and
> then parsing would be a two stages of split on \0\0 for records and t=
hen
> split on \0 for entries?

Surely that won't work - if file2 can be empty, \0[file2]\0 reduces to
\0\0 which would be confused with the \0\0 proposed as a record
separator.

jon.
