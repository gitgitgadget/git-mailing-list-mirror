From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 31/31] rebase -i: remove unnecessary state rebase-root
Date: Tue, 28 Dec 2010 10:30:48 +0100
Message-ID: <1293528648-21873-32-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 16:34:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXbYq-0005Wr-Qn
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 16:34:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753991Ab0L1PdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 10:33:21 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:60539 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753909Ab0L1PdR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 10:33:17 -0500
Received: by mail-qw0-f46.google.com with SMTP id 26so9392227qwa.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 07:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=3LTjCZF0lP6QoPTEHkQTGh4oKp6xSFqIkpVRimgeMK8=;
        b=P+djzMULh8xVwJmwc/mhEd9KIJebYZ4oyHnvgVLQjgLq0vI+fIw7bvTkpCvkSY5zeN
         XWP2TEkJgN8nwrHMiw0nTsGYcNaSeNi7FZMSirfQMNAQys9V12xj4bEwhG7klFK2KO4p
         PGsLMv5bsQBtYmMjmBk8eSxrlS9/YfAGfcc5A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OXfIOyqWi08VfeHtgJ5HgroFpTbHPPk5+7n+zZwgKeH8367SKCv6iBPk8piTyBCH7+
         8b71+jH6hxwJ8dZqAkfZ/6BfbQr/UakeSPs4OLelqE5bn77m+6Ey206uhMZs2ZYCpDlx
         hklRpq1ZsQvNGz1pH3Aprd6AEGli4k6Ir7RfU=
Received: by 10.229.217.196 with SMTP id hn4mr12062678qcb.180.1293550397463;
        Tue, 28 Dec 2010 07:33:17 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s10sm6222962qco.35.2010.12.28.07.33.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 07:33:16 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164270>

Before calling 'git cherry-pick', interactive rebase currently checks
if we are rebasing from root (if --root was passed). If we are, the
'--ff' flag to 'git cherry-pick' is omitted. However, according to the
documentation for 'git cherry-pick --ff', "If the current HEAD is the
same as the parent of the cherry-picked commit, then a fast forward to
this commit will be performed.". This should never be the case when
rebasing from root, so it should not matter whether --ff is passed, so
simplify the code by removing the condition.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---

While factoring out the state writing code a few patches back, I went
through each of the pieces of state that was written. I was a bit
hesitant to include this patch since I'm not quite sure why the code
was introduced, but I thought I would include it anyway to hear what
you have to say.

There used to be bug when using --ff when rebasing a root commit. This
was fixed in 6355e50 (builtin/revert.c: don't dereference a NULL
pointer, 2010-09-27). Could this have been the reason for the check?
Thomas, do you remember?

 git-rebase--interactive.sh |   15 ---------------
 1 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index d20a9b2..a9f44d8 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -168,11 +168,6 @@ pick_one () {
 	output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
 	test -d "$REWRITTEN" &&
 		pick_one_preserving_merges "$@" && return
-	if test -n "$rebase_root"
-	then
-		output git cherry-pick "$@"
-		return
-	fi
 	output git cherry-pick $ff "$@"
 }
 
@@ -582,10 +577,6 @@ skip_unnecessary_picks () {
 	die "Could not skip unnecessary pick commands"
 }
 
-get_saved_options () {
-	test -f "$state_dir"/rebase-root && rebase_root=t
-}
-
 # Rearrange the todo list that has both "pick sha1 msg" and
 # "pick sha1 fixup!/squash! msg" appears in it so that the latter
 # comes immediately after the former, and change "pick" to
@@ -701,12 +692,6 @@ mkdir "$state_dir" || die "Could not create temporary $state_dir"
 
 : > "$state_dir"/interactive || die "Could not mark as interactive"
 write_basic_state
-case "$rebase_root" in
-'')
-	rm -f "$state_dir"/rebase-root ;;
-*)
-	: >"$state_dir"/rebase-root ;;
-esac
 if test t = "$preserve_merges"
 then
 	if test -z "$rebase_root"
-- 
1.7.3.2.864.gbbb96
