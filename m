From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Checking the merge conflicts
Date: Tue, 11 Mar 2008 01:31:01 +0100
Message-ID: <8aa486160803101731t1a8caa8bva73dc64021290c72@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 11 01:31:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYsPB-0000RJ-0h
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 01:31:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbYCKAbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 20:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbYCKAbG
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 20:31:06 -0400
Received: from el-out-1112.google.com ([209.85.162.177]:54580 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbYCKAbE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 20:31:04 -0400
Received: by el-out-1112.google.com with SMTP id v27so1325821ele.17
        for <git@vger.kernel.org>; Mon, 10 Mar 2008 17:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=+pkf9EDR6aliBv5uLFHIey9yizkHCOQ6JgdOV/fOBl0=;
        b=k9e103n7v780uTsNmeO+pEMMrePTqzCQCkO+kUrkKs5QJLR/CCREcje6jiqUMPDO3BxbaSVVREj50PN44baButrQeM8YjBGsDVs4fYNPPxPdW7bHkMXx8b3rd04iKepZrwhwS+4XF++ZcrfsQwweQtNUArT4VNk0Lj4tV+tbmJk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=RHehKeUq9vSSk9etAyHOU2MvwQlzh54KVcES28ajiOY+UN3UXDuPt7S6RHqz/PpEAf35IUE2NW+OTaRMkzWiRW+FceuE1DCDDNwx0xPDYIUNLylu03tlnSLNLOD+3j5sv2dCUxUgM1ZuTtEWcL+ud7rZwOrCrnhqFLvVYax9e4c=
Received: by 10.150.138.8 with SMTP id l8mr3178559ybd.72.1205195461999;
        Mon, 10 Mar 2008 17:31:01 -0700 (PDT)
Received: by 10.150.199.9 with HTTP; Mon, 10 Mar 2008 17:31:01 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76776>

Hi *,

  sometimes I want to check how a conflicting merge was performed.
"git diff --cc" is not exactly what I want because it suppress a hunk
when the merge is equal to one of the parents (at the file and hunk
level). But I want to know which one was chosen. So I've made this
simple shell. Yes, it is ugly and all but does what I want.

[git-checkmerge]
#!/bin/sh
merge=${1:-HEAD}
branch1=$(git rev-parse $merge^1) || exit
branch2=$(git rev-parse $merge^2) || exit
tmpdir=$(mktemp -t -d git-checkmerge.XXXXXXXXX)
newrepo=$tmpdir/checkmerge
git clone -s $PWD $newrepo
cd $newrepo
git config user.name checkmerge
git config user.email checkmerge@checkmerge
git checkout $branch1
git merge $branch2
git diff -R $merge

I recreates the merge with conflict marks included, and shows the diff
between the "recreated merge" and the "merge".

For example with:

$ git-checkmerge 83a2cbbd5873afd99c6cfa01296532ed9a19bdac
[noisy output]
diff --git a/Makefile b/Makefile
index d2fefa1..bd0d05f 100644
--- a/Makefile
+++ b/Makefile
@@ -304,12 +304,7 @@ LIB_H = \
        run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
        tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
        utf8.h reflog-walk.h patch-ids.h attr.h decorate.h progress.h \
-<<<<<<< HEAD:Makefile
        mailmap.h remote.h parse-options.h transport.h diffcore.h
hash.h ll-merge.h fsck.h pack-revindex.h
-=======
-       mailmap.h remote.h parse-options.h transport.h diffcore.h
hash.h fsck.h \
-       pack-revindex.h
->>>>>>> 34cd62eb91600109378c8121c1fecd924a9af177:Makefile

 DIFF_OBJS = \
        diff.o diff-lib.o diffcore-break.o diffcore-order.o \
@@ -333,11 +328,7 @@ LIB_OBJS = \
        color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
        convert.o attr.o decorate.o progress.o mailmap.o symlinks.o remote.o \
        transport.o bundle.o walker.o parse-options.o ws.o archive.o branch.o \
-<<<<<<< HEAD:Makefile
        ll-merge.o alias.o fsck.o pack-revindex.o
-=======
-       alias.o fsck.o pack-revindex.o
->>>>>>> 34cd62eb91600109378c8121c1fecd924a9af177:Makefile

 BUILTIN_OBJS = \
        builtin-add.o \

(sorry if it get refilled/truncated)

you can see that in both conflicting hunks the first change was chosen.

It does all what I want (although slowly, does not support different
strategies,...),
but if there is interest ...

Santi
