From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH] remote-testsvn: use internal argv_array of struct child_process
 in cmd_import()
Date: Fri, 18 Jul 2014 21:30:13 +0200
Message-ID: <53C975C5.8020709@web.de>
References: <53C93B33.5070006@web.de> <xmqq8unqmqk7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 21:30:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8DrX-0005bt-9k
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 21:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422845AbaGRTab convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jul 2014 15:30:31 -0400
Received: from mout.web.de ([212.227.15.4]:58903 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754909AbaGRTaa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 15:30:30 -0400
Received: from [192.168.178.27] ([79.250.167.186]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0M57ni-1WLKhR2DFO-00zG1r; Fri, 18 Jul 2014 21:30:27
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqq8unqmqk7.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:fZCXy31bPjl+VfB8yFQVImqCeYHoh9y757voPSe1Sr84S3I/g8J
 UnJTs2cP24R3QTdwpvWrYlQe4F3hR7wXDdCBYPoAcLNdeWvqru37f9h8cmNPmcPnDKdr3dg
 IqqXdiGzzIXyKy27TwnHzI3I9siob6sLqffMIQgAdh+T5jtC+uV/xK8RsW5YdvzFSp+DmNZ
 OMz0tNYmuowIwH28uoThQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253842>



Am 18.07.2014 21:10, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
>> Use the existing argv_array member instead of providing our own.  Th=
is
>> way we don't have to initialize or clean it up explicitly.
>>
>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>> ---
>=20
> The change below looks so trivial and I cannot offhand see why it
> would break t9020 in a reproducible way.
>=20
> Puzzled...
>=20
>>   remote-testsvn.c | 11 ++++-------
>>   1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/remote-testsvn.c b/remote-testsvn.c
>> index 6be55cb..31415bd 100644
>> --- a/remote-testsvn.c
>> +++ b/remote-testsvn.c
>> @@ -175,7 +175,6 @@ static int cmd_import(const char *line)
>>   	char *note_msg;
>>   	unsigned char head_sha1[20];
>>   	unsigned int startrev;
>> -	struct argv_array svndump_argv =3D ARGV_ARRAY_INIT;
>>   	struct child_process svndump_proc;
>>  =20
>>   	if (read_ref(private_ref, head_sha1))
>> @@ -202,11 +201,10 @@ static int cmd_import(const char *line)
>>   	} else {
>>   		memset(&svndump_proc, 0, sizeof(struct child_process));
>>   		svndump_proc.out =3D -1;
>> -		argv_array_push(&svndump_argv, "svnrdump");
>> -		argv_array_push(&svndump_argv, "dump");
>> -		argv_array_push(&svndump_argv, url);
>> -		argv_array_pushf(&svndump_argv, "-r%u:HEAD", startrev);
>> -		svndump_proc.argv =3D svndump_argv.argv;
>> +		argv_array_push(&svndump_proc.args, "svnrdump");
>> +		argv_array_push(&svndump_proc.args, "dump");
>> +		argv_array_push(&svndump_proc.args, url);
>> +		argv_array_pushf(&svndump_proc.args, "-r%u:HEAD", startrev);
>>  =20
>>   		code =3D start_command(&svndump_proc);
>>   		if (code)
>> @@ -227,7 +225,6 @@ static int cmd_import(const char *line)
>>   		code =3D finish_command(&svndump_proc);
>>   		if (code)
>>   			warning("%s, returned %d", svndump_proc.argv[0], code);
>> -		argv_array_clear(&svndump_argv);

Unfortunately I don't get a test failure, but I think I see what's
wrong: The warning line above references the argv array after it was
freed by finish_command.  Ouch.  Fixup below:

---
 remote-testsvn.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/remote-testsvn.c b/remote-testsvn.c
index 31415bd..e3ad11b 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -176,6 +176,7 @@ static int cmd_import(const char *line)
 	unsigned char head_sha1[20];
 	unsigned int startrev;
 	struct child_process svndump_proc;
+	const char *command;
=20
 	if (read_ref(private_ref, head_sha1))
 		startrev =3D 0;
@@ -199,16 +200,17 @@ static int cmd_import(const char *line)
 		if(dumpin_fd < 0)
 			die_errno("Couldn't open svn dump file %s.", url);
 	} else {
+		command =3D "svnrdump";
 		memset(&svndump_proc, 0, sizeof(struct child_process));
 		svndump_proc.out =3D -1;
-		argv_array_push(&svndump_proc.args, "svnrdump");
+		argv_array_push(&svndump_proc.args, command);
 		argv_array_push(&svndump_proc.args, "dump");
 		argv_array_push(&svndump_proc.args, url);
 		argv_array_pushf(&svndump_proc.args, "-r%u:HEAD", startrev);
=20
 		code =3D start_command(&svndump_proc);
 		if (code)
-			die("Unable to start %s, code %d", svndump_proc.argv[0], code);
+			die("Unable to start %s, code %d", command, code);
 		dumpin_fd =3D svndump_proc.out;
 	}
 	/* setup marks file import/export */
@@ -224,7 +226,7 @@ static int cmd_import(const char *line)
 	if (!dump_from_file) {
 		code =3D finish_command(&svndump_proc);
 		if (code)
-			warning("%s, returned %d", svndump_proc.argv[0], code);
+			warning("%s, returned %d", command, code);
 	}
=20
 	return 0;
--=20
2.0.2
