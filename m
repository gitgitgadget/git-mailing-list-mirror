From: Jeff King <peff@peff.net>
Subject: Re: git merge remote branch says "Merge commit ..."?
Date: Fri, 22 May 2009 03:49:27 -0400
Message-ID: <20090522074927.GB1409@coredump.intra.peff.net>
References: <2729632a0905211250v4e7537caybe9e703c14361b5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Fri May 22 09:49:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7PVX-0004hs-Sg
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 09:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbZEVHt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 03:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbZEVHt2
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 03:49:28 -0400
Received: from peff.net ([208.65.91.99]:54505 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751250AbZEVHt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 03:49:27 -0400
Received: (qmail 17019 invoked by uid 107); 22 May 2009 07:49:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 22 May 2009 03:49:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 22 May 2009 03:49:27 -0400
Content-Disposition: inline
In-Reply-To: <2729632a0905211250v4e7537caybe9e703c14361b5f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119717>

On Thu, May 21, 2009 at 12:50:48PM -0700, skillzero@gmail.com wrote:

> I noticed that if I do 'git merge origin/branch' that the log message
> says (using --log):
> 
> Merge commit 'origin/branch'
> 
>    * commit 'origin/branch':
>      Fixed some bug.
> 
> If I do the same thing from a local tracking branch of origin/branch, it says:
> 
> Merge branch 'branch'
> 
>    * branch:
>      Fixed some bug.
> 
> Is it expected that it say "commit" instead of "branch" when the
> branch is not a local tracking branch? I sometimes merge from remote
> branches when I don't need to do anything with that branch locally
> (e.g. I already did the work on another computer and I'm just merging
> the result into my test machine before I push to the shared server).

I think doing a "git merge origin/master" is perfectly normal for some
workflows. For example:

  $ git fetch origin ;# grab it
  $ gitk origin/master...master ;# check if it is good to merge
  $ git merge origin/master ;# and merge it

The final step _could_ be a pull, but there is no point in repeating the
fetch (which might be costly).

There is already code in fmt-merge-msg to handle remote branches; it
looks like we just need to signal that code the same way "git fetch"
would. Maybe something like the patch below (which is really just a
cut-and-paste of the code directly above it to special-case real
branches).

It gives a sensible "Merge" line but you end up with

  * remote branch 'origin/master':
    ...

instead of

  * origin/master:
    ...

So it probably requires some deeper digging into what git-fetch is
doing, and to emulate that (I am pretty ignorant of this part of the
code).

---
diff --git a/builtin-merge.c b/builtin-merge.c
index 0b58e5e..a74a4d0 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -378,6 +378,17 @@ static void merge_name(const char *remote, struct strbuf *msg)
 		goto cleanup;
 	}
 
+	strbuf_setlen(&buf, 0);
+	strbuf_addstr(&buf, "refs/remotes/");
+	strbuf_addstr(&buf, remote);
+	resolve_ref(buf.buf, branch_head, 0, 0);
+
+	if (!hashcmp(remote_head->sha1, branch_head)) {
+		strbuf_addf(msg, "%s\t\tremote branch '%s'\n",
+				sha1_to_hex(branch_head), remote);
+		goto cleanup;
+	}
+
 	/* See if remote matches <name>^^^.. or <name>~<number> */
 	for (len = 0, ptr = remote + strlen(remote);
 	     remote < ptr && ptr[-1] == '^';
