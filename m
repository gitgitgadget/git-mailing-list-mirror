From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 02/27] Convert git_snpath() to strbuf_git_path()
Date: Mon, 3 Mar 2014 07:15:47 +0700
Message-ID: <CACsJy8DeGCdnWHOxTeGUV4CsHyV-u_DgR-03iyOrEKznsQsqGA@mail.gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1393675983-3232-1-git-send-email-pclouds@gmail.com> <1393675983-3232-3-git-send-email-pclouds@gmail.com>
 <CAPig+cTjqrveuOS+3+bonwJa_Kjg=STJU1JJ2Kj7Gs5U9eEB9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 01:16:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKGYQ-0000Hl-GE
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 01:16:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753644AbaCCAQS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Mar 2014 19:16:18 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:55629 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071AbaCCAQS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Mar 2014 19:16:18 -0500
Received: by mail-qa0-f46.google.com with SMTP id i13so2781243qae.5
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 16:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=3OjG/39SJZKG/xirphGd4f6q9y+UV6TJtThDp0o+sFQ=;
        b=Nfshkz9pb1GQs1nIFT6fqYfcR8p2/r5EPZTwmIN3mDNSwn3XL7KhJN9+4SqtunWO1r
         W8JhiTe6sjCgoSuUYfgRoEjQ4aPIMk7S4NLoGDSVFg5PTckp6muLP5eyqL4TrDmKmpEI
         I75ulfFBcGpJ6laeJOS60sOE0n2iYxyaOFAKsFrmat1FHjNdgqsJ3/ZuHAME6yXTBDw2
         7MLVGYJJOj07fo5V5jhNv9Ukq5zUjjxy4AQ13NGwtY2U/FZVgXE6Pf9M6kBBO3f87bWl
         S1B7mTnfRfSf/UNTXXalIw1JhZcwzhJ6LaA6c+rlCt9NhPS7ER15utspLxRjEsbOACnZ
         CURw==
X-Received: by 10.229.118.4 with SMTP id t4mr19786607qcq.9.1393805777401; Sun,
 02 Mar 2014 16:16:17 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Sun, 2 Mar 2014 16:15:47 -0800 (PST)
In-Reply-To: <CAPig+cTjqrveuOS+3+bonwJa_Kjg=STJU1JJ2Kj7Gs5U9eEB9Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243168>

On Mon, Mar 3, 2014 at 7:02 AM, Eric Sunshine <sunshine@sunshineco.com>=
 wrote:
> On Sat, Mar 1, 2014 at 7:12 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy <pclouds@gmail.com> wrote:
>> In the previous patch, git_snpath() is modified to allocate a new
>> strbuf buffer because vsnpath() needs that. But that makes it awkwar=
d
>> because git_snpath() receives a pre-allocated buffer from outside an=
d
>> has to copy data back. Rename it to strbuf_git_path() and make it
>> receive strbuf directly.
>>
>> The conversion from git_snpath() to git_path() in
>> update_refs_for_switch() is safe because that function does not keep
>> any pointer to the round-robin buffer pool allocated by
>> get_pathname().
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> diff --git a/refs.c b/refs.c
>> index 89228e2..434bd5e 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2717,17 +2729,19 @@ static int copy_msg(char *buf, const char *m=
sg)
>>         return cp - buf;
>>  }
>>
>> -int log_ref_setup(const char *refname, char *logfile, int bufsize)
>> +int log_ref_setup(const char *refname, struct strbuf *sb_logfile)
>>  {
>>         int logfd, oflags =3D O_APPEND | O_WRONLY;
>> +       const char *logfile;
>>
>> -       git_snpath(logfile, bufsize, "logs/%s", refname);
>> +       strbuf_git_path(sb_logfile, "logs/%s", refname);
>> +       logfile =3D sb_logfile->buf;
>>         if (log_all_ref_updates &&
>>             (starts_with(refname, "refs/heads/") ||
>>              starts_with(refname, "refs/remotes/") ||
>>              starts_with(refname, "refs/notes/") ||
>>              !strcmp(refname, "HEAD"))) {
>> -               if (safe_create_leading_directories(logfile) < 0)
>> +               if (safe_create_leading_directories(sb_logfile->buf)=
 < 0)
>
> At this point, 'logfile' is still 'sb_logfile->buf', so do you really
> need this change?

Junio made the same comment last time and I missed it. Will update.
--=20
Duy
