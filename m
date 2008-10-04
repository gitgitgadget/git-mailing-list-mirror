From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Files with colons under Cygwin
Date: Sun, 5 Oct 2008 03:39:45 +0400
Message-ID: <20081004233945.GM21650@dpotapov.dyndns.org>
References: <c475e2e60810020702q573570dcp31a5dc18bf98ef30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Giovanni Funchal <gafunchal@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 05 01:41:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmGkH-0007qD-MT
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 01:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754825AbYJDXjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Oct 2008 19:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754813AbYJDXjw
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Oct 2008 19:39:52 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:29163 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754752AbYJDXjv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Oct 2008 19:39:51 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1481539fgg.17
        for <git@vger.kernel.org>; Sat, 04 Oct 2008 16:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=9NDOMMHzkRSPP8n6Jnifwq27uz/BHFW+nSEUbHD02lQ=;
        b=mjitnWEGlzwgVQWl9DMmEGeCi++m8L9eHAOk56eajqqWnAF+TfggPz2DkawZP0SB2A
         ls4i8NhZ6EUhmIeXyQw0HcW7Sp1XK/1BK+8MVZJkrwtB19qgT/XNyav6Al3pbwVJR4Qr
         hYUAE6pkbHtcTerkLzlRcIEIdvgEMrmsncaEM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=b69oPHplOeRSz/2HYT+raEFCUzBXWf8oZdWalIrqQUFfxv0a5HEys8HaDrRJOvMcxX
         2mrpi7yEdVie+HKRVLBf6tpfjoT8H85/weYSqdezw7ZNWtIyZ63BuZVo5sqyi1UeRBfp
         U/4cfK27UBCasGqfJXh0QqZ74z39PzIFUN1vU=
Received: by 10.86.57.9 with SMTP id f9mr2849367fga.66.1223163589498;
        Sat, 04 Oct 2008 16:39:49 -0700 (PDT)
Received: from localhost (ppp83-237-185-144.pppoe.mtu-net.ru [83.237.185.144])
        by mx.google.com with ESMTPS id e20sm7385979fga.1.2008.10.04.16.39.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Oct 2008 16:39:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <c475e2e60810020702q573570dcp31a5dc18bf98ef30@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97488>

On Thu, Oct 02, 2008 at 04:02:23PM +0200, Giovanni Funchal wrote:
> 
> Cygwin does not allow files with colons, I think this is Windows stuff
> one just can't avoid. 

At least, you cannot use colon in Win32 API. They say Windows "native"
API has less restrictions over what symbols are not allowed in file
names, but I guess it is still not allowed.

> If you have files with colons in a git
> repository and try pulling them on cygwin, the file is empty, its name
> is truncated and the status is wrong.
> 
> linux $ date > a:b
> linux $ git init
> linux $ git add a:b
> linux $ git commit -m test
> linux $ git push
> cygwin $ git pull

Strange...  What version of Cygwin did you use?  When I tried this with
Cygwin 1.5.25, I got the following error:

  error: git checkout-index: unable to create file a:b (No medium found)

Apparently, Git tried to create 'b' file on the drive 'a', and creating
files outside of the working tree is not a very good thing to do from
the security point of view, as it can easily overwrite anything in
c:/windows/.

So, here is a patch. It basically disallow backslashes and colons in
file names on Windows (whether it is MinGW or Cygwin).

I wonder if the problem exists on Mac OS X too. From what I heard, it
does not treat ':' as a normal symbol. But I have no access to Mac OS X,
so here is a patch for Windows only.

-- >8 --
From: Dmitry Potapov <dpotapov@gmail.com>
Date: Sat, 4 Oct 2008 22:57:19 +0400
Subject: [PATCH] correct verify_path for Windows

Colon and backslash in names may be used on Windows to overwrite files
outside of the working directory.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 read-cache.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 901064b..972592e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -701,6 +701,16 @@ inside:
 			}
 			return 0;
 		}
+#if defined(_WIN32) || defined(__CYGWIN__)
+		/*
+		 * There is a bunch of other characters that are not allowed
+		 * in Win32 API, but the following two create a security hole
+		 * by allowing to overwrite files outside of the working tree,
+		 * therefore they are explicitly prohibited.
+		 */
+		else if (c == ':' || c == '\\')
+			return 0;
+#endif
 		c = *path++;
 	}
 }
-- 
1.6.0.2.445.g1198

-- >8 --
