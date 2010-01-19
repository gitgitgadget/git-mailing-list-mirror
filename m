From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH v2 06/14] mingw: use real pid
Date: Tue, 19 Jan 2010 20:23:32 +0100
Message-ID: <40aa078e1001191123t7e8e9a47l46394d62648dfdb8@mail.gmail.com>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
	 <40aa078e1001160112k68c0daafnd6abcb715e1176fe@mail.gmail.com>
	 <40aa078e1001181433v3c86f147wf3e6aace4501c1a8@mail.gmail.com>
	 <201001191919.16070.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jan 19 20:23:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXJg2-0001f1-FA
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 20:23:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021Ab0ASTXf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Jan 2010 14:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870Ab0ASTXf
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 14:23:35 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:26793 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711Ab0ASTXe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jan 2010 14:23:34 -0500
Received: by fg-out-1718.google.com with SMTP id 22so1333230fge.1
        for <git@vger.kernel.org>; Tue, 19 Jan 2010 11:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iSZe+PwtsoY7wUleUegDOz1wqSAWVhshTSvbhOueH7g=;
        b=j/za04dJ9/5dnUraIQrNzkIWrqjp+fkPk0RdiiRl+eEbeiMXB0x8n5olmNLizyT3ZB
         4GfcYq/j7cQ4dCguS2xmiNQVZt9kmDsn4cLJYafJELnf5peaOWoyCLusWcqvHaVpNZEh
         mYjuICPY4QoZqMussiN4tACQgxLNI9pU0YiDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=wK/Yf/ibWj/KsaRYE6QabAZKryrSErEkqGBBQvSS6VheqVYMNVBCPyAbnpyAAc96Gk
         DbRuxWQ/a6kDpO58O8NllGc2QOViZSF0dkAcYuk1JbnfnqYmCUq5SwKS7STlXEv7EkxL
         wRli8jakQkXTX4r6dFHSX5U0WU3q8Zwn+ZlKY=
Received: by 10.216.88.75 with SMTP id z53mr1712358wee.46.1263929012878; Tue, 
	19 Jan 2010 11:23:32 -0800 (PST)
In-Reply-To: <201001191919.16070.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137489>

On Tue, Jan 19, 2010 at 7:19 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Montag, 18. Januar 2010, Erik Faye-Lund wrote:
>> On Sat, Jan 16, 2010 at 10:12 AM, Erik Faye-Lund wrote:
>> > On Sat, Jan 16, 2010 at 9:03 AM, Johannes Sixt <j6t@kdbg.org> wrot=
e:
>> >> On Freitag, 15. Januar 2010, Erik Faye-Lund wrote:
>> >>> No. If I do, the pid becomes invalid after the process is finish=
ed,
>> >>> and waitpid won't work. I couldn't find anywhere were we actuall=
y were
>> >>> closing the handle, even after it was finished. So I don't think=
 we
>> >>> leak any more than we already did (for non-daemon purposes).
>> >>
>> >> Previously, this handle was closed by _cwait() (it was the "pid")=
, so we
>> >> didn't leak it.
>> >
>> > Oh, I see. My planned route with this (before I looked for where t=
he
>> > handle was closed), was to maintain some sort of list of each star=
ted
>> > PID and their handle, and lookup in that list instead of using
>> > OpenProcess. I guess that would solve the problem here, but it fee=
ls a
>> > bit nasty. Not as nasty as introducing a leak, though.
>>
>> What I had in mind was something along these lines:
>
> Given that that the process ID is the user-visible (and system-wide u=
nique)
> identifier of a process, this looks like the only reasonable way to g=
o. Your
> implementation looks good as well.
>
>> + =A0 =A0 /* store process handle */
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * The process ID is the human-readable identifier of =
the process
> =A0 =A0 =A0 =A0 * that we want to present in log and error messages. =
The handle
> =A0 =A0 =A0 =A0 * is not useful for this purpose. But we cannot close=
 it, either,
> =A0 =A0 =A0 =A0 * because it is not possible to turn a process ID int=
o a process
> =A0 =A0 =A0 =A0 * handle after the process terminated.
> =A0 =A0 =A0 =A0 * Keep the handle in a list for waitpid.
> =A0 =A0 =A0 =A0 */
>

Much better, thanks.

--=20
Erik "kusma" Faye-Lund
