From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 00/13] Column display again
Date: Fri,  3 Feb 2012 20:34:25 +0700
Message-ID: <1328276078-27955-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 03 14:30:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtJE3-0007gv-L3
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 14:30:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756322Ab2BCNah convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 08:30:37 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37976 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756308Ab2BCNaf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 08:30:35 -0500
Received: by dadp15 with SMTP id p15so2736866dad.19
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 05:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=niFghLFNSczPxQ0y6TvCIdxr0CYb254JqeOvcFORLu8=;
        b=UHgud3HBRAV1OxnRh4Cmgme+TYcjU5BDvsF4twryFf8L1n20023d846Hd1phqjLGWe
         v1vvjZZYFGu/xmYQax93RJInIkzLAr7FMnuaBGBnLRERl5sxNMqeOfRMtsJ86rxzAZVk
         +AKTNK9sc7A40UiFggiduEgc9F+PfctcvF7ko=
Received: by 10.68.219.234 with SMTP id pr10mr10186315pbc.11.1328275834897;
        Fri, 03 Feb 2012 05:30:34 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id j5sm13138163pbe.1.2012.02.03.05.30.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Feb 2012 05:30:33 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Fri, 03 Feb 2012 20:34:38 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189758>

Reroll of v3 [1]. This series adds support for column display like
"ls". "git branch", "git tag -l" and "git status"'s untracked files
can now be displayed in columns. There's also "git-column" to help
do the layout for commands that are not aware of column display. In
fact git-tag uses it this way.

I've been thinking of supporting the layout where a cell's content can
occupy more than one cell. It'll make better use of space when there
are a few long entries. Something like this:

abc    def    ghk
longlonglong  short
again  here   now

"git status" may benefit when you have untracked files in some deep
directories.

"ls -R" layout is also an option ("branch -r" and ls-files will
benefit due to dense tree output). But these ideas will have to wait
until later.

Compared to v3, it has "git status" support, the return of git-column,
and column.* conf vars.

[1] http://mid.gmane.org/1300625873-18435-1-git-send-email-pclouds@gmai=
l.com

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (13):
  Save terminal width before setting up pager
  column: add API to print items in columns
  parseopt: make OPT_INTEGER support hexadecimal as well
  Add git-column and column mode parsing
  Stop starting pager recursively
  column: add columnar layout
  column: support columns with different widths
  column: add column.ui for default column output settings
  help: reuse print_columns() for help -a
  branch: add --column
  status: add --column
  column: support piping stdout to external git-column process
  tag: add --column

 .gitignore                   |    1 +
 Documentation/config.txt     |   38 ++++
 Documentation/git-branch.txt |    9 +
 Documentation/git-column.txt |   53 +++++
 Documentation/git-status.txt |    7 +
 Documentation/git-tag.txt    |   11 +-
 Makefile                     |    3 +
 builtin.h                    |    1 +
 builtin/branch.c             |   26 ++-
 builtin/column.c             |   64 ++++++
 builtin/commit.c             |   13 +-
 builtin/tag.c                |   25 ++-
 column.c                     |  493 ++++++++++++++++++++++++++++++++++=
++++++++
 column.h                     |   41 ++++
 command-list.txt             |    1 +
 git.c                        |    1 +
 help.c                       |   70 ++-----
 pager.c                      |   37 +++-
 parse-options.c              |    5 +-
 parse-options.h              |    2 +
 t/t9002-column.sh            |  135 ++++++++++++
 wt-status.c                  |   38 +++-
 wt-status.h                  |    2 +-
 23 files changed, 1002 insertions(+), 74 deletions(-)
 create mode 100644 Documentation/git-column.txt
 create mode 100644 builtin/column.c
 create mode 100644 column.c
 create mode 100644 column.h
 create mode 100755 t/t9002-column.sh

--=20
1.7.8.36.g69ee2
