From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-push through git protocol
Date: Sun, 21 Jan 2007 14:00:16 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701211341300.14248@woody.osdl.org>
References: <17843.29798.866272.414435@lisa.zopyra.com> <ep00nl$mop$1@sea.gmane.org>
 <Pine.LNX.4.64.0701211034490.14248@woody.osdl.org> <17843.55730.456139.247155@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 21 23:00:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8kjf-00065L-JN
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 23:00:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbXAUWAU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 17:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751696AbXAUWAU
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 17:00:20 -0500
Received: from smtp.osdl.org ([65.172.181.24]:38769 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694AbXAUWAU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 17:00:20 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0LM0HhB004657
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 21 Jan 2007 14:00:17 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0LM0GUm010679;
	Sun, 21 Jan 2007 14:00:16 -0800
To: Bill Lear <rael@zopyra.com>
In-Reply-To: <17843.55730.456139.247155@lisa.zopyra.com>
X-Spam-Status: No, hits=-0.66 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.108__
X-MIMEDefang-Filter: osdl$Revision: 1.170 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37348>



On Sun, 21 Jan 2007, Bill Lear wrote:
>
> I did the steenking testing and it appears to fail.

Ok, I did the test too. It does _appear_ to fail, where the keyword is 
actually the "appear". 

I get

	[torvalds@woody new-repo]$ git push
	updating 'refs/heads/master'
	  from b66385f8f77014d9c3985b1ed1654401508392ad
	  to   2cd693b97b450378fa300ddf6b093aef236953cd
	Generating pack...
	Done counting 4 objects.
	Result has 3 objects.
	Deltifying 3 objects.
	 100% (3/3) done
	Writing 3 objects.
	 100% (3/3) done
	Total 3 (delta 0), reused 0 (delta 0)
	fatal: read error (Bad file descriptor)

On the pushing side, but it all did actually work fine, and trying to push 
again gets you a

	[torvalds@woody new-repo]$ git push
	Everything up-to-date

and the repo I pushed to did get the changes and checks out ok.

So the patch works, but yeah, there's a few issues:

 - the native git:// protocol doesn't open a stream for stderr like ssh 
   does, so all the nice status updates go to the _daemon_ stderr, and on 
   the daemon side I see:

	Unpacking 3 objects
	 100% (3/3) done
	refs/heads/master: b66385f8f77014d9c3985b1ed1654401508392ad -> 2cd693b97b450378fa300ddf6b093aef236953cd

   which might actually be nice from a debugging and logging standpoint, 
   except it doesn't log enough to really be useful.

 - git-send-pack wants expects the status report, and doesn't get one. 
   That, in turn, seems to be because it expects "out" and "in" to be 
   different file descriptors, and with the git:// protocol they aren't 
   (they're the same file descriptor)

This attached patch should fix the second problem. Maybe.

		Linus
---
diff --git a/send-pack.c b/send-pack.c
index cd478dd..3d3ca07 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -327,6 +327,8 @@ static int send_pack(int in, int out, int nr_refspec, char **refspec)
 	}
 
 	packet_flush(out);
+	if (out == in)
+		out = dup(out);
 	if (new_refs)
 		ret = pack_objects(out, remote_refs);
 	close(out);
