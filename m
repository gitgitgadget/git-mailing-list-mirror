From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [msysGit] [PATCH v3 02/14] mingw: implement syslog
Date: Sun, 10 Oct 2010 22:37:26 +0200
Message-ID: <AANLkTinsqAOj7LtACpbcOrVZfeUApDjmQe2uYLH8npBF@mail.gmail.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
 <1286716854-5744-3-git-send-email-kusmabite@gmail.com> <4CB2190F.6000908@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	Mike Pape <dotzenlabs@gmail.com>
To: Eric Sunshine <ericsunshine@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 10 22:37:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P52eY-0000zV-B0
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 22:37:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419Ab0JJUht convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Oct 2010 16:37:49 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64641 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776Ab0JJUhs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Oct 2010 16:37:48 -0400
Received: by vws2 with SMTP id 2so570110vws.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 13:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=Gqk+3e6u2BP9urLjywHh5xydwwOc2TofDQ891Qa91Fk=;
        b=Y5poE2m259InXstQZH7hUNLJJ7hLzkuX1RYk3nlIJhbbBs+a2RQ363VKnQc+htu6tt
         3Gex+6RSVxAjE7VD/1V/HfQ5qqSUk0KlqmfrJFKzNzSe6kHUypwlR5BlDVp539O/T0a+
         sp8I3uIR0UIEGJ8RmquRUeCAEdDO1sfAK75BQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=W1awm82vn5kTkMj9Ec7FLfQeraj88rUP5OynOYdc6XYGKGxgHJXwTLZfa+7JASQpK/
         yHRCf7lxAi55ihMA15Wm/WNTXjRPasjmraVLTRLQgWau2gp+hwmFNHVs7q5pSv5/2VeW
         /ShxF6OROMAIboqFkgC1LowSBmhIWDyhdDdCs=
Received: by 10.220.176.130 with SMTP id be2mr1646908vcb.205.1286743067521;
 Sun, 10 Oct 2010 13:37:47 -0700 (PDT)
Received: by 10.220.45.196 with HTTP; Sun, 10 Oct 2010 13:37:26 -0700 (PDT)
In-Reply-To: <4CB2190F.6000908@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158702>

On Sun, Oct 10, 2010 at 9:50 PM, Eric Sunshine <ericsunshine@gmail.com>=
 wrote:
> On 10/10/2010 9:20 AM, Erik Faye-Lund wrote:
>>
>> From: Mike Pape<dotzenlabs@gmail.com>
>>
>> Syslog does not usually exist on Windows, so we implement our own
>> using Window's ReportEvent mechanism.
>>
>> Signed-off-by: Mike Pape<dotzenlabs@gmail.com>
>> Signed-off-by: Erik Faye-Lund<kusmabite@gmail.com>
>> ---
>> +void syslog(int priority, const char *fmt, const char *arg)
>> +{
>> + =A0 =A0 =A0 WORD logtype;
>> +
>> + =A0 =A0 =A0 if (!ms_eventlog)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 =A0 if (strcmp(fmt, "%s")) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 warning("format string of syslog() not=
 implemented");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 =A0 }
>
> It is not exactly clear what the intention is here. Is this trying to=
 say
> that no formatting directives are allowed in 'fmt' or what? The simpl=
e case
> it is actually checking (where 'fmt' is solely '%s') could easily be =
handled
> manually, as could more complex formats.
>

This is the result of the feed-back in v1, where we tried to implement
all format strings. But that turned out to be very complex (due to the
lack of a portable va_copy()) and since we control all call-sites for
syslog and already only use "%s" as the format, it should be OK.

Perhaps that should be mentioned in the commit message...

>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* ReportEvent() doesn't handle strings containing %=
n, where n is
>> + =A0 =A0 =A0 =A0* an integer. Such events must be reformatted by th=
e caller.
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 ReportEventA(ms_eventlog,
>> + =A0 =A0 =A0 =A0 =A0 logtype,
>> + =A0 =A0 =A0 =A0 =A0 0,
>> + =A0 =A0 =A0 =A0 =A0 0,
>> + =A0 =A0 =A0 =A0 =A0 NULL,
>> + =A0 =A0 =A0 =A0 =A0 1,
>> + =A0 =A0 =A0 =A0 =A0 0,
>> + =A0 =A0 =A0 =A0 =A0 (const char **)&arg,
>> + =A0 =A0 =A0 =A0 =A0 NULL);
>
> The comment about '%n' seems to be warning about a potential problem =
but
> does not actually protect against it. Should this issue be handled?
>

This is again an issue that was discussed in the first round.
ReportEvent() CANNOT report a string containing "%n" (where n is an
integer). And while we could probably try to work around it by
inserting a space or something, and I don't think we ever were able to
find a case where we could report a string containing "%n" in the
first place...

Are you suggesting that we report an error when we can't report the
string correctly? We could do that, but I'm not sure how the end-user
would benefit from that. ReportEvent is used to report errors (unless
the --verbose flag has been specified), and reporting that we can't
present an error message strike me as a bit confusing... Even the
corrupted error message is probably better :P
