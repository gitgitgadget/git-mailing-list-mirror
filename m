From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: rebase -i might leave =?UTF-8?Q?CHERRY=5FPICK=5FHEAD=20behind?=
Date: Tue, 16 Jun 2015 16:56:43 +0200
Organization: gmx
Message-ID: <a1b485b913b374a1cf7f1bcd1e77532f@www.dscho.org>
References: <20150616140612.Horde.a1irZQmh2o42SqDfxAytHg1@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Jun 16 16:57:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4sIK-00009O-4F
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 16:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756745AbbFPO4w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Jun 2015 10:56:52 -0400
Received: from mout.gmx.net ([212.227.15.18]:54757 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756723AbbFPO4r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 10:56:47 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MAPoQ-1ZGNny0pDu-00BbFT; Tue, 16 Jun 2015 16:56:44
 +0200
In-Reply-To: <20150616140612.Horde.a1irZQmh2o42SqDfxAytHg1@webmail.informatik.kit.edu>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:ripc4zLOT+YXPpP5MQl4m/+tQBjKkjvMU0UsSpKkOYWz1SulK4S
 C9KtTWaTOxabYk0xoRDkgff96g6Atk2D/nGNqK1lwzqXYbB6ZyXc8L4M0xq27izDNn0YGQC
 CpLSFmsrhXMLOEbjfA0ihN9upzzDuhnTsDP/S8dNrSa2Jxuq1KmTRODVRA29YW4ZWfDv3yo
 Kpfp9FlHwY1fjSgtFpzEQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271767>

Hi,

On 2015-06-16 14:06, SZEDER G=C3=A1bor wrote:

> When skipping an empty commit with 'git rebase --continue' a
> CHERRY_PICK_HEAD file might be left behind.

Yeah, I noticed that, too... it even survives the cleanup of the finish=
ed rebase under certain circumstances.

Maybe something like this?

-- snipsnap --
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index dc3133f..16e0a82 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -849,7 +849,11 @@ continue)
 	# do we have anything to commit?
 	if git diff-index --cached --quiet HEAD --
 	then
-		: Nothing to commit -- skip this
+		: Nothing to commit -- skip this commit
+
+		test ! -f "$GIT_DIR"/CHERRY_PICK_HEAD ||
+		rm "$GIT_DIR"/CHERRY_PICK_HEAD ||
+		die "Could not remove CHERRY_PICK_HEAD"
 	else
 		if ! test -f "$author_script"
 		then
