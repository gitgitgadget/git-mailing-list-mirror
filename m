From: =?UTF-8?B?U2ViYXN0aWFuIEfDtnR0ZQ==?= <jaseg@physik.tu-berlin.de>
Subject: [PATCH v2 0/1] templates: pre-push hook: check for missing GPG signatures
Date: Thu, 25 Apr 2013 14:19:13 +0200
Message-ID: <51791F41.3040203@physik.tu-berlin.de>
References: <7vppxjbt6t.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, joel@trustly.com, git@drmicha.warpmail.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Apr 25 14:19:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVL8i-0006iX-Qf
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 14:19:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758310Ab3DYMS7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Apr 2013 08:18:59 -0400
Received: from mail.tu-berlin.de ([130.149.7.33]:42084 "EHLO mail.tu-berlin.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756937Ab3DYMS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 08:18:58 -0400
X-tubIT-Incoming-IP: 130.149.58.163
Received: from mail.physik-pool.tu-berlin.de ([130.149.58.163] helo=mail.physik.tu-berlin.de)
	by mail.tu-berlin.de (exim-4.75/mailfrontend-3) with esmtp 
	id 1UVL8b-00004w-Dw; Thu, 25 Apr 2013 14:18:57 +0200
Received: from [141.23.96.137] (wlan-141-23-96-137.tubit.tu-berlin.de [141.23.96.137])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.physik.tu-berlin.de (Postfix) with ESMTPSA id BEE5211403;
	Thu, 25 Apr 2013 14:18:49 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130403 Thunderbird/17.0.5
In-Reply-To: <7vppxjbt6t.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222381>

On 04/24/2013 09:54 PM, Junio C Hamano wrote:
> None of the above is part of a proper commit log message, is it?
=46ixed (I hope)

>> Signed-off-by: Sebastian G=C3=B6tte <jaseg@physik-pool.tu-berlin.de>
>> diff --git a/templates/hooks--pre-push.sample b/templates/hooks--pre=
-push.sample
>> old mode 100644
>> new mode 100755
> Why?
According to man githooks(5):
>It is also a requirement for a given hook to be executable. However - =
in a
>freshly initialized repository - the .sample files are executable by d=
efault.
This file is the only one in templates/ that was not executable, so I a=
ssume
this was a mistake.

>> index 15ab6d8..08a72df
>> --- a/templates/hooks--pre-push.sample
>> +++ b/templates/hooks--pre-push.sample
>> -# This sample shows how to prevent push of commits where the log me=
ssage starts
>> -# with "WIP" (work in progress).
>> +# This sample shows how to prevent pushing commits without good GPG=
 signatures
> What justifies to remove existing demonstration?  It is far easier
> for the end users to remove parts that do not apply to their needs,
> than coming up with a solution to add themselves without help from
> an example.
re-added it.

>> +ec=3D0
> I think it is more customary to call this kind of variable "ret" or
> "retval", not an abbreviation for "european commission" ;-).
renamed it to "exitcode".

>> -IFS=3D' '
> Why?
Otherwise in the for-loop below the output of the pipe chain is not cor=
rectly
split by newlines. Also AFAIK, this is not needed: I think the default
'<space><tab><newline>' is just fine here.
=20
>> +		commits=3D`git log --format=3D"%G? %h" "$range" | grep -v '^G' | =
cut -d\  -f2`
> Useless use of cut.  You could do
I just tried this, but I really want the script to output a list of *al=
l*
offending commits (instead of exiting on the first problem). For this I=
 need
the exitcode variable, but since at least bash executes the while loop =
in a
subshell due to the preceding pipe, I have some issues getting that out=
 of the
subshell. This is what the code looked like without grep/cut:
># Check for missing good GPG signatures
>git log --format=3D"%G? %h" "$range" |
>(
>                exitcode=3D0
>                while read sign commit
>                do
>                                test "$sign" =3D G && continue
>                                echo "Commit $commit does not have a g=
ood GPG signature"
>                                exitcode=3D1
>                done
>                exit $exitcode
>)
>let exitcode=3Dexitcode\|$?
This is less readable and only spawns one process less.

Sebastian G=C3=B6tte (1):
  templates: pre-push hook: check for missing GPG signatures

 templates/hooks--pre-push.sample | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)
 mode change 100644 =3D> 100755 templates/hooks--pre-push.sample

--=20
1.8.2
