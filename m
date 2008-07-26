From: Jeff King <peff@peff.net>
Subject: fetch refspec foo/* matches foo*
Date: Sat, 26 Jul 2008 04:24:05 -0400
Message-ID: <20080726082405.GA10104@sigill.intra.peff.net>
References: <1216854795-51155-1-git-send-email-lee.marlow@gmail.com> <1216858043-53646-1-git-send-email-lee.marlow@gmail.com> <20080725204051.GB23202@spearce.org> <7v1w1hsmnc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 10:25:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMf5T-0007NJ-5h
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 10:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbYGZIYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 04:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbYGZIYK
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 04:24:10 -0400
Received: from peff.net ([208.65.91.99]:3124 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750726AbYGZIYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 04:24:09 -0400
Received: (qmail 8396 invoked by uid 111); 26 Jul 2008 08:24:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 26 Jul 2008 04:24:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Jul 2008 04:24:05 -0400
Content-Disposition: inline
In-Reply-To: <7v1w1hsmnc.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90199>

On Fri, Jul 25, 2008 at 02:02:15PM -0700, Junio C Hamano wrote:

> BTW, has anybody taken a look at this one?
> 
>   Subject: BUG: fetch incorrect interpretation of globing patterns in refspecs
>   Date: Thu, 24 Jul 2008 09:07:21 +0200
>   Message-ID: <71295b5a0807240007k246973abj1897895d0d67bb6c@mail.gmail.com>
> 
> If not, I think I probably need to take a look at this, reproducing and
> possibly fixing, before applying non-fix patches.

I have been meaning to look at it for days, so I finally took a peek.  I
was able to reproduce the problem easily. I think it is (almost) as
simple as the patch below. In the refspec parsing, we already require
globs to come after '/', so this is the analagous check during match.

Unfortunately, this breaks t1020 (something about failing to clone HEAD
it looks like, so probably it is some boundary case for matching just
"*"). I don't have time to look further, and I will be out of touch
until probably Sunday evening, so hopefully somebody else can run with
it.

---
diff --git a/remote.c b/remote.c
index 0d6020b..3ae0431 100644
--- a/remote.c
+++ b/remote.c
@@ -1108,7 +1108,8 @@ static struct ref *get_expanded_map(const struct ref *remote_refs,
 	for (ref = remote_refs; ref; ref = ref->next) {
 		if (strchr(ref->name, '^'))
 			continue; /* a dereference item */
-		if (!prefixcmp(ref->name, refspec->src)) {
+		if (!prefixcmp(ref->name, refspec->src)
+		     && ref->name[remote_prefix_len] == '/') {
 			const char *match;
 			struct ref *cpy = copy_ref(ref);
 			match = ref->name + remote_prefix_len;
