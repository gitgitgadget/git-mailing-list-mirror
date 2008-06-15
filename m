From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Bug with approxidate("never")?
Date: Mon, 16 Jun 2008 01:20:44 +0200
Message-ID: <4855A3CC.2090701@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 16 01:21:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K81Wv-0003DN-Hz
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 01:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbYFOXUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 19:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751644AbYFOXUH
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 19:20:07 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:36780 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751393AbYFOXUG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 19:20:06 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 8A45512B6BD;
	Mon, 16 Jun 2008 01:20:04 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 426DB12B6B8;
	Mon, 16 Jun 2008 01:20:04 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85152>

Hi,

While I was playing in the stash area and with "reflog expire" I was
surprised by the fact that "never" is not always never. For example,
approxidate("never") returns 4294960096 for my timezone (CET-2), it
loops with all negative timezones.

I fixed it by replacing date_never() with this one:

static void date_never(struct tm *tm, int *num)
{
        time_t n = 0;
        localtime_r(&n, tm);
}

but I not sure this is the right fix. Better idea?

If you want to try yourself, the following test case should trigger
the problem.

diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 73f830d..b07d7bd 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -158,6 +158,17 @@ test_expect_success 'reflog expire' '
        check_fsck "dangling commit $K"
 '
 
+test_expect_success 'reflog expire --expire=never' '
+
+       TZ=CET-2 &&
+       git reflog expire --expire=never \
+               --stale-fix \
+               --all &&
+
+       loglen=$(wc -l <.git/logs/refs/heads/master) &&
+       test $loglen = 2
+'
+
 test_expect_success 'prune and fsck' '
 
        git prune &&
