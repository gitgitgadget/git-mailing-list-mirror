From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash-completion: fix getting strategy list
Date: Wed, 20 Aug 2008 22:07:55 -0700
Message-ID: <7v7iabklas.fsf@gitster.siamese.dyndns.org>
References: <fcaeb9bf0808190527q60869fd0uccbfd165431a752d@mail.gmail.com>
 <20080819132803.GA26201@laptop> <48AADDBB.1080203@viscovery.net>
 <fcaeb9bf0808200958u65ad8fa3oa118b88e16c9c50c@mail.gmail.com>
 <7vfxozpeyh.fsf@gitster.siamese.dyndns.org>
 <237967ef0808201914k2cf8ad09s7b7d56dd8ea35d62@mail.gmail.com>
 <7vbpznkmbf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Mikael Magnusson" <mikachu@gmail.com>,
	"Nguyen Thai Ngoc Duy" <pclouds@gmail.com>,
	"Johannes Sixt" <j.sixt@viscovery.net>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Aug 21 07:09:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW2Q8-0006GV-Az
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 07:09:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147AbYHUFIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 01:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752020AbYHUFIM
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 01:08:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34755 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007AbYHUFIL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 01:08:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4C4B155225;
	Thu, 21 Aug 2008 01:08:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 26EE455224; Thu, 21 Aug 2008 01:08:02 -0400 (EDT)
In-Reply-To: <7vbpznkmbf.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 20 Aug 2008 21:45:56 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 260D1AC0-6F3F-11DD-B72D-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93111>

Junio C Hamano <gitster@pobox.com> writes:

> "Mikael Magnusson" <mikachu@gmail.com> writes:
>
>> I don't know if i somehow have some weird patch merged in, i tried to check
>> and didn't find anything, at least. But when i run git merge -s help i get:
>
> Yes, there are some weird patch in 'next'.  Miklos, could you fix the
> output format of that thing?

I do not think the code in 'next' that reuses the "help" thing to show
only the list to stdout while still giving the error message to stderr
makes any sense.

Let's do this.

---

 builtin-merge.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git c/builtin-merge.c w/builtin-merge.c
index 1f9389b..3e8db0d 100644
--- c/builtin-merge.c
+++ w/builtin-merge.c
@@ -110,9 +110,17 @@ static struct strategy *get_strategy(const char *name)
 		}
 	}
 	if (!is_in_cmdlist(&main_cmds, name) && !is_in_cmdlist(&other_cmds, name)) {
-
-		fprintf(stderr, "Could not find merge strategy '%s'.\n\n", name);
-		list_commands("strategies", longest, &main_cmds, &other_cmds);
+		fprintf(stderr, "Could not find merge strategy '%s'.\n", name);
+		fprintf(stderr, "Available strategies are:");
+		for (i = 0; i < main_cmds.cnt; i++)
+			fprintf(stderr, " %s", main_cmds.names[i]->name);
+		fprintf(stderr, ".\n");
+		if (other_cmds.cnt) {
+			fprintf(stderr, "Available custom strategies are:");
+			for (i = 0; i < other_cmds.cnt; i++)
+				fprintf(stderr, " %s", other_cmds.names[i]->name);
+			fprintf(stderr, ".\n");
+		}
 		exit(1);
 	}
 
