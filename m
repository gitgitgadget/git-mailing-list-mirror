From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Unify the use of standard set of exclude files
Date: Wed, 14 Nov 2007 22:38:41 -0800
Message-ID: <7v4pfo813i.fsf_-_@gitster.siamese.dyndns.org>
References: <30046e3b0711131349h51d253d5n4e5649bde36dc36f@mail.gmail.com>
	<20071113225057.GB22836@artemis.corp>
	<7vsl39l0b7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: shunichi fuji <palglowr@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 15 07:39:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsYNj-0001V4-AV
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 07:39:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333AbXKOGjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 01:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbXKOGjA
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 01:39:00 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:49453 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbXKOGi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 01:38:59 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 63DDD2EF;
	Thu, 15 Nov 2007 01:39:20 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id C3A9890F1B;
	Thu, 15 Nov 2007 01:39:14 -0500 (EST)
In-Reply-To: <7vsl39l0b7.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 14 Nov 2007 00:05:00 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65070>

Junio C Hamano <gitster@pobox.com> writes:

> We probably could change git-ls-files to use the standard set
> when no excludes are specified from the command line, or
> something like that, but this will be a change in semantics that
> would affect the scripts in a subtle way.  I am somewhat
> reluctant to make such a change.

So here it is.

This teaches "git ls-files" to read the standard set of exclude
files when no exclude patterns nor files is given from the
command line.  We used to error out in such a case.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 builtin-ls-files.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index e0b856f..50dcb89 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -542,11 +542,8 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 		ps_matched = xcalloc(1, num);
 	}
 
-	if (dir.show_ignored && !exc_given) {
-		fprintf(stderr, "%s: --ignored needs some exclude pattern\n",
-			argv[0]);
-		exit(1);
-	}
+	if (dir.show_ignored && !exc_given)
+		setup_standard_excludes(&dir);
 
 	/* With no flags, we default to showing the cached files */
 	if (!(show_stage | show_deleted | show_others | show_unmerged |
