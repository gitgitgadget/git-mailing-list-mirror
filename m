From: Geert Bosch <bosch@adacore.com>
Subject: git gc taking forever to reflog expire --all
Date: Mon, 10 May 2010 13:58:11 -0400
Message-ID: <0C5B1A89-551A-4EC8-862A-C306A286FAF4@adacore.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 10 19:58:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBXFE-0003Oj-BX
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 19:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753795Ab0EJR6N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 May 2010 13:58:13 -0400
Received: from rock.gnat.com ([205.232.38.15]:45702 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751717Ab0EJR6M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 May 2010 13:58:12 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id 9F9BF2BABDB
	for <git@vger.kernel.org>; Mon, 10 May 2010 13:58:11 -0400 (EDT)
X-Virus-Scanned: Debian amavisd-new at gnat.com
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id WvzyzE+0rwIw for <git@vger.kernel.org>;
	Mon, 10 May 2010 13:58:11 -0400 (EDT)
Received: from potomac.gnat.com (potomac.gnat.com [205.232.38.115])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTPSA id 867072BABBC
	for <git@vger.kernel.org>; Mon, 10 May 2010 13:58:11 -0400 (EDT)
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146840>

On my recent MacBook Pro, I gave up after reflog expire --all
had chewed up 30 minutes of perfectly fine CPU time.

Basically, I have a SVN import of a single branch of a repository
with just a single directory with 3K files or so (this SVN import
is part of a bigger repository). There are about 117K commits
in the GIT history. I have a few local branches of just a couple
commits each. The total .git size is 450MB, with about 3K loose
objects.

This seems something that should be "git gc"-ed in about a
minute or less, so I'm puzzled what is going on in this
git reflog expire. From a cursory look it seems that
we're in a loop finding a merge base for each commit, or
similar. I'm including a log of a random interruption
(using Ubuntu here instead of MacOS for better debugging).

  -Geert

#0  0x080b1c8c in clear_commit_marks (commit=3D0x87b2d60, mark=3D983040=
)
    at commit.c:403
#1  0x080b2d44 in get_merge_bases_many (one=3D0x90a9120, n=3D1, twos=3D=
0xbffff344,=20
    cleanup=3D1) at commit.c:655
#2  0x080b2e67 in get_merge_bases (one=3D0x90a9120, two=3D0x819f720, cl=
eanup=3D1)
    at commit.c:704
#3  0x080b2e9b in in_merge_bases (commit=3D0x90a9120, reference=3D0xbff=
ff51c,=20
    num=3D1) at commit.c:728
#4  0x08092ffa in unreachable (cb=3D0xbffff514, commit=3D0x5,=20
    sha1=3D0xbffff484 "\264\252\244\232\320=3DQ\213\243=D2=8A\323\070%[=
T\232\360,\032\214=3D\226\340\001\253\335tZ ", <incomplete sequence \30=
3>) at builtin/reflog.c:233
#5  0x080930f5 in expire_reflog_ent (
    osha1=3D0xbffff498 "\232\360,\032\214=3D\226\340\001\253\335tZ ", <=
incomplete sequence \303>,=20
    nsha1=3D0xbffff484 "\264\252\244\232\320=3DQ\213\243=D2=8A\323\070%=
[T\232\360,\032\214=3D\226\340\001\253\335tZ ", <incomplete sequence \3=
03>,=20
    email=3D0x81c0ada "Geert Bosch <bosch@gnat.com>", timestamp=3D12659=
08541,=20
    tz=3D0, message=3D0x81c0b08 "r4741\n", cb_data=3D0xbffff514)
    at builtin/reflog.c:298
#6  0x080e2c1f in for_each_recent_reflog_ent (
    ref=3D0x818066c "refs/remotes/git-svn@130115",=20
    fn=3D0x8093030 <expire_reflog_ent>, ofs=3D0, cb_data=3D0xbffff514) =
at refs.c:1623
#7  0x080e2d27 in for_each_reflog_ent (
    ref=3D0x818066c "refs/remotes/git-svn@130115",=20
    fn=3D0x8093030 <expire_reflog_ent>, cb_data=3D0xbffff514) at refs.c=
:1635
#8  0x080924d7 in expire_reflog (ref=3D0x818066c "refs/remotes/git-svn@=
130115",=20
    sha1=3D0x819f720 "\005", unused=3D<value optimized out>, cb_data=3D=
0xbffff594)
    at builtin/reflog.c:353
#9  0x08092ab6 in cmd_reflog_expire (argc=3D2, argv=3D0xbffffb2c, prefi=
x=3D0x0)
    at builtin/reflog.c:599
#10 0x0804b374 in run_builtin (argc=3D3, argv=3D0xbffffb28) at git.c:26=
0
#11 handle_internal_command (argc=3D3, argv=3D0xbffffb28) at git.c:416
#12 0x0804b572 in run_argv (argc=3D3, argv=3D0xbffffb28) at git.c:458
#13 main (argc=3D3, argv=3D0xbffffb28) at git.c:529
