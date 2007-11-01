From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] Add --first-parent support to interactive rebase.
Date: Wed, 31 Oct 2007 23:23:03 -0400
Message-ID: <20071101032303.GA14495@coredump.intra.peff.net>
References: <1193797309-1161-1-git-send-email-B.Steinbrink@gmx.de> <7vodefj2lk.fsf@gitster.siamese.dyndns.org> <20071031055303.GB3326@atjola.homenet> <20071031134358.GD15182@dpotapov.dyndns.org> <20071031140028.GA30207@diana.vm.bytemark.co.uk> <20071031143641.GF15182@dpotapov.dyndns.org> <20071031180557.GA12211@coredump.intra.peff.net> <7v8x5jgdck.fsf@gitster.siamese.dyndns.org> <20071031215625.GC14211@coredump.intra.peff.net> <7vzlxygblz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 04:23:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InQeQ-0007uN-O2
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 04:23:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043AbXKADXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 23:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753074AbXKADXH
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 23:23:07 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3414 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753009AbXKADXG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 23:23:06 -0400
Received: (qmail 2646 invoked by uid 111); 1 Nov 2007 03:23:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 31 Oct 2007 23:23:05 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Oct 2007 23:23:03 -0400
Content-Disposition: inline
In-Reply-To: <7vzlxygblz.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62909>

On Wed, Oct 31, 2007 at 03:31:20PM -0700, Junio C Hamano wrote:

> > ... I had one concern that
> > I was tracking down: is the author name encoding necessarily the same as
> > the commit text encoding?
> 
> The user is screwing himself already if that is the case and
> uses -s to format-patch, isn't he?

Hrm, they probably _should_ be the same in the output. It's not clear to
me what encoding we assume the name comes in (utf-8, I guess). Looks
like we don't touch it at all when putting it in the signoff. I think we
should just be able to reencode when appending the signoff; patch is
below.

I'm sure there are other weird interactions lurking. For example, do we
correctly detect an existing signoff if we are storing in a non-utf8
encoding? I must admit to being a little ignorant to some of the
encoding magic of git, having a us-ascii name myself.

---

diff --git a/log-tree.c b/log-tree.c
index 3763ce9..906942d 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -3,6 +3,7 @@
 #include "commit.h"
 #include "log-tree.h"
 #include "reflog-walk.h"
+#include "utf8.h"
 
 struct decoration name_decoration = { "object names" };
 
@@ -111,7 +112,14 @@ static void append_signoff(struct strbuf *sb, const char *signoff)
 		strbuf_addch(sb, '\n');
 
 	strbuf_addstr(sb, signed_off_by);
-	strbuf_add(sb, signoff, signoff_len);
+	if (git_log_output_encoding) {
+		char *encoded_name = reencode_string(signoff,
+				git_log_output_encoding, "utf-8");
+		strbuf_addstr(sb, encoded_name);
+		free(encoded_name);
+	}
+	else
+		strbuf_add(sb, signoff, signoff_len);
 	strbuf_addch(sb, '\n');
 }
 
