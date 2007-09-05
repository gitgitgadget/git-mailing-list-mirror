From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Invoke "git gc --auto" from "git add" and "git fetch"
Date: Wed, 05 Sep 2007 13:37:30 -0700
Message-ID: <7vhcm8j1bp.fsf_-_@gitster.siamese.dyndns.org>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
	<20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>
	<46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix>
	<alpine.LFD.0.9999.0709051438460.21186@xanadu.home>
	<7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nix <nix@esperi.org.uk>, Steven Grimm <koreth@midwinter.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Sep 05 22:37:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT1d9-000149-Od
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 22:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755232AbXIEUhj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 16:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755958AbXIEUhj
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 16:37:39 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:39915 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755086AbXIEUhi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 16:37:38 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 4063512F182;
	Wed,  5 Sep 2007 16:37:54 -0400 (EDT)
In-Reply-To: <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 05 Sep 2007 13:01:37 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57760>

This makes the two commands to call "git gc --auto" when they
are done.

I earlier said that obvious candidates also include merge and
rebase, but these are lot less frequent operations compared to
add, and more importantly, in a normal workflow they would
almost always happen after "git fetch" is done.

In other words, if you are downstream developer, the automatic
invocation in "git fetch" will take care of things for you, and
otherwise if you do not have an upstream, you would be doing
your own development, so "git add" to add your changes will take
care of the auto invocation for you.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This is obviously a follow-up to the previous one that allows
   you to say "git gc --auto".  I somewhat feel dirty about
   calling cmd_gc() bypassing fork & exec from "git add",
   though...

 builtin-add.c |    2 ++
 git-fetch.sh  |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 105a9f0..8431c16 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -263,9 +263,11 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
  finish:
 	if (active_cache_changed) {
+		const char *args[] = { "gc", "--auto", NULL };
 		if (write_cache(newfd, active_cache, active_nr) ||
 		    close(newfd) || commit_locked_index(&lock_file))
 			die("Unable to write new index file");
+		cmd_gc(2, args, NULL);
 	}
 
 	return 0;
diff --git a/git-fetch.sh b/git-fetch.sh
index c3a2001..86050eb 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -375,3 +375,4 @@ case "$orig_head" in
 	fi
 	;;
 esac
+git gc --auto
-- 
1.5.3.1.840.g0fedbc
