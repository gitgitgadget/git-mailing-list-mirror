From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH v4 1/2] push: Don't push a repository with unpushed
 submodules
Date: Mon, 22 Aug 2011 21:47:29 +0200
Message-ID: <20110822194728.GA11745@sandbox-rc>
References: <1313791728-11328-1-git-send-email-iveqy@iveqy.com>
 <1313791728-11328-2-git-send-email-iveqy@iveqy.com>
 <7vwre9yodc.fsf@alter.siamese.dyndns.org>
 <7vippszj70.fsf@alter.siamese.dyndns.org>
 <7vmxf3xnsf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	jens.lehmann@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 22 21:47:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvaTB-0004WD-W1
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 21:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267Ab1HVTrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 15:47:33 -0400
Received: from darksea.de ([83.133.111.250]:35848 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753108Ab1HVTrc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 15:47:32 -0400
Received: (qmail 31557 invoked from network); 22 Aug 2011 21:47:29 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 22 Aug 2011 21:47:29 +0200
Content-Disposition: inline
In-Reply-To: <7vmxf3xnsf.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179883>

Hi,

On Sat, Aug 20, 2011 at 11:48:48PM -0700, Junio C Hamano wrote:
> After removing the change to combine-diff.c from your two-patch series, I
> applied them on top of this one, and queued the result in 'pu'.
> 
> While I tried to be careful while doing this callback-for-combine-diff
> patch so that a callback function written for two-way diff can be used
> without any change as long as it does not care about the LHS (i.e. "one")
> of the filepair, please double check. I didn't read your change to
> submodule.c very carefully (and I didn't have to change it).
> 
> The result seems to pass your new tests ;-).

Very nice. Today I had a deeper look into the current tests for
on-demand and found a bug in them. Cleaning them up also revealed a bug
in the current code. Junio could you please squash this[1] in the last
patch (on-demand option).

I analysed the cause of this bug and it seems that we are not allowed to
iterate revisions using init_revisions() and setup_revisions() more
than once. I tracked this down to the SEEN flag in the struct object.
Junio since you are one person listed in the api docs could you maybe
quickly explain to me what this flag is used for?

I quickly tried to implement a reset_revision_walk function which will
reset this flag but it seems that this breaks some expectations in the
code since I got a segfault.

Cheers Heiko

[1]

diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index 35820ec..b0e94f7 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -124,6 +124,10 @@ test_expect_success 'push unpushed submodules' '
 		cd work &&
 		git checkout master &&
 		git push --recurse-submodules=on-demand ../pub.git master
+		cd gar/bage &&
+		git rev-parse master >expected &&
+		git rev-parse origin/master >actual &&
+		test_cmp expected actual
 	)
 '
 
@@ -132,10 +136,14 @@ test_expect_success 'push unpushed submodules when not needed' '
 		cd work &&
 		(
 			cd gar/bage &&
-			>junk4 &&
-			git add junk4 &&
-			git commit -m "junk4" &&
-			git push
+			git checkout master &&
+			>junk5 &&
+			git add junk5 &&
+			git commit -m "junk5" &&
+			git push &&
+			git rev-parse master >expected &&
+			git rev-parse origin/master >actual &&
+			test_cmp expected actual
 		) &&
 		git add gar/bage &&
 		git commit -m "updated submodule" &&
@@ -143,4 +151,20 @@ test_expect_success 'push unpushed submodules when not needed' '
 	)
 '
 
+test_expect_failure 'push unpushed submodules on-demand fails when submodule not pushable' '
+	(
+		cd work &&
+		(
+			cd gar/bage &&
+			git checkout HEAD~0 &&
+			>junk6 &&
+			git add junk6 &&
+			git commit -m "junk6"
+		) &&
+		git add gar/bage &&
+		git commit -m "updated submodule" &&
+		test_must_fail git push --recurse-submodules=on-demand ../pub.git master
+	)
+'
+
 test_done
-- 
1.7.6.46.g0f058
