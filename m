From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Git.pm: Fix internal git_command_bidi_pipe() users
Date: Mon, 04 Aug 2008 09:56:04 +0200
Message-ID: <20080804075313.21325.28396.stgit@localhost>
References: <be6fef0d0808032149p651309a8o773dca5f16923ee1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 04 09:57:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPuwN-0003mg-4k
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 09:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbYHDH4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 03:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbYHDH4N
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 03:56:13 -0400
Received: from 159-162.104-92.cust.bluewin.ch ([92.104.162.159]:55432 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750754AbYHDH4N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 03:56:13 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by pixie.suse.cz (Postfix) with ESMTP id D86D789249;
	Mon,  4 Aug 2008 09:56:04 +0200 (CEST)
In-Reply-To: <be6fef0d0808032149p651309a8o773dca5f16923ee1@mail.gmail.com>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91323>

The hash_and_insert_object() and cat_blob() helpers were using
an incorrect slice-from-ref Perl syntax. This patch fixes that up
in the _close_*() helpers and make the _open_*() helpers use the
same syntax for consistnecy.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

  Wow, the command_bidi_pipe API really is dirty. Of course, it is
my fault as anyone's since I didn't get around to review the patches
introducing it.

 perl/Git.pm |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 087d3d0..0624428 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -827,8 +827,7 @@ sub _open_hash_and_insert_object_if_needed {
 
 	return if defined($self->{hash_object_pid});
 
-	($self->{hash_object_pid}, $self->{hash_object_in},
-	 $self->{hash_object_out}, $self->{hash_object_ctx}) =
+	@$self{map { "hash_object_$_" } qw(pid in out ctx)} =
 		command_bidi_pipe(qw(hash-object -w --stdin-paths));
 }
 
@@ -837,9 +836,8 @@ sub _close_hash_and_insert_object {
 
 	return unless defined($self->{hash_object_pid});
 
-	my @vars = map { 'hash_object_' . $_ } qw(pid in out ctx);
-
-	command_close_bidi_pipe($self->{@vars});
+	my @vars = map { "hash_object_$_" } qw(pid in out ctx);
+	command_close_bidi_pipe(@$self{@vars});
 	delete $self->{@vars};
 }
 
@@ -916,8 +914,7 @@ sub _open_cat_blob_if_needed {
 
 	return if defined($self->{cat_blob_pid});
 
-	($self->{cat_blob_pid}, $self->{cat_blob_in},
-	 $self->{cat_blob_out}, $self->{cat_blob_ctx}) =
+	@$self{map { "cat_blob_$_" } qw(pid in out ctx)} =
 		command_bidi_pipe(qw(cat-file --batch));
 }
 
@@ -926,9 +923,8 @@ sub _close_cat_blob {
 
 	return unless defined($self->{cat_blob_pid});
 
-	my @vars = map { 'cat_blob_' . $_ } qw(pid in out ctx);
-
-	command_close_bidi_pipe($self->{@vars});
+	my @vars = map { "cat_blob_$_" } qw(pid in out ctx);
+	command_close_bidi_pipe(@$self{@vars});
 	delete $self->{@vars};
 }
 
