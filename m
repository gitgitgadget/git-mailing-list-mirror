X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: fork0@t-online.de (Alex Riesen)
Subject: git-blame: handling of revisions and filenames
Date: Wed, 15 Nov 2006 22:52:25 +0100
Message-ID: <20061115215225.GA4595@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 21:52:52 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-ID: GoSYY0ZJoenBxUqMPl0U6Rf9oEv0u27E1XRoBWSgysDMiuzMPfOeUX
X-TOI-MSGID: d46a4bb8-79d8-4057-8823-240d290f2d42
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31508>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkSgY-0000kU-6R for gcvg-git@gmane.org; Wed, 15 Nov
 2006 22:52:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161771AbWKOVwn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 16:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161774AbWKOVwn
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 16:52:43 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:9189 "EHLO
 mailout05.sul.t-online.com") by vger.kernel.org with ESMTP id
 S1161771AbWKOVwm (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006
 16:52:42 -0500
Received: from fwd26.aul.t-online.de  by mailout05.sul.t-online.com with smtp
  id 1GkSgP-0006yk-03; Wed, 15 Nov 2006 22:52:37 +0100
Received: from tigra.home
 (GoSYY0ZJoenBxUqMPl0U6Rf9oEv0u27E1XRoBWSgysDMiuzMPfOeUX@[84.163.116.204]) by
 fwd26.sul.t-online.de with esmtp id 1GkSgF-1V8d3Q0; Wed, 15 Nov 2006 22:52:27
 +0100
Received: from steel.home (steel.home [192.168.1.2]) by tigra.home (Postfix)
 with ESMTP id 9F4B0277AF; Wed, 15 Nov 2006 22:52:26 +0100 (CET)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian)) id
 1GkSgD-0003rv-Ny; Wed, 15 Nov 2006 22:52:25 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

I noticed that there is no safe way to give a revision to git-blame:
it can always be interpreted as an existing file:
 - "git blame rev -- file.txt" can fail if "rev" is a file
 - "git blame rev^0 -- file.txt" can file there is a "rev^0" file
   (happens if you type too fast with a tool not designed for keyboard)
 - "git blame file.txt rev" is ambiguos too, for the same reasons.

I did the simple patch (below) to resolve at least the very first one,
just because that is how git-rev-list does it.
But if all forms of git-blame command line are expected to live, a
more serious surgery of the argv[] handling code needed.
And I afraid the patch has a small chance of crashing: I don't check
if there is enough space in argv (don't actually even know how to),
so Junio, please do not apply it (it passes blame tests, though).
I also suspect git-blame is not the only command using revision
machinery which has the same problem, so this message is more like a
discussion starter.

diff --git a/builtin-blame.c b/builtin-blame.c
index 066dee7..83c8905 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -1787,6 +1787,7 @@ int cmd_blame(int argc, const char **arg
        /* Now we got rev and path.  We do not want the path pruning
         * but we may want "bottom" processing.
         */
+       argv[unk++] = "--";
        argv[unk] = NULL;
 
        init_revisions(&revs, NULL);
