From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] transport-helper.c: don't leak fdopen'd stream buffers
Date: Sat, 12 Sep 2009 11:38:58 +0200
Message-ID: <87hbv833kd.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 12 11:39:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmP4b-0007om-Dh
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 11:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744AbZILJjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 05:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752314AbZILJjD
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 05:39:03 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:57251 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751979AbZILJjC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 05:39:02 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 9E1388180C2
	for <git@vger.kernel.org>; Sat, 12 Sep 2009 11:39:01 +0200 (CEST)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g21.free.fr (Postfix) with ESMTP id BF27781814E
	for <git@vger.kernel.org>; Sat, 12 Sep 2009 11:38:58 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id A26C92BDA2; Sat, 12 Sep 2009 11:38:58 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128244>

Looking in the vicinity today, I noticed that these
fdopen'd streams were never fclosed;  technically a leak
of both the FILE buffer and the file descriptor.

>From aeae4edb1146b107f6a397118db8b0ac06b884d9 Mon Sep 17 00:00:00 2001
From: Jim Meyering <meyering@redhat.com>
Date: Sat, 12 Sep 2009 11:35:17 +0200
Subject: [PATCH] transport-helper.c: don't leak fdopen'd stream buffers

* transport-helper.c (get_helper, fetch_with_fetch, get_refs_list):
Call fclose on each just-created FILE* pointer, when done.

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 transport-helper.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index f57e84c..0bbd014 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -49,6 +49,7 @@ static struct child_process *get_helper(struct transport *transport)
 		if (!strcmp(buf.buf, "fetch"))
 			data->fetch = 1;
 	}
+	fclose (file);
 	return data->helper;
 }

@@ -88,6 +89,7 @@ static int fetch_with_fetch(struct transport *transport,
 		if (strbuf_getline(&buf, file, '\n') == EOF)
 			exit(128); /* child died, message supplied already */
 	}
+	fclose (file);
 	return 0;
 }

@@ -147,6 +149,7 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 			get_sha1_hex(buf.buf, (*tail)->old_sha1);
 		tail = &((*tail)->next);
 	}
+	fclose (file);
 	strbuf_release(&buf);

 	for (posn = ret; posn; posn = posn->next)
--
1.6.5.rc0.190.g15871
