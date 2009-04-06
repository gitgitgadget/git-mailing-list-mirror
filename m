From: Jeff King <peff@peff.net>
Subject: Re: [question] how can i verify whether a local branch is tracking
	a remote branch?
Date: Mon, 6 Apr 2009 00:34:26 -0400
Message-ID: <20090406043426.GC12341@coredump.intra.peff.net>
References: <4d8e3fd30904050332w394cccbaq5b82d2a53ed357a3@mail.gmail.com> <20090405144413.GC2076@sigill.intra.peff.net> <4d8e3fd30904051425w6739a12fp5666e71e8b2d7958@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 06:36:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqgZG-0004hB-2w
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 06:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbZDFEer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 00:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbZDFEeq
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 00:34:46 -0400
Received: from peff.net ([208.65.91.99]:42748 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779AbZDFEeq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 00:34:46 -0400
Received: (qmail 20919 invoked by uid 107); 6 Apr 2009 04:35:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 06 Apr 2009 00:35:04 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Apr 2009 00:34:26 -0400
Content-Disposition: inline
In-Reply-To: <4d8e3fd30904051425w6739a12fp5666e71e8b2d7958@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115762>

On Sun, Apr 05, 2009 at 11:25:29PM +0200, Paolo Ciarrocchi wrote:

> An example:
> $ git clone -n URL temp
> $ cd temp
> $ git branch -r
>   origin/master
>   origin/foo
>   Origin/bar
> $ git checkout --track -b foo origin/foo
> 
> Now, how can I know that foo is tracking origin/foo ?

Doing it right is hard. You have to:

  1. check branch.foo.merge and branch.foo.rebase; if no value, it is not
     tracking anything; if it is, remember that value as $m

  2. check branch.foo.remote for the remote name, $r

  3. check the fetch refspecs for remote $r; these can come from
     the config, or from .git/remotes/* files. Maybe even .git/branches
     files; I don't even remember how those work.

  4. find the refspec that fetches from $m; then find the matching
     destination for that refspec. That is the tracking branch.

E.g., in your example (and using a modern git):

  1. $m is refs/heads/foo
  2. $r is origin
  3. The fetch refspec is in remote.origin.fetch, and is generally
     "refs/heads/*:refs/remotes/origin/*"
  4. So refs/heads/foo becomes refs/remotes/origin/foo.
     refs/remotes/origin/foo is your tracking branch.

Steps 1 and 2 are easy, but 3 and 4 are a bit nasty. You can fake it by
assuming that "refs/heads/$m" on "$r" is always "refs/remotes/$r/$m",
which is true for very vanilla setups.

There is C code that does this, but there is not a good way of accessing
it from the command-line. The best you can do is "git remote show
origin", which on recent git versions should show something like:

  ...
  Local branches configured for 'git pull':
    foo    merges with remote foo
  ...

But of course that implies that you already guessed the remote "origin".
And it's not using plumbing, so it's not very suitable for scripts.

I don't think it would be unreasonable to expose this functionality via
"for-each-ref". Something like this (which would need cleanup,
documentation, and perhaps a :short variant):

---
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 5cbb4b0..3f418e4 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -8,6 +8,7 @@
 #include "blob.h"
 #include "quote.h"
 #include "parse-options.h"
+#include "remote.h"
 
 /* Quoting styles */
 #define QUOTE_NONE 0
@@ -66,6 +67,7 @@ static struct {
 	{ "subject" },
 	{ "body" },
 	{ "contents" },
+	{ "tracking" },
 };
 
 /*
@@ -699,6 +701,18 @@ static void populate_value(struct refinfo *ref)
 				v->s = s;
 			}
 		}
+		if (!strcmp(name, "tracking")) {
+			struct branch *branch;
+			if (prefixcmp(ref->refname, "refs/heads/"))
+				continue;
+			branch = branch_get(ref->refname + 11);
+			if (branch && branch->merge && branch->merge[0] &&
+			    branch->merge[0]->dst)
+				v->s = branch->merge[0]->dst;
+			else
+				v->s = NULL;
+			free(branch); /* XXX should also free other parts? */
+		}
 	}
 
 	grab_values(ref->value, 0, obj, buf, size);





> 
> Thanks.
> 
> 
> Ciao,
> -- 
> Paolo
> http://paolo.ciarrocchi.googlepages.com/
> http://mypage.vodafone.it/
