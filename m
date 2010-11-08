From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] docs: give more hints about how "add -e" works
Date: Mon, 8 Nov 2010 17:33:23 -0500
Message-ID: <20101108223322.GA12258@sigill.intra.peff.net>
References: <20101021143034.GA16083@sigill.intra.peff.net>
 <7v4ocftbww.fsf@alter.siamese.dyndns.org>
 <20101022192529.GA13059@sigill.intra.peff.net>
 <7v8w1plwq0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 23:32:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFaGO-00072J-SB
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 23:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754921Ab0KHWc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 17:32:28 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:56129 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752583Ab0KHWc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 17:32:27 -0500
Received: (qmail 3085 invoked by uid 111); 8 Nov 2010 22:32:26 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 08 Nov 2010 22:32:26 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Nov 2010 17:33:23 -0500
Content-Disposition: inline
In-Reply-To: <7v8w1plwq0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160999>

[long quote, since it has been a few weeks]

On Fri, Oct 22, 2010 at 02:54:31PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Perhaps the list should be structured not as "what you can do to each
> > line" but rather "here are some _concepts_ you might see, here's how
> > they are represented, and how you might want to edit them". So
> > basically:
> >
> >   - added lines; represented by "+" lines. You can prevent staging any
> >     addition lines by deleting them.
> >
> >   - removed lines; represented by "-" lines. You can prevent staging any
> >     removal lines by converting "-" to " ".
> >
> >   - modified lines; represented by "-" followed by "+". You can prevent
> >     staging the modification by converting the "-" to a " ", and
> >     removing the "+" lines. And this would be a good place to warn that
> >     just deleting half of the pair is going to cause problems.
> >
> >   - existing lines; represented by " " lines. You can:
> >
> >       - remove them, by converting " " to "-".
> >
> >       - modify them, by converting " " to "-", and adding a new "+" line
> >         with the new content.
> >
> >   - adding new lines; do not yet exist in the patch. You can add new
> >     lines by inserting "+" lines with the new content.
> >
> > which is perhaps better, as it directs the user according to what they
> > actually want to accomplish.
> 
> Yes, the above reads much better than starting from "when you see a '+'
> you can do..." (which I think is a wrong approach that is backwards).
> 
> >> Is there a way to move this note way upwards?  Once the reader understands
> >> what this paragraph teaches, it becomes much easier to understand the
> >> implication of "remove addition".
> >
> > I agree it would be better at the top, but I think formatting it as I
> > just wrote above would mean we can actually explain the issue in a more
> > appropriate place. And then this bottom warning can just go away.
> 
> Agreed, again.

I found a few minutes to look at this today. However, it looks like you
already merged my original to next. :) The patch below implements the
strategy I discussed above, and IMHO it ended up being much clearer.

It should replace what's in next. You can either start a new branch and
revert what's in next, or I can prepare it on top of what's in next if
you prefer.

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
 Documentation/git-add.txt |   63 ++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 73378b2..5048309 100644
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
@@ -295,6 +297,61 @@ diff::
   This lets you review what will be committed (i.e. between
   HEAD and index).
 
+
+EDITING PATCHES
+---------------
+
+Invoking `git add -e` or selecting `e` from the interactive hunk
+selector will open a patch in your editor; after the editor exits, the
+result is applied to the index. You are free to make arbitrary changes
+to the patch, but note that only a small subset of possible changes will
+result in a patch that can be applied. If you want to abort the
+operation entirely (i.e., stage nothing new in the index), simply delete
+all lines of the patch. The list below describes common things you may
+see in a patch, and which editing operations make sense on them.
+
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
+
+untouched content::
+
+Untouched content exists in context lines, beginning with a " " (space).
+You can stage context lines for removal by converting the space to a
+"-".
+
+new content::
+
+You may also add new content that does not exist in the patch. Simply
+add new lines, each starting with "{plus}".
+
+You can also perform more complex operations, such as modifying the
+content to be staged by a "{plus}" line. However, note that this impacts
+_only_ the index; the working tree file will remain unchanged, and will
+appear to "undo" the content you have staged. Such operations should be
+performed only if you know what you are doing.
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
1.7.3.2.218.g4ee9d
