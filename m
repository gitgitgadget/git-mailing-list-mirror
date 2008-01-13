From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH] Don't display crlf warning twice
Date: Mon, 14 Jan 2008 02:46:19 +0300
Message-ID: <1200267979-17683-1-git-send-email-dpotapov@gmail.com>
References: <1200241847776-git-send-email-prohaska@zib.de>
Cc: gitster@pobox.com, torvalds@linux-foundation.org,
	git@vger.kernel.org, Dmitry Potapov <dpotapov@gmail.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Jan 14 00:46:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JECXZ-00036E-NI
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 00:46:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754652AbYAMXq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 18:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754656AbYAMXq2
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 18:46:28 -0500
Received: from smtp03.mtu.ru ([62.5.255.50]:57901 "EHLO smtp03.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754651AbYAMXq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 18:46:27 -0500
Received: from smtp03.mtu.ru (localhost.mtu.ru [127.0.0.1])
	by smtp03.mtu.ru (Postfix) with ESMTP id 547451870BE0;
	Mon, 14 Jan 2008 02:46:24 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-140-170-195.pppoe.mtu-net.ru [85.140.170.195])
	by smtp03.mtu.ru (Postfix) with ESMTP id B1DA11870B2B;
	Mon, 14 Jan 2008 02:46:19 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JECWx-0004bW-J1; Mon, 14 Jan 2008 02:46:19 +0300
X-Mailer: git-send-email 1.5.3.5
In-Reply-To: <1200241847776-git-send-email-prohaska@zib.de>
X-DCC-STREAM-Metrics: smtp03.mtu.ru 10002; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70425>

'git add' could call crlf_to_git() twice, and this caused that the same
crlf warning being display twice. The first time crlf_to_git() is called
when a file is added to index, and it could be called the second time
during writing the index.

This patches sets safe_crlf to false before the second call.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---

On Sun, Jan 13, 2008 at 05:30:47PM +0100, Steffen Prohaska wrote:
>_
> I mentioned earlier that crlf_to_git() would be called twice.  Unfortunately,
> I can't reproduce this behaviour and are not even sure if it ever happend.

I think I have found the cause. It can be seen from the following trace:

==============
#0  crlf_to_git (path=0x814b37e "a", src=0xb7fb4000 "Hello\r\nHello\r\nHello\n", len=20, buf=0xbfad504c, action=-1) at convert.c:89
#1  0x080e0454 in convert_to_git (path=0x814b37e "a", src=0xb7fb4000 "Hello\r\nHello\r\nHello\n", len=20, dst=0xbfad504c) at convert.c:578
#2  0x080b7194 in index_fd (sha1=0xbfad508c "", fd=7, st=0xbfad50d8, write_object=0, type=OBJ_BLOB, path=0x814b37e "a") at sha1_file.c:2345
#3  0x080a7dd4 in ce_compare_data (ce=0x814b340, st=0xbfad50d8) at read-cache.c:56
#4  0x080a8045 in ce_modified_check_fs (ce=0x814b340, st=0xbfad50d8) at read-cache.c:111
#5  0x080aa66d in ce_smudge_racily_clean_entry (ce=0x814b340) at read-cache.c:1121
#6  0x080aa79d in write_index (istate=0x814a3e0, newfd=6) at read-cache.c:1177
#7  0x0804c66a in cmd_add (argc=1, argv=0xbfad6408, prefix=0x0) at builtin-add.c:261
==============
#0  crlf_to_git (path=0x814b094 "a", src=0xb7fb4000 "Hello\r\nHello\r\nHello\n", len=20, buf=0xbfad50ec, action=-1) at convert.c:89
#1  0x080e0454 in convert_to_git (path=0x814b094 "a", src=0xb7fb4000 "Hello\r\nHello\r\nHello\n", len=20, dst=0xbfad50ec) at convert.c:578
#2  0x080b7194 in index_fd (sha1=0x814b368 "", fd=7, st=0xbfad5174, write_object=1, type=OBJ_BLOB, path=0x814b094 "a") at sha1_file.c:2345
#3  0x080b731f in index_path (sha1=0x814b368 "", path=0x814b094 "a", st=0xbfad5174, write_object=1) at sha1_file.c:2377
#4  0x080a8c00 in add_file_to_index (istate=0x814a3e0, path=0x814b094 "a", verbose=0) at read-cache.c:433
#5  0x0804c640 in cmd_add (argc=1, argv=0xbfad6408, prefix=0x0) at builtin-add.c:257
==============

This patch works for me but it certainly needs better testing.

 builtin-add.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 5c29cc2..f113fc1 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -258,9 +258,12 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
  finish:
 	if (active_cache_changed) {
+		enum safe_crlf old = safe_crlf;
+		safe_crlf = SAFE_CRLF_FALSE;
 		if (write_cache(newfd, active_cache, active_nr) ||
 		    close(newfd) || commit_locked_index(&lock_file))
 			die("Unable to write new index file");
+		safe_crlf = old;
 	}
 
 	return 0;
-- 
1.5.3.5
