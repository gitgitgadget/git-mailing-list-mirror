From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] send-email: stop asking when we have an ident
Date: Tue, 13 Nov 2012 20:19:24 +0100
Message-ID: <1352834364-2674-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Felipe Contreras 2nd <felipe.contreras+2@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 20:19:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYM1X-0005Xv-2z
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 20:19:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754747Ab2KMTTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 14:19:37 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:32971 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752261Ab2KMTTg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 14:19:36 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so732896bkw.19
        for <git@vger.kernel.org>; Tue, 13 Nov 2012 11:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=f7ofRitOV8xidA+XM/mDQdeP+cEeW9lfamyo4csEY8I=;
        b=zb/J+3XDmzEe3Xt16Tu+qMwGyq5TT0yyvXgo7YN0sIvnS5z1MAQzz/MjaeBO7WJYSh
         BJyH8Bn/QBJ+Ezf1V3ctj4NO392LVeVZRkzXG0QsfHDA0gLJdyQMnbpH+fP23C9em9ll
         OOnOkJVwNJ/NhjLagOnQqV94kspVhP0PRNNU+oqUUiQ8bYmdxbiFKcs+6ZT95BQUfX3y
         NgR8f835d6to3+/5C9iXC9RdAVy8eIJKTM2SSSjtc/bAnKF7+ur337WGcsKw5HqZiGkd
         NoF2csAo6cVqbtAcNhn7g1MSYURcqcxKpo6brICn7UEgMKmSZFpQX6jg7bgvhI5oKX/w
         oHwg==
Received: by 10.205.130.9 with SMTP id hk9mr8541647bkc.52.1352834375422;
        Tue, 13 Nov 2012 11:19:35 -0800 (PST)
Received: from localhost (ip-109-43-0-94.web.vodafone.de. [109.43.0.94])
        by mx.google.com with ESMTPS id 1sm6583067bks.3.2012.11.13.11.19.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Nov 2012 11:19:34 -0800 (PST)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209660>

From: Felipe Contreras 2nd <felipe.contreras+2@gmail.com>

Currently we keep getting questions even when the user has properly
configured his full name and password:

 Who should the emails appear to be from?
 [Felipe Contreras <felipe.contreras@gmail.com>]

And once a question pops up, other questions are turned on. This is
annoying.

The reason this is safe is because currently the script fails completely
when the autohor (or committer) is not correct, so we won't even be
reaching this point in the code.

The scenarios, and the current situation:

1) No information at all, no fully qualified domain name

fatal: empty ident name (for <felipec@nysa.(none)>) not allowed

2) Only full name

fatal: unable to auto-detect email address (got 'felipec@nysa.(none)')

3) Full name + fqdm

Who should the emails appear to be from?
[Felipe Contreras <felipec@nysa.felipec.org>]

4) Full name + EMAIL

Who should the emails appear to be from?
[Felipe Contreras <felipe.contreras@gmail.com>]

5) User configured
6) GIT_COMMITTER
7) GIT_AUTHOR

All these are the same as 4)

After this patch:

1) 2) won't change: git send-email would still die

4) 5) 6) 7) will change: git send-email won't ask the user

This is good, that's what we would expect, because the identity is
explicit.

3) will change: git send-email won't ask the user

This is bad, because we will try with an address such as
'felipec@nysa.felipec.org', which is most likely not what the user
wants, but the user will get warned by default, and if not, most likley
the sending won't work, which the user can easily fix.

The worst possible scenario is that such a mail address does work, and
the user sends an email from that addres unintentionally, when in fact
the user expected to correct that address in the propmpt.

This is a very, very, very unlikely scenario, with many dependencies:

1) No configured user.name/user.email
2) No specified $EMAIL
3) No configured sendemail.from
4) No specified --from argument
5) A fully qualified domain name
6) A full name in the geckos field
7) A sendmail configuration that allows sending from this domain name
8) confirm=never, or
8.1) confirm configuration not hitting, or
8.2) Getting the error, not being aware of it
9) The user expecting to correct this address in the prompt

In a more likely scenario where 7) is not the case (can't send from
nysa.felipec.org), the user will simply see the mail was not sent
properly, and fix the problem.

The much more likely scenario though, is where 5) is not the case
(nysa.(none)), and git send-email will fail right away like it does now.

So the likelyhood of this affecting anybody seriously is very very slim,
and the chances of this affecting somebody slightly are still very
small. The vast majority, if not all, of git users won't be affected
negatively, and a lot will benefit from this.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-send-email.perl | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index aea66a0..503e551 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -748,16 +748,11 @@ if (!$force) {
 	}
 }
 
-my $prompting = 0;
 if (!defined $sender) {
 	$sender = $repoauthor || $repocommitter || '';
-	$sender = ask("Who should the emails appear to be from? [$sender] ",
-	              default => $sender,
-		      valid_re => qr/\@.*\./, confirm_only => 1);
-	print "Emails will be sent from: ", $sender, "\n";
-	$prompting++;
 }
 
+my $prompting = 0;
 if (!@initial_to && !defined $to_cmd) {
 	my $to = ask("Who should the emails be sent to (if any)? ",
 		     default => "",
-- 
1.8.0
