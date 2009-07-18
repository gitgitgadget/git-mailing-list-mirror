From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] Re: cosmetic improvements for "git show tag"
Date: Sat, 18 Jul 2009 06:14:37 -0400
Message-ID: <20090718101436.GA22535@coredump.intra.peff.net>
References: <20090717231622.GA13511@coredump.intra.peff.net>
 <20090718011006.GB12968@vidovic>
 <20090718014743.GA16381@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Sat Jul 18 12:14:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MS6wT-0004ml-UN
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 12:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757999AbZGRKOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2009 06:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757991AbZGRKOu
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jul 2009 06:14:50 -0400
Received: from peff.net ([208.65.91.99]:43167 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757985AbZGRKOt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2009 06:14:49 -0400
Received: (qmail 31590 invoked by uid 107); 18 Jul 2009 10:16:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 18 Jul 2009 06:16:43 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 18 Jul 2009 06:14:37 -0400
Content-Disposition: inline
In-Reply-To: <20090718014743.GA16381@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123513>

On Fri, Jul 17, 2009 at 09:47:43PM -0400, Jeff King wrote:

> So when you show two tags you get:
> 
>   tag foo
> 
>   message
> 
>   commit foo^{}
> 
>   message
>   tag bar
> 
> 
>   commit bar^{}
> 
> That is, the newline is actually stuck in the wrong place. So we
> actually need to turn that newline off, which I'm not sure is possible.
> I'll look into it more.

The code calls into log_tree_commit, which uses the "shown_one" member
of rev_info to determine. So we should be able to just use that for our
tags, and everything will work fine.

I think we can replace 2/2 with the patch below, which also covers the
tree case neatly.

-- >8 --
Subject: [PATCH] show: add space between multiple items

When showing an annotated tag, "git show" will always
display the pointed-to object. However, it didn't separate
the two with whitespace, making it more difficult to notice
where the new object started. For example:

  $ git tag -m 'my message' foo
  $ git show foo
  tag foo
  Tagger: Jeff King <peff@peff.net>
  Date:   Fri Jul 17 18:46:25 2009 -0400

  my message
  commit 41cabf8fed2694ba33e01d64f9094f2fc5e5805a
  Author: Jeff King <peff@peff.net>
  Date:   Thu Jul 16 17:31:34 2009 -0400
  ...

This patch respects and sets the rev.shown_one member to
prepend a blank line before showing a second item. We use
this member of rev_info instead of a local flag, because the
log_tree_commit we call into for showing commits already
respects and sets that flag. Meaning that everything will be
spaced properly if you intermix commits and tags, like:

  $ git show v1.6.3 v1.6.2 HEAD

In that case, a single blank line will separate the first
tag, the commit it points to, the second tag, the commit
that one points to, and the final commit.

While we're at it, let's also support trees, so that even
something as crazy as

  $ git show HEAD^{tree} HEAD~1^{tree} HEAD

will also be spaced in an easy-to-read way. However, we
intentionally do _not_ insert blank lines for blobs, so
that specifying multiple blobs gives a strict concatenation.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-log.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index b05796d..3035816 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -329,11 +329,14 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 		case OBJ_TAG: {
 			struct tag *t = (struct tag *)o;
 
+			if (rev.shown_one)
+				putchar('\n');
 			printf("%stag %s%s\n",
 					diff_get_color_opt(&rev.diffopt, DIFF_COMMIT),
 					t->tag,
 					diff_get_color_opt(&rev.diffopt, DIFF_RESET));
 			ret = show_object(o->sha1, 1, &rev);
+			rev.shown_one = 1;
 			if (ret)
 				break;
 			o = parse_object(t->tagged->sha1);
@@ -345,12 +348,15 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 			break;
 		}
 		case OBJ_TREE:
+			if (rev.shown_one)
+				putchar('\n');
 			printf("%stree %s%s\n\n",
 					diff_get_color_opt(&rev.diffopt, DIFF_COMMIT),
 					name,
 					diff_get_color_opt(&rev.diffopt, DIFF_RESET));
 			read_tree_recursive((struct tree *)o, "", 0, 0, NULL,
 					show_tree_object, NULL);
+			rev.shown_one = 1;
 			break;
 		case OBJ_COMMIT:
 			rev.pending.nr = rev.pending.alloc = 0;
-- 
1.6.4.rc1.177.g80fb1.dirty
