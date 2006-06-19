From: Salikh Zakirov <Salikh.Zakirov@Intel.com>
Subject: Re: [PATCH] cvsimport: ignore CVSPS_NO_BRANCH and impossible branches
Date: Mon, 19 Jun 2006 20:20:35 +0400
Message-ID: <4496CED3.7050204@Intel.com>
References: <11500135293734-git-send-email-martin@catalyst.net.nz> <7vzmgb8plx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 19 19:27:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsNXB-0008B5-Pd
	for gcvg-git@gmane.org; Mon, 19 Jun 2006 19:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWFSR1b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 13:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932534AbWFSR1a
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 13:27:30 -0400
Received: from mga03.intel.com ([143.182.124.21]:59187 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932465AbWFSR13 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jun 2006 13:27:29 -0400
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101-1.ch.intel.com with ESMTP; 19 Jun 2006 10:27:28 -0700
Received: from fmsmsx331.fm.intel.com (HELO fmsmsx331.amr.corp.intel.com) ([132.233.42.156])
  by azsmga001.ch.intel.com with ESMTP; 19 Jun 2006 09:21:10 -0700
X-IronPort-AV: i="4.06,152,1149490800"; 
   d="scan'208"; a="54288655:sNHT3899727839"
Received: from fmsmsx312.amr.corp.intel.com ([132.233.42.227]) by fmsmsx331.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 19 Jun 2006 09:20:44 -0700
Received: from mssmsx402.ccr.corp.intel.com ([10.125.2.12]) by fmsmsx312.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 19 Jun 2006 09:20:44 -0700
Received: from [10.125.151.180] ([10.125.151.180]) by mssmsx402.ccr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Mon, 19 Jun 2006 20:20:40 +0400
User-Agent: Thunderbird 1.5 (Windows/20051201)
In-Reply-To: <7vzmgb8plx.fsf@assigned-by-dhcp.cox.net>
X-OriginalArrivalTime: 19 Jun 2006 16:20:40.0767 (UTC) FILETIME=[4E8D84F0:01C693BC]
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22130>

Junio C Hamano wrote:
> Martin Langhoff <martin@catalyst.net.nz> writes:
> 
>> cvsps output often contains references to CVSPS_NO_BRANCH, commits that it
>> could not trace to a branch. Ignore that branch.
>>
>> Additionally, cvsps will sometimes draw circular relationships between
>> branches -- where two branches are recorded as opening from the other.
>> In those cases, and where the ancestor branch hasn't been seen, ignore
>> it.
> 
> This sounds more like an workaround than a real fix to me,
> although I'd apply it for now.  I see Yann is collecting cvsps
> patches but maybe there will be a real fix soonish?

#CVSPS_NO_BRANCH is the identifier that CVSPS gives to the unnamed branches.
Unnamed branches appear when the branch tag is removed or moved forcefully.
The following short script reproduces the CVS repository with unnamed branches.

In my opinion, ignoring #CVSPS_NO_BRANCH in git-cvsimport is the most sensible
thing to do, because the branch was abandoned in the CVS in the first place. 
I had to preprocess cvsps output to cut out CVSPS_NO_BRANCH commits anyway.

I vote for including the Martin's patch.

Creating CVS repository with unnamed branch
--8<--
export CVSROOT=$PWD/cvsroot
cvs init
cvs checkout .
mkdir a
cvs add a
cd a
vim a.txt
cvs add a.txt
cvs commit -m "added a.txt" a.txt
cvs tag -b br1
cvs update -r br1
echo "br1 update" >> a.txt
cvs commit -m "br1 update" a.txt
cvs update -A
echo "HEAD update" >> a.txt
cvs commit -m "HEAD update" a.txt
cvs tag -d br1
cvs tag -b br1
cvs tag -d -B br1
cvs tag -b br1
cvs update -r br1
echo "branch update, once more" >> a.txt
cvs commit -m "2nd branch update" a.txt
------

and corresponding CVSPS output is
--8<--
$ cvsps -A
WARNING: revision 1.1.2.1 of file a.txt on unnamed branch
---------------------
PatchSet 1 
Date: 2006/06/19 20:10:09
Author: sszakiro
Branch: HEAD
Tag: (none) 
Log:
added a.txt

Members: 
        a.txt:INITIAL->1.1 

---------------------
PatchSet 2 
Date: 2006/06/19 20:10:45
Author: sszakiro
Branch: #CVSPS_NO_BRANCH
Ancestor branch: HEAD
Tag: (none) 
Log:
br1 update

Members: 
        a.txt:1.1->1.1.2.1 

---------------------
PatchSet 3 
Date: 2006/06/19 20:11:18
Author: sszakiro
Branch: HEAD
Tag: (none) 
Log:
HEAD update

Members: 
        a.txt:1.1->1.2 

---------------------
PatchSet 4 
Date: 2006/06/19 20:12:07
Author: sszakiro
Branch: br1
Ancestor branch: HEAD
Tag: (none) 
Log:
2nd branch update

Members: 
        a.txt:1.2->1.2.2.1 
------
