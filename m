From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [msysGit] upload-pack timing issue on windows?
Date: Mon, 8 Feb 2010 12:18:06 +0100
Message-ID: <40aa078e1002080318n16918f91r5a5f4cd9b76a8436@mail.gmail.com>
References: <40aa078e1002051551o6d116a50uee3f6a32b16adb46@mail.gmail.com>
	 <201002061106.04305.j6t@kdbg.org>
	 <40aa078e1002060401r1dec3c2ate3ddd4f5f5db1e0c@mail.gmail.com>
	 <201002062318.59180.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Feb 08 12:18:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeRd9-0000P9-3a
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 12:18:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779Ab0BHLSJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Feb 2010 06:18:09 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:51483 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722Ab0BHLSH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Feb 2010 06:18:07 -0500
Received: by ewy28 with SMTP id 28so2327513ewy.28
        for <git@vger.kernel.org>; Mon, 08 Feb 2010 03:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UDro1GhLO3oAbkP5B2JiMkVZlCbRD++dQG6etgT96mU=;
        b=I+8/3bELvG2gGzJy2ZYhW0oWj7H4wmxXFJfqPfcfMjWqGudh6fk0BszRcYdNHZ7qhx
         cVSQ5QVgck/kOmKQKHUheIU546ESMoOaFmqnkj+v7Z6p5Tl7UUsKfSwTdIQtw/ErvVQw
         gH80CIgwjHjXUd51mwQ45/y1BL0k/LtqCWM78=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=A67/PhvN6iqW0JN7w6/0HsvwNVTN6gRb4xUs6PsR40f2FKznuyqoyLydX11HH6CVqh
         YD7Dz4v+JZr3OXPyetT3NzT9fE4kxgs1wDFXN0yWWkA/pWqopoV40uXOezorrRnvT9s6
         JPmwaJ+4+cSUke682vPysyqpMdAD3POhwKmDk=
Received: by 10.216.90.1 with SMTP id d1mr927845wef.136.1265627886235; Mon, 08 
	Feb 2010 03:18:06 -0800 (PST)
In-Reply-To: <201002062318.59180.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139285>

On Sat, Feb 6, 2010 at 11:18 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Samstag, 6. Februar 2010, Erik Faye-Lund wrote:
>> However, I have tracked down a bit of what goes on in the client.
>> There's a call to read_in_full, called from pack-write.c, line 246
>> that fails in the failure-case, but not in the success-case. This is
>> where the client expects "pack\tSHA-1" or "keep\tSHA-1". There "fata=
l:
>> early EOF"-messages seems to originate from index-pack.c, line 197.
>> This is the first line of code in parse_pack_header(), it's also
>> AFAICT the first call-site for any read(0, <...>) (though fill()).
>
> This looks like upload-pack died without sending enough to fill a pac=
k header.
>
> Try merging this branch:
>
> =A0git://repo.or.cz/git/mingw/j6t.git async-in-thread
>
> It contains your changes to start_async plus a refinement of die() wh=
en it is
> called from the async procedure (it passes t5530, for example). It is=
 also
> converted to pthreads, and therefore also works on Unix. The new
> implementation of start_async is more careful about the file handles,=
 though
> not so much on Windows.
>
> If there's no change for you, then you could look into implementing
> fcntl(F_GETFD/SETFD, FD_CLOEXEC), which are currently ignored, on top=
 of this
> branch, using Get/SetHandleInformation().
>

Thanks a lot. I tried merging it, but the issue still pops up. I also
tried to implement fcntl(F_GETFD/SETFD, FD_CLOEXEC), still no dice.
I'm not entirely sure if I did it correctly, though.

> Background: On Unix, we need FD_CLOEXEC so that the fds that are mean=
t for the
> async thread do not remain open in an unrelated child process; on Win=
dows, we
> are just lucky and can get away without FD_CLOEXEC because our pipe()=
s are
> non-inheritable and async only work with pipes. But once we pass othe=
r fds to
> the async procedure, we need a working FD_CLOEXEC. Perhaps something =
in this
> direction is related to your problem.
>
> You could push out your current state of the git-daemon and a recipe =
to
> reproduce the problem. Perhaps I find some time to look into it.
>

Sure. You can find my current version at
git://repo.or.cz/git/kusma.git work/daemon-fcntl

This branch includes your branch and my fcntl-attempt, as well as an
almost-fixed-up version of the last daemon-win32 series I sent out
(still lacking critical sections when saving process ids, as you
suggested).

--=20
Erik "kusma" Faye-Lund
