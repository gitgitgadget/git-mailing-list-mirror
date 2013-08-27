From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH/RFC] core.precomposeunicode is true by default
Date: Tue, 27 Aug 2013 15:45:44 +0200
Message-ID: <521CAD88.4080609@web.de>
References: <201307270321.32398.tboegi@web.de> <7vmwp5z3iu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 27 15:46:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEJbC-0008N9-1v
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 15:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753741Ab3H0NqI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Aug 2013 09:46:08 -0400
Received: from mout.web.de ([212.227.15.3]:58265 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753722Ab3H0NqE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 09:46:04 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0M2dxF-1W4DE51hH3-00sPe0 for <git@vger.kernel.org>;
 Tue, 27 Aug 2013 15:46:00 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <7vmwp5z3iu.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V03:K0:4lpvYjgh5YQ9vzGTrFv+b5t2mkeiWBVnz9hUJTsDHVlSztZ82Wi
 riK0k+TYRJVhABaasHHExjSXWpSgnvS1GsrsrpZqdsefmf98ORauyonZgKwtXBFOFgDSWGc
 SYbVvJipxSYmorOpo3eWVWd7n8rrkiBsNttBFtaecKll6NOfIosQeiMMkUsLDzdUy0aeRjj
 C8EegcibbNn7KIZppLGSA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233086>

(Sorry for the somewhat late reply, thanks for review)
>Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> When core.precomposeunicode was introduced, it was set to false
>> by default, to be compatible with older versions of Git.
>>
>> Whenever UTF-8 file names are used in a mixed environment,
>> the Mac OS users need to find out that this configuration exist
>> and set it to true manually.
>>
>> There is no measurable performance impact between false and true.
>
>The real reason we default it to auto-sensing in the current code is
>for correctness, I think. the new precompose code could be buggy,
>and by auto-sensing, we hoped that we would enable it only on
>filesystems that the codepath matters.
>
>> A smoother workflow can be achieved for new Git users,
>> so change the default to true:
>>
>> - Remove the auto-sensing
>
>Why?
>
>> - Rename the internal variable into precompose_unicode,
>>   and set it to 1 meaning true.
>
>Why the rename?
>
>> - Adjust and clean up test cases
>>
>> The configuration core.precomposeunicode is still supported.
>
>Sorry, but I do not quite understand the change.  Is this because
>the auto-sensing is not working, or after auto-sensing we do a wrong
>thing?  If that is the case, perhaps that is what we should fix?
>
>> diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
>> index 7980abd..5396b91 100644
>> --- a/compat/precompose_utf8.c
>> +++ b/compat/precompose_utf8.c
>> @@ -36,30 +36,6 @@ static size_t has_non_ascii(const char *s, size_t=
 maxlen, size_t *strlen_c)
>>  }
>> =20
>> =20
>> -void probe_utf8_pathname_composition(char *path, int len)
>> -{
>> -	static const char *auml_nfc =3D "\xc3\xa4";
>> -	static const char *auml_nfd =3D "\x61\xcc\x88";
>> -	int output_fd;
>> -	if (precomposed_unicode !=3D -1)
>> -		return; /* We found it defined in the global config, respect it *=
/
>> -	strcpy(path + len, auml_nfc);
>> -	output_fd =3D open(path, O_CREAT|O_EXCL|O_RDWR, 0600);
>
>So we try to create a path under one name, and ...
>
>> -	if (output_fd >=3D 0) {
>> -		close(output_fd);
>> -		strcpy(path + len, auml_nfd);
>> -		/* Indicate to the user, that we can configure it to true */
>> -		if (!access(path, R_OK))
>> -			git_config_set("core.precomposeunicode", "false");
>
>... see if that path can be seen under its alias.  Why do we set it
>to "false"?  Isn't this the true culprit?
>
>After all, this is not in the "reinit" codepath, so we know we are
>dealing with a repository that was created afresh.
>

There is nothing wrong with the auto-sensing as such.
The problem for many users today is that we set core.precomposeunicode
to false, when it should be true.

A patch for that comes out in a minute. But first look back and=20
collect some experience with core.precomposeunicode.

Lets have a look at the variable "precomposed_unicode",
(the one I wanted to rename to be more consistant).
It is controlled by the git config files and
depending on the config it is set like this:
core.precomposeuinicode false -> precomposed_unicode =3D 0
core.precomposeuinicode true  -> precomposed_unicode =3D 1
core.precomposeuinicode <not set> -> precomposed_unicode =3D -1.

Let's look what precomposed_unicode does and go through a couple
of git operations.

1)
When we create a repo under Mac OS using HFS+,
we want to have precomposed_unicode =3D 1

2)
When we access a repo from Windows/Linux using SAMBA,
readdir() will return decomposed.
When the repo is created by nonMacOS, core.precomposeunicode is undefin=
ed.
The precomposition is off, but should be on,=20
precomposed_unicode =3D -1, but should be =3D 1

3)
When we access a repo from another Mac OS system using=20
SAMBA, NFS or AFP readdir() will return decomposed.
As the repo is created under Mac OS, we have the same case as (1)

4)
When we access a repo from Linux using NFS we can have
precomposed_unicode =3D 0 (which is technically more correct).
If Linux users do not use decomposed unicode in their file names,
(according to my understanding this is the case), we can use 1
as well as 0:
precomposing an already precomposed string is a no-op, so it doesn't
harm.


5)
When we create a repo under Linux/Windows on a USB-drive,
and run "git status" under Mac OS, we want precomposed_unicode =3D 1.

There are few cases where we want to use precomposed_unicode=3D0:
a) To work around bugs. This may be a short term solution,
  I would rather see bugs to be fixed.
  I'm not aware of any bugs, so please remind me if I missed something.

b) Working with foreign vcs:  E.g. bzr and hg use decomposed unicode,
   so it may be better to use decomposed unicode in git as well.

The simplified V2 patch looks like this (I send it in a seperate mail):

diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index 7980abd..95fe849 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -48,11 +48,8 @@ void probe_utf8_pathname_composition(char *path, int=
 len)
 	if (output_fd >=3D 0) {
 		close(output_fd);
 		strcpy(path + len, auml_nfd);
-		/* Indicate to the user, that we can configure it to true */
-		if (!access(path, R_OK))
-			git_config_set("core.precomposeunicode", "false");
-		/* To be backward compatible, set precomposed_unicode to 0 */
-		precomposed_unicode =3D 0;
+		precomposed_unicode =3D access(path, R_OK) ? 0 : 1;
+		git_config_set("core.precomposeunicode", precomposed_unicode ? "true=
" : "false");

This will not affect existing repos, as they should have
core.precomposeunicode either true or false.
When a new repo is created, users having core.precomposeunicode in the
global config are not effected,
and the global setting switches off the auto-sensing.

The users which are new to git are affected,
and hopefully we do the right thing for them.
At least, according to my understanding, we do the best for majority
of users and use cases.

Thoughts are welcome, and arguments for and against V1 or V2.

Anybody who uses Mac OS and has experience with decomposed unicode?
I have core.precomposeunicode true in my global config.
=20
