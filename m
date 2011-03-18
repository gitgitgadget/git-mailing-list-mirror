From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Include headers for getrlimit() in sha1_file.c
Date: Fri, 18 Mar 2011 15:23:52 -0500
Message-ID: <20110318202351.GA22696@elie>
References: <1300271879-2050-1-git-send-email-stsp@stsp.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Stefan Sperling <stsp@stsp.name>
X-From: git-owner@vger.kernel.org Fri Mar 18 21:24:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0gDN-0008IC-Qi
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 21:24:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757056Ab1CRUYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 16:24:00 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43363 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756981Ab1CRUX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 16:23:59 -0400
Received: by ywj3 with SMTP id 3so1737092ywj.19
        for <git@vger.kernel.org>; Fri, 18 Mar 2011 13:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=vOvswrfQbs0ezmA3bFHDGuGPu2oMebXaCZAzokJaXoo=;
        b=NpNq+15tOXjod5mk3ColPIU+uCPOfGFQ0TzHSznE254IOxqdj3cYe9jk7s2lj/4lsD
         v8m8N+LkdtKWGEgZNvrq+rW0/fm4yZ3pL6bRrWxkh0/ldlYQRuB/mKCUpN0JldrY4/Qj
         DxzeOXXFCC7pvs1Z8HHy+IVnfMH8KoF/LkCXg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gax7Bb3FamsKq8TwJ4X0KkyRZw9Q5pnQH5+B9PFhIyXgT/0DNlYUdnzzhP06U/RtVG
         9wmKzU5nkdirbqdmH2EcaT+bHizikh0tSkXFzA+yC5+y0w8w+a0uLDFkx5H3qU81RZY9
         8XMg4eQ2RkxsGBMN2ja599pO+XewIBGFPhw3E=
Received: by 10.91.50.6 with SMTP id c6mr1634880agk.66.1300479838775;
        Fri, 18 Mar 2011 13:23:58 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id c24sm445866ana.21.2011.03.18.13.23.56
        (version=SSLv3 cipher=OTHER);
        Fri, 18 Mar 2011 13:23:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1300271879-2050-1-git-send-email-stsp@stsp.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169354>

(+cc: Shawn, Erik)
Hi Stefan,

Stefan Sperling wrote:

> Fixes compilation error on OpenBSD:
> sha1_file.c: In function 'open_packed_git_1':
> sha1_file.c:718: error: storage size of 'lim' isn't known
> sha1_file.c:721: warning: implicit declaration of function 'getrlimit'
> sha1_file.c:721: error: 'RLIMIT_NOFILE' undeclared (first use in this function)
> sha1_file.c:718: warning: unused variable 'lim'

Good catch.

> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -18,6 +18,10 @@
>  #include "pack-revindex.h"
>  #include "sha1-lookup.h"
>  
> +#include <sys/types.h>
> +#include <sys/time.h>
> +#include <sys/resource.h>

System headers like this tend to go in git-compat-util.h, so
portability fixes having to do with compatibility replacements or
order of inclusion only need to happen in one place.

In this case, afaict sys/resource.h is not available on mingw, meaning
the #include would probably go in the "#ifndef __MINGW32__" block.
Maybe something like this (untested)?

-- 8< --
Subject: compat: add missing #include <sys/resource.h>

Starting with commit c793430 (Limit file descriptors used by packs,
2011-02-28), git uses getrlimit to tell how many file descriptors it
can use.  Unfortunately it does not include the header declaring that
function, resulting in compilation errors on OpenBSD:

 sha1_file.c: In function 'open_packed_git_1':
 sha1_file.c:718: error: storage size of 'lim' isn't known
 sha1_file.c:721: warning: implicit declaration of function 'getrlimit'
 sha1_file.c:721: error: 'RLIMIT_NOFILE' undeclared (first use in this function)
 sha1_file.c:718: warning: unused variable 'lim'

The standard header to include for this is <sys/resource.h> (which on
some systems itself requires declarations from <sys/types.h> or
<sys/time.h>).  Probably the problem was missed until now because in
current glibc sys/resource.h happens to be included by sys/wait.h.

MinGW does not provide sys/resource.h (and compat/mingw takes care of
providing getrlimit some other way), so add the missing #include to
the "#ifndef __MINGW32__" block in git-compat-util.h.

Reported-by: Stefan Sperling <stsp@stsp.name>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 git-compat-util.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 49b50ee..40498b3 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -118,6 +118,7 @@
 #endif
 #ifndef __MINGW32__
 #include <sys/wait.h>
+#include <sys/resource.h>
 #include <sys/socket.h>
 #include <sys/ioctl.h>
 #include <termios.h>
-- 
1.7.4.1
