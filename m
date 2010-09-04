From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] Avoid TAGS/tags warning from GNU Make
Date: Sat, 4 Sep 2010 11:34:07 -0500
Message-ID: <20100904163407.GA31513@burratino>
References: <20100904090331.GA10903@burratino>
 <vpqeid97sn6.fsf@bauges.imag.fr>
 <7v8w3hxz81.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Fredrik Kuivinen <frekui@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 04 18:36:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Orviw-0004Nh-HU
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 18:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754386Ab0IDQgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 12:36:09 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50939 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754367Ab0IDQgH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 12:36:07 -0400
Received: by iwn5 with SMTP id 5so2599071iwn.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 09:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=3cQsnCZH63SMnH32j2QTmbLzU3Us4diZAvOHD64DWmU=;
        b=TKpTLXSUMb0RqDj2C8ClWQiq3bIbMt0mdvswsF0O6XMOgU+s8VQjHPQ1aKQWLlMv0O
         0qxczOAB7vbLnp+VFIm1fFE6pdbYB0oklpl+zudS8z3mOZ44dp8ohyASBOzIPkgiM1Wu
         q4EBi4FJBYrHsBq6VKvBG4FTcVaRPr8IzIM4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KJJkFh2LtZNcSfSgv2mBoqlW43ymh0Yxpu5Cm1f921caCM40WKkMP3StbP0xZnDNHf
         G4YCq9YqyDnFs07qwkZji19gb5he1Pdkqzz4UqIUIiKXhQHByT0WW+6kV2U7QghQfTsy
         dXga9/hiN2cdItCm37rTEkBYNMx+z/g/U9J+o=
Received: by 10.231.17.11 with SMTP id q11mr3071490iba.63.1283618167256;
        Sat, 04 Sep 2010 09:36:07 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id h8sm3490714ibk.15.2010.09.04.09.36.05
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 09:36:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v8w3hxz81.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155339>

Junio C Hamano wrote:

> +++ b/Makefile
> @@ -390,6 +390,8 @@ SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
>  	  $(patsubst %.py,%,$(SCRIPT_PYTHON)) \
>  	  git-instaweb
>  
> +ETAGS_TARGET = TAGS
[...]
> @@ -1954,9 +1957,9 @@ info:
>  pdf:
>  	$(MAKE) -C Documentation pdf
>  
> -TAGS:
> -	$(RM) TAGS
> -	$(FIND) . -name '*.[hcS]' -print | xargs etags -a
> +$(ETAGS_TARGET):
> +	$(RM) $(ETAGS_TARGET)
> +	$(FIND) . -name '*.[hcS]' -print | xargs etags -a -o $(ETAGS_TARGET)

Nice.

> @@ -2252,7 +2255,7 @@ endif
>  
>  .PHONY: all install clean strip
>  .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
> -.PHONY: FORCE TAGS tags cscope
> +.PHONY: FORCE cscope

make: `tags' is up to date.

How about something like this squashed in or on top?

-- 8< --
Subject: Makefile: regenerate editor tag files when asked

tags and TAGS depend on all source files, but it is easier to teach
the Makefile to regenerate them every time the user asks than to
declare that.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 52252d4..205fe58 100644
--- a/Makefile
+++ b/Makefile
@@ -1955,11 +1955,11 @@ info:
 pdf:
 	$(MAKE) -C Documentation pdf
 
-$(ETAGS_TARGET):
+$(ETAGS_TARGET): FORCE
 	$(RM) $(ETAGS_TARGET)
 	$(FIND) . -name '*.[hcS]' -print | xargs etags -a -o $(ETAGS_TARGET)
 
-tags:
+tags: FORCE
 	$(RM) tags
 	$(FIND) . -name '*.[hcS]' -print | xargs ctags -a
 
-- 
1.7.2.3
