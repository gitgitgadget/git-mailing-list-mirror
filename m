From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Commit templates are not readable after 'make install'
Date: Tue, 09 Sep 2008 13:18:16 -0700
Message-ID: <7vprnd5b07.fsf@gitster.siamese.dyndns.org>
References: <3665a1a00809091202u295fedabl53b280aad7bedb62@mail.gmail.com>
 <7v8wu16sbc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johannes.sixt@telecom.at
To: "Anatol Pomozov" <anatol.pomozov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 22:19:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd9gR-0002EY-Il
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 22:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbYIIUSZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 16:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753471AbYIIUSY
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 16:18:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40793 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbYIIUSY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 16:18:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 10B945A14C;
	Tue,  9 Sep 2008 16:18:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D01AC5A149; Tue,  9 Sep 2008 16:18:18 -0400 (EDT)
In-Reply-To: <7v8wu16sbc.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 09 Sep 2008 12:19:03 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 73A39A6C-7EAC-11DD-A089-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95422>

Junio C Hamano <gitster@pobox.com> writes:

> Didn't 9907721 (templates/Makefile: don't depend on local umask setting,
> 2008-02-28) take care of that?
>
>     ... goes and looks ...
>
> Ah, that is only to propagate the wish of the person who _built_ it.
>
> You probably have a tight umask and have sources checked out unreadable to
> others, which is propagated to the installation (check the permission of
> files in your templates/blt directory to verify this conjecture).  And the
> build procedure is honoring your wish to make things unreadable to others.

I should have said "too tight a umask", but anyway, try this patch and see
it helps.

-- >8 --
Fix permission bits on sources checked out with an overtight umask

Two patches 9907721 (templates/Makefile: don't depend on local umask
setting, 2008-02-28) and 96cda0b (templates/Makefile: install is
unnecessary, just use mkdir -p, 2008-08-21) tried to prevent an overtight
umask the builder/installer might have from screwing over the installation
procedure, but we forgot there was another source of trouble.  If the
person who checked out the source tree had an overtight umask, it will
leak out to the built products, which is propagated to the installation
destination.

 templates/Makefile |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git c/templates/Makefile w/templates/Makefile
index 0722a92..a12c6e2 100644
--- c/templates/Makefile
+++ w/templates/Makefile
@@ -31,9 +31,11 @@ boilerplates.made : $(bpsrc)
 		dir=`expr "$$dst" : '\(.*\)/'` && \
 		mkdir -p blt/$$dir && \
 		case "$$boilerplate" in \
-		*--) ;; \
-		*) cp -p $$boilerplate blt/$$dst ;; \
-		esac || exit; \
+		*--) continue;; \
+		esac && \
+		cp $$boilerplate blt/$$dst && \
+		if test -x "blt/$$dst"; then rx=rx; else rx=r; fi && \
+		chmod a+$$rx "blt/$$dst" || exit; \
 	done && \
 	date >$@
 
