From: Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com>
Subject: [PATCH] grep: Fix race condition in delta_base_cache
Date: Tue, 30 Aug 2011 15:45:38 +0200
Message-ID: <4E5CE982.7080200@morey-chaisemartin.com>
Reply-To: devel-git@morey-chaisemartin.com
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060100070806040400020700"
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 31 00:01:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyWNa-0002bk-Sv
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 00:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070Ab1H3WBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 18:01:53 -0400
Received: from 18.mo1.mail-out.ovh.net ([46.105.35.72]:45273 "EHLO
	mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751854Ab1H3WBx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 18:01:53 -0400
X-Greylist: delayed 25195 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Aug 2011 18:01:52 EDT
Received: from mail194.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with SMTP id 1F1F61008736
	for <git@vger.kernel.org>; Tue, 30 Aug 2011 15:45:54 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 30 Aug 2011 15:45:41 +0200
Received: from mailhost.kalray.eu (HELO sat.lin.mbt.kalray.eu) (devel-git@morey-chaisemartin.com@217.108.237.233)
  by ns0.ovh.net with SMTP; 30 Aug 2011 15:45:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110707 Thunderbird/5.0
X-Ovh-Mailout: 178.32.228.1 (mo1.mail-out.ovh.net)
X-Ovh-Tracer-Id: 16826292634427449304
X-Ovh-Remote: 217.108.237.233 (mailhost.kalray.eu)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -30
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeftddrtdeiucetggdotefuucfrrhhofhhilhgvmecuqfggjfenuceurghilhhouhhtmecufedttdenuchthhgvuchprhhosghlvghmucdlqdeftddm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180446>

This is a multi-part message in MIME format.
--------------060100070806040400020700
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


When running large git grep (ie: git grep regexp $(git rev-list --all)), glibc error sometimes occur:
*** glibc detected *** git: double free or corruption (!prev): 0x00000000010abdf0 ***

According to gdb the problem originate from release_delta_cash (sha1_file.c:1703)
		free(ent->data);

>From my analysis it seems that git grep threads do acquire lock before calling read_sha1_file but not before calling
read_object_with_reference who ends up calling read_sha1_file too.

Adding the lock around read_object_with_reference seems to fix the issue for me.
I've ran git grep about a dozen time and seen no more error while
it usually happened half the time before.

Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
---
 builtin/grep.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)



--------------060100070806040400020700
Content-Type: text/x-patch;
 name="0001-grep-Fix-race-condition-in-delta_base_cache.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-grep-Fix-race-condition-in-delta_base_cache.patch"

diff --git a/builtin/grep.c b/builtin/grep.c
index 1c359c2..56398d5 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -598,8 +598,10 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 		struct strbuf base;
 		int hit, len;
 
+		read_sha1_lock();
 		data = read_object_with_reference(obj->sha1, tree_type,
 						  &size, NULL);
+		read_sha1_unlock();
 		if (!data)
 			die(_("unable to read tree (%s)"), sha1_to_hex(obj->sha1));
 


--------------060100070806040400020700--
