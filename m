From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-am failed, what's next ?
Date: Thu, 22 Feb 2007 20:11:21 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702222009380.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <38b2ab8a0702220022wab25519hbb57629934e7f104@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 22 20:11:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKJLj-0003W6-DA
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 20:11:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbXBVTLX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 14:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbXBVTLX
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 14:11:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:43122 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751772AbXBVTLW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 14:11:22 -0500
Received: (qmail invoked by alias); 22 Feb 2007 19:11:21 -0000
X-Provags-ID: V01U2FsdGVkX19X5RkeTI9XMd5GY8yKm05GmfF/Apm3zX0wg72SRV
	0QfA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <38b2ab8a0702220022wab25519hbb57629934e7f104@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40369>

Hi,

On Thu, 22 Feb 2007, Francis Moreau wrote:

> I'm a bit clueless when git-am failed to apply a patch. I dunno what I
> should do at this point since errors reported by git-am are not
> usefull for me. For example I got:
> 
> ----
> error: patch failed: foo:1
> error: foo: patch does not apply

I had that quite often. I then ran

	git apply --verbose < .dotest/patch

to find out why it fails, but alas it did not tell me more. That's why I 
wrote this patch:

-- snipsnap --
[PATCH] apply: make --verbose a little more useful

When a patch fails, I automatically add '-v' to the command line
to see what fails.

This patch makes -v a synonym to --verbose, and actually tells
the user which text was not found.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 builtin-apply.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 630d8fd..2dde341 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1723,6 +1723,8 @@ static int apply_one_fragment(struct buffer_desc *desc, struct fragment *frag, i
 			/* Ignore it, we already handled it */
 			break;
 		default:
+			if (apply_verbosely)
+				error("invalid start of line: '%c'", first);
 			return -1;
 		}
 		patch += len;
@@ -1820,6 +1822,9 @@ static int apply_one_fragment(struct buffer_desc *desc, struct fragment *frag, i
 		}
 	}
 
+	if (offset && apply_verbosely)
+		error("while searching for:\n%.*s", oldsize, oldlines);
+
 	free(old);
 	free(new);
 	return offset;
@@ -2811,7 +2816,7 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 			apply = apply_with_reject = apply_verbosely = 1;
 			continue;
 		}
-		if (!strcmp(arg, "--verbose")) {
+		if (!strcmp(arg, "-v") || !strcmp(arg, "--verbose")) {
 			apply_verbosely = 1;
 			continue;
 		}
-- 
1.5.0.51.ge5582-dirty
