From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH] make prefix_path() never return NULL
Date: Sun, 5 Oct 2008 04:40:36 +0400
Message-ID: <20081005004036.GO21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 05 02:41:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmHh3-0003Co-AH
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 02:41:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048AbYJEAkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Oct 2008 20:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754003AbYJEAkm
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Oct 2008 20:40:42 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:43845 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893AbYJEAkm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Oct 2008 20:40:42 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1490634fgg.17
        for <git@vger.kernel.org>; Sat, 04 Oct 2008 17:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=LvfVGR8VMVoGJA8BZ9PVF0t66bGAwnNV8ZQ+rq/Zg1c=;
        b=Hm7n29prUGRB4BEzA2y8bcDxMEM0YMroPZSbRTE+4HBiUKFy+/Hz5sl4PBELr4tDe7
         Zqz7etMgmRB3BNk46TZzggKQSCagA/Z0xA6pFE8aLVJEuXBH9+UFN63bSsjuhv264h3+
         ofkzxCvIr9CyrstSFm4FRGOrbFO0QZjKxsU7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=fcNDJdBSOv8AC6jiXMMim+wVzf1RZUcemskuYiHJ8Rq0WSUA0ukdoPIM4e3RNoC+tV
         mDB5FuuQiwt0rhctcOK1Me3IKVfpl/GDDYbyhBlyxOI3Qw3DUy5u74k46OUPMcbTn/WX
         I+rU0qckSN3NtbtvEi9Rrde5a2xdnqdLYdTLo=
Received: by 10.86.1.1 with SMTP id 1mr2889742fga.61.1223167239887;
        Sat, 04 Oct 2008 17:40:39 -0700 (PDT)
Received: from localhost (ppp83-237-185-144.pppoe.mtu-net.ru [83.237.185.144])
        by mx.google.com with ESMTPS id d4sm8824099fga.5.2008.10.04.17.40.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Oct 2008 17:40:39 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97490>

There are 9 places where prefix_path is called, and only in one of
them the returned pointer was checked to be non-zero and only to
call exit(128) as it is usually done by die(). In other 8 places,
the returned value was not checked and it caused SIGSEGV when a
path outside of the working tree was used. For instance, running
  git update-index --add /some/path/outside
caused SIGSEGV.

This patch changes prefix_path() to die if the path is outside of
the repository, so it never returns NULL.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 setup.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/setup.c b/setup.c
index 2e3248a..78a8041 100644
--- a/setup.c
+++ b/setup.c
@@ -110,9 +110,7 @@ const char *prefix_path(const char *prefix, int len, const char *path)
 		if (strncmp(sanitized, work_tree, len) ||
 		    (sanitized[len] != '\0' && sanitized[len] != '/')) {
 		error_out:
-			error("'%s' is outside repository", orig);
-			free(sanitized);
-			return NULL;
+			die("'%s' is outside repository", orig);
 		}
 		if (sanitized[len] == '/')
 			len++;
@@ -216,10 +214,7 @@ const char **get_pathspec(const char *prefix, const char **pathspec)
 	prefixlen = prefix ? strlen(prefix) : 0;
 	while (*src) {
 		const char *p = prefix_path(prefix, prefixlen, *src);
-		if (p)
-			*(dst++) = p;
-		else
-			exit(128); /* error message already given */
+		*(dst++) = p;
 		src++;
 	}
 	*dst = NULL;
-- 
1.6.0.2.445.g1198
