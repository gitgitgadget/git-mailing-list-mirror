From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [msysGit] [PATCH v3 02/14] mingw: implement syslog
Date: Sun, 10 Oct 2010 23:17:30 +0200
Message-ID: <AANLkTimSxk=b=cHSvvnVejy=smwTmGboqya0cW+6YOrF@mail.gmail.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
 <4CB2190F.6000908@gmail.com> <AANLkTinsqAOj7LtACpbcOrVZfeUApDjmQe2uYLH8npBF@mail.gmail.com>
 <201010102251.27095.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <ericsunshine@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com, Mike Pape <dotzenlabs@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Oct 10 23:18:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P53HN-0001gi-3D
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 23:18:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864Ab0JJVRv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Oct 2010 17:17:51 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36673 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642Ab0JJVRv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Oct 2010 17:17:51 -0400
Received: by vws2 with SMTP id 2so581345vws.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 14:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=jWahtCsc9UZwkBaDxliUhpNWs4rZAUx9ulOiSclNFxI=;
        b=S7JgFJdjtipiyR9asuH2OO8EvA1/H38EhOsKwD+xfgFbc3/EltWOAEu2wyNylwrd63
         0XxmAabTd+zsN5A1JAoIbvx9sLY/NU0rog4dq/q0kpBmKBpKQpBbJ4Z1Gii/0vwFoHyQ
         7DtrglDcO+4/jnCs8RNcGICjMcpD6qxZ03juY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=x5EQte8/exEaJ64ahLE5MXFeZNwsynHYCMoDAhUkn9aMC/XzyawaexGIpAStjW7IV+
         NEWkmtxBKvMktvkjGw/oyHF3lRSWJqB3tQIGRKLUIH9O8PZZFrBK9ecHDFVA16tOqCx+
         1v3C9+jjzIi9FdvTLFDkUe1tTruaBU+tL9DTg=
Received: by 10.220.195.73 with SMTP id eb9mr1666164vcb.34.1286745470293; Sun,
 10 Oct 2010 14:17:50 -0700 (PDT)
Received: by 10.220.45.196 with HTTP; Sun, 10 Oct 2010 14:17:30 -0700 (PDT)
In-Reply-To: <201010102251.27095.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158709>

On Sun, Oct 10, 2010 at 10:51 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Sonntag, 10. Oktober 2010, Erik Faye-Lund wrote:
>> On Sun, Oct 10, 2010 at 9:50 PM, Eric Sunshine <ericsunshine@gmail.c=
om>
> wrote:
>> > On 10/10/2010 9:20 AM, Erik Faye-Lund wrote:
>> >> + =A0 =A0 =A0 /*
>> >> + =A0 =A0 =A0 =A0* ReportEvent() doesn't handle strings containin=
g %n, where n
>> >> is + =A0 =A0 =A0 =A0* an integer. Such events must be reformatted=
 by the caller.
>> >> + =A0 =A0 =A0 =A0*/
>> >
>> > The comment about '%n' seems to be warning about a potential probl=
em but
>> > does not actually protect against it. Should this issue be handled=
?
>>
>> This is again an issue that was discussed in the first round.
>> ReportEvent() CANNOT report a string containing "%n" (where n is an
>> integer). And while we could probably try to work around it by
>> inserting a space or something, and I don't think we ever were able =
to
>> find a case where we could report a string containing "%n" in the
>> first place...
>
> I recall that it was mentioned that this could happen for IPv6 addres=
ses?
>

Ah, that's right. Microsoft even mentions it in MSDN: "Note that the
string that you log cannot contain %n, where n is an integer value
(for example, %1) because the event viewer treats it as an insertion
string. Because an IPv6 address can contain this character sequence,
you cannot log an event message that contains an IPv6 address".

What should we do about it? Error out?

Strangely enough, reporting strings with "%1" works fine when I test
it now. Perhaps this is dependent on the windows-version?

Yep, it is. On Vista 64 it seems to work, but on WinXP it does not.
The string gets expanded into itself 100 times, and then there's
apparently a recursion test.

Also, it is only %1 that does not report correctly on WinXP, probably
because of a check against the wNumStrings-parameter. Even strings
like %11 does not expand.

=46ormatMessage has the FORMAT_MESSAGE_IGNORE_INSERTS-flag to avoid thi=
s
kind of expansion, but unfortunately I can't find similar
functionality for ReportEvent :(
