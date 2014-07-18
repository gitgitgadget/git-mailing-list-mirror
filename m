From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH v2] remote-testsvn: use internal argv_array of struct
 child_process in cmd_import()
Date: Fri, 18 Jul 2014 23:45:50 +0200
Message-ID: <53C9958E.8080105@web.de>
References: <53C93B33.5070006@web.de>	<xmqq8unqmqk7.fsf@gitster.dls.corp.google.com>	<53C975C5.8020709@web.de> <53C97BA4.7020503@web.de> <xmqqtx6el619.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 23:46:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8Fys-0003ea-CX
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 23:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759287AbaGRVqO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jul 2014 17:46:14 -0400
Received: from mout.web.de ([212.227.15.14]:53923 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752348AbaGRVqN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 17:46:13 -0400
Received: from [192.168.178.27] ([79.250.167.186]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0LjrYH-1WWSBR1FM1-00brlt; Fri, 18 Jul 2014 23:46:04
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqtx6el619.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:J07Zvmeat9MsggaDuTyUHmQX3YYb+Kom/wUvcqO+ui2d7EwZvz5
 uRZbMYTK+Tt8mwIdsJm/cK2WJc5gixQ9F3mkBJMY7lZPeINHKkPjZyTBy0MlPzpG7ywR9x/
 0UZqNBOuQBP2VoozBsvRVpuCxSia2jNHxhc0f9BNAO/dTm0bnleE9sy5VS52LA4gC3/kKyq
 c5EaKyHxS+g/TrgApJupQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253849>

Am 18.07.2014 23:18, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Use the existing argv_array member instead of providing our own.  Th=
is
>> way we don't have to initialize or clean it up explicitly.  Because =
of
>> that automatic cleanup, we need to keep our own reference to the
>> command name instead of using .argv[0] to print the warning at the e=
nd.
>>
>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>> ---
>> The added command pointer makes the patch more complicated, but I th=
ink
>> it still counts as a cleanup.
>
> Surely.  I'd move the "svnrdump" assignment to where the variable is
> defined, though; we do not switch what "command" to run depending on
> some computed conditions anyway.

OK; I see you already did that in pu, thanks.  My point was to allow th=
e=20
compiler to warn if the variable command was used in the case=20
start_command was not actually called.  That's probably too subtle to b=
e=20
useful.

>
>>
>>   remote-testsvn.c | 17 ++++++++---------
>>   1 file changed, 8 insertions(+), 9 deletions(-)
>>
>> diff --git a/remote-testsvn.c b/remote-testsvn.c
>> index 6be55cb..e3ad11b 100644
>> --- a/remote-testsvn.c
>> +++ b/remote-testsvn.c
>> @@ -175,8 +175,8 @@ static int cmd_import(const char *line)
>>   	char *note_msg;
>>   	unsigned char head_sha1[20];
>>   	unsigned int startrev;
>> -	struct argv_array svndump_argv =3D ARGV_ARRAY_INIT;
>>   	struct child_process svndump_proc;
>> +	const char *command;
>>
>>   	if (read_ref(private_ref, head_sha1))
>>   		startrev =3D 0;
>> @@ -200,17 +200,17 @@ static int cmd_import(const char *line)
>>   		if(dumpin_fd < 0)
>>   			die_errno("Couldn't open svn dump file %s.", url);
>>   	} else {
>> +		command =3D "svnrdump";
>>   		memset(&svndump_proc, 0, sizeof(struct child_process));
>>   		svndump_proc.out =3D -1;
>> -		argv_array_push(&svndump_argv, "svnrdump");
>> -		argv_array_push(&svndump_argv, "dump");
>> -		argv_array_push(&svndump_argv, url);
>> -		argv_array_pushf(&svndump_argv, "-r%u:HEAD", startrev);
>> -		svndump_proc.argv =3D svndump_argv.argv;
>> +		argv_array_push(&svndump_proc.args, command);
>> +		argv_array_push(&svndump_proc.args, "dump");
>> +		argv_array_push(&svndump_proc.args, url);
>> +		argv_array_pushf(&svndump_proc.args, "-r%u:HEAD", startrev);
>>
>>   		code =3D start_command(&svndump_proc);
>>   		if (code)
>> -			die("Unable to start %s, code %d", svndump_proc.argv[0], code);
>> +			die("Unable to start %s, code %d", command, code);
>>   		dumpin_fd =3D svndump_proc.out;
>>   	}
>>   	/* setup marks file import/export */
>> @@ -226,8 +226,7 @@ static int cmd_import(const char *line)
>>   	if (!dump_from_file) {
>>   		code =3D finish_command(&svndump_proc);
>>   		if (code)
>> -			warning("%s, returned %d", svndump_proc.argv[0], code);
>> -		argv_array_clear(&svndump_argv);
>> +			warning("%s, returned %d", command, code);
>>   	}
>>
>>   	return 0;
