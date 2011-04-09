From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/5] New get_pathspec()
Date: Sat,  9 Apr 2011 23:54:15 +0700
Message-ID: <1302368060-23827-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Apr 09 18:54:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8bQu-0004g8-6e
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 18:54:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754679Ab1DIQya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2011 12:54:30 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33520 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754329Ab1DIQy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2011 12:54:29 -0400
Received: by iyb14 with SMTP id 14so4332135iyb.19
        for <git@vger.kernel.org>; Sat, 09 Apr 2011 09:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=qyilhYl2aaLTl2TvJdhcC3KHkPTudXciPBhSqKMGVvo=;
        b=RjOkRbNcUEjIxj7iGG1IPQgSuMVfiSfYnuyL6iMqRdMC6mms3k1CoBVMVA6Wq/Tysy
         5o0B2gt9TbY1P7uBBfZK2H4610iW1BX4N2QnZcYLc07Mb9bomGwwIWpdFyO4AivFFh1g
         qKaoK+eK+QR8TvHdWX9yKTpEiCUmAzNfVa0Tg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=BDeegHYbYJmFiVZIgMFDeQIjkKiaSAURBgCbYs90sYcasJ0cgAkB+OQaa+wZFKEpSh
         XB9AdUH99vkcD4YAVgJrkspn7Sig6XnS66+m+7ANqnQsc2oGo/nf2MOXbg+WJ8kPJT12
         cm/QK76z74qW+YnWwJxOACazDvV9SNNAxRBlQ=
Received: by 10.42.117.68 with SMTP id s4mr5172194icq.348.1302368068587;
        Sat, 09 Apr 2011 09:54:28 -0700 (PDT)
Received: from tre ([115.73.238.90])
        by mx.google.com with ESMTPS id c1sm2752916ibe.51.2011.04.09.09.54.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 09 Apr 2011 09:54:27 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Sat, 09 Apr 2011 23:54:21 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171195>

This is on top of jc/magic-pathspec. It implements new get_pathspec().
Remaining work includes

 - implement verify_pathspec() (see notes on 5/5)

 - make use of pathspec_item.plain_len introduced in 3/5

 - convert the rest to use new get_pathspec(). Can we make it a GSoC
   project?

 - get rid of old pathspec code.

 - implement a whole lot more of pathspec magic.

I think that's it. We also need to think if we can use similar syntax
for gitattr/gitignore, reuse as much code as possible.


[PATCH 1/5] Rename functions in preparation for get_pathspec() restructure

  I figure I cannot bring all commands to the new get_pathspec() at
  once and remove the old one. So instead I rename the old one so that
  we can have both implementations running in parallel.


[PATCH 2/5] Replace has_wildcard with PATHSPEC_NOGLOB

  This effectively kills Junio's use_wildcard rename patch.


[PATCH 3/5] Convert prefix_pathspec() to produce struct pathspec_item

  Also put plain_len field in place for literal matching on prefix.
  Nobody uses it yet though.


[PATCH 4/5] Implement new get_pathspec()

  I don't move prefix_pathspec() to dir.c yet. It may need some
  updates until things are stablized. It will be moved at latest when
  get_pathspec_old() is retired.


[PATCH 5/5] grep: convert to use the new get_pathspec()

  The first user of the new get_pathspec(), just to make sure I don't
  introduce too many bugs.
  The verify_filename() issue remains. I suggest we keep an
  incarnation of it to catch simple pathspecs, then implement
  verify_pathspec() for wildcard pathspecs.

 archive.c              |    2 +-
 builtin/add.c          |    6 ++--
 builtin/checkout.c     |    8 ++--
 builtin/clean.c        |    4 +-
 builtin/commit.c       |    6 ++--
 builtin/grep.c         |   14 ++------
 builtin/ls-files.c     |    8 ++--
 builtin/ls-tree.c      |    2 +-
 builtin/mv.c           |    2 +-
 builtin/rerere.c       |    2 +-
 builtin/reset.c        |    4 +-
 builtin/rm.c           |    4 +-
 builtin/update-index.c |    2 +-
 cache.h                |   26 +++++++++++++--
 dir.c                  |   81 +++++++++++++++++++++++++++++++++++------------
 dir.h                  |    4 +-
 read-cache.c           |    4 +-
 rerere.c               |    2 +-
 resolve-undo.c         |    2 +-
 revision.c             |    2 +-
 setup.c                |   45 +++++++++++---------------
 tree-walk.c            |   25 +++++++--------
 wt-status.c            |    4 +-
 23 files changed, 151 insertions(+), 108 deletions(-)

-- 
1.7.4.74.g639db
