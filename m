From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v3 01/14] mingw: add network-wrappers for daemon
Date: Sun, 10 Oct 2010 22:20:58 +0200
Message-ID: <AANLkTinP7RKOhLFZs71P5dpmA1p1OsjikSmVv5WkkL1z@mail.gmail.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
 <1286716854-5744-2-git-send-email-kusmabite@gmail.com> <4CB216C2.1060608@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	Mike Pape <dotzenlabs@gmail.com>
To: Eric Sunshine <ericsunshine@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 10 22:21:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P52Of-00027S-Dv
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 22:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964Ab0JJUVY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Oct 2010 16:21:24 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52315 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761Ab0JJUVX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Oct 2010 16:21:23 -0400
Received: by vws2 with SMTP id 2so565718vws.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 13:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=n7VYbU4RqR6qrrI9RDiDwKUYoug2bex1OHRbvbc/OQ4=;
        b=eXN+LOOLIHCmMKh1wFAyZgfREL0E5wSnlQ0h4/m/RoNEDenXshalQdMAwMwXHbou2g
         lPZZq4UxfUgZQDFBhyHCutXOvgrWfGnBfW5K3M1UTYaXgua95P6naJxQWPBAtg7uge5q
         1KC+QLDHSVyrKcPKlUVm/qaczNLMdmj9MS2BY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=wCT+sUcETCTOifPrvGJraYkxULNrn8dci2AZyjQ0qa/rxn6tF0rnsFbsrzxYKHJ7AH
         u6Nc6/bPSPeEnn5AZBqGoP40hEHEqli2wz0ECE16bbU2Ve46r1/2Oi3JklYPbMwK2KYv
         FD+NzYVSWbB86D0E2BqEYRCJRHYVRm++3NqAw=
Received: by 10.220.160.130 with SMTP id n2mr1657156vcx.45.1286742078233; Sun,
 10 Oct 2010 13:21:18 -0700 (PDT)
Received: by 10.220.45.196 with HTTP; Sun, 10 Oct 2010 13:20:58 -0700 (PDT)
In-Reply-To: <4CB216C2.1060608@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158697>

On Sun, Oct 10, 2010 at 9:40 PM, Eric Sunshine <ericsunshine@gmail.com>=
 wrote:
> On 10/10/2010 9:20 AM, Erik Faye-Lund wrote:
>>
>> From: Mike Pape<dotzenlabs@gmail.com>
>>
>> git-daemon requires some socket-functionality that is not yet
>> supported in the Windows-port. This patch adds said functionality,
>> and makes sure WSAStartup gets called by socket(), since it is the
>> first network-call in git-daemon. In addition, a check is added to
>> prevent WSAStartup (and WSACleanup, though atexit) from being
>> called more than once, since git-daemon calls both socket() and
>> gethostbyname().
>>
>> Signed-off-by: Mike Pape<dotzenlabs@gmail.com>
>> Signed-off-by: Erik Faye-Lund<kusmabite@gmail.com>
>> ---
>> diff --git a/compat/mingw.c b/compat/mingw.c
>> index 6590f33..563ef1f 100644
>> --- a/compat/mingw.c
>> +++ b/compat/mingw.c
>> +#undef accept
>> +int mingw_accept(int sockfd1, struct sockaddr *sa, socklen_t *sz)
>> +{
>> + =A0 =A0 =A0 int sockfd2;
>> +
>> + =A0 =A0 =A0 SOCKET s1 =3D (SOCKET)_get_osfhandle(sockfd1);
>> + =A0 =A0 =A0 SOCKET s2 =3D accept(s1, sa, sz);
>> +
>> + =A0 =A0 =A0 /* convert into a file descriptor */
>> + =A0 =A0 =A0 if ((sockfd2 =3D _open_osfhandle(s2, O_RDWR|O_BINARY))=
< =A00) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 closesocket(s2);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return error("unable to make a socket =
file descriptor:
>> %s",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strerror(errno));
>
> Is 'errno' from _open_osfhandle() still valid when handed to strerror=
() or
> has it been clobbered by closesocket()?
>
> Corollary: Does _open_osfhandle() indeed set 'errno', or is it more
> appropriate to call WSAGetLastError()? (The documentation I read for
> _open_osfhandle() did not say anything about how to determine the rea=
son for
> failure.)
>

_open_osfhandle seems to set both errno and the winsock-error.
closesocket() sets the winsock-error but not the CRT. I've just tested
with a very simple application:

---8<---
#include <winsock2.h>
#include <io.h>
#include <fcntl.h>
#include <stdio.h>

const char *win32_strerror(DWORD dw)
{
	static char tmp[4096];
	FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM, NULL, dw,
	    MAKELANGID(LANG_NEUTRAL, SUBLANG_NEUTRAL),
	    tmp, sizeof(tmp), NULL);
	return tmp;
}

int main()
{
	WSADATA wsa =3D {0};

	WSAStartup(MAKEWORD(2, 0), &wsa);
	printf("errno: '%s'\nWSAGetLastError: '%s'\n",
	    strerror(errno), win32_strerror(WSAGetLastError()));
	errno =3D 0;

	_open_osfhandle(-1, O_RDWR | O_BINARY);
	printf("errno: '%s'\nWSAGetLastError: '%s'\n",
	    strerror(errno), win32_strerror(WSAGetLastError()));
	errno =3D 0;

	closesocket(-1);
	printf("errno: '%s'\nWSAGetLastError: '%s'\n",
	    strerror(errno), win32_strerror(WSAGetLastError()));

	return 0;
}

---8<---

The output is:

---8<---
errno: 'Result too large'
WSAGetLastError: 'The operation completed successfully.
'
errno: 'Bad file descriptor'
WSAGetLastError: 'The handle is invalid.
'
errno: 'No error'
WSAGetLastError: 'An operation was attempted on something that is not a=
 socket.
'
---8<---

So, it seems that WSAGetLastError() gets clobbered by closesocket(),
but not errno.
