From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] pack-objects: use of version 3 delta is now optional.
Date: Sun, 15 Oct 2006 11:53:35 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610151135110.17085@xanadu.home>
References: <7v4pu62ite.fsf@assigned-by-dhcp.cox.net>
 <7virim10rb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Oct 15 17:53:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZ8J4-00068H-PY
	for gcvg-git@gmane.org; Sun, 15 Oct 2006 17:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbWJOPxi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 11:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWJOPxh
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 11:53:37 -0400
Received: from relais.videotron.ca ([24.201.245.36]:57232 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751034AbWJOPxh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Oct 2006 11:53:37 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J76000FAPHBB190@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 15 Oct 2006 11:53:36 -0400 (EDT)
In-reply-to: <7virim10rb.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28919>

On Sun, 15 Oct 2006, Junio C Hamano wrote:

> This introduces a new configuration item, pack.deltaversion, to
> control whether pack-objects is allowed to use version 3 delta.
> By default, we keep generating version 2 delta (and version 2
> packfile format) to be compatible with git earlier than v1.2.0.
> 
> This configuration affects the command in the following ways:
> 
>  - the resulting packfile will have the specified version;
> 
>  - when generating delta, larger copies are allowed only when
>    deltaversion is 3;
> 
>  - the logic to reuse delta from existing packs refuses to reuse
>    delta from packs that uses delta version 3 when the
>    configuration is set to 2.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>

I'd suggest to drop this altogether.  See my previous email for my 
reasoning on this issue.  I think this should be done another way.

If anything, maybe this patch can be added before v1.4.3 is released:

diff --git a/fetch-pack.c b/fetch-pack.c
index 7d23a80..1688417 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -165,9 +165,10 @@ static int find_common(int fd[2], unsign
 			continue;
 		}
 
-		packet_write(fd[1], "want %s%s%s\n", sha1_to_hex(remote),
+		packet_write(fd[1], "want %s%s%s%s\n", sha1_to_hex(remote),
 			     (multi_ack ? " multi_ack" : ""),
-			     (use_thin_pack ? " thin-pack" : ""));
+			     (use_thin_pack ? " thin-pack" : ""),
+			     " packv3");
 		fetching++;
 	}
 	packet_flush(fd[1]);
diff --git a/upload-pack.c b/upload-pack.c
index 979e583..8e57316 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -218,7 +218,7 @@ static int receive_needs(void)
 
 static int send_ref(const char *refname, const unsigned char *sha1)
 {
-	static char *capabilities = "multi_ack thin-pack";
+	static char *capabilities = "multi_ack thin-pack packv3";
 	struct object *o = parse_object(sha1);
 
 	if (!o)

This way pack v3 could be fed to GIT v1.4.3 and above whenever we add 
back pack v3 generation, and a pack converted to v2 from any v3 on the 
fly when that capability is not present.


Nicolas
