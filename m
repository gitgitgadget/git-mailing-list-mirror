From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] Makefile: Remove excess backslashes from sed
Date: Thu, 8 Apr 2010 23:04:28 -0700
Message-ID: <20100409060427.GA6012@gmail.com>
References: <1270783330-35215-1-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 07:48:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O075P-0007fr-49
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 07:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754613Ab0DIFsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 01:48:53 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:43823 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754182Ab0DIFsw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 01:48:52 -0400
Received: by gwb19 with SMTP id 19so1609533gwb.19
        for <git@vger.kernel.org>; Thu, 08 Apr 2010 22:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=hD2TzM+yxqlO+y0Mvb7D9GccPsTa8uy/1IlfqY6A4fk=;
        b=d8JzqIepa9ifAt8KV1mH2NzORMX3NyAMqiDGAWfde3WTe5bCdTeLTvQ8FfgVyjMcyb
         kpW0vZybJobcNL/Nx/RRQRxdPvkuySAOXi9UzpMUajpqpl+zND1HjxSEn7FX2yWBunNk
         DbSgqF5ODHvz2k4grdHP/TfoL1Jr7PwuO3+lk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=vTboQfi4Djasy8UgsxZvFwa12o2P61MCqLbkhBXnCDhY2m5He6V26Z0OnxUJm5uEOA
         SJDFRBlmY8Ky/ZEmAA76MrwMRpftJctt7+OwQGCJx8RWkijI1ClhmFvQZOTdRMLV0ew+
         vgaWWRqWilnhzEOgGz/+wfSv0lraZnu0wG40c=
Received: by 10.151.94.1 with SMTP id w1mr1337568ybl.72.1270792131448;
        Thu, 08 Apr 2010 22:48:51 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 23sm235686ywh.0.2010.04.08.22.48.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Apr 2010 22:48:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1270783330-35215-1-git-send-email-brian@gernhardtsoftware.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144407>

On Thu, Apr 08, 2010 at 11:22:10PM -0400, Brian Gernhardt wrote:
> The sed script that was intended to add lines altering the sys.path
> had extra backslashes in them.  Instead resulting [snip]
>   import sys; \ import os; \ sys.path.insert( ... )

On linux sed I get (or I was dreaming when I tried it):

import sys; \
	import os; \
	sys.path.insert(0, os.getenv(foo,
	                             bar))

We should instead smash it all into one line instead to
avoid differences in sed behavior:

import sys; import os; sys.path.insert(0, os.getenv(foo,
                                                    bar))

If that's what it is, then your patch would produce this on
linux:

import sys;
	import os;
	sys.path.insert(foo,
	                bar)

...which is invalid syntax.

So let's smash it all onto one line instead.  That way I don't
have to think about or test whether there's any difference in
how sed handles newlines.  It'll be the Obviously Correct(tm)
sol'n.  Or maybe I was dreaming?

If you don't beat me to it by the tomorrow night I'll try and
throw together a patch.  Thanks for catching this.

> diff --git a/Makefile b/Makefile
> index f0fe351..b9eb1ca 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1632,8 +1632,8 @@ $(patsubst %.py,%,$(SCRIPT_PYTHON)): % : %.py
>  	sed -e '1{' \
>  	    -e '	s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
>  	    -e '}' \
> -	    -e 's|^import sys.*|&; \\\
> -	           import os; \\\
> +	    -e 's|^import sys.*|&; \
> +	           import os; \
>  	           sys.path.insert(0, os.getenv("GITPYTHONLIB",\
>  	                                        "@@INSTLIBDIR@@"));|' \
-- 

	David
