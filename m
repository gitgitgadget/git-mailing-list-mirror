From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git grep broken on master - won't work when merging
Date: Mon, 05 Nov 2007 17:02:24 -0800
Message-ID: <7vlk9ckwyn.fsf@gitster.siamese.dyndns.org>
References: <46a038f90711051553p6202cc62wfda6b45ff7769984@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git list" <git@vger.kernel.org>
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 02:02:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpCq6-0004LZ-LS
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 02:02:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754507AbXKFBCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 20:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754738AbXKFBCc
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 20:02:32 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:50276 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069AbXKFBCb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 20:02:31 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id CE3742EF;
	Mon,  5 Nov 2007 20:02:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 514F192767;
	Mon,  5 Nov 2007 20:02:50 -0500 (EST)
In-Reply-To: <46a038f90711051553p6202cc62wfda6b45ff7769984@mail.gmail.com>
	(Martin Langhoff's message of "Tue, 6 Nov 2007 12:53:21 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63605>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> Strange behaviour of git grep on one of the projects I hack on...
>
>   $ git --version
>   git version 1.5.3.5.561.g140d
>
>   $ git grep LOB lib
>   fatal: insanely many options to grep
>
> After a bit of head-scratching I realised I was in the middle of a
> merge, with some unresolved paths in the lib directory. A bit of
> testing shows that the unresolved index is probably the problem:
>
>   $ git grep LOB lib
>   fatal: insanely many options to grep
>
>   # an unresolved file
>   $ git grep  LOB lib/accesslib.php
>   fatal: insanely many options to grep

I think 36f2587ffb6802cb38071510810f48cddfc4f34a (grep: do not
skip unmerged entries when grepping in the working tree.) is the
dud one.  Would this help?

diff --git a/builtin-grep.c b/builtin-grep.c
index c7b45c4..185876b 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -343,7 +343,7 @@ static int external_grep(struct grep_opt *opt, const char **paths, int cached)
 			memcpy(name + 2, ce->name, len + 1);
 		}
 		argv[argc++] = name;
-		if (argc < MAXARGS && !ce_stage(ce))
+		if (argc < MAXARGS)
 			continue;
 		status = flush_grep(opt, argc, nr, argv, &kept);
 		if (0 < status)
