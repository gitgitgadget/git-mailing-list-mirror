From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Octopus merge: unique (?) to git, but is it useful?
Date: Mon, 02 Jun 2008 22:17:42 -0700
Message-ID: <7vskvv3xmx.fsf@gitster.siamese.dyndns.org>
References: <200806030314.03252.jnareb@gmail.com>
 <alpine.LFD.1.10.0806021845210.3473@woody.linux-foundation.org>
 <7v3anv5fy3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 03 07:18:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3Ov2-0006sN-Fv
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 07:18:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbYFCFRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 01:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752122AbYFCFRz
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 01:17:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62152 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708AbYFCFRz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 01:17:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2CA4C3DD2;
	Tue,  3 Jun 2008 01:17:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EB9423DD0; Tue,  3 Jun 2008 01:17:45 -0400 (EDT)
In-Reply-To: <7v3anv5fy3.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 02 Jun 2008 20:56:52 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6AD5BBE0-312C-11DD-814B-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83615>

Junio C Hamano <gitster@pobox.com> writes:

> Having said that, I think what is happening is that the final set of
> "other parents" is computed inside git-merge out of MERGE_HEAD and that is
> usually what is recorded in the resulting merge, but if the merge results
> in a conflict with manual resolution, that information is not given to the
> final "git commit".  The resulting commit records the parents out of HEAD
> and MERGE_HEAD.  I do not think this part has changed from scripted
> version of git-commit.

Sorry, my thinko.

The scripted version obviously used commit-tree to omit the duplicated
parent.  Perhaps we can do something like this.

-- >8 --
commit: drop duplicated parents

The scripted version of git-commit internally used git-commit-tree which
omitted duplicated parents given from the command line.  This prevented a
nonsensical octopus merge from getting created even when you said "git
merge A B" while you are already on branch A.

However, when git-commit was rewritten in C, this sanity check was lost.
This resurrects it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-commit.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index b294c1f..1d8d208 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -883,10 +883,19 @@ static void add_parent(struct strbuf *sb, const unsigned char *sha1)
 {
 	struct object *obj = parse_object(sha1);
 	const char *parent = sha1_to_hex(sha1);
+	const char *cp;
+
 	if (!obj)
 		die("Unable to find commit parent %s", parent);
 	if (obj->type != OBJ_COMMIT)
 		die("Parent %s isn't a proper commit", parent);
+	cp = strstr(sb->buf, parent);
+	if (cp &&
+	    sb->buf + 8 <= cp && !memcmp(cp - 8, "\nparent ", 8) &&
+	    cp[40] == '\n') {
+		error("duplicate parent %s ignored", parent);
+		return;
+	}
 	strbuf_addf(sb, "parent %s\n", parent);
 }
 
