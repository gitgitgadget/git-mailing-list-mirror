From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Breakage in master?
Date: Thu, 2 Feb 2012 13:14:19 +0100
Message-ID: <CABPQNSbWu0r_gKGvCHk567pUtQiyDOCO8vFfrzPMFW1eUaj1nw@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 13:15:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsvZF-0005MT-3L
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 13:15:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755833Ab2BBMPA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Feb 2012 07:15:00 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52028 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755509Ab2BBMO7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 07:14:59 -0500
Received: by pbdu11 with SMTP id u11so1966788pbd.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 04:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=0uableIXaUljXLoRHbEfCgmYTa0amuKX/h2JnWBez8I=;
        b=jxcWI3cdl8jubhgFcjkhU/QHrBaNh0Dh6wba+5u1IXTqQve1tsegj04JLjJUDfnMlI
         zqvlIm1lXN6czvkr8Qh9U98OdB5jP72IIOGCtIUbAOFAR8/Ew+OudqwxWyY70lH/3b4K
         eDTlg9I66a0GvUTd7WIOQaBjxFEYOqFnRHI4w=
Received: by 10.68.72.73 with SMTP id b9mr7468874pbv.67.1328184899321; Thu, 02
 Feb 2012 04:14:59 -0800 (PST)
Received: by 10.68.222.165 with HTTP; Thu, 2 Feb 2012 04:14:19 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189635>

Something strange is going on in Junio's current 'master' branch
(f3fb075). "git show" has started to error out on Windows with a
complaint about our vsnprintf:
---8<---

$ git show
commit f3fb07509c2e0b21b12a598fcd0a19a92fc38a9d
Author: Junio C Hamano <gitster@pobox.com>
Date:   Tue Jan 31 22:31:35 2012 -0800

    Update draft release notes to 1.7.10

    Signed-off-by: Junio C Hamano <gitster@pobox.com>

fatal: BUG: your vsnprintf is broken (returned -1)
---8<---

"git status" is also behaving strange:
---8<---
$ git status
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       =E2=86=90[31mcompat/vcbuild/include/sys/resource.h=E2=86=90[m
#       =E2=86=90[31mtemp.patch=E2=86=90[m
#       =E2=86=90[31mtest.c=E2=86=90[m
#       =E2=86=90[31mtest.patch=E2=86=90[m
nothing added to commit but untracked files present (use "git add" to t=
rack)
---8<---

Yeah, the ANSI color codes are being printed verbatim, even though
compat/winansi.c is supposed to convert these. "git -p status" works
fine, as it pipes the ANSI codes directly through less.

But here's the REALLY puzzling part: If I add a simple, unused
function to diff-lib.c, like this:

---8<---
diff --git a/diff-lib.c b/diff-lib.c
index fc0dff3..914a224 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -82,6 +82,11 @@ static int match_stat_with_submodule(struct
diff_options *diffopt,
 	return changed;
 }

+static unsigned int foo(const char *a, unsigned int b)
+{
+	return b;
+}
+
 int run_diff_files(struct rev_info *revs, unsigned int option)
 {
 	int entries, i;
---8<---

"git status" starts to error out with that same vsnprintf complaint!

---8<---
$ git status
# On branch master
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
fatal: BUG: your vsnprintf is broken (returned -1)
---8<---

Here's the stack-trace:
---8<---
Breakpoint 1, die (err=3D0x5268ec "BUG: your vsnprintf is broken (retur=
ned %d)")
    at usage.c:81
81      void NORETURN die(const char *err, ...)
(gdb) bt
#0  die (err=3D0x5268ec "BUG: your vsnprintf is broken (returned %d)")
    at usage.c:81
#1  0x00466314 in strbuf_vaddf (sb=3D0x28fb54,
    fmt=3D0x533ef4 "  (use \"git checkout -- <file>...\" to discard cha=
nges in wor
king directory)", ap=3D0x28fbac "+\025\026\002") at strbuf.c:221
#2  0x004cbb6f in status_vprintf (s=3D0x28fc38, at_bol=3D0,
    color=3D0x46c4f2 "\205=E2=94=94t\n\203=E2=94=80\020[^=E2=95=94=E2=94=
=9C\215v",
    fmt=3D0x533ef4 "  (use \"git checkout -- <file>...\" to discard cha=
nges in wor
king directory)", ap=3D0x28fbac "+\025\026\002", trail=3D0x533a89 "\n")
    at wt-status.c:44
#3  0x004cbe6b in status_printf_ln (s=3D0x28fc38, color=3D0x28fc70 "",
    fmt=3D0x533ef4 "  (use \"git checkout -- <file>...\" to discard cha=
nges in wor
king directory)") at wt-status.c:87
#4  0x004cced1 in wt_status_print (s=3D0x28fc38) at wt-status.c:176
#5  0x0041922e in cmd_status (argc=3D1, argv=3D0x319b4, prefix=3D0x0)
    at builtin/commit.c:1254
#6  0x004019d6 in handle_internal_command (argc=3D<value optimized out>=
,
    argv=3D<value optimized out>) at git.c:308
#7  0x00401c26 in main (argc=3D2, argv=3D0x319b0) at git.c:513
(gdb)
---8<---

This smells a bit like a smashed stack to me. Both issues happens in
roughly the same area of the call stack, and when adding an unused
function changes behavior, something really odd is going on ;)

I've bisected the issues down to 5e9637c (i18n: add infrastructure for
translating Git with gettext). Trying to apply my unused-function
patch on top of this commit starts giving the same "fatal: BUG: your
vsnprintf is broken (returned -1)" error. It's ancestor, bc1bbe0(Git
1.7.8-rc2), does not yield any of the issues.

I'm at a loss here. Does anyone have a hunch about what's going on?
