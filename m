From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Thu, 29 Jan 2009 18:18:22 -0800
Message-ID: <7vwscdbkpd.fsf@gitster.siamese.dyndns.org>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de>
 <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de>
 <7v4ozhd1wp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 30 03:20:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSiz4-0003D6-D0
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 03:19:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbZA3CSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 21:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbZA3CS3
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 21:18:29 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35072 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbZA3CS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 21:18:28 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 46313948E0;
	Thu, 29 Jan 2009 21:18:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F389C948DD; Thu,
 29 Jan 2009 21:18:23 -0500 (EST)
In-Reply-To: <7v4ozhd1wp.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 29 Jan 2009 17:21:26 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 476A4698-EE74-11DD-BB46-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107764>

I do not think this improves anything.

@@ -239,9 +239,12 @@ static const char *update(struct command *cmd)
 			" that are now in HEAD.");
 		break;
 	case DENY_REFUSE:
-		if (!is_ref_checked_out(name))
+		if (is_bare_repository() || !is_ref_checked_out(name))
 			break;
-		error("refusing to update checked out branch: %s", name);
+		error("refusing to update checked out branch: %s\n"
+			"if you know what you are doing, you can allow it by "
+			"setting\n\n"
+			"\tgit config receive.denyCurrentBranch true\n", name);
 		return "branch is currently checked out";
 	}
 
As the message I am currently getting from such a push is:

$ git push ../victim-010 next:master
Total 0 (delta 0), reused 0 (delta 0)
warning: updating the currently checked out branch; this may cause confusion,
as the index and working tree do not reflect changes that are now in HEAD.
To ../victim-010
   a34a9db..d79e69c  next -> master

which is much better than what you did.  It at least tries to explain why
it is warning, even though I think it has a huge room for improvement.

Saying "If you know what you are doing" never works in practice.  It can
serve as an excuse for you to later say, "See, I told you so", but that is
the only usefulness of the expression, and everybody, especially the most
clueless people, *think* they know what they are doing.


You alluded that we wanted to make grace period much longer, but you want
to cut it short.  I think it is a huge mistake.  The warning has only been
there for the last two months, and only can be seen from v1.6.1-rc1 or
newer software.  These new people even haven't a chance to learn from the
existing warning.


I think what would work much better would be a patch that keeps the
warn-but-allow as the default, but clarifies the warning message.  Say
these things in separate paragraphs, perhaps in red blinking letters:

 (1) what symptoms, that are easily observable by the most novice users,
     are caused by "index and work tree going out of sync" the warning
     talks about, and why that would not be what they want;

 (2) if the user did not mean to do it (and the user can tell by observing
     the symptom described in the previous point), describe what needs to
     be done to recover from the fallout this push has caused (we do not
     need a recipe; pointing at a URL or manpage is fine), and what switch
     to flip to prevent herself from doing it again in the future;

 (3) if the user did mean it, and finds the above two big warning
     annoying, what switch to flip to squelch the warning for future
     pushes.

The goal of the warning should be to *force* people *choose*, either to
silently-allow (aka DENY_IGNORE) or refuse (DENY_REFUSE), and give enough
information for them to make an informed decision.  We can afford to be
annoyingly long, loud and verbose there.

On the other hand, you cannot make the message for DENY_REFUSE annoyingly
long, as people may have already chosen to say "please refuse my push into
a live branch".

If you are making "refuse" the default, an annoyingly long message is even
worse.  "Yeah, thanks for stopping me, but you do not have to remind me
every time that I made a mistake in large red letters.  I perfectly well
know what I am doing, I perfectly well know that I did not want to push
into that branch, I just made a mistake---you do not have to be so loud".

I suspect that you cannot even be long enough to be informative, not to
annoy people.
