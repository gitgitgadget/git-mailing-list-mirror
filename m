From: Joe Perches <joe@perches.com>
Subject: git blame vs git log --follow performance
Date: Sun, 26 Jan 2014 13:10:52 -0800
Message-ID: <1390770652.20150.25.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Ian Campbell <Ian.Campbell@citrix.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 26 22:18:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7X61-0007AP-2A
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jan 2014 22:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753058AbaAZVSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jan 2014 16:18:21 -0500
Received: from smtprelay0209.hostedemail.com ([216.40.44.209]:54047 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752397AbaAZVSU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jan 2014 16:18:20 -0500
X-Greylist: delayed 446 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Jan 2014 16:18:20 EST
Received: from smtprelay.hostedemail.com (ff-bigip1 [10.5.19.254])
	by smtpgrave05.hostedemail.com (Postfix) with ESMTP id E93C4184B5D
	for <git@vger.kernel.org>; Sun, 26 Jan 2014 21:11:03 +0000 (UTC)
Received: from filter.hostedemail.com (ff-bigip1 [10.5.19.254])
	by smtprelay01.hostedemail.com (Postfix) with ESMTP id 6585323622;
	Sun, 26 Jan 2014 21:10:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::,RULES_HIT:41:355:379:541:960:973:988:989:1260:1261:1277:1311:1313:1314:1345:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3653:3865:3866:3867:3868:3870:3871:3872:3874:5007:6119:7652:7875:7901:10004:10400:10848:11658:11914:12043:12517:12519:13069:13071:13161:13229:13311:13357:21060,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:none,Custom_rules:0:0:0
X-HE-Tag: turn70_5ef0caa9e4058
X-Filterd-Recvd-Size: 1652
Received: from [192.168.1.157] (pool-96-251-49-11.lsanca.fios.verizon.net [96.251.49.11])
	(Authenticated sender: joe@perches.com)
	by omf07.hostedemail.com (Postfix) with ESMTPA;
	Sun, 26 Jan 2014 21:10:52 +0000 (UTC)
X-Mailer: Evolution 3.8.4-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241117>

Hi.

Is there something that can be done about improving
git log --follow -- <file> performance to be nearly
equivalent speed to git blame -- <file> ?

The overall cpu time taken for these 2 commands that
track individual file history can be quite different.

	git log --follow -- <file>
and
	git blame -- <file>

It seems that there can be a couple orders of magnitude
delta in the overall time taken.

For instance (using the Linus' linux kernel git):

$ time git log --follow -- drivers/firmware/google/Kconfig > /dev/null

real	0m42.329s
user	0m40.984s
sys	0m0.792s

$ time git blame -- drivers/firmware/google/Kconfig > /dev/null

real	0m0.963s
user	0m0.860s
sys	0m0.096s

This particular file has never been renamed.

Looking at the output on screen, there does seem to
be 25+ seconds of cpu time consumed after the initial
(last shown) commit that introduces this file.

Perhaps adding a whole-file rename option to the
"git log" history simplification mechanism could
help?

Thoughts?
