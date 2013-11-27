From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 07/24] make sure partially read index is not changed
Date: Wed, 27 Nov 2013 13:00:42 +0100
Message-ID: <1385553659-9928-8-git-send-email-t.gummerer@gmail.com>
References: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Cc: t.gummerer@gmail.com, gitster@pobox.com, tr@thomasrast.ch,
	mhagger@alum.mit.edu, pclouds@gmail.com,
	robin.rosenberg@dewire.com, sunshine@sunshineco.com,
	ramsay@ramsay1.demon.co.uk
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 27 13:02:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VldoZ-0001qJ-8m
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 13:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754710Ab3K0MBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 07:01:50 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:49959 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754322Ab3K0MBr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 07:01:47 -0500
Received: by mail-lb0-f174.google.com with SMTP id c11so5376191lbj.33
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 04:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pKx2xS4sXZUvQEPNOOhYKJR5+NN4HWc+NtDzLInpxS0=;
        b=rWLcc9PcQBjV//5VvQ2a/BwGGMI284XwS+RU32KgZMRQuCRcOE+RZX+dGK6NfHys0L
         YCzxxUKJ1MUUryNbf189FdtDwJY1mkavXLIqrSG46LdOfUjXVIGohxroNSNTYutAfxOd
         oKGowCHJ3hq+pXRw16vkERdiS8KN6bAIc5XwshN0lfTOpb8WP2Ushx6kSJygtenrc2Qk
         3EbhDB9I4hS6AoRrZr1bxfTvwKRZTIYriaa5UdIo7RB7ID5xB+Acb03nvbMMGWoq/Pys
         mF7pUpCu3SCB7lh70BSIS1zjevAO58fQ+mdBdVpfChDP8kMfRg9z0DZkkM5W0V7f97oS
         z04Q==
X-Received: by 10.152.44.202 with SMTP id g10mr29857751lam.16.1385553706421;
        Wed, 27 Nov 2013 04:01:46 -0800 (PST)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id o1sm63650893lah.8.2013.11.27.04.01.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2013 04:01:45 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238421>

A partially read index file currently cannot be written to disk.  Make
sure that never happens by erroring out when a caller tries to write a
partially read index.  Do the same when trying to re-read a partially
read index without having discarded it first to avoid losing any
information.

Forcing the caller to load the right part of the index file, instead of
re-reading it when changing it, gives a bit of a performance advantage
by avoiding reading parts of the index twice.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 read-cache.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 01f5397..7020f26 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1330,6 +1330,8 @@ int read_index_filtered_from(struct index_state *istate, const char *path,
 	void *mmap;
 	size_t mmap_size;
 
+	if (istate->filter_opts)
+		die("BUG: cannot re-read partially read index");
 	errno = EBUSY;
 	if (istate->initialized)
 		return istate->cache_nr;
@@ -1452,6 +1454,8 @@ void update_index_if_able(struct index_state *istate, struct lock_file *lockfile
 
 int write_index(struct index_state *istate, int newfd)
 {
+	if (istate->filter_opts)
+		die("BUG: cannot write a partially read index");
 	return istate->ops->write_index(istate, newfd);
 }
 
-- 
1.8.4.2
