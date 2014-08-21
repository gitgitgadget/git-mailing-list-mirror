From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] teach fast-export an --anonymize option
Date: Thu, 21 Aug 2014 18:49:10 -0400
Message-ID: <20140821224910.GB21105@peff.net>
References: <20140821070130.GA15930@peff.net>
 <xmqqiollqzel.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 00:49:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKbAS-0003Be-R3
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 00:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754935AbaHUWtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 18:49:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:56431 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754792AbaHUWtM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 18:49:12 -0400
Received: (qmail 17210 invoked by uid 102); 21 Aug 2014 22:49:12 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Aug 2014 17:49:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Aug 2014 18:49:10 -0400
Content-Disposition: inline
In-Reply-To: <xmqqiollqzel.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255645>

On Thu, Aug 21, 2014 at 02:57:22PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +--anonymize::
> > +	Replace all paths, blob contents, commit and tag messages,
> > +	names, and email addresses in the output with anonymized data,
> > +	while still retaining the shape of history and of the stored
> > +	tree.
> 
> Sometimes branch names can contain codenames the project may prefer
> to hide from the general public, so they may need to be anonymised
> as well.

Yes, I do anonymize them (and check it in the tests). See
anonymize_refname. I just forgot to include it in the list. Trivial
squashable patch is below.

The few things I don't anonymize are:

  1. ref prefixes. We see the same distribution of refs/heads vs
     refs/tags, etc.

  2. refs/heads/master is left untouched, for convenience (and because
     it's not really a secret). The implementation is lazy, though, and
     would leave "refs/heads/master-supersecret", as well. I can tighten
     that if we really want to be careful.

  3. gitlinks are left untouched, since sha1s cannot be reversed. This
     could leak some information (if your private repo points to a
     public, I can find out you have it as submodule). I doubt it
     matters, but we can also scramble the sha1s.

---
diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 0ec7cad..52831fa 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -106,10 +106,10 @@ marks the same across runs.
 	different from the commit's first parent).
 
 --anonymize::
-	Replace all paths, blob contents, commit and tag messages,
-	names, and email addresses in the output with anonymized data,
-	while still retaining the shape of history and of the stored
-	tree.
+	Replace all refnames, paths, blob contents, commit and tag
+	messages, names, and email addresses in the output with
+	anonymized data, while still retaining the shape of history and
+	of the stored tree.
 
 --refspec::
 	Apply the specified refspec to each ref exported. Multiple of them can
