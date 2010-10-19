From: David Michael Barr <david.barr@cordelta.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial git-svn fetch)
Date: Wed, 20 Oct 2010 01:28:03 +1100
Message-ID: <126B270C-AEB2-4632-A2CD-E8F2AAE20A62@cordelta.com>
References: <6831849.526935.1287495195964.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Matt Stump <mstump@goatyak.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 16:28:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8DAm-00025A-6H
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 16:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112Ab0JSO2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 10:28:09 -0400
Received: from ironport1-mx.cbr1.mail-filtering.com.au ([203.88.115.241]:24396
	"EHLO ironport1-mx.cbr1.mail-filtering.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751845Ab0JSO2I convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 10:28:08 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EABVIvUzLWHsF/2dsb2JhbAChXwhxthSIT4VKBA
X-IronPort-AV: E=Sophos;i="4.57,350,1283695200"; 
   d="scan'208";a="262499287"
Received: from node2.alpha.aussiehq.net.au ([203.88.123.5])
  by ironport1-mta.cbr1.mail-filtering.com.au with ESMTP; 20 Oct 2010 01:28:04 +1100
Received: (qmail 26610 invoked from network); 20 Oct 2010 01:28:04 +1100
Received: from d110-33-95-167.mit3.act.optusnet.com.au (HELO ?192.168.1.1?) (110.33.95.167)
  by 203.88.123.185 with SMTP; 20 Oct 2010 01:28:04 +1100
In-Reply-To: <6831849.526935.1287495195964.JavaMail.root@mail.hq.genarts.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159331>

Hi,

> Oh, from that point of view the svn mirror is a bystander.  I was developing these tools at the same time as svnrdump (or at least prior to a stable version of svnrdump).  So when I found that running "svnadmin dump | svn-fe | git fast-import" on the server was taxing the system, I decided it was better to create a dump file, copy it to my local machine, and run svn-fe and fast-import locally.  Once I had the dump file, the local mirror sped up the SVN::Ra calls in buildSVNTree, and made any "did that really happen in svn?!" questions a little easier to answer.

So, I think there's two valuable nuggets per commit omitted at the moment in svn-fe.
Firstly, the longest common root between all paths in the commit, which can be computed efficiently.
Secondly, the copyfrom_rev and copyfrom_path for the copy operation that targets the common root.
The second nugget can be noted while computing the first.
From my reading of buildSVNTree.pl, these two nuggets drive the mapping logic.

The first nugget can be computed in git-land fairly easily.
The second requires information not embedded in the git commit graph.

I suggest that svn-fe be extended to annotate the commits with this information.
Implementation-wise, the revision context should be extended to include:
* longest common path
* source revision of copy operation targeting longest common path
* source path of copy operation targeting longest common path
