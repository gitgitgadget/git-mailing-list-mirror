From: Nicolas Pitre <nico@cam.org>
Subject: Re: 'git fast-export' is crashing on the gcc repo
Date: Tue, 11 Dec 2007 17:06:42 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712111703380.555@xanadu.home>
References: <alpine.LFD.0.99999.0712111509270.555@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 11 23:07:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2DGC-0006fC-Fv
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 23:07:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbXLKWHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 17:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751872AbXLKWHG
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 17:07:06 -0500
Received: from relais.videotron.ca ([24.201.245.36]:34102 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657AbXLKWHF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 17:07:05 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSW000NYO367ME0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 11 Dec 2007 17:06:42 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.0.99999.0712111509270.555@xanadu.home>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67956>

On Tue, 11 Dec 2007, Nicolas Pitre wrote:

> Simply doing something like:
> 
> $ git fast-export --all > /dev/null
> 
> results in:
> 
> fatal: Could not write blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
> 
> Since this is extremely enlightening, I patched it as follows:
> 
> diff --git a/builtin-fast-export.c b/builtin-fast-export.c
> index 2136aad..5c7bfe0 100755
> --- a/builtin-fast-export.c
> +++ b/builtin-fast-export.c
> @@ -104,7 +104,8 @@ static void handle_object(const unsigned char *sha1)
>  
>  	printf("blob\nmark :%d\ndata %lu\n", last_idnum, size);
>  	if (fwrite(buf, size, 1, stdout) != 1)
> -		die ("Could not write blob %s", sha1_to_hex(sha1));
> +		die ("Could not write blob %s: %s",
> +		     sha1_to_hex(sha1), strerror(errno));
>  	printf("\n");
>  
>  	show_progress();
> 
> And then running it again produced:
> 
> fatal: Could not write blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391: Inappropriate ioctl for device
> 
> adding to today's confusion.

Well, ignore the above.  It seems that most of stdio doesn't set errno 
so the above is crap.

Even strace doesn't show any error.

But, somehow, the following patch fixes it:

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 2136aad..c32a124 100755
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -103,7 +103,7 @@ static void handle_object(const unsigned char *sha1)
 	mark_object(object);
 
 	printf("blob\nmark :%d\ndata %lu\n", last_idnum, size);
-	if (fwrite(buf, size, 1, stdout) != 1)
+	if (fwrite(buf, 1, size, stdout) != size)
 		die ("Could not write blob %s", sha1_to_hex(sha1));
 	printf("\n");
 

Go figure.


Nicolas
