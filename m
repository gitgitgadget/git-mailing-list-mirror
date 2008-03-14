From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-fetch question/bug
Date: Thu, 13 Mar 2008 22:27:43 -0700
Message-ID: <7vbq5hub74.fsf@gitster.siamese.dyndns.org>
References: <5d46db230803132208r3f3f9e34q80bb9c03d65ab67c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: "Govind Salinas" <blix@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 06:28:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja2T1-0007h7-KF
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 06:28:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753021AbYCNF1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 01:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752405AbYCNF1x
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 01:27:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57224 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbYCNF1w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 01:27:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 82A65154D;
	Fri, 14 Mar 2008 01:27:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id AE924154C; Fri, 14 Mar 2008 01:27:45 -0400 (EDT)
In-Reply-To: <5d46db230803132208r3f3f9e34q80bb9c03d65ab67c@mail.gmail.com>
 (Govind Salinas's message of "Fri, 14 Mar 2008 00:08:01 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77183>

"Govind Salinas" <blix@sophiasuchtig.com> writes:

> ... git-fetch when I discovered that it does not return
> error when the
> fetch fails due to it not being a ff...

I think this is a regression introduced when "git-fetch" was
re-implemented in C.  git-fetch--tool's native-store subcommand seems to
have signaled this as an error, and it is reasonable to expect an error
exit from the command in this case.

Probably something like this?

 builtin-fetch.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 55f611e..a2deb3e 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -297,7 +297,7 @@ static int store_updated_refs(const char *url, struct ref *ref_map)
 {
 	FILE *fp;
 	struct commit *commit;
-	int url_len, i, note_len, shown_url = 0;
+	int url_len, i, note_len, shown_url = 0, err = 0;
 	char note[1024];
 	const char *what, *kind;
 	struct ref *rm;
@@ -364,7 +364,8 @@ static int store_updated_refs(const char *url, struct ref *ref_map)
 			note);
 
 		if (ref) {
-			update_local_ref(ref, what, verbose, note);
+			if (update_local_ref(ref, what, verbose, note))
+				err = 1;
 			if (*note) {
 				if (!shown_url) {
 					fprintf(stderr, "From %.*s\n",
@@ -376,7 +377,7 @@ static int store_updated_refs(const char *url, struct ref *ref_map)
 		}
 	}
 	fclose(fp);
-	return 0;
+	return err;
 }
 
 /*
