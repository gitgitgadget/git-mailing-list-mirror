From: Andrew Keller <andrew@kellerfarm.com>
Subject: Re: submodules: reuse .git/modules/... for multiple checkouts of same URL
Date: Mon, 3 Mar 2014 08:47:52 -0500
Message-ID: <8C74E5C5-1330-4B57-9961-AF775C5A8BB2@kellerfarm.com>
References: <175C83AE67A6484B9A9351B9AE4D0662042809@smucm57a>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: <Stefan.Liebl@partner.bmw.de>
X-From: git-owner@vger.kernel.org Mon Mar 03 14:48:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKTDr-0002ht-V4
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 14:48:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754103AbaCCNrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 08:47:55 -0500
Received: from atl4mhob18.myregisteredsite.com ([209.17.115.58]:43440 "EHLO
	atl4mhob18.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753545AbaCCNrz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 3 Mar 2014 08:47:55 -0500
Received: from mailpod.hostingplatform.com ([10.30.71.203])
	by atl4mhob18.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id s23DlqJr022911
	for <git@vger.kernel.org>; Mon, 3 Mar 2014 08:47:52 -0500
Received: (qmail 4051 invoked by uid 0); 3 Mar 2014 13:47:52 -0000
X-TCPREMOTEIP: 23.28.12.255
X-Authenticated-UID: andrew@kellerfarm.com
Received: from unknown (HELO ?192.168.0.108?) (andrew@kellerfarm.com@23.28.12.255)
  by 0 with ESMTPA; 3 Mar 2014 13:47:52 -0000
In-Reply-To: <175C83AE67A6484B9A9351B9AE4D0662042809@smucm57a>
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243221>

On Mar 3, 2014, at 7:24 AM, <Stefan.Liebl@partner.bmw.de> wrote:

> I have a git superproject with 3 submodules. The submodules are cloned from the same URL but use different branches. Git clones the repo three times and I have three entries in .git/modules. Is it possible to reuse the first clone for the next submodule clones?

Sort of - but I don't think you'll like the side effects.

If each of the submodules are checked out on a different branch, then HEAD is going to be different in each repository in .git/modules.  So, each of the repositories in .git/modules are unique.

You could share the objects database (see --shared or --reference) which would dramatically reduce the size of each repo on its own, but that comes with a side effect: because there is no communication between any of the repositories involved in sharing objects, git-gc will happily delete an object that may be unneeded locally, but another repository will suddenly think it's corrupt.

You could also customize the refspecs in each repository.  For example, if one of the submodules has only 'origin/contrib' checked out, then you could change the refspec to '+refs/heads/contrib:refs/remotes/origin/contrib', which will cause only the objects pertaining to that branch will be downloaded.  This has the most benefit when the commit graph is orphaned in some way.  However, this approach requires manual labor every time you initialize a submodule.

 - Andrew Keller
