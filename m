From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH v2 06/14] mingw: use real pid
Date: Sat, 16 Jan 2010 10:12:47 +0100
Message-ID: <40aa078e1001160112k68c0daafnd6abcb715e1176fe@mail.gmail.com>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
	 <201001152330.06083.j6t@kdbg.org>
	 <40aa078e1001151453i3576a345k217944c38887b61f@mail.gmail.com>
	 <201001160903.25162.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Jan 16 10:12:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NW4iH-0001U6-LI
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 10:12:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275Ab0APJMu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Jan 2010 04:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752234Ab0APJMu
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 04:12:50 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:41171 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049Ab0APJMt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Jan 2010 04:12:49 -0500
Received: by ey-out-2122.google.com with SMTP id d26so274202eyd.19
        for <git@vger.kernel.org>; Sat, 16 Jan 2010 01:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zByHrVCPXBYKAavSb8cqoBtqRmljdy1cmtGlocDEZt8=;
        b=w4psn3F0453sdkOmfWyI3mlDNB3qUPN3OiO1GXpHEtqM36lx1i3LiW0IavSl7L43cg
         iimK3vr+8sJq0SsA2vkPe0Bbil4Lm7f3aS8IejqTB6IHyJAHyPsq9vBjV6Buol1RwHIE
         ceiJuTrKH/yRLJVTl2/iG0ScGAEOBMSetIYRY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=wOHrvgl8hEJuBt7lr5nwhQv7/hXOdmsLVVQIPjCbUU3duMbkKM/LoAN4xgljP9cCiz
         XDI7gMBpqTpDVo3BQNusLdmBahwK5OH73dOKt+J6cOoz3mZZngM5XxEQ28BfI9uuSaXN
         bl3+yYqL3LbMW60T414CM8X6k9zTc+qb5rnpA=
Received: by 10.216.88.136 with SMTP id a8mr1156191wef.77.1263633167148; Sat, 
	16 Jan 2010 01:12:47 -0800 (PST)
In-Reply-To: <201001160903.25162.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137209>

On Sat, Jan 16, 2010 at 9:03 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Freitag, 15. Januar 2010, Erik Faye-Lund wrote:
>> On Fri, Jan 15, 2010 at 11:30 PM, Johannes Sixt <j6t@kdbg.org> wrote=
:
>> > On Freitag, 15. Januar 2010, Erik Faye-Lund wrote:
>> >> @@ -729,7 +729,7 @@ static pid_t mingw_spawnve(const char *cmd, c=
onst
>> >> char **argv, char **env, return -1;
>> >> =A0 =A0 =A0 }
>> >> =A0 =A0 =A0 CloseHandle(pi.hThread);
>> >> - =A0 =A0 return (pid_t)pi.hProcess;
>> >> + =A0 =A0 return (pid_t)pi.dwProcessId;
>> >> =A0}
>> >
>> > You are not using the pi.hProcess anymore, so you must close it.
>>
>> No. If I do, the pid becomes invalid after the process is finished,
>> and waitpid won't work. I couldn't find anywhere were we actually we=
re
>> closing the handle, even after it was finished. So I don't think we
>> leak any more than we already did (for non-daemon purposes).
>
> Previously, this handle was closed by _cwait() (it was the "pid"), so=
 we
> didn't leak it.

Oh, I see. My planned route with this (before I looked for where the
handle was closed), was to maintain some sort of list of each started
PID and their handle, and lookup in that list instead of using
OpenProcess. I guess that would solve the problem here, but it feels a
bit nasty. Not as nasty as introducing a leak, though.

>
> I somehow thought that you need the process ID instead of the handle =
for
> TerminateProcess, but now I see that this is not the case (it takes t=
he
> handle). So I don't see the point of this change anymore. You say the=
 process
> handle "does not work consistently with getpid", but I don't know wha=
t you
> mean. Please explain.

getpid() returns the real PID, and is used for prefixing each logged
message by git-daemon. However, the root process reports whenever a
new process is started or has terminated using the PID returned by
mingw_spawnve(), and this handle does not match up with the PID that
getpid() reports. Thus it becomes impossible to tell which reported
error belongs to which client.

--=20
Erik "kusma" Faye-Lund
