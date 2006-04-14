From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Solaris test t5500 race condition
Date: Fri, 14 Apr 2006 05:17:59 +0200
Message-ID: <20060414031759.GA9524@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Apr 14 05:18:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUEp0-0003sR-BI
	for gcvg-git@gmane.org; Fri, 14 Apr 2006 05:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965073AbWDNDSD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Apr 2006 23:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWDNDSC
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Apr 2006 23:18:02 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:37867 "HELO bohr.gbar.dtu.dk")
	by vger.kernel.org with SMTP id S1751223AbWDNDSB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Apr 2006 23:18:01 -0400
Received: (qmail 8027 invoked by uid 5842); 14 Apr 2006 05:17:59 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18682>

Hello,

I've found a race in t5500-fetch-pack.sh.  The problem is the way the
number of unpacked objects are counted:

    pack_count=$(grep Unpacking log.txt|tr -dc "0-9")

It just concatenates all the digits on the line with "Unpacking" in it. 
This is the output I get on Solaris:

    Generating pack...
    Done counting 3 objects.
    Deltifying 3 objects.
      33% (1/3) done^M  66% (2/3) done^M 100% (3/3) done
    Total 3Unpacking , written 33 objects          <------------
     (delta 0), reused 0 (delta 0)
    11fa2f0cb58ed7f02dbd5ac75ed82a53fae62a7b refs/heads/A

The marked line is written as a joyful duet between these
two functions:

    unpack-objects.c:   fprintf(stderr, "Unpacking %d objects\n",
                                nr_objects);

    pack-objects.c:     fprintf(stderr, "Total %d, written %d 
                                (delta %d), reused %d (delta %d)\n",

I can't think of a good solution right now.

Regards,

Peter
