From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 2/2] A loose object is not corrupt if it cannot be read
 due to EMFILE
Date: Thu, 18 Nov 2010 18:21:27 +0100
Message-ID: <AANLkTikns0Rm5znC7FOa72qZXKpQzazKiYsPe-oDNMAk@mail.gmail.com>
References: <1288299210-27092-1-git-send-email-gitster@pobox.com>
 <1288299210-27092-2-git-send-email-gitster@pobox.com> <AANLkTi=L1Z6kxubMf3yPUfpY9ugd+Qan+yCxi3dp4oR4@mail.gmail.com>
 <4CE55794.7050201@viscovery.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Nov 18 18:21:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ8BH-00026P-Ru
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 18:21:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759950Ab0KRRVv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Nov 2010 12:21:51 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33578 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755241Ab0KRRVu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Nov 2010 12:21:50 -0500
Received: by fxm10 with SMTP id 10so132942fxm.19
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 09:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=fqeYDtCM9Y6yXbtqJRI1ZZT6BgbGfPcKfJ1qwoy0MtM=;
        b=EiHvONyVD64Zi6ffdGnjGBq7XfJXE0dWCVQ3OIUlYqwoetSdzJz//B6IGFRPQqhV18
         ewQPmrlbxHzKutzEJ0uCjG1bij84UDMNYZtMNfj6AJ58vWxMTbx+Oog5GPnoTbv+C9ix
         6XMHEGMFQYkH8zaYSonD8gCVXqXKas+QPwpL4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=uOWXCMTrL7als8/3r/h1RRyhkaMEXsxKyAMpu9niWp07vdVI1vChKene/hTBcjIMdV
         40mXyAqsk450ecsqf18weu7SY882Dlp6LwvqXUukfnwOmY3e1Eh8jR8CLaoL3bb9RD4r
         VP7N+4sxrQUqchySb4m3imrN4rRm00BqWNojg=
Received: by 10.223.107.16 with SMTP id z16mr856257fao.7.1290100909078; Thu,
 18 Nov 2010 09:21:49 -0800 (PST)
Received: by 10.223.72.206 with HTTP; Thu, 18 Nov 2010 09:21:27 -0800 (PST)
In-Reply-To: <4CE55794.7050201@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161689>

On Thu, Nov 18, 2010 at 5:43 PM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> Am 11/18/2010 15:19, schrieb Erik Faye-Lund:
>> What happens, is that read_object returns NULL, but errno is 0.
>> Further, it looks to me like read_object can only return NULL throug=
h
>> the unpack_sha1_file (problem with the compressed data) or
>> read_packed_sha1 (find_pack_entry() failure) code-paths.
>>
>> errno is set to ENOENT by open_sha1_file (through map_sha1_file)
>> before any possible error-points. I guess this makes the "errno =3D =
0"
>> redundant, but I think it improves readability of the code. I'm
>> guessing that errno gets overwritten by some other call, losing the
>> ENOENT. Perhaps some unintended side-effect of one of the
>> compat/mingw.[ch]-wrappers?
>
> The problem is in opendir() called via prepare_packed_git_one() via
> prepare_packed_git(). It resets errno to 0 on success.
>

Hmm, this is not one of our wrappings, but a bug in the mingw-runtine,
right? Perhaps we should report it? I see that "errno =3D 0;" is the
first line of code of _topendir() in the mingw-runtime (see
http://cygwin.com/cgi-bin/cvsweb.cgi/src/winsup/mingw/mingwex/dirent.c?=
rev=3D1.9&cvsroot=3Dsrc),
and from the looks of it it should simply be removed. The same goes
for closedir() and readdir().

That being said, we should probably work around this problem with
opendir() ourselves. This patch fixes the problem for me:

---8<---
diff --git a/compat/mingw.h b/compat/mingw.h
index 35d9813..b5f16fa 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -133,6 +133,29 @@ static inline int mingw_unlink(const char *pathnam=
e)
 }
 #define unlink mingw_unlink

+static inline DIR *mingw_opendir(const char *path)
+{
+	DIR *ret;
+	int saved_errno =3D errno;
+
+	if (!(ret =3D opendir(path)))
+		return NULL;
+
+	errno =3D saved_errno;
+	return ret;
+}
+#define opendir mingw_opendir
+
+static inline int mingw_closedir(DIR *dir)
+{
+	int saved_errno =3D errno;
+	if (closedir(dir) =3D=3D -1)
+		return -1;
+	errno =3D saved_errno;
+	return 0;
+}
+#define closedir mingw_closedir
+
 #define WNOHANG 1
 pid_t waitpid(pid_t pid, int *status, unsigned options);

---8<---

I didn't patch readdir(), since we already have our own
implementation, but perhaps the code should work together with
NO_MINGW_REPLACE_READDIR also... Can somebody remind me why we have an
opt-out for the readdir()-replacement? Debugging?

> You can test this easily by inserting test_done after the 3rd test of
> t5530 and run it with --debug; in the trash-directory you can run
>
> =A0../../git-pack-objects --revs --all --stdout >/dev/null </dev/null
>
> and observe the different failure modes on Windows and Linux.
>

Thanks.

> This makes me question whether the approach of Junio's fix is sane. I=
t
> depends on errno being set *way* before it is checked and after *a*lo=
t* of
> potentially failing system and library calls have been called. Which
> function is it that is expected to fail with ENOENT? git_open_noatime=
()?
>

I was wondering about the same thing, I don't think this approach is
very easy to follow. But either way I think we should make sure
opendir/closedir/readdir doesn't mess with errno.
