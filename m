From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] Compile fix for MSVC: Move poll.h out of sys-folder
Date: Fri, 18 Nov 2011 15:09:49 +0100
Message-ID: <CABPQNSa+ZjAMSxpBTqGW7P=v-tJTW_jdx3MO=vCpzc-z_XdHTg@mail.gmail.com>
References: <1321624070-4246-1-git-send-email-vfr@lyx.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, msysgit@googlegroups.com,
	j.sixt@viscovery.net
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Fri Nov 18 15:10:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRP9H-0004aE-31
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 15:10:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757975Ab1KROKb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Nov 2011 09:10:31 -0500
Received: from mail-pz0-f42.google.com ([209.85.210.42]:62601 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756830Ab1KROKa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2011 09:10:30 -0500
Received: by pzk36 with SMTP id 36so6074507pzk.1
        for <git@vger.kernel.org>; Fri, 18 Nov 2011 06:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=cn8K77VQs2km0Rs1hjMnQzbinD9nvaK1DtrmhxxHd0o=;
        b=oMr2FYquSSxUl8DYZyv8TIEWcwEL7is31SjhUtkBNj7xTGWIJlpfn6mpU56CNDERjt
         RI7ViettPa7SFwjzCb+V89lj0PLgiD9rtbojKWX/TA/AsRMohR/8UQN7dhJ6kI2M1aGi
         vtU53RqYzs5FS4RwvU64ayuUO7KxlnpsRKn4Y=
Received: by 10.68.0.68 with SMTP id 4mr9758207pbc.51.1321625430061; Fri, 18
 Nov 2011 06:10:30 -0800 (PST)
Received: by 10.68.71.135 with HTTP; Fri, 18 Nov 2011 06:09:49 -0800 (PST)
In-Reply-To: <1321624070-4246-1-git-send-email-vfr@lyx.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185661>

On Fri, Nov 18, 2011 at 2:47 PM, Vincent van Ravesteijn <vfr@lyx.org> w=
rote:
> In v1.7.7.1-432-g0f77dea (Oct 24 2011; Erik Faye-Lund; mingw: move
> poll out of sys-folder) poll.h was moved out of the compat/win32/sys
> folder. As the change in the Makefile also affects the MSVC build,
> the same must be done for poll.h in compat/vcbuild/include/sys/poll.h=
=2E
>
> Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
> ---
> =A0compat/vcbuild/include/poll.h =A0 =A0 | =A0 =A01 +
> =A0compat/vcbuild/include/sys/poll.h | =A0 =A01 -
> =A02 files changed, 1 insertions(+), 1 deletions(-)
> =A0create mode 100644 compat/vcbuild/include/poll.h
> =A0delete mode 100644 compat/vcbuild/include/sys/poll.h
>

This looks strange to me. vcbuild/include/poll.h will only prevent the
correct header from being included, while compiling an linking against
compat/win32/poll.[co]... That seems dangerous to me, because the
interface might be declared differently.

Instead, I think compat/vcbuild/include/poll.h should be removed, and
_WIN32_WINNT set to a value below 0x600. That way the poll-stuff
doesn't get pulled in by winsock2.h (as it's Vista and above only).

This was already discussed in your "[PATCHv2] Compile fix for MSVC" thr=
ead:
http://mid.gmane.org/CABPQNSaCRRRpEQPG1Mb4DovkMdQSBhHTm-i7y5M4iT+ndHX4X=
A@mail.gmail.com

Here's the patch that fixes it. I still can't build Junio's master,
due to sys/resource.h missing. This comes from ebae9ff ("compat: add
missing #include <sys/resource.h>"), and is only guarded against
MinGW, not MSVC...

$ git diff
diff --git a/compat/mingw.h b/compat/mingw.h
index dfb0e87..a06269d 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -1,3 +1,4 @@
+#define _WIN32_WINNT 0x0501
 #include <winsock2.h>
 #include <ws2tcpip.h>

diff --git a/git-compat-util.h b/git-compat-util.h
index 5ef8ff7..c52be6c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -85,6 +85,7 @@
 #define _SGI_SOURCE 1

 #ifdef WIN32 /* Both MinGW and MSVC */
+#define _WIN32_WINNT 0x0501
 #define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
 #include <winsock2.h>
 #include <windows.h>
