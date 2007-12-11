From: Nicolas Pitre <nico@cam.org>
Subject: 'git fast-export' is crashing on the gcc repo
Date: Tue, 11 Dec 2007 15:27:33 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712111509270.555@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 11 21:28:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Bhs-0005ci-Dt
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 21:27:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753121AbXLKU1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 15:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752949AbXLKU1f
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 15:27:35 -0500
Received: from relais.videotron.ca ([24.201.245.36]:32796 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752459AbXLKU1e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 15:27:34 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSW008O6JHXAEM0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 11 Dec 2007 15:27:33 -0500 (EST)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67932>

Simply doing something like:

$ git fast-export --all > /dev/null

results in:

fatal: Could not write blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391

Since this is extremely enlightening, I patched it as follows:

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 2136aad..5c7bfe0 100755
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -104,7 +104,8 @@ static void handle_object(const unsigned char *sha1)
 
 	printf("blob\nmark :%d\ndata %lu\n", last_idnum, size);
 	if (fwrite(buf, size, 1, stdout) != 1)
-		die ("Could not write blob %s", sha1_to_hex(sha1));
+		die ("Could not write blob %s: %s",
+		     sha1_to_hex(sha1), strerror(errno));
 	printf("\n");
 
 	show_progress();

And then running it again produced:

fatal: Could not write blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391: Inappropriate ioctl for device

adding to today's confusion.


Nicolas
