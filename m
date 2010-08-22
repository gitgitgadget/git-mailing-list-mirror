From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [msysGit] upload-pack timing issue on windows?
Date: Mon, 23 Aug 2010 01:27:41 +0200
Message-ID: <AANLkTimk+SsmiHk7zWCTEeghk3sYjapDCDeZX=TP9UH_@mail.gmail.com>
References: <40aa078e1002051551o6d116a50uee3f6a32b16adb46@mail.gmail.com>
	<201002061106.04305.j6t@kdbg.org>
	<40aa078e1002060401r1dec3c2ate3ddd4f5f5db1e0c@mail.gmail.com>
	<201002062318.59180.j6t@kdbg.org>
	<40aa078e1002080318n16918f91r5a5f4cd9b76a8436@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, msysgit@googlegroups.com,
	Git Mailing List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Aug 23 01:28:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnJxI-0006gD-0n
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 01:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120Ab0HVX1o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Aug 2010 19:27:44 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34446 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807Ab0HVX1m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Aug 2010 19:27:42 -0400
Received: by vws3 with SMTP id 3so4799263vws.19
        for <git@vger.kernel.org>; Sun, 22 Aug 2010 16:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=s6fZSWPGPzLKEHQzrRsR+r6HF189rU7p9kmgolZZFtE=;
        b=xI0U0Lwf30Tv/HVknHSgJ3pl/52Xo8hEZPUfg0zZVUNIgu5dKB7jB/0smEublfexmd
         BdwdUMicGK5A5GWdEc5SbbvDEBlZ/sPXUZ5LYHMr9zJj+llhQXsP0PqogMVWr67PkivR
         hF4Xiei0Q2Xa1gLMVgXKHK7L3oBjEQRXfXNww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=rmwKAOuR204TPImpBn4jZj4vbDiR5DwJyuwE4axglfQ2ui2j5Aame/bWTikvNeTfJd
         RP2Ki7jD97M7f/MvHUZUaooWMR1zO4Vi+WDuZvkKlCPAeuuCX7LV17CZ3T5KBrB1txar
         7HiTAuWHHnjkJlqrsl+bJ0JGKxkCEdRrlKPFM=
Received: by 10.220.88.30 with SMTP id y30mr2636849vcl.239.1282519661645; Sun,
 22 Aug 2010 16:27:41 -0700 (PDT)
Received: by 10.220.180.76 with HTTP; Sun, 22 Aug 2010 16:27:41 -0700 (PDT)
In-Reply-To: <40aa078e1002080318n16918f91r5a5f4cd9b76a8436@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154200>

On Mon, Feb 8, 2010 at 1:18 PM, Erik Faye-Lund <kusmabite@googlemail.co=
m> wrote:
> On Sat, Feb 6, 2010 at 11:18 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> On Samstag, 6. Februar 2010, Erik Faye-Lund wrote:
>>> However, I have tracked down a bit of what goes on in the client.
>>> There's a call to read_in_full, called from pack-write.c, line 246
>>> that fails in the failure-case, but not in the success-case. This i=
s
>>> where the client expects "pack\tSHA-1" or "keep\tSHA-1". There "fat=
al:
>>> early EOF"-messages seems to originate from index-pack.c, line 197.
>>> This is the first line of code in parse_pack_header(), it's also
>>> AFAICT the first call-site for any read(0, <...>) (though fill()).
>>
>> This looks like upload-pack died without sending enough to fill a pa=
ck header.
>>
>> Try merging this branch:
>>
>> =A0git://repo.or.cz/git/mingw/j6t.git async-in-thread
>>
>> It contains your changes to start_async plus a refinement of die() w=
hen it is
>> called from the async procedure (it passes t5530, for example). It i=
s also
>> converted to pthreads, and therefore also works on Unix. The new
>> implementation of start_async is more careful about the file handles=
, though
>> not so much on Windows.
>>
>> If there's no change for you, then you could look into implementing
>> fcntl(F_GETFD/SETFD, FD_CLOEXEC), which are currently ignored, on to=
p of this
>> branch, using Get/SetHandleInformation().
>>
>
> Thanks a lot. I tried merging it, but the issue still pops up. I also
> tried to implement fcntl(F_GETFD/SETFD, FD_CLOEXEC), still no dice.
> I'm not entirely sure if I did it correctly, though.
>

More than 6 months later, and I've finally bothered to debug this furth=
er:
- The culprit seems to be our poll-emulation. My understanding is that
poll() was called by create_pack_file() in upload-pack.c with nfds=3D1
(it's 2 until one of the fds are closed) when there's no data
available in the pipe. Since our poll() always returns POLLIN when
nfds=3D1, the check for xread(...) =3D=3D 0 further down in
create_pack_file() cause the fd to be closed, leading to an error on
the client-side.
-  Just removing the nfds=3D1-hack works for me, but I'm suspecting the
nfds=3D1-hack is there for some socket-reason. So instead I've replaced
our poll-emulation with gnulib's in my branch (with a couple of
patches on top), and it seems to do the trick for me. I still haven't
tested it heavily, though.
- The easiest way I've found to debug the issue, is to use git-fetch
from localhost with a repo with a single commit with a single, empty
file. Doing this triggers the bug every time for me, and doesn't hide
what's going on as much as git-clone does.

The latest version of my branch can be found here:
http://repo.or.cz/w/git/kusma.git/shortlog/refs/heads/work/daemon-win32=
-process
