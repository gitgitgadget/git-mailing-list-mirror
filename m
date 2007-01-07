From: "H. Peter Anvin" <hpa@zytor.com>
Subject: How git affects kernel.org performance
Date: Sat, 06 Jan 2007 21:24:02 -0800
Message-ID: <45A083F2.5000000@zytor.com>
References: <20061214223718.GA3816@elf.ucw.cz>	 <20061216094421.416a271e.randy.dunlap@oracle.com>	 <20061216095702.3e6f1d1f.akpm@osdl.org>  <458434B0.4090506@oracle.com>	 <1166297434.26330.34.camel@localhost.localdomain>	 <1166304080.13548.8.camel@nigel.suspend2.net>  <459152B1.9040106@zytor.com> <1168140954.2153.1.camel@nigel.suspend2.net> <45A08269.4050504@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: nigel@nigel.suspend2.net, "J.H." <warthog9@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	webmaster@kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 06:24:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3QWC-0007KL-ND
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 06:24:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbXAGFYX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 00:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbXAGFYX
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 00:24:23 -0500
Received: from terminus.zytor.com ([192.83.249.54]:52222 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932400AbXAGFYW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 00:24:22 -0500
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id l075O2Dd026494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 6 Jan 2007 21:24:03 -0800
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
To: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
In-Reply-To: <45A08269.4050504@zytor.com>
X-Virus-Scanned: ClamAV 0.88.7/2417/Sat Jan  6 15:06:17 2007 on terminus.zytor.com
X-Virus-Status: Clean
X-Spam-Status: No, score=1.0 required=5.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_24_48,RCVD_IN_SORBS_DUL autolearn=no version=3.1.7
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.1.7 (2006-10-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36126>

Some more data on how git affects kernel.org...

During extremely high load, it appears that what slows kernel.org down 
more than anything else is the time that each individual getdents() call 
takes.  When I've looked this I've observed times from 200 ms to almost 
2 seconds!  Since an unpacked *OR* unpruned git tree adds 256 
directories to a cleanly packed tree, you can do the math yourself.

I have tried reducing vm.vfs_cache_pressure down to 1 on the kernel.org 
machines in order to improve the situation, but even at that point it 
appears the kernel doesn't readily hold the entire directory hierarchy 
in memory, even though there is space to do so.  I have suggested that 
we might want to add a sysctl to change the denominator from the default 
100.

The one thing that we need done locally is to have a smart uploader, 
instead of relying on rsync.  That, unfortunately, is a fairly sizable 
project.

	-hpa
