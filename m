From: Junio C Hamano <gitster@pobox.com>
Subject: Re: tracking repository
Date: Sun, 16 Mar 2008 16:01:41 -0700
Message-ID: <7vbq5eff3e.fsf@gitster.siamese.dyndns.org>
References: <frh8dg$t9j$1@ger.gmane.org>
 <7vabkzmltc.fsf@gitster.siamese.dyndns.org> <1205697779.12760.20.camel@duo>
 <7vwso2ieuu.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803161716470.19665@iabervon.org>
 <7vwso2gwnf.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803161812340.19665@iabervon.org>
 <7vzlsyfgjg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, kenneth johansson <ken@kenjo.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Mar 17 00:02:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jb1sH-0003m6-7M
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 00:02:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999AbYCPXCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 19:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753058AbYCPXCA
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 19:02:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34890 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752957AbYCPXB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 19:01:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A307D2B65;
	Sun, 16 Mar 2008 19:01:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 2331F2B64; Sun, 16 Mar 2008 19:01:50 -0400 (EDT)
In-Reply-To: <7vzlsyfgjg.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 16 Mar 2008 15:30:27 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77398>

Junio C Hamano <gitster@pobox.com> writes:

> Daniel Barkalow <barkalow@iabervon.org> writes:
>
>> Is "refs/*:refs/*" (mirror everything, including weird stuff) supposed to 
>> be prohibited?
>
> No.  In fact "remote add --mirror" actively creates such.  See my other
> message about design level issues.

I think something like this is needed.  It still has an independent issue
that this is now called by "git remote show" or "git remote prune", and it
will die with a nonsense "refusing to create" error message, though.

The error, as far as I can tell, is half about a misconfigured config
(e.g. "fetch = refs/heads/*:refs/remotes/[]?/*") and half about screwy
remote repository (e.g. a misnamed "[]?" branch on the remote end can try
to update a broken "refs/remotes/origin/[]?" even the configuration is a
perfectly valid "fetch = refs/heads/*:refs/remotes/origin/*").  It may
make sense to reword the error message to "ignoring" from "refusing" and
do just that without dying here.  I dunno.

 remote.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index f3f7375..fbcb03c 100644
--- a/remote.c
+++ b/remote.c
@@ -1007,9 +1007,12 @@ int get_fetch_map(const struct ref *remote_refs,
 	}
 
 	for (rm = ref_map; rm; rm = rm->next) {
-		if (rm->peer_ref && check_ref_format(rm->peer_ref->name + 5))
-			die("* refusing to create funny ref '%s' locally",
-			    rm->peer_ref->name);
+		if (rm->peer_ref) {
+			int st = check_ref_format(rm->peer_ref->name + 5);
+			if (st && st != CHECK_REF_FORMAT_ONELEVEL)
+				die("* refusing to create funny ref '%s'"
+				    " locally", rm->peer_ref->name);
+		}
 	}
 
 	if (ref_map)
