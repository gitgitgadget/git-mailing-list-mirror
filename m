From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [msysGit] upload-pack timing issue on windows?
Date: Wed, 10 Feb 2010 15:41:03 -0500
Message-ID: <76718491002101241y591c63abv403660bd22c814c3@mail.gmail.com>
References: <40aa078e1002051551o6d116a50uee3f6a32b16adb46@mail.gmail.com>
	 <201002061106.04305.j6t@kdbg.org>
	 <40aa078e1002060401r1dec3c2ate3ddd4f5f5db1e0c@mail.gmail.com>
	 <201002062318.59180.j6t@kdbg.org>
	 <40aa078e1002080318n16918f91r5a5f4cd9b76a8436@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, msysgit@googlegroups.com,
	Git Mailing List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Feb 10 21:41:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfJN2-0007WK-DF
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 21:41:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756209Ab0BJUlH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Feb 2010 15:41:07 -0500
Received: from mail-iw0-f185.google.com ([209.85.223.185]:36648 "EHLO
	mail-iw0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756222Ab0BJUlF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Feb 2010 15:41:05 -0500
Received: by iwn15 with SMTP id 15so490605iwn.19
        for <git@vger.kernel.org>; Wed, 10 Feb 2010 12:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JZDpH4+e0fFNtIDCo2QGsLNh5umEJVdMs4wjawwdaFw=;
        b=grJZgE4LSL83SzXLh5nb4To9LgC4iPsPWOL/uYJDfwigKNf1/g/dFXX+uBQMOI7Xjg
         hw98URqRzB0xopTtxO6nSjgDmtrpfTVXqEnfBMcp8jgXLnPP3CckY+1B+VZuDVhDR47M
         PxmppUnwE9tREJRS3F4GvJOlJ1TZF2xnFuWwU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PxGxCZ9Sdm6kcKFrrKi1Z+94Uj+NQu+stOWuCQ1SF52FwR6Hf4pfTf6jsUBtuIHiE3
         4ujHcmtHCn4JraBQh0WywYiT61bmAzY3NUyXHxMHXLVaz6Jttt6akI73TMX5HeHU4E1C
         7wOVdXFNbt5TSClHeBPpFgU/JttAvHIHcOedk=
Received: by 10.231.191.135 with SMTP id dm7mr472237ibb.46.1265834463949; Wed, 
	10 Feb 2010 12:41:03 -0800 (PST)
In-Reply-To: <40aa078e1002080318n16918f91r5a5f4cd9b76a8436@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139549>

On Mon, Feb 8, 2010 at 6:18 AM, Erik Faye-Lund <kusmabite@googlemail.co=
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
>> =C2=A0git://repo.or.cz/git/mingw/j6t.git async-in-thread
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

I have no idea if it's related, but a similar thing seems to happen
with git under cygwin-1.7.1.

http://article.gmane.org/gmane.os.cygwin/114032

This is when cloning/fetching over ssh. I've not personally seen the
problem, but I compile git from source. Coworkers who are using the
cygwin-1.7.1 provided git see the problem consistently.

j.
