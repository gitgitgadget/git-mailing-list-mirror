From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Fix gitdir detection when in subdir of gitdir
Date: Sun, 18 Jan 2009 13:27:44 -0800
Message-ID: <7vhc3wuwxb.fsf@gitster.siamese.dyndns.org>
References: <1232120253-1551-1-git-send-email-szeder@ira.uka.de>
 <alpine.DEB.1.00.0901161729070.3586@pacific.mpi-cbg.de>
 <4970BA2B.7090807@viscovery.net> <4970BAE5.8080006@viscovery.net>
 <7vr63386rc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sun Jan 18 22:29:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOfCv-0007wH-MI
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 22:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754551AbZARV1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 16:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752179AbZARV1y
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 16:27:54 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41979 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754692AbZARV1x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 16:27:53 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3451B1BC52;
	Sun, 18 Jan 2009 16:27:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 689621B56B; Sun,
 18 Jan 2009 16:27:46 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DD5A80FE-E5A6-11DD-B7B3-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106284>

Junio C Hamano <gitster@pobox.com> writes:

> I think (1) the solution (almost) makes sense, (2) the patch needs to be
> explained a lot better as you mentioned in your two messages, and (3) if
> it does not affect any other case than when you are in a subdirectory of
> the .git/ directory, then you are doing something funny anyway and
> performance issue Dscho mentions, if any, is not a concern.
>
> My "(almost)" in (1) above is because the patch uses this new behaviour
> even when you are inside the .git/ directory itself (or at the root of a
> bare repository), which is a very common case that we do not have to nor
> want to change the behaviour.  It also invalidates the precondition of (3)
> above.

And this is a trivial follow-up on top of Szeder's patch.

 setup.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git c/setup.c w/setup.c
index 4049298..dd7c039 100644
--- c/setup.c
+++ w/setup.c
@@ -456,8 +456,11 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			inside_git_dir = 1;
 			if (!work_tree_env)
 				inside_work_tree = 0;
-			cwd[offset] = '\0';
-			setenv(GIT_DIR_ENVIRONMENT, cwd, 1);
+			if (offset != len) {
+				cwd[offset] = '\0';
+				setenv(GIT_DIR_ENVIRONMENT, cwd, 1);
+			} else
+				setenv(GIT_DIR_ENVIRONMENT, ".", 1);
 			check_repository_format_gently(nongit_ok);
 			return NULL;
 		}
