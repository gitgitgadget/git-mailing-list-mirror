From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Support working directory located at root
Date: Tue, 9 Feb 2010 09:18:22 +0700
Message-ID: <fcaeb9bf1002081818s53f8646ev80afbaa37f039e50@mail.gmail.com>
References: <1265640810-6361-1-git-send-email-pclouds@gmail.com> 
	<7v8wb3pqqw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Jo=C3=A3o_Carlos_Mendes_Lu=C3=ADs?= <jonny@jonny.eng.br>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Feb 09 03:18:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nefge-0007aZ-5f
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 03:18:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752965Ab0BICSn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Feb 2010 21:18:43 -0500
Received: from mail-px0-f202.google.com ([209.85.216.202]:43655 "EHLO
	mail-px0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763Ab0BICSm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Feb 2010 21:18:42 -0500
Received: by pxi40 with SMTP id 40so6977446pxi.21
        for <git@vger.kernel.org>; Mon, 08 Feb 2010 18:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=rJ6L5PMfAH0GW5vPmZeJkIP3qRUzNg59hVVTOfLCGCc=;
        b=kseS60mBv52dcO0IYaX16lsrYCxKeQY7ZzJwpDi5ZzyPjs5wJOJZINBp/YIdgn59dR
         xgEaOg8AhW2QapB35YcRR2LwrAmi+8/xKcsTqYWwhhy7RgjvP649rNSvZt0Zmtt2h0Yl
         QigAFdW7mwkKA2Me9bIwC00jwJgq19/JReabI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=mc0U50sgbOjGx225wu0MMlTrk07MHEFoGvSqEAqsliSqH/1W96cG+Kls7s7KfOFMHC
         LOISnVJXl4rDHmF4RaxKM2hZWKYHHdoaCyVXLXyznclebVnJMMQ9W4OewCxThCBIEPhW
         k2wdUt7fp0vK37fXRWUB026ctmW2j5z3PZSU8=
Received: by 10.115.38.27 with SMTP id q27mr4995432waj.58.1265681922086; Mon, 
	08 Feb 2010 18:18:42 -0800 (PST)
In-Reply-To: <7v8wb3pqqw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139348>

2010/2/9 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> Git should work regardless where the working directory is located,
>> even at root. This patch fixes two places where it assumes working
>> directory always have parent directory.
>>
>> In setup_git_directory_gently(), when Git goes up to root and finds
>> .git there, it happily sets worktree to "".
>
> If you mean "instead set it to "/" and things will work much better."
> I agree with the reasoning (not suggesting to reword---just trying to
> make sure I understood what you meant).

Yes.

>
>> In prefix_path(), loosen the outside repo check a little bit. Usuall=
y
>> when a path XXX is inside worktree /foo, it must be either "/foo", o=
r
>> "/foo/...". When worktree is simply "/", we can safely ignore the
>> check: we have a slash at the beginning already.
>
> The logic for the "are we inside?" check above sounds correct. =C2=A0=
When
> work_tree is at root, have "/" in it, and len inside the "if orig is
> absolute" block is 1, so memmove() strips out the leading '/' and mak=
es
> the result relative to the root level. =C2=A0Am I reading the code ri=
ght?

You are. But I suspect my change in this code is not enough and caused
the problem (on msys?) for Hannes. If the worktree somehow is '//' and
sanitized is '/etc/resolv.conf', then we could end up eating two
chars, leading to "'tc/resolv.conf' not match" error.

Hannes, can you put a "printf("%s\n", work_tree);" in prefix_path() to
see if it's the case?
--=20
Duy
