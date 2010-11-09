From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] docs: give more hints about how "add -e" works
Date: Mon, 8 Nov 2010 23:58:20 -0500
Message-ID: <20101109045820.GA19728@sigill.intra.peff.net>
References: <20101021143034.GA16083@sigill.intra.peff.net>
 <7v4ocftbww.fsf@alter.siamese.dyndns.org>
 <20101022192529.GA13059@sigill.intra.peff.net>
 <7v8w1plwq0.fsf@alter.siamese.dyndns.org>
 <20101108223322.GA12258@sigill.intra.peff.net>
 <7vlj53nwjl.fsf@alter.siamese.dyndns.org>
 <20101109030358.GA17747@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 09 05:57:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFgHB-0002mx-2R
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 05:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753518Ab0KIE53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 23:57:29 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:58205 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753387Ab0KIE51 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 23:57:27 -0500
Received: (qmail 4404 invoked by uid 111); 9 Nov 2010 04:57:25 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 09 Nov 2010 04:57:25 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Nov 2010 23:58:20 -0500
Content-Disposition: inline
In-Reply-To: <20101109030358.GA17747@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161015>

On Mon, Nov 08, 2010 at 10:03:58PM -0500, Jeff King wrote:

> > This "However, note that" part should apply not only to newly introduced
> > {plus} lines but also to {plus} lines whose change were edited (lines from
> > "added content" and from post-image half of "modified content"), no?
> 
> Right. The final paragraph you quoted is not part of the list, and it
> looks better when rendered by asciidoc, as it's indented differently. So
> I think some of the confusion is from the source formatting. But...

In the version below I used asciidoc's "--" block separator. It makes no
difference to the formatted output, but hopefully makes the source a
little more obvious.

> Yeah, some of the operations described in the upper list are actually
> "more complex" in the sense of looking like reverts. Basically any time
> you are _introducing_ a change during the diff edit rather than simply
> selecting or not-selecting changes that exist in the working tree, you
> are going to get confusing results. So let me take one more stab at it,
> and I think the correct breakdown is:

Patch is below. Thanks for bearing with me through all the versions; it
turned out to be harder to explain than I thought. :) I think the back
and forth has led us to a much more natural organization of the
information.

-- >8 --
Subject: [PATCH] docs: give more hints about how "add -e" works

The previous text was not exactly accurate; it is OK to
change space and minus lines, but only in certain ways.

This patch takes a whole new approach, which is to describe
the sorts of conceptual operations you might want to
perform. It also includes a healthy dose of warnings about
how things can go wrong.

Since the size of the text is getting quite long, it also
splits this out into an "editing patches" section. This
makes more sense with the current structure, anyway, which
already splits out the interactive mode description.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-add.txt |   80 +++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 73378b2..54aaaeb 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -92,9 +92,11 @@ See ``Interactive mode'' for details.
 	edit it.  After the editor was closed, adjust the hunk headers
 	and apply the patch to the index.
 +
-*NOTE*: Obviously, if you change anything else than the first character
-on lines beginning with a space or a minus, the patch will no longer
-apply.
+The intent of this option is to pick and choose lines of the patch to
+apply, or even to modify the contents of lines to be staged. This can be
+quicker and more flexible than using the interactive hunk selector.
+However, it is easy to confuse oneself and create a patch that does not
+apply to the index. See EDITING PATCHES below.
 
 -u::
 --update::
@@ -295,6 +297,78 @@ diff::
   This lets you review what will be committed (i.e. between
   HEAD and index).
 
+
+EDITING PATCHES
+---------------
+
+Invoking `git add -e` or selecting `e` from the interactive hunk
+selector will open a patch in your editor; after the editor exits, the
+result is applied to the index. You are free to make arbitrary changes
+to the patch, but note that some changes may have confusing results, or
+even result in a patch that cannot be applied.  If you want to abort the
+operation entirely (i.e., stage nothing new in the index), simply delete
+all lines of the patch. The list below describes some common things you
+may see in a patch, and which editing operations make sense on them.
+
+--
+added content::
+
+Added content is represented by lines beginning with "{plus}". You can
+prevent staging any addition lines by deleting them.
+
+removed content::
+
+Removed content is represented by lines beginning with "-". You can
+prevent staging their removal by converting the "-" to a " " (space).
+
+modified content::
+
+Modified content is represented by "-" lines (removing the old content)
+followed by "{plus}" lines (adding the replacement content). You can
+prevent staging the modification by converting "-" lines to " ", and
+removing "{plus}" lines. Beware that modifying only half of the pair is
+likely to introduce confusing changes to the index.
+--
+
+There are also more complex operations that can be performed. But beware
+that because the patch is applied only to the index and not the working
+tree, the working tree will appear to "undo" the change in the index.
+For example, introducing a a new line into the index that is in neither
+the HEAD nor the working tree will stage the new line for commit, but
+the line will appear to be reverted in the working tree.
+
+Avoid using these constructs, or do so with extreme caution.
+
+--
+removing untouched content::
+
+Content which does not differ between the index and working tree may be
+shown on context lines, beginning with a " " (space).  You can stage
+context lines for removal by converting the space to a "-". The
+resulting working tree file will appear to re-add the content.
+
+modifying existing content::
+
+One can also modify context lines by staging them for removal (by
+converting " " to "-") and adding a "{plus}" line with the new content.
+Similarly, one can modify "{plus}" lines for existing additions or
+modifications. In all cases, the new modification will appear reverted
+in the working tree.
+
+new content::
+
+You may also add new content that does not exist in the patch; simply
+add new lines, each starting with "{plus}". The addition will appear
+reverted in the working tree.
+--
+
+There are also several operations which should be avoided entirely, as
+they will make the patch impossible to apply:
+
+* adding context (" ") or removal ("-") lines
+* deleting context or removal lines
+* modifying the contents of context or removal lines
+
 SEE ALSO
 --------
 linkgit:git-status[1]
-- 
1.7.3.2.357.g419a4
