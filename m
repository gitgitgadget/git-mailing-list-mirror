From: Sergey Yanovich <ynvich@gmail.com>
Subject: [PATCH 1/3] Accept root <tree-ish> in 'git-svn commit-diff'
Date: Mon, 18 Jun 2007 15:14:02 +0300
Message-ID: <11821688461828-git-send-email-ynvich@gmail.com>
References: vpqhcp6b85c.fsf@bauges.imag.fr
 <11821688443683-git-send-email-ynvich@gmail.com>
Cc: Sergey Yanovich <ynvich@gmail.com>
To: git@vger.kernel.org, normalperson@yhbt.net, Matthieu.Moy@imag.fr
X-From: git-owner@vger.kernel.org Mon Jun 18 14:13:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0G6b-0007ke-8M
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 14:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760881AbXFRMNL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 08:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761571AbXFRMNJ
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 08:13:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:20317 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760828AbXFRMNG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 08:13:06 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1401990ugf
        for <git@vger.kernel.org>; Mon, 18 Jun 2007 05:13:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:message-id:in-reply-to:references;
        b=Y8RZZXJ+JFyPFt61MYOUPyswkPG5tOtZTC1gHizAxeH7qdZ06WdakgpNcS5vcZTvnmAosN9/z/3raqkdolsFdcDuNsgBtmnp9sG/+E2HBaamFjeKgshkd2XKe8RcG5leIcPmCUko8sK3ibVy6DFU92BXk1yJqvo2FhZ6t6yTn6E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WPtizLyku18MUztf9wNRTNEDk3NdFzGmCQYL0YR10T0EIdFMDajjwrsAO3Jj+JmaNGF7/tZG/bZ1lnlrfcIWjDy9SZW+f7KgUtO5zZIxR9Rr+XNP0AvhyxzN8w71f6auNtewD/73I1bvMmlBtRv6OHR/eA68KBsdwZiMNmOO/QE=
Received: by 10.82.126.5 with SMTP id y5mr11104231buc.1182168785098;
        Mon, 18 Jun 2007 05:13:05 -0700 (PDT)
Received: from host3 ( [87.252.237.202])
        by mx.google.com with ESMTP id c24sm14951916ika.2007.06.18.05.13.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Jun 2007 05:13:03 -0700 (PDT)
Received: from sergei by host3 with local (Exim 4.63)
	(envelope-from <ynvich@gmail.com>)
	id 1I0G7S-0001Rw-K3; Mon, 18 Jun 2007 15:14:06 +0300
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <11821688443683-git-send-email-ynvich@gmail.com>
Message-Id: <4e79874760c3773448d886608d6db7bbda3c97f2.1182168501.git.ynvich@gmail.com>
In-Reply-To: <vpqhcp6b85c.fsf@bauges.imag.fr>
References: <vpqhcp6b85c.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


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
