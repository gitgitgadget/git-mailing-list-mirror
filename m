From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git clone error
Date: Sat, 05 Apr 2008 13:09:05 -0700
Message-ID: <7vabk8vzby.fsf@gitster.siamese.dyndns.org>
References: <a00d3c7f0804051020u366e978ei7252c904c48461f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Chuck Ritter" <cfr100@psu.edu>
X-From: git-owner@vger.kernel.org Sat Apr 05 22:10:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiEi7-0003Ag-N7
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 22:10:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753452AbYDEUJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2008 16:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752864AbYDEUJN
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 16:09:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40443 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265AbYDEUJM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2008 16:09:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 439849771;
	Sat,  5 Apr 2008 16:09:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 789FA976D; Sat,  5 Apr 2008 16:09:08 -0400 (EDT)
In-Reply-To: <a00d3c7f0804051020u366e978ei7252c904c48461f6@mail.gmail.com>
 (Chuck Ritter's message of "Sat, 5 Apr 2008 13:20:25 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78862>

"Chuck Ritter" <cfr100@psu.edu> writes:

> $ git clone ~dab143/src/OVER-REL/SOURCE-GIT-TEST OVER-REL
> Initialized empty Git repository in /home/cfr100/OVER-REL/.git/
> cpio: objects/pack/pack-80a0460fc07be5e0628b02549fdaa186b792d3f3.keep:
> Permission denied
> 888 blocks
>
> # cat pack-80a0460fc07be5e0628b02549fdaa186b792d3f3.keep
> fetch-pack 31620 on githost.arl.psu.edu
>
> Permission on the keep file are 600. Of course this looks like a stale
> lock of some sort.

The original repository you are cloning from is owned by somebody else,
and a file in it is not readable by you.  Bad.

No, .keep is not a stale lock.  It is active and valid --- do not
remove it --- it prevents the corresponding pack from being subject to
repacking.

The bug is that index-pack.c::final() tries to make the resulting pack and
idx readable with chmod(0444), but it forgets to make .keep readable.

To unblock you, you would need to ask the user "dab143" to make the
repository readable by you; the damage has already been done.  There may
be files other than that .keep file that is unreadable.

The following patch would prevent the breakage the repository you are
trying to clone from is suffering from happening again.

---

 index-pack.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/index-pack.c b/index-pack.c
index 9c0c278..9dc3cfd 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -720,6 +720,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 				die("cannot write keep file");
 			report = "keep";
 		}
+		chmod(keep_name, 0444);
 	}
 
 	if (final_pack_name != curr_pack_name) {
