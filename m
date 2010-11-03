From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v6 00/16] daemon-win32
Date: Wed, 3 Nov 2010 23:18:38 +0100
Message-ID: <AANLkTin2BCxDoKhDCSgSRG1eVUGVeQh6Bq_=FfAe0M_M@mail.gmail.com>
References: <1288801894-1168-1-git-send-email-kusmabite@gmail.com> <877hgunmdc.fsf@fox.patthoyts.tk>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Nov 03 23:19:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDlfe-0001lj-5m
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 23:19:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636Ab0KCWTB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Nov 2010 18:19:01 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38160 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520Ab0KCWS7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Nov 2010 18:18:59 -0400
Received: by fxm16 with SMTP id 16so956507fxm.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 15:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=4jQmmXb6EJ4NIiXqdVvL0rQL/tjywtOdTj9LV0LFJOw=;
        b=hEZxL6MQRd78FInazwqrAFTSpIgeovuc5Ms6xf5e++AyUpQ2FD8FXz5nBZoE63ZYvE
         vGqrYNvrW5xdP4gM4fFNHGsDSfJPJQHMgLkcyguCVHyg3+Qu/nOxHSFyZ+ORgDsD7Ok+
         qdREi5t+fS56BAGnXBFC8jGqnxotAvoEpByno=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=CzsH1hPIuOJwO/88Z8OfITOVViis+zb/h7RcqmLpC64K8kV5k3C4bpblj2iBNPgLL/
         /FycRUsQNKOX7JTP6RZvtA3/g4cUBonq1D9PRtPMoDwiAA3pO36GIIfNUGnou/U0HqOT
         n9bCuT7VjtIMVkz/zU5QGiTWlpggnB4apWXsU=
Received: by 10.223.96.198 with SMTP id i6mr7357036fan.10.1288822738327; Wed,
 03 Nov 2010 15:18:58 -0700 (PDT)
Received: by 10.223.108.73 with HTTP; Wed, 3 Nov 2010 15:18:38 -0700 (PDT)
In-Reply-To: <877hgunmdc.fsf@fox.patthoyts.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160644>

On Wed, Nov 3, 2010 at 10:11 PM, Pat Thoyts
<patthoyts@users.sourceforge.net> wrote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>>Here's hopefully the last iteration of this series. The previous vers=
ion
>>only got a single complain about a typo in the subject of patch 14/15=
, so
>>it seems like most controversies have been settled.
>
> I pulled this win32-daemon branch into my msysgit build tree and buil=
t
> it. I get the following warnings:
>
> =A0 =A0CC daemon.o
> daemon.c: In function 'service_loop':
> daemon.c:674: warning: dereferencing pointer 'ss.124' does break stri=
ct-aliasing rules
> daemon.c:676: warning: dereferencing pointer 'ss.124' does break stri=
ct-aliasing rules
> daemon.c:681: warning: dereferencing pointer 'ss.124' does break stri=
ct-aliasing rules
> daemon.c:919: note: initialized from here
> daemon.c:679: warning: dereferencing pointer 'sin_addr' does break st=
rict-aliasing rules
> daemon.c:675: note: initialized from here
> daemon.c:691: warning: dereferencing pointer 'sin6_addr' does break s=
trict-aliasing rules
> daemon.c:682: note: initialized from here
>

Yeah, I'm aware of these. I thought those warnings were already
present in the Linux build, but checking again I see that that's not
the case. Need to investigate.

> Otherwise it builds clean. The daemon running on Windows7 seems to be
> working fine for both ipv4 and ipv6 connections (I tried both).
>
> However, monitoring the resource usage in procexp it looks like there=
 is
> a handle leak. Each 'git ls-remote' over ipv6 is gaining 16 handles t=
hat
> do not appear to be released. They're all process handles for dead
> processes it looks like, so possibly there is a missing waitpid() or
> something similar for the 'git daemon -serve' subprocess. Doing this
> over ipv4 leaks 2 handles per request.
>

Ah, thanks. For me it's leaking a variable amount of handles per
ls-remote, but if I apply the following patch it's down to one. Need
to find that one as well...

diff --git a/compat/mingw.c b/compat/mingw.c
index b780200..47e7d26 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1519,8 +1519,10 @@ pid_t waitpid(pid_t pid, int *status, unsigned o=
ptions)
 	}

 	if (pid > 0 && options & WNOHANG) {
-		if (WAIT_OBJECT_0 !=3D WaitForSingleObject((HANDLE)pid, 0))
+		if (WAIT_OBJECT_0 !=3D WaitForSingleObject((HANDLE)pid, 0)) {
+			CloseHandle(h);
 			return 0;
+		}
 		options &=3D ~WNOHANG;
 	}
