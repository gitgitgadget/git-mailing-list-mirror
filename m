From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] "add -p": work-around an old laziness that does not
 coalesce hunks
Date: Fri, 29 Apr 2011 15:49:33 -0700
Message-ID: <1304117373-592-4-git-send-email-gitster@pobox.com>
References: <1304117373-592-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 00:50:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFwVa-00084m-HG
	for gcvg-git-2@lo.gmane.org; Sat, 30 Apr 2011 00:49:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933986Ab1D2Wty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 18:49:54 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33293 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932247Ab1D2Wtw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 18:49:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C29F95555
	for <git@vger.kernel.org>; Fri, 29 Apr 2011 18:51:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=LxAY
	FcDJRq3zPLgVQORCW4cnlug=; b=YpDuwCCOllmLJye9v1DmEsjiymZSLbOeo76w
	+ajce7F6nC5pz6IHpboiGr9S/1eft6khhu9N4iQ91dr1o0qFtg4SWEVZkB2EfkiK
	q97OAQ/HpuxSybQIbYJP8XUtCbUIAFNie2sBhHDHLNFNgqPYbNkc/LS2Zz1b+mlw
	vQzPHyg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=gdlfBW
	WVxkdF5GBBD5dXzTbSw9/v1S/NqpcSVVtrHmXn12d9F077a02UQc+4Z4GllVY+Dy
	4UIEm7c0FtDN3KzJaGH4JFb43Z8qiYykwxdPaQZmXuog1Z3AXeHhAYO6+OE4gyIY
	1rf31i5kb0SbAr2iXgFuLiOSUmo0q0letdeqs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BE2275554
	for <git@vger.kernel.org>; Fri, 29 Apr 2011 18:51:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 21C8A5553 for
 <git@vger.kernel.org>; Fri, 29 Apr 2011 18:51:51 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.252.g565191
In-Reply-To: <1304117373-592-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4663A7A6-72B3-11E0-9837-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172509>

Since 0beee4c (git-add--interactive: remove hunk coalescing, 2008-07-02),
"git add--interactive" behaves lazily and passes overlapping hunks to the
underlying "git apply" without coalescing.  This was partially corrected
by 7a26e65 (its partial revert, 2009-05-16), but overlapping hunks are
still passed when the patch is edited.

Teach "git apply" the --allow-overlap option that disables a safety
feature that avoids misapplication of patches by not applying patches
to overlapping hunks, and pass this option form "add -p" codepath.

Do not even advertise the option, as this is merely a workaround, and the
correct fix is to make "add -p" correctly coalesce adjacent patch hunks.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c           |    9 ++++++---
 git-add--interactive.perl |    2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 04f56f8..8be1ce5 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -43,6 +43,7 @@ static int apply = 1;
 static int apply_in_reverse;
 static int apply_with_reject;
 static int apply_verbosely;
+static int allow_overlap;
 static int no_add;
 static const char *fake_ancestor;
 static int line_termination = '\n';
@@ -2430,9 +2431,9 @@ static void update_image(struct image *img,
 	memcpy(img->line + applied_pos,
 	       postimage->line,
 	       postimage->nr * sizeof(*img->line));
-	for (i = 0; i < postimage->nr; i++)
-		img->line[applied_pos + i].flag |= LINE_PATCHED;
-
+	if (!allow_overlap)
+		for (i = 0; i < postimage->nr; i++)
+			img->line[applied_pos + i].flag |= LINE_PATCHED;
 	img->nr = nr;
 }
 
@@ -3877,6 +3878,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			"don't expect at least one line of context"),
 		OPT_BOOLEAN(0, "reject", &apply_with_reject,
 			"leave the rejected hunks in corresponding *.rej files"),
+		OPT_BOOLEAN(0, "allow-overlap", &allow_overlap,
+			"allow overlapping hunks"),
 		OPT__VERBOSE(&apply_verbosely, "be verbose"),
 		OPT_BIT(0, "inaccurate-eof", &options,
 			"tolerate incorrectly detected missing new-line at the end of file",
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index fced0ce..4f08fe7 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -705,7 +705,7 @@ sub add_untracked_cmd {
 sub run_git_apply {
 	my $cmd = shift;
 	my $fh;
-	open $fh, '| git ' . $cmd . " --recount";
+	open $fh, '| git ' . $cmd . " --recount --allow-overlap";
 	print $fh @_;
 	return close $fh;
 }
-- 
1.7.5.252.g565191
