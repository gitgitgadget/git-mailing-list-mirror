From: Kevin Brannen <kbrannen@corp.hrsmart.com>
Subject: bug in merge
Date: Mon, 4 Jun 2012 11:32:06 -0500
Message-ID: <4FCCE306.9020600@corp.hrsmart.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 04 18:32:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbaCZ-0006Qc-HI
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 18:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760928Ab2FDQcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 12:32:15 -0400
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:5259
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754055Ab2FDQcO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jun 2012 12:32:14 -0400
Received: from mail120-ch1-R.bigfish.com (10.43.68.239) by
 CH1EHSOBE018.bigfish.com (10.43.70.68) with Microsoft SMTP Server id
 14.1.225.23; Mon, 4 Jun 2012 16:31:34 +0000
Received: from mail120-ch1 (localhost [127.0.0.1])	by
 mail120-ch1-R.bigfish.com (Postfix) with ESMTP id 0693C1E02A6	for
 <git@vger.kernel.org>; Mon,  4 Jun 2012 16:31:34 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:157.56.234.117;KIP:(null);UIP:(null);IPV:NLI;H:SN2PRD0510HT002.namprd05.prod.outlook.com;RD:none;EFVD:NLI
X-SpamScore: -1
X-BigFish: PS-1(zz1418Izz1202hzzz2fh2a8h668h839hd25hf0ah)
Received-SPF: pass (mail120-ch1: domain of corp.hrsmart.com designates 157.56.234.117 as permitted sender) client-ip=157.56.234.117; envelope-from=kbrannen@corp.hrsmart.com; helo=SN2PRD0510HT002.namprd05.prod.outlook.com ;.outlook.com ;
Received: from mail120-ch1 (localhost.localdomain [127.0.0.1]) by mail120-ch1
 (MessageSwitch) id 1338827492862061_31081; Mon,  4 Jun 2012 16:31:32 +0000
 (UTC)
Received: from CH1EHSMHS016.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.248])	by mail120-ch1.bigfish.com (Postfix) with ESMTP id
 C7C99320045	for <git@vger.kernel.org>; Mon,  4 Jun 2012 16:31:32 +0000 (UTC)
Received: from SN2PRD0510HT002.namprd05.prod.outlook.com (157.56.234.117) by
 CH1EHSMHS016.bigfish.com (10.43.70.16) with Microsoft SMTP Server (TLS) id
 14.1.225.23; Mon, 4 Jun 2012 16:31:30 +0000
Received: from [192.168.168.42] (65.65.116.130) by pod51010.outlook.com
 (10.255.116.37) with Microsoft SMTP Server (TLS) id 14.16.164.5; Mon, 4 Jun
 2012 16:32:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120329 Thunderbird/11.0.1
X-Originating-IP: [65.65.116.130]
X-OriginatorOrg: corp.hrsmart.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199144>

I believe I've just found a bug in "merge", specifically in the 
"recursive" strategy. (Or really, here's another example of and 
hopefully more info on a known bug.) Oh, this is with 1.7.2.3, the 
latest I'm able to use on this machine.

Background:
Over time, code as been developed and commited to our main "dev" branch. 
So the present HEAD was formed by something like 30 commits since the 
last merge. It is not corrupt in any way that I can tell.

We also have a "production" branch, which holds what's approved for 
production. From time to time, we merge "dev" into "production". There 
is no corruption, no unchecked out files, no unmerged files, and not 
even untracked files in the work area. It was totally clean.

Bug:
When I tried to merge dev into production with "git checkout production; 
git merge dev", it would fail:

archive/cgi-bin/admin/addcompany.cgi: unmerged 
(2ea980aa213c6a0bfb0a7e33c8d3fce3af6be91e)
archive/cgi-bin/admin/admineditprofile.cgi: unmerged 
(297a3a7e3229b085061668abd8d5122b48d8d53a)
fatal: git write-tree failed to write a tree

Research:
I had to "git reset --hard" to reset production and try again. After 
googling for this and a few tests, I found that "git merge -s resolve 
dev" was able to successfully merge the code. In looking at the output, 
I think it gives me a clue as to what was failing with the recursive 
strategy.

Trying really trivial in-index merge...
error: Merge requires file-level merging
Nope.
Trying simple merge.
Simple merge failed, trying Automatic merge.
Adding archive/cgi-bin/admin/addcompany.cgi
Adding archive/cgi-bin/admin/admineditprofile.cgi
Merge made by resolve.
  .gitignore                                         |    4 +-
  archive/cgi-bin/{admin => admin/addcompany.cgi}    |    0
...
  rename archive/cgi-bin/{admin => admin/addcompany.cgi} (100%)
  rename {cgi-bin => archive/cgi-bin}/admin/admineditprofile.cgi (100%)

Knowing what happened to the files, I think that I ended up with a 
change tree that recursive just couldn't handle. To the best of my 
knowledge, the changes that happened over time and over multiple 
commits  on dev went something like (each of these being in a different 
commit):

git mv fileA dirX
git mv dirA dirX/fileA
git mv fileB dirX/fileB

So I think the problem is just too many renames/moves of the same object 
and when "recursive" descends the tree, it just can't handle that 
correctly -- or that's my guess. :)

HTH,
Kevin
