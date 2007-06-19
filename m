From: Sergey Yanovich <ynvich@gmail.com>
Subject: [PATCH 1/3] Accept root <tree-ish> in 'git-svn commit-diff'
Date: Tue, 19 Jun 2007 09:54:35 +0300
Message-ID: <11822360772759-git-send-email-ynvich@gmail.com>
Cc: Sergey Yanovich <ynvich@gmail.com>
To: git@vger.kernel.org, normalperson@yhbt.net, J.Sixt@eudaptics.com,
	masterdriverz@gmail.com
X-From: git-owner@vger.kernel.org Tue Jun 19 08:53:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0Xat-0005Q8-LT
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 08:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755865AbXFSGxh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 02:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755910AbXFSGxh
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 02:53:37 -0400
Received: from hu-out-0506.google.com ([72.14.214.231]:62754 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754354AbXFSGxg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 02:53:36 -0400
Received: by hu-out-0506.google.com with SMTP id 19so874853hue
        for <git@vger.kernel.org>; Mon, 18 Jun 2007 23:53:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:message-id:in-reply-to:references;
        b=SCgliK7kklR+ts4hrU/M43t2XSAj6lRC5Y0veZTu+1b+FQohB0BOR1O7fgZ+iUUlKFkyd4XHaNde4mdTgLgCT/nSm/3wuafqgJW2p12JlM4HQZo8eU5h5w+SQ4v2oWA7naVe0vAB/Mdf/5UwAPS5+eizTeeWwutVGl4g4lUjEK0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=J6i5nccc1HiehLupQqh3eq8ZvFRSSvbWaBguPjor+pfboZ9g/r31+QWWVTBK89vf2tQo3Oj9sze9ShQ9rqFLgvM43wB5LcTPoWE84UWqQE7ABDLXlNFl/aVY6G199OXWN47n99BafCy0zN1YS129IriPPUwrlGytc9Dw/Jh78XE=
Received: by 10.78.201.2 with SMTP id y2mr2654545huf.1182236014482;
        Mon, 18 Jun 2007 23:53:34 -0700 (PDT)
Received: from host3 ( [87.252.237.202])
        by mx.google.com with ESMTP id z29sm2358584hub.2007.06.18.23.53.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Jun 2007 23:53:33 -0700 (PDT)
Received: from sergei by host3 with local (Exim 4.63)
	(envelope-from <ynvich@gmail.com>)
	id 1I0Xbp-0003Tl-Pu; Tue, 19 Jun 2007 09:54:37 +0300
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: 11821688443683-git-send-email-ynvich@gmail.com
References: 11821688443683-git-send-email-ynvich@gmail.com
Message-Id: <cff8d32813e43d9e1c75ad50824d95dbcd6f669c.1182235491.git.ynvich@gmail.com>
In-Reply-To: <11821688443683-git-send-email-ynvich@gmail.com>
References: <11821688443683-git-send-email-ynvich@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Experiments with Subversion (my version is 1.4.2) show that it is
not necessary to call 'svn import' before the first commit. Contrarily
to the Subversion documentation, first commit may be done even when
Subversion repository is at revision 0.

This allow export the whole git branch to a Subversion repo using only
'git-svn commit-diff'. Before this patch, however, 'git-svn' had
no means to operate on root commits.

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
