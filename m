From: Steven Walter <stevenrwalter@gmail.com>
Subject: [PATCH] Don't checkout the full tree if avoidable
Date: Fri, 28 Sep 2007 13:24:19 -0400
Message-ID: <1191000259190-git-send-email-stevenrwalter@gmail.com>
Cc: Steven Walter <stevenrwalter@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 19:24:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbJa5-00042w-JQ
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 19:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753363AbXI1RYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 13:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753349AbXI1RYm
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 13:24:42 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:49199 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753280AbXI1RYl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 13:24:41 -0400
Received: by py-out-1112.google.com with SMTP id u77so5373624pyb
        for <git@vger.kernel.org>; Fri, 28 Sep 2007 10:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=77Oe75maatH7MnQHL6zvjrRmnzhMQ13idPPvL7zSjO0=;
        b=SVM0w2JeKW6l1vkmO2ka4f95E9aKr0dSSGdNNtfEsB0jieWMhfDkhDOf6XdGxjjzAgXyrEz+u7LqYhVPlL04oOMcUWOnDyYGNqwQoZPK8m6SDZWXT+dADLfuVar12/ASHvjR8ZRsH8e0WfD63LAUh/kCojqG283aTFosfqQO4v0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qRFb8aIQVZ5GJcuOODgDGvtntxMAjOLn2nIryrg/VuVpKteU4gaM5m8JtFrREdpRUHO54AChLPyC7MZB6yQ7xUznrFajNtsDLYvtcqCKZRJh0lBZ+iaiMqm/0xShU+SwwbA7TZdIA7kCAXFd3UWCaCqfJNesOcJSpvdI9gwfljc=
Received: by 10.64.184.16 with SMTP id h16mr8096319qbf.1191000279221;
        Fri, 28 Sep 2007 10:24:39 -0700 (PDT)
Received: from dasbrennen.isa-geek.org ( [76.177.36.23])
        by mx.google.com with ESMTPS id 37sm4441092nzf.2007.09.28.10.24.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 28 Sep 2007 10:24:36 -0700 (PDT)
Received: by dasbrennen.isa-geek.org (Postfix, from userid 1000)
	id 21EC0CDD09E; Fri, 28 Sep 2007 13:24:19 -0400 (EDT)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: 20070928171959.GA21816@dervierte
References: 20070928171959.GA21816@dervierte
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59412>

In most cases of branching, the tree is copied unmodified from the trunk
to the branch.  When that is done, we can simply start with the parent's
index and apply the changes on the branch as usual.

Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
---
 git-svn.perl |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 484b057..2ca2042 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1847,6 +1847,13 @@ sub find_parent_branch {
 			$gs->ra->gs_do_switch($r0, $rev, $gs,
 					      $self->full_url, $ed)
 			  or die "SVN connection failed somewhere...\n";
+		} elsif ($self->trees_match($new_url, $r0,
+			                    $self->full_url, $rev)) {
+			$self->tmp_index_do(sub {
+			    command_noisy('read-tree', $parent);
+			});
+			$self->{last_commit} = $parent;
+			# Assume copy with no changes
 		} else {
 			print STDERR "Following parent with do_update\n";
 			$ed = SVN::Git::Fetcher->new($self);
@@ -1859,6 +1866,17 @@ sub find_parent_branch {
 	return undef;
 }
 
+sub trees_match {
+    my ($self, $url1, $rev1, $url2, $rev2) = @_;
+    
+    my $ret=1;
+    open(my $fh, "svn diff $url1\@$rev1 $url2\@$rev2 |");
+    $ret=0 if (<$fh>);
+    close($fh);
+
+    return $ret;
+}
+
 sub do_fetch {
 	my ($self, $paths, $rev) = @_;
 	my $ed;
-- 
1.5.3.1
