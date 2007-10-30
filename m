From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] remote.c/match_explicit() ... NULL pointer dereferenciation (git 1.5.3.4)
Date: Tue, 30 Oct 2007 11:30:43 -0700
Message-ID: <7vwst4lajw.fsf@gitster.siamese.dyndns.org>
References: <200710301144.32528@rk-nord.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org
To: Melchior FRANZ <mfranz@aon.at>
X-From: git-owner@vger.kernel.org Tue Oct 30 19:31:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Imvrz-0001Ju-7i
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 19:31:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753620AbXJ3Saw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 14:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753634AbXJ3Saw
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 14:30:52 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:40238 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753623AbXJ3Sav (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 14:30:51 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id D2C9C2F2;
	Tue, 30 Oct 2007 14:31:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 49DF5905B9;
	Tue, 30 Oct 2007 14:31:07 -0400 (EDT)
In-Reply-To: <200710301144.32528@rk-nord.at> (Melchior FRANZ's message of
	"Tue, 30 Oct 2007 11:44:32 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62726>

Subject: Prevent send-pack from segfaulting (backport from 'master')

4491e62ae932d5774f628d1bd3be663c11058a73 (Prevent send-pack from
segfaulting when a branch doesn't match) 

If we can't find a source match, and we have no destination, we
need to abort the match function early before we try to match
the destination against the remote.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

  Thanks.  Shawn fixed it on the 'master' side but 'maint' is
  still using the old code.

 remote.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/remote.c b/remote.c
index cdbbdcb..9a88917 100644
--- a/remote.c
+++ b/remote.c
@@ -504,8 +504,11 @@ static int match_explicit(struct ref *src, struct ref *dst,
 	if (!matched_src)
 		errs = 1;
 
-	if (dst_value == NULL)
+	if (!dst_value) {
+		if (!matched_src)
+			return errs;
 		dst_value = matched_src->name;
+	}
 
 	switch (count_refspec_match(dst_value, dst, &matched_dst)) {
 	case 1:
