From: Alexander Potashev <aspotashev@gmail.com>
Subject: [PATCH 0/2] Allow cloning to an existing empty directory
Date: Fri,  9 Jan 2009 02:24:21 +0300
Message-ID: <1231457063-29186-1-git-send-email-aspotashev@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	Alexander Potashev <aspotashev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 09 00:25:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LL4Fo-0004hp-CC
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 00:25:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753008AbZAHXYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 18:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752681AbZAHXYM
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 18:24:12 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:42765 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776AbZAHXYL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 18:24:11 -0500
Received: by bwz14 with SMTP id 14so28191822bwz.13
        for <git@vger.kernel.org>; Thu, 08 Jan 2009 15:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Cqsh5p4Oeai7DRmI8+zUnhOiPCyKd0cMrW73ej3LoQY=;
        b=m3yoF2McIt9v2NcdhrsFFrVnsckt+3MRXWdRWIqoggV4PBpURlL9bsLluFhv49AVNN
         D87NhHhh6/rSXLN/jQw7d0gnbNpQeV4+NMBSC5oNctC2V1XDh7wzIpBlgW+Kb6izRSpd
         XYSiooFybcEJ6m+VnchLIjX3bc9V0qvnXB5yI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=L70VFQJ2nwlN7wRYLnUi0m2Z9ducgWL4/7gYH6JZTb4k7rXBKAzQuUYpdq89ue2cO/
         wwUM6AlzlklbSFSFIy8CC2aYBPZM6r7AM4QYAoNUQ/837hnWZA9nfplJLrP43obhuz30
         raX1AVrN8B9vmZuvUZIwUYq8wbumP8dNajnmc=
Received: by 10.223.124.75 with SMTP id t11mr9631254far.73.1231457049395;
        Thu, 08 Jan 2009 15:24:09 -0800 (PST)
Received: from localhost.localdomain (ppp91-77-14-152.pppoe.mtu-net.ru [91.77.14.152])
        by mx.google.com with ESMTPS id p17sm45302243fka.30.2009.01.08.15.24.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Jan 2009 15:24:09 -0800 (PST)
X-Mailer: git-send-email 1.6.1.77.g84c9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104965>

The problem I experienced today was that I couldn't clone a repo to a
separate filesystem. I've created a new LVM volume, a FS on it (XFS)
and mounted it to a directory.

But wasn't able to clone the repo to that directory. It's impossible to
mount a FS to a non-existent directory, right? But Git refuses to clone
to an existing directory.

The solution in my first patch allows cloning to an existing empty
directory. However, there could be problems doing the same as I did
with XFS using ext2-like filesystems, because they have lost+found
directories, i.e. the root directory of those FSs is never empty.



The first patch adds a function (is_pseudo_dir_name) to compare a
string with "." and "..", the second patch reuses that function in
the rest of the code.


Alexander Potashev (2):
  Allow cloning to an existing empty directory
  Use is_pseudo_dir_name everywhere

 builtin-clone.c         |    8 +++++---
 builtin-count-objects.c |    5 ++---
 builtin-fsck.c          |   14 ++++----------
 builtin-prune.c         |   14 ++++----------
 builtin-rerere.c        |   11 +++++------
 dir.c                   |   31 +++++++++++++++++++++++--------
 dir.h                   |    8 ++++++++
 entry.c                 |    5 ++---
 remote.c                |    6 ++----
 transport.c             |    4 +---
 10 files changed, 56 insertions(+), 50 deletions(-)
