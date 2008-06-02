From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-lib.sh: set PERL5LIB instead of GITPERLLIB
Date: Sun, 01 Jun 2008 22:17:43 -0700
Message-ID: <7vfxrwa008.fsf@gitster.siamese.dyndns.org>
References: <7vy75oalh7.fsf@gitster.siamese.dyndns.org>
 <1212358587-15948-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 07:19:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K32Rj-0002d1-OU
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 07:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbYFBFSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 01:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbYFBFSG
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 01:18:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45597 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbYFBFSE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 01:18:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 398EB242B;
	Mon,  2 Jun 2008 01:18:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6E5C9242A; Mon,  2 Jun 2008 01:17:57 -0400 (EDT)
In-Reply-To: <1212358587-15948-1-git-send-email-LeWiemann@gmail.com> (Lea
 Wiemann's message of "Mon, 2 Jun 2008 00:16:27 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 44A03E7E-3063-11DD-8BE1-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83490>

Lea Wiemann <lewiemann@gmail.com> writes:

>>> How about [setting PERL5LIB in] test-lib.sh?
>> 
>> Sure, I think that would be sensible.
>
> Actually, GITPERLLIB becomes redundant in that case, so I've simply
> replaced it with PERL5LIB in test-lib.sh.

Sorry, but now you mention it, it comes back to me why we have GITPERLLIB,
why the setting of GITPERLLIB in t/test-lib.sh we already have did not
work, and why my "this on top of yours" was a mere workaround and not a
real fix.

The fact is that Git.pm can be installed in a private path outside of
where people usually install site-perl modules, and the primary Makefile
has this rule to munge our perl scripts:

        $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
                $(QUIET_GEN)$(RM) $@ $@+ && \
                INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
                sed -e '1{' \
                    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
                    -e '	h' \
                    -e '	s=.*=use lib (split(/:/, $$ENV{GITPERLLIB} || "@@INSTLIBDIR@@"));=' \
                    -e '	H' \
                    -e '	x' \
                    -e '}' \
                    -e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR"'|g' \
                    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
                    $@.perl >$@+ && \
                chmod +x $@+ && \
                mv $@+ $@

so that people do not have to have that path on PERL5LIB in their
environment when they use git (namely, git-send-email and other scripts
that do "use Git").

The real fix to the issue, which is consistent with what 6fcca93 (Use
$GITPERLLIB instead of $RUNNING_GIT_TESTS and centralize @INC munging,
2006-07-03) did, is not touch any of the t/* files (neither my "this on
top of yours", nor the patch I am responding to), but to fix the build
procedure of gitweb/gitweb.perl so that the above script rewriting is also
applied to it.
