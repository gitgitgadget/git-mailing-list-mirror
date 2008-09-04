From: Junio C Hamano <gitster@pobox.com>
Subject: Re: latest clone/pull of git.git problems with setlinebuf.
Date: Wed, 03 Sep 2008 20:33:29 -0700
Message-ID: <7vljy88u0m.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.10.0809031858570.12887@suse104.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 05:34:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb5cK-0005eL-Ha
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 05:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753614AbYIDDdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 23:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753641AbYIDDdi
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 23:33:38 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48982 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753600AbYIDDdh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 23:33:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 56A9E7241C;
	Wed,  3 Sep 2008 23:33:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7D3C57241B; Wed,  3 Sep 2008 23:33:31 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.10.0809031858570.12887@suse104.zenez.com> (Boyd
 Lynn Gerber's message of "Wed, 3 Sep 2008 19:04:30 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 40B391D0-7A32-11DD-8B73-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94885>

Boyd Lynn Gerber <gerberb@zenez.com> writes:

> Hello,
>
> I just noticed that setlinebuf is coming back as undefined when trying
> to build the lastest version.
>
> on UnixWare 7.1.4 I get
>
>     LINK git-var
>     CC daemon.o
> UX:acomp: WARNING: "daemon.c", line 485: end-of-loop code not reached
>     LINK git-daemon
> Undefined                       first referenced
> symbol                              in file
> setlinebuf                          daemon.o
> UX:ld: ERROR: Symbol referencing errors. No output written to git-daemon
> gmake: *** [git-daemon] Error 1

Ah, ok.  I should have noticed that setlinebuf() was outside POSIX (it is
not usable on older BSDs either).

Let's see if we can replace it with setvbuf() which is POSIX.

---
 daemon.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git c/daemon.c w/daemon.c
index 23278e2..7f2743a 100644
--- c/daemon.c
+++ w/daemon.c
@@ -1083,7 +1083,8 @@ int main(int argc, char **argv)
 		openlog("git-daemon", LOG_PID, LOG_DAEMON);
 		set_die_routine(daemon_die);
 	} else
-		setlinebuf(stderr); /* avoid splitting a message in the middle */
+		/* avoid splitting a message in the middle */
+		setvbuf(stderr, NULL, _IOLBF, 0);
 
 	if (inetd_mode && (group_name || user_name))
 		die("--user and --group are incompatible with --inetd");
