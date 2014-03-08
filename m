From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] builtin/mv: fix out of bounds write
Date: Sat, 8 Mar 2014 18:35:01 +0000
Message-ID: <20140308183501.GH18371@serenity.lan>
References: <CAPn4x+oTTzYMSFzqUmJ8tOO0DdqR+HJJdoeXFZxhABu6B=QmBQ@mail.gmail.com>
 <20140308164651.GA32213@vauxhall.crustytoothpaste.net>
 <20140308181218.GG18371@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Guillaume Gelin <contact@ramnes.eu>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 08 19:35:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMM66-0001F0-51
	for gcvg-git-2@plane.gmane.org; Sat, 08 Mar 2014 19:35:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbaCHSfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2014 13:35:13 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:42810 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086AbaCHSfM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2014 13:35:12 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id A5BEB22D87;
	Sat,  8 Mar 2014 18:35:11 +0000 (GMT)
X-Quarantine-ID: <OWq7VHtyZuJm>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OWq7VHtyZuJm; Sat,  8 Mar 2014 18:35:11 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id B8DB422BC6;
	Sat,  8 Mar 2014 18:35:03 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20140308181218.GG18371@serenity.lan>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243679>

When commit a88c915 (mv: move submodules using a gitfile, 2013-07-30)
added the submodule_gitfile array, it was not added to the block that
enlarges the arrays when we are moving a directory so that we do not
have to worry about it being a directory when we perform the actual
move.  After this, the loop continues over the enlarged set of sources.

Since we assume that submodule_gitfile has size argc, if any of the
items in the source directory are submodules we are guaranteed to write
beyond the end of submodule_gitfile.

Fix this by realloc'ing submodule_gitfile at the same time as the other
arrays.

Reported-by: Guillaume Gelin <contact@ramnes.eu>
Signed-off-by: John Keeping <john@keeping.me.uk>
---
On Sat, Mar 08, 2014 at 06:12:18PM +0000, John Keeping wrote:
> This fixes it for me:

Here it is as a proper patch.

 builtin/mv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/mv.c b/builtin/mv.c
index 21c46d1..f99c91e 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -179,6 +179,9 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 						modes = xrealloc(modes,
 								(argc + last - first)
 								* sizeof(enum update_mode));
+						submodule_gitfile = xrealloc(submodule_gitfile,
+								(argc + last - first)
+								* sizeof(char *));
 					}
 
 					dst = add_slash(dst);
-- 
1.9.0.6.g037df60.dirty
