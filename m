From: Phil Hord <hordp@cisco.com>
Subject: [PATCH] Make is_gitfile a non-static generic function
Date: Tue, 11 Oct 2011 18:52:27 -0400
Message-ID: <4E94C8AB.3040807@cisco.com>
References: <4E94C70E.3080003@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>,
	Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 00:52:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDlBh-0001A9-9p
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 00:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594Ab1JKWw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 18:52:28 -0400
Received: from rcdn-iport-6.cisco.com ([173.37.86.77]:36027 "EHLO
	rcdn-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491Ab1JKWw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 18:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=2354; q=dns/txt;
  s=iport; t=1318373547; x=1319583147;
  h=message-id:date:from:mime-version:to:subject:references:
   in-reply-to:content-transfer-encoding;
  bh=l+XTGA1R78LSAewdPu8Z3nG6xvpYw8jXv5RmBpcfYp0=;
  b=c8k1JGcCbRO5MFqWuiJiTjxghgATL8zRuS1OdTodLFaOHdQUhVvq3PKH
   7SG7gSpURwCz8K/Xo1uqRfXKy1HZTGT3jltskBCSgWKVUlNT1/rUjR2W7
   b58yJfXXLLmAp9hMWDKaQpTY/1IpBKb80WWxgGldZbCVEzgD3hF69QHNZ
   c=;
X-IronPort-AV: E=Sophos;i="4.68,526,1312156800"; 
   d="scan'208";a="27684171"
Received: from rcdn-core2-5.cisco.com ([173.37.113.192])
  by rcdn-iport-6.cisco.com with ESMTP; 11 Oct 2011 22:52:26 +0000
Received: from [64.100.104.107] (dhcp-64-100-104-107.cisco.com [64.100.104.107])
	by rcdn-core2-5.cisco.com (8.14.3/8.14.3) with ESMTP id p9BMqPqv025844;
	Tue, 11 Oct 2011 22:52:26 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110812 Thunderbird/6.0
In-Reply-To: <4E94C70E.3080003@cisco.com>
X-Enigmail-Version: 1.2.1
X-TagToolbar-Keys: D20111011185227201
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183341>

The new is_gitfile is an amalgam of similar functional checks
from different places in the code.  All these places do
slightly different checks on the suspect gitfile (for their
own good reasons).  But the lack of common code leads to bugs
and maintenance problems. Help move the code forward by making
is_gitfile() a common function that everyone can use for this
purpose.

Signed-off-by: Phil Hord <hordp@cisco.com>
---

I'm not sure this function belongs in transport.c anymore, but
I left it here to minimize conflicts.  I think a better home would
be path.c, but maybe not.  If someone has a preference,
please let me know.

 builtin/clone.c |    8 +-------
 cache.h         |    1 +
 transport.c     |    6 +++++-
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 488f48e..5110399 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -120,13 +120,7 @@ static char *get_repo_path(const char *repo, int
*is_bundle)
 			return xstrdup(absolute_path(path));
 		} else if (S_ISREG(st.st_mode) && st.st_size > 8) {
 			/* Is it a "gitfile"? */
-			char signature[8];
-			int len, fd = open(path, O_RDONLY);
-			if (fd < 0)
-				continue;
-			len = read_in_full(fd, signature, 8);
-			close(fd);
-			if (len != 8 || strncmp(signature, "gitdir: ", 8))
+			if (!is_gitfile(path))
 				continue;
 			path = read_gitfile(path);
 			if (path) {
diff --git a/cache.h b/cache.h
index 601f6f6..7a8d9f9 100644
--- a/cache.h
+++ b/cache.h
@@ -441,6 +441,7 @@ extern const char *get_git_work_tree(void);
 extern const char *read_gitfile(const char *path);
 extern const char *resolve_gitdir(const char *suspect);
 extern void set_git_work_tree(const char *tree);
+extern int is_gitfile(const char *path);
  #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 diff --git a/transport.c b/transport.c
index f3195c0..d08a826 100644
--- a/transport.c
+++ b/transport.c
@@ -859,7 +859,11 @@ static int is_local(const char *url)
 		has_dos_drive_prefix(url);
 }
 -static int is_gitfile(const char *url)
+/*
+ * See if the referenced file looks like a 'gitfile'.
+ * Does not try to determine if the referenced gitdir is actually valid.
+ */
+int is_gitfile(const char *url)
 {
 	struct stat st;
 	char buf[9];
-- 
1.7.7.334.gfc143d
