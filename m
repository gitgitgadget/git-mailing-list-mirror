From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Weird problem with long $PATH and alternates (bisected)
Date: Sun, 26 Oct 2008 09:15:18 -0700
Message-ID: <7vljwb5o4p.fsf@gitster.siamese.dyndns.org>
References: <237967ef0810260746w10e930c1sf36a2674f49afbe1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Mikael Magnusson" <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 17:16:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ku8IE-0008J7-Ep
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 17:16:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755058AbYJZQP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 12:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753887AbYJZQP3
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 12:15:29 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33478 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753331AbYJZQP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 12:15:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1F0F08F805;
	Sun, 26 Oct 2008 12:15:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3ACEB8F804; Sun, 26 Oct 2008 12:15:19 -0400 (EDT)
In-Reply-To: <237967ef0810260746w10e930c1sf36a2674f49afbe1@mail.gmail.com>
 (Mikael Magnusson's message of "Sun, 26 Oct 2008 15:46:39 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4D1DC434-A379-11DD-9837-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99171>

"Mikael Magnusson" <mikachu@gmail.com> writes:

> % mkdir 1; cd 1
> % echo > a; git add a; git commit -m a
> % cd ..
> % git clone -s 1 2
> % git push . master:master
> fatal: Could not switch to
> '/tmp/a/1/.git/objects/n:/usr/games/bin:/usr/local/ipod-chain'
> fatal: The remote end hung up unexpectedly

I think I see a bug in foreach_alt_odb() to add_refs_from_alternate()
callchain, but I cannot explain why the contents of $PATH leaks to the
error message.

Can you try this patch?

 sha1_file.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git i/sha1_file.c w/sha1_file.c
index ab2b520..98e7d7a 100644
--- i/sha1_file.c
+++ w/sha1_file.c
@@ -402,9 +402,11 @@ void foreach_alt_odb(alt_odb_fn fn, void *cb)
 	struct alternate_object_database *ent;
 
 	prepare_alt_odb();
-	for (ent = alt_odb_list; ent; ent = ent->next)
+	for (ent = alt_odb_list; ent; ent = ent->next) {
+		*ent->name = '\0';
 		if (fn(ent, cb))
 			return;
+	}
 }
 
 void prepare_alt_odb(void)
