From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH/RFC] Fix for default pager
Date: Tue, 08 Jun 2010 16:17:39 +0200
Message-ID: <4C0E5103.7030501@viscovery.net>
References: <1275955088-32750-1-git-send-email-soft.d4rio@gmail.com>	<1275955270-sup-2380@pinkfloyd.chass.utoronto.ca>	<AANLkTinydWk3GqGDww8FS7pmW16jAVazRkmT_GsRMIhy@mail.gmail.com>	<20100608053507.GB15156@coredump.intra.peff.net> <AANLkTilvvpy4TBQF6g8boQL87FRB7kFDrVfYiHvOv6xu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Ben Walton <bwalton@artsci.utoronto.ca>,
	git <git@vger.kernel.org>
To: Dario Rodriguez <soft.d4rio@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 08 16:17:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLzci-0006X9-Mx
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 16:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755337Ab0FHORo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 10:17:44 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:48340 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755170Ab0FHORn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 10:17:43 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OLzca-0000ke-Dt; Tue, 08 Jun 2010 16:17:40 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 28ACB1660F;
	Tue,  8 Jun 2010 16:17:40 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <AANLkTilvvpy4TBQF6g8boQL87FRB7kFDrVfYiHvOv6xu@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148677>

Am 6/8/2010 15:49, schrieb Dario Rodriguez:
> we must correct
> something... the other way is that if pager fails to execute, we
> cannot simply return 0.

But we do not return 0:

 $ GIT_PAGER=/is/not/there git log
 $ echo $?
 141

That's SIGPIPE, just as I would expect.

And with this change

diff --git a/pager.c b/pager.c
index dac358f..86519cc 100644
--- a/pager.c
+++ b/pager.c
@@ -89,9 +89,6 @@ void setup_pager(void)
 		static const char *env[] = { "LESS=FRSX", NULL };
 		pager_process.env = env;
 	}
-#ifndef WIN32
-	pager_process.preexec_cb = pager_preexec;
-#endif
 	if (start_command(&pager_process))
 	return;


I get:

 $ GIT_PAGER=/is/not/there ./git log -1 --oneline
 error: cannot run /is/not/there: No such file or directory
 1a16cee merge-recursive: demonstrate an incorrect conflict with submodule

-- Hannes
