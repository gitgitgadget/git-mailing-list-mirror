From: "Phil Hord (hordp)" <hordp@cisco.com>
Subject: Checkout --force without complete overwrite?
Date: Fri, 6 Mar 2015 02:39:58 +0000
Message-ID: <D289021BF8782144A9BEB8ED592B380D2B106BA9@xmb-aln-x02.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 06 03:49:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTiKS-0003H9-3J
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 03:49:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176AbbCFCt1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 21:49:27 -0500
Received: from rcdn-iport-4.cisco.com ([173.37.86.75]:28576 "EHLO
	rcdn-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599AbbCFCtZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2015 21:49:25 -0500
X-Greylist: delayed 566 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Mar 2015 21:49:25 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2140; q=dns/txt; s=iport;
  t=1425610167; x=1426819767;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=EVl91aJttT4TVewd15IroDrA0J1IE/yjq++MG3Yeezc=;
  b=CXq7Jqtd1ifQsOTznnrW0jOehbBS8afktbekcaCOu9+QXEfVcvPg3Cd8
   drWQMnMX3GJctta+Ebb38vmrmzi1v0VZo7UFAJP7fR2Y8QGp+cvK+K8vm
   AuRy63+YAcW42AgXPRtMvGMP+dcNRcD1EACYb4a0tujZAV+K5LcYwRUl0
   Q=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A0AJBQDhEvlU/4QNJK1cgwaBMMczAoE9TQEBAQEBAXyEEQEEOlEBKhRCJgEEG4gnqUuqKQEBAQEGAQEBAR6PVINPgRQFkAeKZ4MmglSJGYNCI4NugjN/AQEB
X-IronPort-AV: E=Sophos;i="5.11,350,1422921600"; 
   d="scan'208";a="401410082"
Received: from alln-core-10.cisco.com ([173.36.13.132])
  by rcdn-iport-4.cisco.com with ESMTP; 06 Mar 2015 02:40:00 +0000
Received: from xhc-aln-x11.cisco.com (xhc-aln-x11.cisco.com [173.36.12.85])
	by alln-core-10.cisco.com (8.14.5/8.14.5) with ESMTP id t262dwrg028031
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Fri, 6 Mar 2015 02:39:58 GMT
Received: from xmb-aln-x02.cisco.com ([169.254.5.138]) by
 xhc-aln-x11.cisco.com ([173.36.12.85]) with mapi id 14.03.0195.001; Thu, 5
 Mar 2015 20:39:58 -0600
Thread-Topic: Checkout --force without complete overwrite?
Thread-Index: AdBXtMlTz0sCpojGR2Win/fUsVe3dQ==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.169.214]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264886>

I have a repo whose workdir tends to get pretty dirty as I jump around from branch to branch tending weeds and whatnot.   Sometimes when I try to switch branches git refuses because of local file changes.

  git checkout otherbranch
  error: Your local changes to the following files would be overwritten by checkout:
	foo.txt
	bar.c
  Please, commit your changes or stash them before you can switch branches.
  Aborting

I resolve this by examining my local changes and deciding if I want to keep them or not.  I keep the changes in the conflicting files that I want, and then I discard the rest.

One way to "discard the rest" is to say 
   git checkout HEAD -- foo.txt bar.c && git checkout otherbranch

But sometimes the list of local-change conflicts I want to discard is too long and this recipe seems like a good alternative to me:
   git checkout -f otherbranch

But this is disastrous, because I have been focused on examining the conflicting local changes in foo.txt and bar.c, but I forgot about my non-conflicting changes to baz.c, lost as it is in a sea of untracked files making up the majority of my workdir local changes.  So all my untracked files make the leap unscathed, but my precious forgotten changes in baz.c get wiped out by the checkout --force, even though the baz.c in index and in otherbranch are the same.

I've read the documentation for 'git checkout --force' several times and I have a hard time deciding what it means to do.  But I'm sure it's doing what it's designed to do and what the man page says it will.  (English is my first language, btw.)

What I am seeking is some way to checkout the other branch and replace my conflicted local changes while ignoring my non-conflicting local changes in tracked files.  Something like --force-gently, maybe.  Does such an option exist?

I could script something, but it comes up only often enough to bite me, so I'm sure I'd forget I had scripted it.

Thanks,
Phil
