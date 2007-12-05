From: Junio C Hamano <gitster@pobox.com>
Subject: fetch_refs_via_pack() discards status?
Date: Tue, 04 Dec 2007 23:01:19 -0800
Message-ID: <7vk5nt1v7k.fsf@gitster.siamese.dyndns.org>
References: <b8bf37780711211659i4d621533o6a3b97349bb75f8c@mail.gmail.com>
	<20071122160959.GA3411@steel.home>
	<b8bf37780711221427q5dda709dt38ce1837c0e56c1f@mail.gmail.com>
	<b8bf37780711251339y796286fbj2cd8d9225008e13@mail.gmail.com>
	<7v3aunqvha.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 05 08:01:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzoGO-000084-Uf
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 08:01:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbXLEHBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 02:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbXLEHBZ
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 02:01:25 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:47466 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbXLEHBY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 02:01:24 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 1BA7E2EF;
	Wed,  5 Dec 2007 02:01:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 9279499FF2;
	Wed,  5 Dec 2007 02:01:42 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67112>

The code calls fetch_pack() to get the list of refs it fetched, and
discards refs and always returns 0 to signal success.

But builtin-fetch-pack.c::fetch_pack() has error cases.  The function
returns NULL if error is detected (shallow-support side seems to choose
to die but I suspect that is easily fixable to error out as well).

Shouldn't fetch_refs_via_pack() propagate that error to the caller?

---
 transport.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/transport.c b/transport.c
index 50db980..048df1f 100644
--- a/transport.c
+++ b/transport.c
@@ -655,7 +655,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	free(heads);
 	free_refs(refs);
 	free(dest);
-	return 0;
+	return (refs ? 0 : -1);
 }
 
 static int git_transport_push(struct transport *transport, int refspec_nr, const char **refspec, int flags)
