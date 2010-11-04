From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH v6 00/16] daemon-win32
Date: Thu, 04 Nov 2010 00:28:33 +0000
Message-ID: <8739rind8u.fsf@fox.patthoyts.tk>
References: <1288801894-1168-1-git-send-email-kusmabite@gmail.com>
	<877hgunmdc.fsf@fox.patthoyts.tk>
	<AANLkTin2BCxDoKhDCSgSRG1eVUGVeQh6Bq_=FfAe0M_M@mail.gmail.com>
	<AANLkTin6120QbxyxHt=UM9Dpk_3C-vaD2z8RaRuut76r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Nov 04 01:28:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDnh5-0003Mr-7I
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 01:28:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752915Ab0KDA2j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Nov 2010 20:28:39 -0400
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:58558 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751384Ab0KDA2h convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 3 Nov 2010 20:28:37 -0400
Received: from [172.23.144.246] (helo=asmtp-out2.blueyonder.co.uk)
	by smtp-out3.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1PDngx-00017N-0s; Thu, 04 Nov 2010 00:28:35 +0000
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out2.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1PDngw-00031P-T9; Thu, 04 Nov 2010 00:28:35 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 4728A218FE; Thu,  4 Nov 2010 00:28:34 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <AANLkTin6120QbxyxHt=UM9Dpk_3C-vaD2z8RaRuut76r@mail.gmail.com>
	(Erik Faye-Lund's message of "Wed, 3 Nov 2010 23:39:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160652>

Erik Faye-Lund <kusmabite@gmail.com> writes:

>On Wed, Nov 3, 2010 at 11:18 PM, Erik Faye-Lund <kusmabite@gmail.com> =
wrote:
>> Ah, thanks. For me it's leaking a variable amount of handles per
>> ls-remote, but if I apply the following patch it's down to one. Need
>> to find that one as well...
>>
>> diff --git a/compat/mingw.c b/compat/mingw.c
>> index b780200..47e7d26 100644
>> --- a/compat/mingw.c
>> +++ b/compat/mingw.c
>> @@ -1519,8 +1519,10 @@ pid_t waitpid(pid_t pid, int *status, unsigne=
d options)
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0if (pid > 0 && options & WNOHANG) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (WAIT_OBJECT_0 !=3D WaitForSingleOb=
ject((HANDLE)pid, 0))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (WAIT_OBJECT_0 !=3D WaitForSingleOb=
ject((HANDLE)pid, 0)) {
>
>AAAND the last one is right here as well:
>-		if (WAIT_OBJECT_0 !=3D WaitForSingleObject((HANDLE)pid, 0))
>+		if (WAIT_OBJECT_0 !=3D WaitForSingleObject(h, 0)) {
>

Applying both of these doesn't fix the handle leak when I test
this. Looking further I believe it is due to the use of a reallocated
array. When you remove a pinfo structure you realloc to the one you
found, potentially freeing items you still require.

Attached is a patch that switches to a linked list for this
instead. Using this I no longer accumulate leaked handles.

----
=46rom e0c05f8f9ed8729648eea92cf654f357fa884e40 Mon Sep 17 00:00:00 200=
1
=46rom: Pat Thoyts <patthoyts@users.sourceforge.net>
Date: Thu, 4 Nov 2010 00:23:08 +0000
Subject: [PATCH] win32-daemon: fix handle leaks

The use of an array of pinfo structures and the realloc used when clean=
ing
up a closed child can free structures that are still in use. Use a link=
ed
list instead.
This stops the leaking of handles in the win32-daemon.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 compat/mingw.c |   43 ++++++++++++++++++++++++-------------------
 1 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index b780200..29f4036 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -637,11 +637,12 @@ static int env_compare(const void *a, const void =
*b)
 	return strcasecmp(*ea, *eb);
 }
=20
-struct {
+struct pinfo_t {
+	struct pinfo_t *next;
 	pid_t pid;
 	HANDLE proc;
-} *pinfo;
-static int num_pinfo;
+} pinfo_t;
+struct pinfo_t *pinfo =3D NULL;
 CRITICAL_SECTION pinfo_cs;
=20
 static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char=
 **env,
@@ -746,10 +747,13 @@ static pid_t mingw_spawnve_fd(const char *cmd, co=
nst char **argv, char **env,
 	 * Keep the handle in a list for waitpid.
 	 */
 	EnterCriticalSection(&pinfo_cs);
-	num_pinfo++;
-	pinfo =3D xrealloc(pinfo, sizeof(*pinfo) * num_pinfo);
-	pinfo[num_pinfo - 1].pid =3D pi.dwProcessId;
-	pinfo[num_pinfo - 1].proc =3D pi.hProcess;
+	{
+		struct pinfo_t *info =3D xmalloc(sizeof(struct pinfo_t));
+		info->pid =3D pi.dwProcessId;
+		info->proc =3D pi.hProcess;
+		info->next =3D pinfo;
+		pinfo =3D info;
+	}
 	LeaveCriticalSection(&pinfo_cs);
=20
 	return (pid_t)pi.dwProcessId;
@@ -1519,13 +1523,15 @@ pid_t waitpid(pid_t pid, int *status, unsigned =
options)
 	}
=20
 	if (pid > 0 && options & WNOHANG) {
-		if (WAIT_OBJECT_0 !=3D WaitForSingleObject((HANDLE)pid, 0))
+		if (WAIT_OBJECT_0 !=3D WaitForSingleObject(h, 0)) {
+			CloseHandle(h);
 			return 0;
+		}
 		options &=3D ~WNOHANG;
 	}
=20
 	if (options =3D=3D 0) {
-		int i;
+		struct pinfo_t **ppinfo;
 		if (WaitForSingleObject(h, INFINITE) !=3D WAIT_OBJECT_0) {
 			CloseHandle(h);
 			return 0;
@@ -1536,17 +1542,16 @@ pid_t waitpid(pid_t pid, int *status, unsigned =
options)
=20
 		EnterCriticalSection(&pinfo_cs);
=20
-		for (i =3D 0; i < num_pinfo; ++i)
-			if (pinfo[i].pid =3D=3D pid)
+		ppinfo =3D &pinfo;
+		while (*ppinfo) {
+			struct pinfo_t *info =3D *ppinfo;
+			if (info->pid =3D=3D pid) {
+				CloseHandle(info->proc);
+				*ppinfo =3D info->next;
+				free(info);
 				break;
-
-		if (i < num_pinfo) {
-			CloseHandle(pinfo[i].proc);
-			memmove(pinfo + i, pinfo + i + 1,
-			    sizeof(*pinfo) * (num_pinfo - i - 1));
-			num_pinfo--;
-			pinfo =3D xrealloc(pinfo,
-			    sizeof(*pinfo) * num_pinfo);
+			}
+			ppinfo =3D &info->next;
 		}
=20
 		LeaveCriticalSection(&pinfo_cs);
--=20
1.7.3.1.210.g3526b.dirty
