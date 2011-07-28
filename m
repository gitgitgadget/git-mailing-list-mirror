From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v2 4/4] upload-archive: use start_command instead of fork
Date: Thu, 28 Jul 2011 10:32:54 +0200
Message-ID: <CABPQNSYtpRpNQVW=QvyfFhmWge5-C+k85bs2EJeK8k0jdfHzrw@mail.gmail.com>
References: <1311012516-4836-1-git-send-email-kusmabite@gmail.com>
 <1311012516-4836-5-git-send-email-kusmabite@gmail.com> <7vmxga7zb9.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, peff@peff.net, j6t@kdbg.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 10:33:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmM2I-0007gg-Pf
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 10:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755119Ab1G1Idh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jul 2011 04:33:37 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:36483 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754883Ab1G1Idf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2011 04:33:35 -0400
Received: by yia27 with SMTP id 27so1627849yia.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 01:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=kF0l3er7XEPE5QMwWal/6xkLKz7W8UQdP+/jjDM86kY=;
        b=yFSl6K4YoBo7sae1YqXGfqXpKtxRQ5IOVHUZB7B6RoMUYj9o2L1jTVOX5bjPajuFuf
         VVyveIITu1Gne2IMj8evCnde5ZnTC4PCyGRD2Un49wJ39lhiTTm0jKfYgoKqzvFvVeNh
         xodZmW30Z7SoSrATRc27rMSBRh0+CBdJHig28=
Received: by 10.68.25.162 with SMTP id d2mr1250191pbg.372.1311842014066; Thu,
 28 Jul 2011 01:33:34 -0700 (PDT)
Received: by 10.68.48.130 with HTTP; Thu, 28 Jul 2011 01:32:54 -0700 (PDT)
In-Reply-To: <7vmxga7zb9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178049>

Sorry for the late reply. Things have been a bit hectic here in Oslo
over the last week.

On Tue, Jul 19, 2011 at 11:09 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> @@ -18,28 +19,16 @@ static const char lostchild[] =3D
>>
>> =A0#define MAX_ARGS (64)
>>
>> -static int run_upload_archive(int argc, const char **argv, const ch=
ar *prefix)
>> +static void prepare_argv(const char **sent_argv, const char **argv)
>> =A0{
>> - =A0 =A0 const char *sent_argv[MAX_ARGS];
>> =A0 =A0 =A0 const char *arg_cmd =3D "argument ";
>> =A0 =A0 =A0 char *p, buf[4096];
>> =A0 =A0 =A0 int sent_argc;
>> =A0 =A0 =A0 int len;
>>
>> - =A0 =A0 if (argc !=3D 2)
>> - =A0 =A0 =A0 =A0 =A0 =A0 usage(upload_archive_usage);
>> -
>> - =A0 =A0 if (strlen(argv[1]) + 1 > sizeof(buf))
>> - =A0 =A0 =A0 =A0 =A0 =A0 die("insanely long repository name");
>> -
>> - =A0 =A0 strcpy(buf, argv[1]); /* enter-repo smudges its argument *=
/
>> -
>> - =A0 =A0 if (!enter_repo(buf, 0))
>> - =A0 =A0 =A0 =A0 =A0 =A0 die("'%s' does not appear to be a git repo=
sitory", buf);
>> -
>> =A0 =A0 =A0 /* put received options in sent_argv[] */
>> =A0 =A0 =A0 sent_argc =3D 1;
>> - =A0 =A0 sent_argv[0] =3D "git-upload-archive";
>> + =A0 =A0 sent_argv[0] =3D "archive";
>> =A0 =A0 =A0 for (p =3D buf;;) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* This will die if not enough free spac=
e in buf */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 len =3D packet_read_line(0, p, (buf + si=
zeof buf) - p);
>> @@ -62,9 +51,6 @@ static int run_upload_archive(int argc, const char=
 **argv, const char *prefix)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 *p++ =3D 0;
>> =A0 =A0 =A0 }
>> =A0 =A0 =A0 sent_argv[sent_argc] =3D NULL;
>> -
>> - =A0 =A0 /* parse all options sent by the client */
>> - =A0 =A0 return write_archive(sent_argc, sent_argv, prefix, 0);
>> =A0}
>
> Hmm, how well would this change work with recent archive-filter work =
by
> Peff, especially with the "when remote, disable some features" bits?
>

Thanks for the notice. And no, not at all :(

OK then. I'll probably have to rewrite this to use start_async +
dup-bonanza instead of start_command...
