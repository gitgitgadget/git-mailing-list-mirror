From: Jeff King <peff@peff.net>
Subject: Re: Regression: git-commit no longer works from within subdirectories
Date: Thu, 3 Aug 2006 16:29:57 -0400
Message-ID: <20060803202957.GA26838@coredump.intra.peff.net>
References: <44D23B1C.80704@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Shearman <rob@codeweavers.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 03 22:30:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8jpa-0003yQ-Rv
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 22:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWHCUaB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 16:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWHCUaB
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 16:30:01 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:23490 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751202AbWHCUaA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Aug 2006 16:30:00 -0400
Received: (qmail 7464 invoked from network); 3 Aug 2006 16:29:23 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 3 Aug 2006 16:29:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu,  3 Aug 2006 16:29:57 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <44D23B1C.80704@codeweavers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24754>

On Thu, Aug 03, 2006 at 07:06:20PM +0100, Robert Shearman wrote:

> It fails with a confusing message when you are in a subdirectory:
> rob@saturn:~/wine-git/dlls/msi$ git commit action.c
> usage: git-read-tree (<sha> | [[-m [--aggressive] | --reset | 
> --prefix=<prefix>] [-u | -i]] <sha1> [<sha2> [<sha3>]])

The culprit is the recent changes to the builtins. cmd_read_tree now
takes an extra parameter 'prefix' which shadows the global declaration
in builtin-read-tree.c (and has a completely different meaning).

The one-liner below fixes it (though style-wise, you may prefer to rename the
shadowed variable).

-Peff

---
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 49c10bf..8e3b04e 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -870,7 +870,7 @@ static const char read_tree_usage[] = "g
 
 static struct lock_file lock_file;
 
-int cmd_read_tree(int argc, const char **argv, const char *prefix)
+int cmd_read_tree(int argc, const char **argv, const char *git_prefix)
 {
        int i, newfd, stage = 0;
        unsigned char sha1[20];
