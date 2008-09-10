From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Commit templates are not readable after 'make install'
Date: Wed, 10 Sep 2008 08:34:48 +0200
Message-ID: <48C76A88.2050109@viscovery.net>
References: <3665a1a00809091202u295fedabl53b280aad7bedb62@mail.gmail.com> <7v8wu16sbc.fsf@gitster.siamese.dyndns.org> <7vprnd5b07.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Anatol Pomozov <anatol.pomozov@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 08:36:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdJJ4-0008V9-On
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 08:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbYIJGez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 02:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbYIJGey
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 02:34:54 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:39530 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbYIJGey (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 02:34:54 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KdJHs-0000Qe-Ii; Wed, 10 Sep 2008 08:34:48 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 39C8E6D9; Wed, 10 Sep 2008 08:34:48 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vprnd5b07.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95487>

Junio C Hamano schrieb:
> Fix permission bits on sources checked out with an overtight umask
> 
> Two patches 9907721 (templates/Makefile: don't depend on local umask
> setting, 2008-02-28) and 96cda0b (templates/Makefile: install is
> unnecessary, just use mkdir -p, 2008-08-21) tried to prevent an overtight
> umask the builder/installer might have from screwing over the installation
> procedure, but we forgot there was another source of trouble.  If the
> person who checked out the source tree had an overtight umask, it will
> leak out to the built products, which is propagated to the installation
> destination.
> 
>  templates/Makefile |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git c/templates/Makefile w/templates/Makefile
> index 0722a92..a12c6e2 100644
> --- c/templates/Makefile
> +++ w/templates/Makefile
> @@ -31,9 +31,11 @@ boilerplates.made : $(bpsrc)
>  		dir=`expr "$$dst" : '\(.*\)/'` && \
>  		mkdir -p blt/$$dir && \
>  		case "$$boilerplate" in \
> -		*--) ;; \
> -		*) cp -p $$boilerplate blt/$$dst ;; \
> -		esac || exit; \
> +		*--) continue;; \
> +		esac && \
> +		cp $$boilerplate blt/$$dst && \
> +		if test -x "blt/$$dst"; then rx=rx; else rx=r; fi && \
> +		chmod a+$$rx "blt/$$dst" || exit; \
>  	done && \
>  	date >$@

Since only hooks need to be executable, how about this instead:

diff --git a/templates/Makefile b/templates/Makefile
index 0722a92..80cd000 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -32,7 +32,12 @@ boilerplates.made : $(bpsrc)
 		mkdir -p blt/$$dir && \
 		case "$$boilerplate" in \
 		*--) ;; \
-		*) cp -p $$boilerplate blt/$$dst ;; \
+		hooks--*) \
+			cp -p "$$boilerplate" "blt/$$dst" && \
+			chmod a+rx "blt/$$dst";; \
+		*) \
+			cp -p "$$boilerplate" "blt/$$dst" && \
+			chmod a+r "blt/$$dst";; \
 		esac || exit; \
 	done && \
 	date >$@
