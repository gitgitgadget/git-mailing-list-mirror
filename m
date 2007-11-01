From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't use cpio in git-clone when not installed
Date: Thu, 01 Nov 2007 14:06:36 -0700
Message-ID: <7vlk9had5v.fsf@gitster.siamese.dyndns.org>
References: <1193861145-20357-1-git-send-email-mh@glandium.org>
	<fcaeb9bf0710311809o41703bc5hda36a9d44a538eeb@mail.gmail.com>
	<7vejfag40g.fsf@gitster.siamese.dyndns.org>
	<20071101105318.GA4744@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Nov 01 22:07:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InhFk-0002oh-7j
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 22:07:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754070AbXKAVGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 17:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753632AbXKAVGn
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 17:06:43 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:46163 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753500AbXKAVGn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 17:06:43 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 9B7D82FB;
	Thu,  1 Nov 2007 17:07:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 0819D91224;
	Thu,  1 Nov 2007 17:06:59 -0400 (EDT)
In-Reply-To: <20071101105318.GA4744@glandium.org> (Mike Hommey's message of
	"Thu, 1 Nov 2007 11:53:18 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63002>

Mike Hommey <mh@glandium.org> writes:

> On Wed, Oct 31, 2007 at 06:15:27PM -0700, Junio C Hamano wrote:
>> "Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:
>> 
>> > BTW, you have workaround for git-merge also? It uses cpio to save/restore state.
>> 
>> Why do people want "workaround"?  Is installing cpio such a
>> hassle?
>
> Note that to do what git-merge does with cpio, i wonder if it wouldn't
> be sensible to use git stash, now.

Like this?  That's an excellent suggestion.

The patch uses the 'git stash create' which is in 'next'
(jc/stash-create topic).

Having said that, the savestate()/restorestate() codepaths are
only relevant to the "try multiple strategies and pick the best
one" feature of git-merge, and that is where cpio is used (and
the patch rewrites it to use stash).  I am not sure if anybody
ever used it in practice.  I admit I am guilty of inventing it,
but I certainly do not.

It might make sense to remove that try-multiple-strategies
feature from git-merge and be done with it.  It would certainly
make the eventual rewrite to C much easier.

---
 git-merge.sh |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index 3a01db0..e8916cc 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -28,20 +28,19 @@ allow_trivial_merge=t
 
 dropsave() {
 	rm -f -- "$GIT_DIR/MERGE_HEAD" "$GIT_DIR/MERGE_MSG" \
-		 "$GIT_DIR/MERGE_SAVE" || exit 1
+		 "$GIT_DIR/MERGE_STASH" || exit 1
 }
 
 savestate() {
 	# Stash away any local modifications.
-	git diff-index -z --name-only $head |
-	cpio -0 -o >"$GIT_DIR/MERGE_SAVE"
+	git stash create >"$GIT_DIR/MERGE_STASH"
 }
 
 restorestate() {
-        if test -f "$GIT_DIR/MERGE_SAVE"
+        if test -f "$GIT_DIR/MERGE_STASH"
 	then
 		git reset --hard $head >/dev/null
-		cpio -iuv <"$GIT_DIR/MERGE_SAVE"
+		git stash apply --index $(cat "$GIT_DIR/MERGE_STASH")
 		git update-index --refresh >/dev/null
 	fi
 }
@@ -386,7 +385,7 @@ case "$use_strategies" in
     single_strategy=no
     ;;
 *)
-    rm -f "$GIT_DIR/MERGE_SAVE"
+    rm -f "$GIT_DIR/MERGE_STASH"
     single_strategy=yes
     ;;
 esac
