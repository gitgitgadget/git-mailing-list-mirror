From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] add -p: import Term::ReadKey with 'require'
Date: Fri,  6 Feb 2009 20:30:01 +0100
Message-ID: <1233948601-4828-1-git-send-email-trast@student.ethz.ch>
References: <20090206140126.GA18364@coredump.intra.peff.net>
Cc: Junio C Hamano <junio@pobox.com>,
	Suraj Kurapati <sunaku@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 06 20:31:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVWQT-0001q0-GI
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 20:31:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753740AbZBFTaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 14:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753405AbZBFTaQ
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 14:30:16 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:16486 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753086AbZBFTaP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 14:30:15 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 6 Feb 2009 20:30:12 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 6 Feb 2009 20:30:13 +0100
X-Mailer: git-send-email 1.6.1.2.605.ge4655
In-Reply-To: <20090206140126.GA18364@coredump.intra.peff.net>
X-OriginalArrivalTime: 06 Feb 2009 19:30:13.0052 (UTC) FILETIME=[54C3BFC0:01C98891]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108777>

eval{use...} is no good because the 'use' is evaluated at compile
time, so manually 'require' it.  We need to forward declare the
functions we use, otherwise Perl raises a compilation error.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
Jeff King wrote:
> Sorry, I am way behind on git mails, so I didn't catch this sooner. But
> it should be "require Term::ReadKey", as "use" statements are done at
> compile time:
> 
>   $ perl -e 'eval { use Bogosity } or print "not found\n"'
>   Can't locate Bogosity.pm in @INC ...
> 
>   $ perl -e 'eval { require Bogosity } or print "not found\n"'
>   not found
> 
> So add--interactive in 'next' is currently broken on non-readkey
> platforms.

Damn, sorry.

The code below _seems_ to work.  I have to say that beyond the
'require', it's all voodoo to me, so I'd appreciate an extra-careful
check.


 git-add--interactive.perl |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index be8ca8e..ec47888 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -40,9 +40,12 @@ my ($diff_new_color) =
 my $normal_color = $repo->get_color("", "reset");
 
 my $use_readkey = 0;
+sub ReadMode;
+sub ReadKey;
 if ($repo->config_bool("interactive.singlekey")) {
 	eval {
-		use Term::ReadKey;
+		require Term::ReadKey;
+		Term::ReadKey->import;
 		$use_readkey = 1;
 	};
 }
-- 
1.6.1.2.605.ge4655
