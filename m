From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/2] notes-merge: Don't remove .git/NOTES_MERGE_WORKTREE;
 it may be the user's cwd
Date: Thu, 15 Mar 2012 00:02:31 -0700
Message-ID: <7vipi6l52w.fsf@alter.siamese.dyndns.org>
References: <7vlin3qdpt.fsf@alter.siamese.dyndns.org>
 <1331769333-13890-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	david@tethera.net, pclouds@gmail.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Mar 15 08:02:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S84hs-0001Wp-Mq
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 08:02:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755587Ab2COHCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 03:02:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44350 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753232Ab2COHCf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 03:02:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6F23486D;
	Thu, 15 Mar 2012 03:02:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IKLdVR/J+ZFWs+ltZ5p8prNYCBs=; b=VNt41T
	E6NzyvXaQsJCjmjbbJvo5UWltA3MD7p9Qv49drc/dTQSi9/3FbrjXofb0jj1GI6v
	l0mEdR6kTRHNiXgebWnsqXE1odS7mvGj8ibNqpd0ZRmEc19EiiCozlvvtAdzYjXc
	z8MRx2l6Hz4LgC8eiKpvlgNlQna22GtlEj4Y8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wUckZmrp1u8UasWx3R8pxIBaMtqqTaia
	Hhhw74ZeuVIAqmzR8gl0pFEb8u5XSPUod5rlQQstP2p09j4n4kbZ0kgKQ5NGwFWv
	OsCELSZ9ee199uDDFmiKqGNKA06PtdWdDtHZlczeQNSDYPWBKfpne6cZiOQwFJ71
	A5UYVOGzw1E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E9A6486C;
	Thu, 15 Mar 2012 03:02:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0935B4869; Thu, 15 Mar 2012
 03:02:32 -0400 (EDT)
In-Reply-To: <1331769333-13890-1-git-send-email-johan@herland.net> (Johan
 Herland's message of "Thu, 15 Mar 2012 00:55:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D6682650-6E6C-11E1-9E52-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193189>

Johan Herland <johan@herland.net> writes:

> I'm torn about the new remove_everything_inside_dir(). Obviously it's a
> copy-paste-modify of dir.c:remove_dir_recursively(), and could instead be
> implemented by adding an extra flag to remove_dir_recursively(). However,
> adding a "#define REMOVE_DIR_CONTENTS_BUT_NOT_DIR_ITSELF 04" seemed even
> uglier to me...

Hmm, what ugliness am I missing when viewing the attached patch?  It looks
simple and straightforward enough, at least to me.

 dir.c |   14 ++++++++++----
 dir.h |    1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/dir.c b/dir.c
index 0a78d00..6432728 100644
--- a/dir.c
+++ b/dir.c
@@ -1178,6 +1178,7 @@ int remove_dir_recursively(struct strbuf *path, int flag)
 	struct dirent *e;
 	int ret = 0, original_len = path->len, len;
 	int only_empty = (flag & REMOVE_DIR_EMPTY_ONLY);
+	int keep_toplevel = (flag & REMOVE_DIR_KEEP_TOPLEVEL);
 	unsigned char submodule_head[20];
 
 	if ((flag & REMOVE_DIR_KEEP_NESTED_GIT) &&
@@ -1185,9 +1186,14 @@ int remove_dir_recursively(struct strbuf *path, int flag)
 		/* Do not descend and nuke a nested git work tree. */
 		return 0;
 
+	flag &= ~REMOVE_DIR_KEEP_TOPLEVEL;
 	dir = opendir(path->buf);
-	if (!dir)
-		return rmdir(path->buf);
+	if (!dir) {
+		if (!keep_toplevel)
+			return rmdir(path->buf);
+		else
+			return -1;
+	}
 	if (path->buf[original_len - 1] != '/')
 		strbuf_addch(path, '/');
 
@@ -1202,7 +1208,7 @@ int remove_dir_recursively(struct strbuf *path, int flag)
 		if (lstat(path->buf, &st))
 			; /* fall thru */
 		else if (S_ISDIR(st.st_mode)) {
-			if (!remove_dir_recursively(path, only_empty))
+			if (!remove_dir_recursively(path, flag))
 				continue; /* happy */
 		} else if (!only_empty && !unlink(path->buf))
 			continue; /* happy, too */
@@ -1214,7 +1220,7 @@ int remove_dir_recursively(struct strbuf *path, int flag)
 	closedir(dir);
 
 	strbuf_setlen(path, original_len);
-	if (!ret)
+	if (!ret && !keep_toplevel)
 		ret = rmdir(path->buf);
 	return ret;
 }
diff --git a/dir.h b/dir.h
index dd6947e..58b6fc7 100644
--- a/dir.h
+++ b/dir.h
@@ -102,6 +102,7 @@ extern void setup_standard_excludes(struct dir_struct *dir);
 
 #define REMOVE_DIR_EMPTY_ONLY 01
 #define REMOVE_DIR_KEEP_NESTED_GIT 02
+#define REMOVE_DIR_KEEP_TOPLEVEL 04
 extern int remove_dir_recursively(struct strbuf *path, int flag);
 
 /* tries to remove the path with empty directories along it, ignores ENOENT */
-- 
1.7.10.rc1.22.g07e85
