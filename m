From: Sergey Yanovich <ynvich@gmail.com>
Subject: [PATCH 1/2] Accept root <tree-ish> in 'git-svn commit-diff'
Date: Sun, 17 Jun 2007 22:38:56 +0300
Message-ID: <11821091373927-git-send-email-ynvich@gmail.com>
References: 11821061823423-git-send-email-ynvich@gmail.com
 <11821091373273-git-send-email-ynvich@gmail.com>
Cc: Sergey Yanovich <ynvich@gmail.com>
To: git@vger.kernel.org, normalperson@yhbt.net
X-From: git-owner@vger.kernel.org Sun Jun 17 21:38:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I00ZV-0004fp-6f
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 21:38:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760132AbXFQTh7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 15:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760021AbXFQTh7
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 15:37:59 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:37613 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754554AbXFQTh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2007 15:37:58 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1243060ugf
        for <git@vger.kernel.org>; Sun, 17 Jun 2007 12:37:56 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kmrObKYXF6TJeRYadEITttE80R+EBTbJRF6MGgNOM0azJ9S5N2hDvKOe0guN/rPJSJtMciY8Y70LPBrMRrssd4fBgzpjAVIUuI6jhRdCqgyB7X1dfr84J5DfnimkSgmQnzJbDYzZAUrAvJv7gM66w5QsAu4w5K3BwuWMwYzuHws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=SgE8+bgjuEiZrSONFt9edEuWnFTEFE3pcurusjvRBjjHSid/eQiFHFTYTLZo49ikWJ3tk/KKcztDJZpygbD1leemsUqw3TCXf/Oj9Wpnh8Jx4lueuGmR3jn/IKuhp7yqx/jlXt7IB3Eey1hovI36iyoGyWpfHI5eWmYYVuWE9zE=
Received: by 10.66.249.16 with SMTP id w16mr4477555ugh.1182109076643;
        Sun, 17 Jun 2007 12:37:56 -0700 (PDT)
Received: from host3 ( [87.252.237.202])
        by mx.google.com with ESMTP id r58sm4348577uga.2007.06.17.12.37.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 17 Jun 2007 12:37:55 -0700 (PDT)
Received: from sergei by host3 with local (Exim 4.63)
	(envelope-from <ynvich@gmail.com>)
	id 1I00aQ-0002mo-2H; Sun, 17 Jun 2007 22:38:58 +0300
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <11821091373273-git-send-email-ynvich@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50368>


Signed-off-by: Sergey Yanovich <ynvich@gmail.com>
---
 git-svn.perl |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 50128d7..8ad291b 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2572,7 +2572,12 @@ sub generate_diff {
 	}
 	push @diff_tree, '--find-copies-harder' if $_find_copies_harder;
 	push @diff_tree, "-l$_rename_limit" if defined $_rename_limit;
-	push @diff_tree, $tree_a, $tree_b;
+	if ($tree_a eq '0000000000000000000000000000000000000000') {
+		push @diff_tree, '--root';
+	} else {
+		push @diff_tree, $tree_a;
+	}
+	push @diff_tree, $tree_b;
 	my ($diff_fh, $ctx) = command_output_pipe(@diff_tree);
 	local $/ = "\0";
 	my $state = 'meta';
@@ -2606,6 +2611,8 @@ sub generate_diff {
 			}
 			$x->{file_b} = $_;
 			$state = 'meta';
+		} elsif ($state eq 'meta' && $_ eq $tree_b &&
+			$tree_a eq '0000000000000000000000000000000000000000') {
 		} else {
 			croak "Error parsing $_\n";
 		}
-- 
1.5.2.1
