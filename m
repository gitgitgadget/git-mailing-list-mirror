From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-clone --quiet broken?
Date: Sat, 05 Jul 2008 17:56:17 -0700
Message-ID: <7vmykvrfta.fsf@gitster.siamese.dyndns.org>
References: <20080705211616.GA3874@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Dave Jones <davej@codemonkey.org.uk>
X-From: git-owner@vger.kernel.org Sun Jul 06 02:58:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFIaD-0005TT-2J
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 02:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbYGFA4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 20:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753184AbYGFA4a
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 20:56:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49144 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753129AbYGFA43 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 20:56:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2B20117B9D;
	Sat,  5 Jul 2008 20:56:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 591EF17B9B; Sat,  5 Jul 2008 20:56:22 -0400 (EDT)
In-Reply-To: <20080705211616.GA3874@codemonkey.org.uk> (Dave Jones's message
 of "Sat, 5 Jul 2008 17:16:16 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5CE0C640-4AF6-11DD-A7CC-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87476>

Dave Jones <davej@codemonkey.org.uk> writes:

> The server I run various git snapshots on recently got upgraded to git 1.5.6,
> ...
> I could run the clone with 2>/dev/null, but I'd really like to get
> mail when something breaks instead of it being totally silent.
>
> I'm assuming this was an unintentional side-effect of some other recent change?

Yeah, I would assume so, too ;-)

Daniel, is this enough?  From re-reading the scripted version of
git-clone, it appears that we *might* need to squelch no-progress if the
stdout is not tty;  I do not offhand if you got that right when you
rewrote this in C.

 transport.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/transport.c b/transport.c
index 3ff8519..b2f0d8a 100644
--- a/transport.c
+++ b/transport.c
@@ -645,7 +645,8 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.lock_pack = 1;
 	args.use_thin_pack = data->thin;
 	args.include_tag = data->followtags;
-	args.verbose = transport->verbose > 0;
+	args.verbose = (transport->verbose > 0);
+	args.quiet = (transport->verbose < 0);
 	args.depth = data->depth;
 
 	for (i = 0; i < nr_heads; i++)
