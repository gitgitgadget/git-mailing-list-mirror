From: Jeff King <peff@peff.net>
Subject: Re: git log doesn't allow %x00 in custom format anymore?
Date: Thu, 7 Oct 2010 13:29:39 -0400
Message-ID: <20101007172939.GA12130@sigill.intra.peff.net>
References: <D9157D2F-31D5-44EF-8FB4-F0E62BBF8017@jetbrains.com>
 <20101007141015.GB8162@sigill.intra.peff.net>
 <5BA0D807-C5C0-4797-82CD-5D5087496D6F@jetbrains.com>
 <4CADE232.8030801@viscovery.net>
 <FF2FF369-0B1C-457E-A86E-8651BF0A82CB@jetbrains.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 19:29:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3uHf-0003Fr-RS
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 19:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949Ab0JGR32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 13:29:28 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:40554 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750760Ab0JGR31 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 13:29:27 -0400
Received: (qmail 19088 invoked by uid 111); 7 Oct 2010 17:29:26 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (129.79.255.184)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 07 Oct 2010 17:29:26 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Oct 2010 13:29:39 -0400
Content-Disposition: inline
In-Reply-To: <FF2FF369-0B1C-457E-A86E-8651BF0A82CB@jetbrains.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158410>

On Thu, Oct 07, 2010 at 07:18:18PM +0400, Kirill Likhodedov wrote:

> Thanks for pointing that out.
> I confirm that on Mac OS X that happens for rev-list as well. 
> 
> # git log --pretty=format:foo%x00bar HEAD -1 | od -c
> 0000000   f   o   o  \0   b   a   r
> 0000007
> 
> # git rev-list --pretty=format:foo%x00bar HEAD -1 | od -c
> 0000000   c   o   m   m   i   t       2   3   6   0   1   a   2   c   3
> 0000020   e   4   6   4   a   4   4   7   9   f   1   7   7   4   e   3
> 0000040   6   e   a   5   b   9   5   8   b   4   6   0   5   2   1  \n
> 0000060   f   o   o  \n
> 0000064

Ugh. Even worse, it does print with --graph, which uses a slightly
different code path.

  $ git rev-list --graph -1 --format=foo%x00bar HEAD | cat -A
  *   commit 81d866a6a213d5524ce389369377ba3529461e1b$
  |\  foo^@bar$

I am inclined to call the rev-list behavior a bug, and the fix is
probably:

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index efe9360..3b2dca0 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -147,8 +147,10 @@ static void show_commit(struct commit *commit, void *data)
 			}
 		} else {
 			if (revs->commit_format != CMIT_FMT_USERFORMAT ||
-			    buf.len)
-				printf("%s%c", buf.buf, info->hdr_termination);
+			    buf.len) {
+				fwrite(buf.buf, 1, buf.len, stdout);
+				putchar(info->hdr_termination);
+			}
 		}
 		strbuf_release(&buf);
 	} else {
