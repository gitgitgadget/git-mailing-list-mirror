From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] do not overwrite untracked symlinks
Date: Sun, 20 Feb 2011 13:13:43 +0100
Message-ID: <20110220121343.GA21514@localhost>
References: <201102022025.06140.j6t@kdbg.org>
 <7v7hdixkys.fsf@alter.siamese.dyndns.org>
 <201102022324.22123.j6t@kdbg.org>
 <201102051918.44848.j6t@kdbg.org>
 <20110205183351.GA25717@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 20 13:12:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pr88w-0001FR-7c
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 13:12:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753798Ab1BTML5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Feb 2011 07:11:57 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42074 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753782Ab1BTML4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Feb 2011 07:11:56 -0500
Received: by mail-fx0-f46.google.com with SMTP id 17so648328fxm.19
        for <git@vger.kernel.org>; Sun, 20 Feb 2011 04:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=SD7B40lGcZPJEOZz0xPT2CkDnPkDSPazNbmB8o12FHY=;
        b=G6isDVM97390AtgUPpYbZPL1z6kzZbBdnF/lJsy1RWiAqIeJFGO4X239RIo7q+H69r
         NBx6r9LNOc2Sz+LgAQQg+Vq+VO4XHSTl9UT3lVax1ewu61Q2BxvkOO5O2AWuVFGGtEe8
         orwFreqlkr/MINYFK205qHtCaTFkNv5MI0f7E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DebcnvEQyy4HYX3pBQyOLACREufRceO+M73WA9+p12ofNfKT7oG6RmuAGiAE93wLCx
         WBCEGZu4SsmRI2gAUmtyzqefku/tBUczcdU5gPwoMb2oKQ9y9iRtcxjYMqpZeaRkp8dW
         qXs8br+Y9k/OKg4ZbpN/T/SSrAYn/cn/Hoz4E=
Received: by 10.223.125.196 with SMTP id z4mr376047far.124.1298203915859;
        Sun, 20 Feb 2011 04:11:55 -0800 (PST)
Received: from darc.lan (p5B22D958.dip.t-dialin.net [91.34.217.88])
        by mx.google.com with ESMTPS id 17sm1924346far.43.2011.02.20.04.11.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 Feb 2011 04:11:55 -0800 (PST)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1Pr8AZ-0005eX-40; Sun, 20 Feb 2011 13:13:43 +0100
Content-Disposition: inline
In-Reply-To: <20110205183351.GA25717@localhost>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167421>

Git traditionally overwrites untracked symlinks silently. This will
generally not cause massive data loss, but it is inconsistent with
the behavior for regular files, which are not silently overwritten.

With this change, git refuses to overwrite untracked symlinks by
default. If the user really wants to overwrite the untracked
symlink, he has git-clean and git-checkout -f at his disposal.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

I checked and there are no undesireable side-effects. One test had
to be modified slightly because it does overwrite an untracked
symlink.

 symlinks.c                      |    2 +-
 t/t6035-merge-dir-to-symlink.sh |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/symlinks.c b/symlinks.c
index 3cacebd..034943b 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -223,7 +223,7 @@ int check_leading_path(const char *name, int len)
 	int flags;
 	int match_len = lstat_cache_matchlen(cache, name, len, &flags,
 			   FL_SYMLINK|FL_NOENT|FL_DIR, USE_ONLY_LSTAT);
-	if (flags & (FL_SYMLINK|FL_NOENT))
+	if (flags & FL_NOENT)
 		return 0;
 	else if (flags & FL_DIR)
 		return -1;
diff --git a/t/t6035-merge-dir-to-symlink.sh b/t/t6035-merge-dir-to-symlink.sh
index 92e02d5..1de285b 100755
--- a/t/t6035-merge-dir-to-symlink.sh
+++ b/t/t6035-merge-dir-to-symlink.sh
@@ -22,7 +22,7 @@ test_expect_success SYMLINKS 'keep a/b-2/c/d across checkout' '
 	git reset --hard master &&
 	git rm --cached a/b &&
 	git commit -m "untracked symlink remains" &&
-	 git checkout start^0 &&
+	 git checkout -f start^0 &&
 	 test -f a/b-2/c/d
 '
 
-- 
1.7.3.1.105.g84915
