From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] improved delta support for git
Date: Wed, 11 May 2005 21:36:54 -0700
Message-ID: <7voebhkql5.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.62.0505112309480.5426@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 06:30:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW5KY-0002Fj-D5
	for gcvg-git@gmane.org; Thu, 12 May 2005 06:29:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVELEhK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 00:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVELEhK
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 00:37:10 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:26612 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261283AbVELEhA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 00:37:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050512043656.XFOB7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 May 2005 00:36:56 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.62.0505112309480.5426@localhost.localdomain> (Nicolas
 Pitre's message of "Wed, 11 May 2005 23:51:07 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The changes to sha1_file interface seems to be contained to
read_sha1_file() only; which is a very good sign.  You have
already expressed that you are aware that fsck-cache needs to be
taught about the delta objects, so I'd trust that would be what
you will be tackling next.

I started wondering how the delta chains would affect pull.c,
the engine that decides which files under GIT_OBJECT_DIRECTORY
need to be pulled from the remote side in order to construct the
set of objects needed by the given commit ID, under various
combinations of cut-off criteria given with -c, -t, and -a
options.

It appears to me that changes to the make_sure_we_have_it()
routine along the following lines (completely untested) would
suffice.  Instead of just returning success, we first fetch the
named object from the remote side, read it to see if it is
really the object we have asked, or just a delta, and if it is a
delta call itself again on the underlying object that delta
object depends upon.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
# - git-pb: Fixed a leak in read-tree
# + (working tree)
--- a/pull.c
+++ b/pull.c
@@ -32,11 +32,23 @@ static void report_missing(const char *w
 static int make_sure_we_have_it(const char *what, unsigned char *sha1)
 {
 	int status;
+	unsigned long mapsize;
+	void *map, *buf;
+
 	if (has_sha1_file(sha1))
 		return 0;
 	status = fetch(sha1);
 	if (status && what)
 		report_missing(what, sha1);
+
+	map = map_sha1_file(sha1, &mapsize);
+	if (map) {
+		buf = unpack_sha1_file(map, mapsize, type, size);
+		munmap(map, mapsize);
+		if (buf && !strcmp(type, "delta"))
+			status = make_sure_we_have_it(what, buf);
+		free(buf);
+	}
 	return status;
 }
 


