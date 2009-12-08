From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [msysGit] [PATCH/RFC 03/11] mingw: implement syslog
Date: Tue, 8 Dec 2009 15:01:16 +0100
Message-ID: <40aa078e0912080601p3d73f8b4k469ba5229c931575@mail.gmail.com>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>
	 <200911262223.22777.j6t@kdbg.org>
	 <40aa078e0911270009u7569cfe5gb250092c8d2c0eac@mail.gmail.com>
	 <200911272023.58262.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org, dotzenlabs@gmail.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Dec 08 15:01:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI0d7-00073N-Nw
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 15:01:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755264AbZLHOBM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Dec 2009 09:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755242AbZLHOBM
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 09:01:12 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:62776 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204AbZLHOBL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Dec 2009 09:01:11 -0500
Received: by ewy1 with SMTP id 1so2764110ewy.28
        for <git@vger.kernel.org>; Tue, 08 Dec 2009 06:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wIv5LBlmKfQWQza9d50RkhMU5BKbgJwZ5pt+Xdq6nIs=;
        b=JnJHVhaYZgzjo06w1V7QOSaH6jZH3EAQ1rzcKa7v+339rNDZ6R0uw66uFJPwaq4Oki
         sChqLc7qvDCjfpWGNXXUa7pcojpYqBKaYxO7oHeb+ASyO+t0Bxrj87T2g9Ry7e/mO5yH
         2bTThpX67bXZgVncreZXWblsj7gK3HtZ6+4pg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=cE2HS4HxxeddeHy68kqz0JFlHF9Om+bQsLlcvIX7lX577Rpgj3banq9566L/EHbNid
         /Zl8FU6b+DkrcfkuCU37a3gsVlUXcY5XDgTjoskqylKSywyj0A9pY9Gayko+swtxxQwr
         BZhRYqCotx+5ACnugrdr3jAujpIqv0XNDod0s=
Received: by 10.216.86.142 with SMTP id w14mr2972854wee.74.1260280876054; Tue, 
	08 Dec 2009 06:01:16 -0800 (PST)
In-Reply-To: <200911272023.58262.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134874>

On Fri, Nov 27, 2009 at 8:23 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Freitag, 27. November 2009, Erik Faye-Lund wrote:
>> On Thu, Nov 26, 2009 at 10:23 PM, Johannes Sixt <j6t@kdbg.org> wrote=
:
>> > I would
>> >
>> > =A0 =A0 =A0 =A0const char* arg;
>> > =A0 =A0 =A0 =A0if (strcmp(fmt, "%s"))
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die("format string of syslog() not =
implemented")
>> > =A0 =A0 =A0 =A0va_start(va, fmt);
>> > =A0 =A0 =A0 =A0arg =3D va_arg(va, char*);
>> > =A0 =A0 =A0 =A0va_end(va);
>> >
>> > because we have exactly one invocation of syslog(), which passes "=
%s" as
>> > format string. Then strbuf_vaddf is not needed. Or even simpler: d=
eclare
>> > the function as
>> >
>> > void syslog(int priority, const char *fmt, const char*arg);
>>
>> After reading this again, I agree that this is the best solution. I'=
ll
>> update for the next iteration.
>
> Except that you shouldn't die like I proposed because here we are alr=
eady in
> the die_routine, no?
>

Might be. Either way, I think loosing a log-entry is better than
taking down the server. I'm just doing a warning() and return. If
we're lucky, the warning gets somewhere. If not, well, something
happened and no one was around to see it.

>> > "Note that the string that you log cannot contain %n, where n is a=
n
>> > integer value (for example, %1) because the event viewer treats it=
 as an
>> > insertion string. ..."
>> >
>> > How are the chances that this condition applies to our use of the
>> > function?
>>
>> Ugh, increasingly high since we're adding IPv6 support, I guess.
>> Perhaps some form of escaping needs to be done?
>
> I think so, but actually I have no clue.
>

Bah, according to Microsoft Support (1), there's no simple way to
escape this. I'm tempted to leave this bug in, and rather try to fix
the symptoms when/if they start popping up. Unless someone else comes
up with something better, that is.

(1) http://support.microsoft.com/kb/934640

--=20
Erik "kusma" Faye-Lund
