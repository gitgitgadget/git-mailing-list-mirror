From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] common_prefix: be more careful about pathspec bounds
Date: Tue, 15 Jun 2010 10:16:16 +0200
Message-ID: <201006151016.16492.trast@student.ethz.ch>
References: <825550ec93610c2d3c7dae7550729d96fc6cebbc.1276194169.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 15 10:17:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OORLC-0006oK-PJ
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 10:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755947Ab0FOIQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 04:16:41 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:20271 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753792Ab0FOIQk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 04:16:40 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Tue, 15 Jun
 2010 10:16:39 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Tue, 15 Jun
 2010 10:16:16 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.3; x86_64; ; )
In-Reply-To: <825550ec93610c2d3c7dae7550729d96fc6cebbc.1276194169.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149165>

Thomas Rast wrote:
> Normally this won't be a problem, which is probably why nobody has
> noticed that this was broken since 2006.

Actually I just noticed it's not from back in 2006 when Linus wrote
this code, but from the following:

commit c7f34c180b7117cf60ad12a8b180eed33716e390
Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Date:   Mon Apr 23 10:21:25 2007 +0200

    dir.c(common_prefix): Fix two bugs
    
    The function common_prefix() is used to find the common subdirectory of
    a couple of pathnames. When checking if the next pathname matches up with
    the prefix, it incorrectly checked the whole path, not just the prefix
    (including the slash). Thus, the expensive part of the loop was executed
    always.
    
    The other bug is more serious: if the first and the last pathname in the
    list have a longer common prefix than the common prefix for _all_ pathnames
    in the list, the longer one would be chosen. This bug was probably hidden
    by the fact that bash's wildcard expansion sorts the results, and the code
    just so happens to work with sorted input.
[...]
--- a/dir.c
+++ b/dir.c
@@ -24,8 +24,9 @@ int common_prefix(const char **pathspec)
        prefix = slash - path + 1;
        while ((next = *++pathspec) != NULL) {
                int len = strlen(next);
-               if (len >= prefix && !memcmp(path, next, len))
+               if (len >= prefix && !memcmp(path, next, prefix))
                        continue;
+               len = prefix - 1;
                for (;;) {
                        if (!len)
                                return 0;

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
