From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v4 11/15] daemon: report connection from root-process
Date: Thu, 14 Oct 2010 12:50:54 +0200
Message-ID: <AANLkTinXNPWaGj2BUaSOJypzv-Sqts-zEdG886oT2YJB@mail.gmail.com>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
 <1286833829-5116-12-git-send-email-kusmabite@gmail.com> <7vlj61hfe7.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	avarab@gmail.com, sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 12:51:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6LPA-0006eK-UJ
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 12:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681Ab0JNKvQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Oct 2010 06:51:16 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38623 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888Ab0JNKvP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Oct 2010 06:51:15 -0400
Received: by iwn41 with SMTP id 41so670363iwn.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 03:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=J+pRGyOeiPpHNLvqLfvVqS62esMUVB4Tvcn/e44ca1A=;
        b=SSqtPuMSZTH4JSS5YeISEqb+4mu4AwODvj3vgLdjnmjhtpBC59SnRcgWIuNYe6WGur
         +as5XM4/msYfZsDphP6xTc/j8Bq8l/6VnPRYNqCB3i6GsXtfONQqfLJQxdCWJSsP5LOB
         9t1A60kAxOAU5RKfWJw5CTiltyPgjnPpucyGE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=eEwiRyZKDZnb1C2ai7GeIXDQjLd022mjNedrzgmiglQNdD85pQddMGNpeU/aQCD2si
         6EI4Jmz9PhhHDcwMNRg3DohENHDC3fllwzwpdfCWTRHFixkKzqamaNIPf3+Q05njr8G/
         B5dA+akhiXWH/kgB26YYqfunhm6U+Y5H5LHAs=
Received: by 10.42.192.12 with SMTP id do12mr4762483icb.315.1287053474445;
 Thu, 14 Oct 2010 03:51:14 -0700 (PDT)
Received: by 10.220.45.196 with HTTP; Thu, 14 Oct 2010 03:50:54 -0700 (PDT)
In-Reply-To: <7vlj61hfe7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159044>

On Thu, Oct 14, 2010 at 12:55 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> Report incoming connections from the process that
>> accept() the connection instead of the handling
>> process.
>>
>> This enables "Connection from"-reporting on
>> Windows, where getpeername(0, ...) consistently
>> fails.
>>
>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
>> ---
>> =A0daemon.c | =A0 72 ++++++++++++++++++++++++++++++-----------------=
--------------
>> =A01 files changed, 35 insertions(+), 37 deletions(-)
>>
>> diff --git a/daemon.c b/daemon.c
>> index 8a44fb9..1574f75 100644
>> --- a/daemon.c
>> +++ b/daemon.c
>> @@ -516,38 +516,11 @@ static void parse_host_arg(char *extra_args, i=
nt buflen)
>> =A0}
>>
>>
>> -static int execute(struct sockaddr *addr)
>> +static int execute(void)
>> =A0{
>> -...
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 loginfo("Connection from %s:%d", addrbuf, =
port);
>> - =A0 =A0 =A0 =A0 =A0 =A0 setenv("REMOTE_ADDR", addrbuf, 1);
>> ...
>> + =A0 =A0 else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 loginfo("[%"PRIuMAX"] Connection from %s:%=
d",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (uintmax_t)cld.pid, addrstr, port)=
;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 add_child(&cld, addr, addrlen);
>
> Hmm, loginfo() calls logreport() and adds the process information as
> necessary to the output. =A0Wouldn't this patch give the pid informat=
ion
> twice?
>

Close, but not quite. logreport() reports the current PID, while this
call to loginfo reports the PID of the child process. So two
non-identical PIDs are reported.

The output becomes something like this:

[6408] [3868] Connection from [::1]:55801
[3868] Extended attributes (16 bytes) exist <host=3Dlocalhost>
[3868] Request upload-pack for '/some-repo.git'
[3868] '/some-repo.git' does not appear to be a git repository
[6408] [1876] Connection from [::1]:57311
[1876] Extended attributes (16 bytes) exist <host=3Dlocalhost>
[1876] Request upload-pack for '/some-repo.git'
[1876] '/some-repo.git' does not appear to be a git repository
