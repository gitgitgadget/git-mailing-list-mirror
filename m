From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Export GIT_DIR after setting it
Date: Wed, 14 May 2008 19:25:32 -0700
Message-ID: <7vod78i9r7.fsf@gitster.siamese.dyndns.org>
References: <1210807401-11201-1-git-send-email-madduck@madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "martin f. krafft" <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Thu May 15 04:26:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwTBC-0004Kg-Bv
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 04:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752397AbYEOCZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 22:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752545AbYEOCZq
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 22:25:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63621 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397AbYEOCZp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 22:25:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8A19A5D54;
	Wed, 14 May 2008 22:25:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E09885D50; Wed, 14 May 2008 22:25:39 -0400 (EDT)
In-Reply-To: <1210807401-11201-1-git-send-email-madduck@madduck.net> (martin
 f. krafft's message of "Thu, 15 May 2008 00:23:21 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 380E1F14-2226-11DD-AB70-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82169>

"martin f. krafft" <madduck@madduck.net> writes:

> git-sh-setup might set GIT_DIR, but not export it. When git-pull, for
> instance, calls cd_to_toplevel, it changes the working directory, and later
> calls git-ls-files, which does *not* inherit GIT_DIR since it's not imported.

"Not exporting GIT_DIR" was very much deliberately done when git-sh-setup
was introduced, and it is caller(includer)'s responsibility to export
GIT_DIR when necessary.  Depending on callers, some did not want to export
GIT_DIR, because exporting GIT_DIR means a bit more than that you are at
the toplevel of the tree (e.g. it tells the command not to do the usual
discovery of .git directory) and they have places in their codepath they
cannot cd up when running a git command internally, and/or they do not
want to cd up but they know what they run does GIT_DIR discovery on their
own.  I do not recall which exact callers they were, though.  Do people
recall the details?

Many scripted Porcelains were rewritten in C, and the need to be careful
and selective about when to export and when not to export might have been
removed already in which case it would be Ok to solve whatever you are
trying to solve like this patch does, but this change needs very careful
vetting to make sure that you did not break other scripts with this
change.

This arrangement predates separate work-tree by many months.  It could be
that what needs fixing is the separate work-tree code.  In any case, this
patch is a bit worrying.
