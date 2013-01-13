From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] tests: turn on test-lint-shell-syntax by default
Date: Sun, 13 Jan 2013 11:25:57 +0100
Message-ID: <50F28BB5.9080607@web.de>
References: <201301120650.46479.tboegi@web.de> <7vvcb37xfe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 13 11:39:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuKy9-0004dw-PN
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 11:39:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754204Ab3AMK0B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 05:26:01 -0500
Received: from mout.web.de ([212.227.17.12]:56535 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754197Ab3AMK0A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 05:26:00 -0500
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0MAdol-1TnTvp10bz-00Bx5Z; Sun, 13 Jan 2013 11:25:58
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <7vvcb37xfe.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:UV014b81mA9lh3IBSNGKG05IqcYhP7Ih9+bLPgHGeLb
 IkOSplXjx7F89QZgNPLeEM7Ag4Nal6jxYN0fhuqi8EIn4YtPc9
 sj1tcAF/UZ7UbgACSysiLIYIqq7cqa/N/uEdcTyTe3Lkv2XVTK
 IvQ8LR1oJCONEBa1af2z/1Y7cBmB6E8X+weyqrwb5ocACYq0Q1
 e145Z566QAD6whbNU0SHg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213335>

On 12.01.13 07:00, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> The test Makefile has a default set of lint tests which are run
>> as part of "make test".
>>
>> The macro TEST_LINT defaults to "test-lint-duplicates test-lint-exec=
utable".
>>
>> Add test-lint-shell-syntax here, to detect non-portable shell syntax=
 early.
>>
>> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
>> ---
>=20
> As I said already, I do not want to do this yet without further
> reduction of false positives.
Which reinds me that the expression fishing for "which" is really poor.

How about something like the following:

-- >8 --
Subject: [PATCH] Reduce false positive in check-non-portable-shell.pl

check-non-portable-shell.pl is using simple regular expressions to
find illegal shell syntax.
Improve the expressions and reduce the chance for false positves:

"sed -i" must be followed by 1..n whitespace and 1 non whitespace
"declare" must be followed by 1..n whitespace and 1 non whitespace
"echo -n" must be followed by 1..n whitespace and 1 non whitespace
"which" must be followed by 1..n whitespace, a string, "end of line"



diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell=
=2Epl
index 8b5a71d..7151dd6 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -16,10 +16,10 @@ sub err {
=20
 while (<>) {
 	chomp;
-	/^\s*sed\s+-i/ and err 'sed -i is not portable';
-	/^\s*echo\s+-n/ and err 'echo -n is not portable (please use printf)'=
;
-	/^\s*declare\s+/ and err 'arrays/declare not portable';
-	/^\s*[^#]\s*which\s/ and err 'which is not portable (please use type)=
';
+	/^\s*sed\s+-i\s+\S/ and err 'sed -i is not portable';
+	/^\s*echo\s+-n\s+\S/ and err 'echo -n is not portable (please use pri=
ntf)';
+	/^\s*declare\s+\S/ and err 'arrays/declare not portable';
+	/^\s*[^#]\s*which\s+[-a-zA-Z0-9]+$/ and err 'which is not portable (p=
lease use type)';
 	/test\s+[^=3D]*=3D=3D/ and err '"test a =3D=3D b" is not portable (pl=
ease use =3D)';
 	# this resets our $. for each file
 	close ARGV if eof;
