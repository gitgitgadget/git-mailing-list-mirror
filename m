From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* [PATCH] "not uptodate" changed to "has local changes"
Date: Wed, 21 May 2008 00:07:29 -0700
Message-ID: <7v4p8s6spa.fsf@gitster.siamese.dyndns.org>
References: <1209833972-12256-1-git-send-email-timcharper@gmail.com>
 <e2b179460805060631l506e2a6leaafc9c0acf3b05b@mail.gmail.com>
 <b8bf37780805151914j65ce5406xc5e6b3d29e3bfb9b@mail.gmail.com>
 <alpine.DEB.1.00.0805161125320.30431@racer>
 <1ED37CF1-EABD-4881-BA29-ED2CB1CE73FC@sb.org>
 <b8bf37780805162030m4c961505nabd72e8f5bd08404@mail.gmail.com>
 <alpine.DEB.1.00.0805171102480.30431@racer>
 <e06498070805170744l7ad213aeqb779b0c0381e1de4@mail.gmail.com>
 <bd6139dc0805170912w14b7894fxfebe15c14e4c44ef@mail.gmail.com>
 <7v63tcda7e.fsf_-_@gitster.siamese.dyndns.org>
 <D925ECD3-1EE2-48EB-B1E5-2604C10AD643@wincent.com>
 <7vzlqm89tj.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0805191523060.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>, sverre@rabbelier.nl,
	Steven Walter <stevenrwalter@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?Q?Andr=C3=A9?= Goddard Rosa <andre.goddard@gmail.com>,
	Kevin Ballard <kevin@sb.org>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed May 21 09:08:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyiRI-0008OV-Cc
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 09:08:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755188AbYEUHHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 03:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754820AbYEUHHr
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 03:07:47 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37993 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146AbYEUHHq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 03:07:46 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A3204D80F;
	Wed, 21 May 2008 03:07:45 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 7CB1BD808; Wed, 21 May 2008 03:07:32 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9CE48F80-2704-11DD-B306-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82531>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Mon, 19 May 2008, Junio C Hamano wrote:
>
>> Why does *everybody* keep missing the whole point of this patch?
>
> That section needs a comment stating that it's the scripting API, not just 
> an arbitrary set of messages.

Yeah, that is a very good explanation.  Thanks for a constructive
suggestion for improvements.

Here is an incremental on top of the one I sent out, in case people want
to improve on it.

 unpack-trees.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index da3bdc8..0de5a31 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -8,7 +8,15 @@
 #include "progress.h"
 #include "refs.h"
 
-static struct unpack_trees_error_msgs unpack_default_errors = {
+/*
+ * Error messages expected by scripts out of plumbing commands such as
+ * read-tree.  Non-scripted Porcelain is not required to use these messages
+ * and in fact are encouraged to reword them to better suit their particular
+ * situation better.  See how "git checkout" replaces not_uptodate_file to
+ * explain why it does not allow switching between branches when you have
+ * local changes, for example.
+ */
+static struct unpack_trees_error_msgs unpack_plumbing_errors = {
 	/* would_overwrite */
 	"Entry '%s' would be overwritten by merge. Cannot merge.",
 
@@ -28,7 +36,7 @@ static struct unpack_trees_error_msgs unpack_default_errors = {
 #define ERRORMSG(o,fld) \
 	( ((o) && (o)->msgs.fld) \
 	? ((o)->msgs.fld) \
-	: (unpack_default_errors.fld) )
+	: (unpack_plumbing_errors.fld) )
 
 static void add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
 	unsigned int set, unsigned int clear)
