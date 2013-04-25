From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH] Fix segfault for insane ident line
Date: Thu, 25 Apr 2013 18:32:25 +0800
Message-ID: <cover.1366885748.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 12:32:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVJU1-00039B-0Z
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 12:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755971Ab3DYKcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 06:32:52 -0400
Received: from mail-da0-f52.google.com ([209.85.210.52]:59584 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754929Ab3DYKcv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 06:32:51 -0400
Received: by mail-da0-f52.google.com with SMTP id j17so1360079dan.11
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 03:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=g68UcU+7I5fbrrs1nkb05NvPjufOgCT91X56oFvz0Nw=;
        b=qemq2LujUm56SDrMMd22Z0AmbiAA8lfG2I3cbQKMwwymP/i6Tx9KoLpWEE9w1gRzbm
         lwllccHuk58MC7BRUb9dPnY6ytaGxOOe8Sf4YHOIOVM5FHoUUNOyM90BqX9joOK+FAam
         j4qW1b6UEUHVOAuq/pEd6v7JBrJ6HTR7dx1bMJBaDdKNz3boc7nRlc9IVb3CkIb3UHFW
         zrkodv8hi49w/OwgEwSfUlpcp2+Ed8bRBLXdESGaUUSYmelLJKdONoG8I5kQWpfNyIXK
         zoWGkhztrxEBHEhYtxww48JtSsaJGrRP8RjXbcMlMlzD1GHCLd6YE5scZoSeLv1M3aUm
         uY6w==
X-Received: by 10.66.254.225 with SMTP id al1mr28050678pad.111.1366885971255;
        Thu, 25 Apr 2013 03:32:51 -0700 (PDT)
Received: from localhost.localdomain ([114.248.159.33])
        by mx.google.com with ESMTPSA id ts3sm6857489pbc.12.2013.04.25.03.32.48
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 03:32:50 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.348.gb94490b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222362>

Today when I push a long run repository, git complains:

    $ git push -u github master:doc-tech
    Counting objects: 5575, done.
    Delta compression using up to 8 threads.
    Compressing objects: 100% (2560/2560), done.
    remote: error: object b798e3ffca56af58c2a7728d75027212a558b6d3:invalid author/committer line - missing space before email
    remote: fatal: Error in object
    error: pack-objects died of signal 13
    error: failed to push some refs to ...

When I check the commit, git will segfault:

    $ git show b798e3ffca56af58c2a7728d75027212a558b6d3
    Segmentation fault: 11

But git v1.8.1 works without difficulty, only with a suspect datetime.

    $ gitv1.8.1 log -1 b798e3ffca56af58c2a7728d75027212a558b6d3
    commit b798e3ffca56af58c2a7728d75027212a558b6d3
    Author: leiweiwei<leiww@bj.ossxp.com>
    Date:   Thu Jan 1 00:00:00 1970 +0000
    
        add blog/typo.mm.

Detail of this commit. (Note that username and email is insane.)

    $ gitv1.8.1 cat-file commit b798e3ffca56af58c2a7728d75027212a558b6d3
    tree a1fcf9257bfbcd75f8c9aa931d1e89dbc60ae308
    parent 566f0a6489316db9c9dd12bfda51ffc75a24a9b0
    author leiweiwei<leiww@bj.ossxp.com> <leiweiwei<leiww@bj.ossxp.com>> 1261964093 +0800
    committer leiweiwei<leiww@bj.ossxp.com> <leiweiwei<leiww@bj.ossxp.com>> 1261964093 +0800
    
    add blog/typo.mm.

Because git v1.8.1 is good and v1.8.2 is bad, so I run a `git bisect` on it,
then I find this issue was was introduced in v1.8.1-rc1-7-g3c020bd.

    commit 3c020bd528d5dc320b82bd787670edfe6695f097
    Author: Antoine Pelisse <apelisse@gmail.com>
    Date:   Sat Jan 5 22:26:38 2013 +0100
    
        Use split_ident_line to parse author and committer
        
        Currently blame.c::get_acline(), pretty.c::pp_user_info() and
        shortlog.c::insert_one_record() are parsing author name, email, time
        and tz themselves.
        
        Use ident.c::split_ident_line() for better code reuse.
        
        Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
        Signed-off-by: Junio C Hamano <gitster@pobox.com>

Backtrace for this segfault:

    (gdb) bt
    #0  0x00007fff8d8959ae in strtoul_l ()
    #1  0x000000010012da4a in pp_user_info ()
    #2  0x000000010012f811 in pp_header ()
    #3  0x000000010012f546 in pretty_print_commit ()
    #4  0x000000010010dd1f in show_log ()
    #5  0x000000010010e601 in log_tree_commit ()
    #6  0x00000001000565f1 in cmd_log_walk ()
    #7  0x0000000100056c5c in cmd_show ()
    #8  0x0000000100002710 in run_builtin ()
    #9  0x0000000100001717 in handle_internal_command ()
    #10 0x0000000100001f39 in run_argv ()
    #11 0x000000010000155d in main ()

This patch can fix it.

Jiang Xin (1):
  Fix segfault for insane ident line

 builtin/blame.c | 14 +++++++++++---
 pretty.c        |  9 +++++++--
 2 files changed, 18 insertions(+), 5 deletions(-)

-- 
1.8.2.1.348.gb94490b
