From: Antoine Pelisse <apelisse@gmail.com>
Subject: BUG: PATHSPEC_PREFER_CWD requires arguments
Date: Fri, 18 Oct 2013 11:21:33 +0200
Message-ID: <CALWbr2zTZzGZ9fkUonQr77Vn_dfzP57CZR1vNxNJW_touxNstQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 18 11:21:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VX6FY-00046Y-El
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 11:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752604Ab3JRJVf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Oct 2013 05:21:35 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:59388 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448Ab3JRJVe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Oct 2013 05:21:34 -0400
Received: by mail-qa0-f46.google.com with SMTP id j15so478765qaq.5
        for <git@vger.kernel.org>; Fri, 18 Oct 2013 02:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9P5iVMy2fAMq+nKJA7bXqLz27q+DuZYbFQdO8aY+1Lw=;
        b=ZaoLFFzWPnAB5FMDF2HxeK4PZpPNTqFtCAk0hmL8FxvoaXEY6wQ0eYe+CtZC+2fjDx
         tXMB2hB1NwL0QrvezMxp0rO+3NLQcnYzK1MlY3xSAWS9GEqLVFeftIiGOn0BggJ6b9rJ
         h1np0plZaaQHvsgL7S+xh+ZywS9421xDuCgT0lQ8eO0nW3fa2oCRh9/tO8OX/p2pw49E
         yL4I7MNkbxb5DlppeDLlhQyyyC3+u0BLinDmrjG5acLpW510R3NQzw2uTYD7Pfrgovg5
         9qNj0Zz4HyCmVXvAH305uc7vfjjoOW++IRl2WR3iJaILJKQsvPEUBPI3plKnpbZXC81O
         LgZw==
X-Received: by 10.224.29.208 with SMTP id r16mr3054679qac.25.1382088093539;
 Fri, 18 Oct 2013 02:21:33 -0700 (PDT)
Received: by 10.49.104.211 with HTTP; Fri, 18 Oct 2013 02:21:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236336>

Hello,

I ran into the following bug today: "BUG: PATHSPEC_PREFER_CWD requires
arguments". It's not that bad because I'm trying to run `git log
--merge` on an already resolved conflict. Still, I don't think I
should hit a "BUG:" :-)

Here is a script to reproduce:
git init .
>a
git add a
git commit -m"create a"
git branch other
echo "1" >a
git commit -m"add 1" a
git checkout other
echo "2" >a
git commit -m"add 2" a
git merge master
git add a
git log --merge -- a
# Fails with "fatal: BUG: PATHSPEC_PREFER_CWD requires arguments"

Here is what GDB gives me when I break on die():
Breakpoint 1, die (err=3D0x57e3a8 "BUG: PATHSPEC_PREFER_CWD requires
arguments") at usage.c:97
97              if (die_is_recursing()) {
(gdb) bt
#0  die (err=3D0x57e3a8 "BUG: PATHSPEC_PREFER_CWD requires arguments")
at usage.c:97
#1  0x00000000004ea58a in parse_pathspec (pathspec=3D0x7fffffffc288,
magic_mask=3D31, flags=3D0, prefix=3D0x580dad "", argv=3D0x0) at
pathspec.c:377
#2  0x00000000005097b4 in prepare_show_merge (revs=3D0x7fffffffc240) at
revision.c:1375
#3  0x000000000050c32e in setup_revisions (argc=3D2,
argv=3D0x7fffffffcb08, revs=3D0x7fffffffc240, opt=3D0x7fffffffc220) at
revision.c:2147
#4  0x0000000000446efc in cmd_log_init_finish (argc=3D4,
argv=3D0x7fffffffcb08, prefix=3D0x0, rev=3D0x7fffffffc240,
opt=3D0x7fffffffc220)
    at builtin/log.c:147
#5  0x000000000044716a in cmd_log_init (argc=3D4, argv=3D0x7fffffffcb08=
,
prefix=3D0x0, rev=3D0x7fffffffc240, opt=3D0x7fffffffc220) at
builtin/log.c:203
#6  0x0000000000448349 in cmd_log (argc=3D4, argv=3D0x7fffffffcb08,
prefix=3D0x0) at builtin/log.c:635
#7  0x000000000040584a in run_builtin (p=3D0x7bdb30, argc=3D4,
argv=3D0x7fffffffcb08) at git.c:314
#8  0x00000000004059d5 in handle_internal_command (argc=3D4,
argv=3D0x7fffffffcb08) at git.c:478
#9  0x0000000000405b88 in main (argc=3D4, av=3D0x7fffffffcb08) at git.c=
:575

And here is what bisect found:
commit 9a0872744315da67db3c81eb9270751e31fcc8f5
Author: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
Date:   Sun Jul 14 15:35:59 2013 +0700

    remove init_pathspec() in favor of parse_pathspec()

    While at there, move free_pathspec() to pathspec.c

    Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks,
Antoine
