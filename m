From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] perl/Makefile: update NO_PERL_MAKEMAKER section
Date: Wed, 23 Jul 2008 16:29:48 -0700
Message-ID: <7vy73s89hv.fsf@gitster.siamese.dyndns.org>
References: <0GfECozN3g0ZvAESKMi76RyOVHEb2OhhwET9GWmEm7pbzYQJub50UlWpZtBa7MGn1UGb-7mzbzE@cipher.nrlssc.navy.mil> <XKT02T_QW2tKLHpR7e3VuZjLXv3RP2E0GD54gXKrdIFm8xQsKvAyjg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Jul 24 01:30:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLnnL-0005is-6Z
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 01:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754356AbYGWX3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 19:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754462AbYGWX3z
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 19:29:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38395 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754333AbYGWX3y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 19:29:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7697438327;
	Wed, 23 Jul 2008 19:29:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C85E138325; Wed, 23 Jul 2008 19:29:50 -0400 (EDT)
In-Reply-To: <XKT02T_QW2tKLHpR7e3VuZjLXv3RP2E0GD54gXKrdIFm8xQsKvAyjg@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Tue, 22 Jul 2008 16:15:41 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 40A227D6-590F-11DD-8418-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89804>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> The perl modules must be copied to blib/lib so they are available for
> testing.

True, but private-Error needs to be handled a bit more carefully, I
think.

How about this on top of your patch?

 perl/Makefile |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/perl/Makefile b/perl/Makefile
index 2b0d3d5..b8547db 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -25,13 +25,15 @@ $(makfile): ../GIT-CFLAGS Makefile
 	echo all: private-Error.pm Git.pm > $@
 	echo '	mkdir -p blib/lib' >> $@
 	echo '	$(RM) blib/lib/Git.pm; cp Git.pm blib/lib/' >> $@
-	echo '	$(RM) blib/lib/Error.pm; \
-	cp private-Error.pm blib/lib/Error.pm' >> $@
+	echo '	$(RM) blib/lib/Error.pm' >> $@
+	'$(PERL_PATH_SQ)' -MError -e 'exit($$Error::VERSION < 0.15009)' || \
+	echo '	cp private-Error.pm blib/lib/Error.pm' >> $@
 	echo install: >> $@
 	echo '	mkdir -p $(instdir_SQ)' >> $@
 	echo '	$(RM) $(instdir_SQ)/Git.pm; cp Git.pm $(instdir_SQ)' >> $@
-	echo '	$(RM) $(instdir_SQ)/Error.pm; \
-	cp private-Error.pm $(instdir_SQ)/Error.pm' >> $@
+	echo '	$(RM) $(instdir_SQ)/Error.pm' >> $@
+	'$(PERL_PATH_SQ)' -MError -e 'exit($$Error::VERSION < 0.15009)' || \
+	echo '	cp private-Error.pm $(instdir_SQ)/Error.pm' >> $@
 	echo instlibdir: >> $@
 	echo '	echo $(instdir_SQ)' >> $@
 else
