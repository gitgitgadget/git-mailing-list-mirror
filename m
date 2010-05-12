From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH v3 0/5] End-of-line normalization, redesigned
Date: Thu, 13 May 2010 01:00:50 +0200
Message-ID: <cover.1273700831.git.eyvind.bernhardsen@gmail.com>
Cc: msysGit <msysgit@googlegroups.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 13 01:02:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCKwI-0004sz-5u
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 01:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757576Ab0ELXBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 May 2010 19:01:05 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:60012 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309Ab0ELXBD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 19:01:03 -0400
Received: by ewy8 with SMTP id 8so355525ewy.28
        for <git@vger.kernel.org>; Wed, 12 May 2010 16:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=95pTe+DG92N79lBnyA3dvzW0g5E9QGpkFYlb/yeSBRc=;
        b=tW5JAPuX/Bhdwu9VskVqexjQQ/lFxnyvXCvQTdlaU6rn/kDPmw09vDHiQW9YBnPuy7
         u8Qb10QunInluHy6HALs0VrDEz7EzzFeTRKgj7HKQjpUdTU961EoJPCBRt8bfjecsSib
         1SosMzOvLgG6BUEIuVEW68hN32UCB/+de35VA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=wsQP4cpUkdiS/g7dzrBo4xrP0VHF8FLdgnoXgxD4kj/2QYQ9e4t2HDo92z9I20NSJP
         mQ3vnKal/U7/qOeGruiovbWI7mGjoQHOvQX8y+4SfKG31N+OLjs/liB/FrrGme0w+WGv
         dgVAB7bF2pF0xWqM3/eVgiU5R9IAKVne10TTU=
Received: by 10.213.48.148 with SMTP id r20mr3699259ebf.42.1273705260586;
        Wed, 12 May 2010 16:01:00 -0700 (PDT)
Received: from localhost.localdomain (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 15sm365675ewy.4.2010.05.12.16.00.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 12 May 2010 16:00:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.5.gd739a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146967>

After Finn Arne's bombshell of a patch, I was almost ready to throw in
the towel on this series.  Then I realized that just because autocrlf
is safe to use now doesn't mean it solves my CRLF-related problems.

The reason is that since autocrlf doesn't require your text files to
be normalized any more, it also doesn't guarantee that they are.  If
you need to interoperate with some other SCM, have tools that require
a specific line ending, or you just like your repository free of CR
characters, autocrlf doesn't do that.

This series does that.  There have been some changes since v2:

- Series is now based on Finn Arne's "safe autocrlf" patch (I took the
  one from "pu" since Junio seems to have fixed some whitespace
  damage).

- Removed core.eolStyle.  This gets more explanation below.

- Added "crlf=lf" and "crlf=crlf"; they turn on normalization and
  convert line endings to LF or CRLF on checkout, respectively.  Yes,
  I know.

- RFC patch: As promised, rename "crlf" attribute as "eolconv",
  keeping "crlf" as an alias for backwards compatibility.  I think
  this one might be worth it, but perhaps not as implemented (see the
  fix I made for git-cvsserver.perl to understand why).

- RFC patch: Rename "core.autocrlf" as "core.eolconv".  This one is
  mainly for fun, not so much for inclusion: it might have the same
  problems as adding an alias for "crlf" and I'm not too bothered
  about the name any more anyway, as I'll explain below.


So if I've removed eolStyle, how does the user say what line endings
to use for a normalized text file in the working directory?  Using
"core.autocrlf".  There are three reasons why that isn't completely
insane:

1. A user who wants CRLFs in text files probably doesn't want them
   just in files that happen to have normalized line endings.

2. You can force CRLF in the working directory now, so if you just
   want .vcproj files and the like to have CRLFs, you check in a
   .gitattributes containing "*.vcproj crlf=crlf" or add that line to
   your .git/info/attributes.  No need to use autocrlf at all.

3. With the "safe autocrlf" patch, core.autocrlf is actually safe to
   use in a non-normalized repository, so "core.autocrlf=true" is no
   longer an insane default.

Given the intended usage for autocrlf it's not even a particularly bad
name any more: "I don't care how you do it, I just want CRLFs in my
text files".  Even "autocrlf=input" isn't that bad if you squint a
bit.  After a few beers.

Summary: the new "core.autocrlf" is for when you don't want to mess up
an existing repository with unwanted CRLFs, and the new "crlf"
mechanisms are for normalizing text files.


Eyvind Bernhardsen (4):
  Add tests for per-repository eol normalization
  Add per-repository eol normalization
  Rename "crlf" attribute as "eolconv"
  Rename "core.autocrlf" config variable as "core.eolconv"

Finn Arne Gangstad (1):
  autocrlf: Make it work also for un-normalized repositories

 Documentation/config.txt        |   26 ++++---
 Documentation/gitattributes.txt |  157 ++++++++++++++++++++++++++++++---------
 attr.c                          |    2 +-
 cache.h                         |    9 ++-
 config.c                        |   13 ++-
 convert.c                       |  115 +++++++++++++++++++++++-----
 environment.c                   |    2 +-
 git-cvsserver.perl              |    8 ++-
 t/t0020-crlf.sh                 |  106 ++++++++++++++++++++++++++
 t/t0025-crlf-auto.sh            |  134 +++++++++++++++++++++++++++++++++
 10 files changed, 497 insertions(+), 75 deletions(-)
 create mode 100755 t/t0025-crlf-auto.sh
