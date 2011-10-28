From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/WIP 02/11] notes-merge: use opendir/readdir instead of
 using read_directory()
Date: Sat, 29 Oct 2011 07:47:44 +1100
Message-ID: <CACsJy8B8Zd092JsBqtuVA-zR-o_uPH2m73wJa0uqgkokE5qnNw@mail.gmail.com>
References: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
 <1319438176-7304-3-git-send-email-pclouds@gmail.com> <7vzkgo3m9b.fsf@alter.siamese.dyndns.org>
 <CACsJy8CocoAiVx_PeaaX1oRZvmzfj9-z9JLJkE5unSRVtpGkNA@mail.gmail.com>
 <7vmxcn3b8w.fsf@alter.siamese.dyndns.org> <CACsJy8C4iHffr4UYP9SvCU0OPC-LocUORwAQ492LqaV_tyvFQA@mail.gmail.com>
 <7vzkgmz6v0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 22:48:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJtLm-0000XD-6F
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 22:48:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933221Ab1J1UsR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Oct 2011 16:48:17 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:65425 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932754Ab1J1UsQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Oct 2011 16:48:16 -0400
Received: by bkbzt4 with SMTP id zt4so778990bkb.19
        for <git@vger.kernel.org>; Fri, 28 Oct 2011 13:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=83bxdOqc/MSr7wc6+TjzsHUgh2lVixu0O41DIP+hiLw=;
        b=aBH9vBWaV/mE2urqMucPgUvy6ga54d1W7KGrZaOeJvwyCrMTjxPCB4wPRaTejJUesh
         myPbAl60pfulumhYvFdZ9y9+9HZvKPNcRd1DMGWOlzqsHaOwmSioIEwRRP7idfRsVveV
         Lrfp1PGLVPMI/qHRadH9jcbQHJrJCXY+P+bV8=
Received: by 10.204.147.215 with SMTP id m23mr3618894bkv.84.1319834895209;
 Fri, 28 Oct 2011 13:48:15 -0700 (PDT)
Received: by 10.204.114.2 with HTTP; Fri, 28 Oct 2011 13:47:44 -0700 (PDT)
In-Reply-To: <7vzkgmz6v0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184432>

On Fri, Oct 28, 2011 at 4:23 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>>> When read_directory("where/ever") is called, what kind of paths doe=
s it
>>> collect? Do the paths the function collects share "where/ever" as t=
heir
>>> common prefix? I thought it collects the paths relative to whatever
>>> top-level directory given to the function, so that "where/ever" cou=
ld be
>>> anything.
>>
>> Correct. But read_directory() takes pathspec now so naturally it doe=
s
>> not treat "where/ever" a common prefix anymore. =C2=A0So it has to o=
pen(".")
>> and starts from there.
>
> That is a puzzling statement. The read_directory() function takes:
>
> =C2=A0- dir: use this struct to pass traversal status and collected p=
aths;
>
> =C2=A0- path, len: this is the directory (not a pathspec) we start tr=
aversal
> =C2=A0 from; and
>
> =C2=A0- pathspec: these are the patterns that specify which parts of =
the
> =C2=A0 directory hierarchy under <path,len> are traversed.
>
> I do not see any good reason for <path,len> to become a match pattern=
=2E Are
> you trying to get it prepended to elements in pathspec[] and match th=
e path
> collected including the <path> part?
>
> Why?
>
> I could see that "open . and start from there, treating as if <path,l=
en>
> is also pathspec" could be made to work, but I do not see why that is
> desirable.
>
> In other words, are there existing callers that abuse read_directory(=
)
> to feed a pattern in <path,len>? Maybe they should be the one that ne=
eds
> fixing instead?

fill_directory() tries to calculate a common prefix (i.e. <path,len>
to read_directory()) from pathspec and that may or may not work when
pathspec magic comes into play. But yes, I could just make
fill_directory() pass <"",0> to read_directory() and keep <path,len>
in read_directory() for notes-merge and future users.
--=20
Duy
