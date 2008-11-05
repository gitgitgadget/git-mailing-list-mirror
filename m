From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] push: fix local refs update if already up-to-date
Date: Wed, 5 Nov 2008 22:57:06 +0100
Message-ID: <20081105215706.GA32063@localhost>
References: <20081104000745.GA28480@localhost> <20081104042643.GA31276@coredump.intra.peff.net> <20081104085630.GA22530@localhost> <20081105024932.GA20907@coredump.intra.peff.net> <20081105202849.GA9484@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 05 22:58:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxqOC-0004ka-Du
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 22:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753438AbYKEV4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 16:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753334AbYKEV4y
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 16:56:54 -0500
Received: from postman.fh-hagenberg.at ([193.170.124.96]:54747 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753264AbYKEV4y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 16:56:54 -0500
Received: from darc.dyndns.org ([84.154.100.25]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 5 Nov 2008 22:56:51 +0100
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1KxqN8-0000cO-IR; Wed, 05 Nov 2008 22:57:06 +0100
Content-Disposition: inline
In-Reply-To: <20081105202849.GA9484@localhost>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 05 Nov 2008 21:56:52.0499 (UTC) FILETIME=[693A0E30:01C93F91]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100187>

On Wed, Nov 05, 2008 at 09:28:49PM +0100, Clemens Buchacher wrote:
> On Tue, Nov 04, 2008 at 09:49:32PM -0500, Jeff King wrote:
> [...]
> > However, I would like to make one additional request.  Since you are
> > killing off all usage of new_sha1 initial assignment, I think it makes
> > sense to just get rid of the variable entirely, so it cannot create
> > confusion later.

Considering that the ref is initialized to the null_sha1, do you think it
would be Ok to do the following instead? The call to hashcpy would not be
needed twice and we get rid of the temporary new_sha1.

--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -435,24 +435,18 @@ static int do_send_pack(int in, int out, struct remote *re
         */
        new_refs = 0;
        for (ref = remote_refs; ref; ref = ref->next) {
-               const unsigned char *new_sha1;
-
-               if (!ref->peer_ref) {
-                       if (!args.send_mirror)
-				continue;
-                       new_sha1 = null_sha1;
-               }
-               else
-                       new_sha1 = ref->peer_ref->new_sha1;
-
+               if (ref->peer_ref)
+                       hashcpy(ref->new_sha1, ref->peer_ref->new_sha1);
+               else if (!args.send_mirror)
+                       continue;
