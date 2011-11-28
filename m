From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 0/6] echo usernames as they are typed
Date: Mon, 28 Nov 2011 13:59:34 +0100
Message-ID: <CABPQNSYd8PFsoRi6NtjQYNQzM+NHv_aRCLRWQ=XsFuw2gGWAng@mail.gmail.com>
References: <20111124105801.GA6168@sigill.intra.peff.net> <20111127082744.GA32068@sigill.intra.peff.net>
 <CABPQNSb09kxjvdvz2P-WqU2VtMspaaA8ujTNLJ4+MuCrV=2zsw@mail.gmail.com>
 <20111128035321.GA15640@sigill.intra.peff.net> <CABPQNSbLvWh-ivaqBk-Du+kwZvV3t+ajEJhHATRzyGZbHYyM=Q@mail.gmail.com>
 <20111128113127.GA23408@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 28 14:00:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RV0oq-0001N2-Ne
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 14:00:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693Ab1K1NAQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Nov 2011 08:00:16 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:34364 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706Ab1K1NAP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2011 08:00:15 -0500
Received: by ggnr5 with SMTP id r5so5179727ggn.19
        for <git@vger.kernel.org>; Mon, 28 Nov 2011 05:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=Qf6bzzHgge+qGEy3xN5KzESI8gEEay9Of4J0lk6gHoI=;
        b=C0E7UyDFtpPtMNMiuvq02isVjKLp7HELtZrcNnxykrGVhlzfSzmzP5V19kk/OST3Pd
         HIB54bTli2eM37Jcq9UREz4lOAwnidAl7JtOAgN2QXmOVwK7CoJxCfJMcb5X1HR0l6C4
         DFEmL+wpEO5awqz+6/yUlMbTlWA2tz5KVT0Lk=
Received: by 10.68.38.106 with SMTP id f10mr53764875pbk.37.1322485215056; Mon,
 28 Nov 2011 05:00:15 -0800 (PST)
Received: by 10.68.21.39 with HTTP; Mon, 28 Nov 2011 04:59:34 -0800 (PST)
In-Reply-To: <20111128113127.GA23408@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186014>

On Mon, Nov 28, 2011 at 12:31 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Nov 28, 2011 at 10:36:21AM +0100, Erik Faye-Lund wrote:
>
>> > You really want to open "/dev/tty" on most Unix systems (which is =
what
>> > getpass() does).
>>
>> Yes, you're right. Opening "/dev/tty" is much better. But what happe=
ns
>> for processes started by GUI applications (with no easily observable
>> tty, if any)? Does open simply fail? If so, is it desirable for us t=
o
>> fail in that case?
>
> Yes, the open will fail (on Linux, I get ENXIO).
>
> And yes, we should fail in that case. getpass() will generally return
> NULL in that instance, and the current implementation of git_getpass(=
)
> will die(), explaining that we could not get the password.
>
>> > I have no idea what would be appropriate on Windows.
>>
>> It's pretty similar, but not exactly: CreateFile("CONIN$", ...) or
>> CreateFile("CONOUT$", ...), depending on if you want the read-handle
>> or the write-handle... I can probably cook up something a bit more
>> concrete, though.
>
> OK, that maps to the /dev/tty concept quite well. Though I suspect th=
e
> code for turning off character echo-ing is going to also be different=
=2E
>
>> But _getch() that we already use always reads from the console
>> (according to MSDN, I haven't actually tested this myself:
>> http://msdn.microsoft.com/en-us/library/078sfkak%28v=3DVS.80%29.aspx=
).
>> But I don't think this allows us to fail when no console is attached=
=2E
>> Question is, should we fail in such cases? Windows does have an API =
to
>> prompt for passwords in a GUI window... Perhaps fallbacking to those
>> are the way to go? Something like:
>>
>> if (GetConsoleWindow()) {
>> =A0 =A0 =A0 /* =A0normal console-stuff */
>> } else {
>> =A0 =A0 =A0 /* call CredUIPromptForWindowsCredentials(...) instead *=
/
>> }
>
> Certainly on non-Windows something like that would not be welcome. Th=
e
> user can already have specified GIT_ASKPASS if they don't have a
> terminal. And once the credential-helper code is in, they can use a
> platform-specific helper that provides a nice dialog if they want it.
>

Yes, that's certainly cleaner implementation-wise. But didn't you
change it to only do the storage-part in the last round, or did I
misunderstand the updated series?

> So I would say trying to do something graphical would be surprising a=
nd
> unwelcome. But then, I am a very Unix-y kind of guy. Maybe on Windows
> something like that would be more favorable. I'll leave that decision=
 to
> people who know more.

Windows doesn't really have that strict norms when it comes to console
applications, but it'd be nice if it didn't do anything obviously
wrong when the GUI isn't available (non-interactive sessions,
PowerShell remote commands, CopSSH, etc). So I guess this is yet
another argument to stay with the credential-helper instead, if
possible...
