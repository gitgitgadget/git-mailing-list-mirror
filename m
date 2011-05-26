From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] Include unistd.h.
Date: Wed, 25 May 2011 21:20:45 -0500
Message-ID: <20110526022045.GA8172@elie>
References: <1306332924-28587-1-git-send-email-mduft@gentoo.org>
 <1306332924-28587-3-git-send-email-mduft@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tor Arntsen <tor@spacetec.no>,
	Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: mduft@gentoo.org
X-From: git-owner@vger.kernel.org Thu May 26 04:21:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPQC5-0000x2-4F
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 04:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932802Ab1EZCUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 22:20:55 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51132 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756767Ab1EZCUz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 22:20:55 -0400
Received: by ywe9 with SMTP id 9so140382ywe.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 19:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=lysKBzINW/U+iembYUv97M09eo5qww/rkrB4ynKuWF0=;
        b=chOUGfzjcDhsEa4TFVDgE84hy+eEc4knjXsz2HY2QliMOpvnyw2ldVCOukwSGYyC96
         rN9slxPG9MHNCp3uP+hOKfsTzBagLyT414zk2BaTujzwos8XZ8/QlPJmVUEhX1hwLYzw
         XbNuIMyW/bg1x70uOHD/ihF31bxqygU2JHjeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MmzBOcaJb/hof8XsN7zYtpJ4ARnu8Z1Qs/QVqBRTd9gwqPi9+TEJogvHKhFrqoZ8NQ
         n182WqE3vaEWQgFkjZLX5D3WnQ1alWa6kDxBD3J7UwJ0jHZDOFXDp/0fyHO5Bm1fpO7g
         Ne8nJ7B2w4tbDNnQnib86qndqZ2khE/1yAyrA=
Received: by 10.236.80.104 with SMTP id j68mr378444yhe.197.1306376454505;
        Wed, 25 May 2011 19:20:54 -0700 (PDT)
Received: from elie (adsl-69-209-65-98.dsl.chcgil.sbcglobal.net [69.209.65.98])
        by mx.google.com with ESMTPS id h27sm514574yhe.34.2011.05.25.19.20.52
        (version=SSLv3 cipher=OTHER);
        Wed, 25 May 2011 19:20:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1306332924-28587-3-git-send-email-mduft@gentoo.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174487>

Hi,

mduft@gentoo.org wrote:

> --- a/compat/fnmatch/fnmatch.c
> +++ b/compat/fnmatch/fnmatch.c
> @@ -25,6 +25,7 @@
>  # define _GNU_SOURCE	1
>  #endif
>  
> +#include <unistd.h>
>  #include <errno.h>

Given that we are touching this file anyway, how about relying on
git-compat-util for this?

That way, there is no need to debug feature test macros, order of
#includes, etc.  Untested.

-- >8 --
Subject: compat/fnmatch: use git-compat-util.h for system headers

Finding the right feature test macros and ordering of #includes to
get the desired functionality from all operating systems can be a big
pain.  Take advantage of the debugging already done and avoid future
churn by using git's usual git-compat-util for this.

In particular, the current fnmatch.c doesn't #include anything that
ought to provide NULL unless HAVE_STRING_H is defined, and it fails to
compile on Interix because of this.  Other platforms must have been
getting the macro through another header.

To make this code easier to reuse and to simplify future automated
merges from upstream, still keep the old #includes, just disabled with
"#if 0".

Reported-by: Markus Duft <mduft@gentoo.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Maybe the old #includes after #include-ing git-compat-util should be
left uncommented because harmless.

 compat/fnmatch/fnmatch.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/compat/fnmatch/fnmatch.c b/compat/fnmatch/fnmatch.c
index 14feac7..4bf3b5c 100644
--- a/compat/fnmatch/fnmatch.c
+++ b/compat/fnmatch/fnmatch.c
@@ -16,6 +16,9 @@
    write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
    Boston, MA 02111-1307, USA.  */
 
+#include "git-compat-util.h"
+
+#if 0
 #if HAVE_CONFIG_H
 # include <config.h>
 #endif
@@ -46,6 +49,7 @@
 # include <wchar.h>
 # include <wctype.h>
 #endif
+#endif
 
 /* Comment out all this code if we are using the GNU C Library, and are not
    actually compiling the library itself.  This code is part of the GNU C
-- 
1.7.5.1
