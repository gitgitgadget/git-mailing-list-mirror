From: Trond Myklebust <Trond.Myklebust@netapp.com>
Subject: Re: pread() over NFS (again) [1.5.5.4]
Date: Fri, 27 Jun 2008 10:50:29 -0400
Organization: NetApp
Message-ID: <1214578229.7437.14.camel@localhost>
References: <6F25C1B4-85DE-4559-9471-BCD453FEB174@gmail.com>
	 <20080626204606.GX11793@spearce.org>
	 <7vskuzq5ix.fsf@gitster.siamese.dyndns.org>
	 <65688C06-BB6A-4E95-A4B9-A1A7C206BE2E@sent.com>
	 <7vhcbfojgf.fsf@gitster.siamese.dyndns.org>
	 <20080627025715.GB19568@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, logank@sent.com,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Christian Holtje <docwhat@gmail.com>, git@vger.kernel.org,
	Trond Myklebust <trond@netapp.com>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Fri Jun 27 16:52:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCFJc-0005o0-RD
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 16:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756382AbYF0Ovi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 10:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756612AbYF0Ovi
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 10:51:38 -0400
Received: from mx2.netapp.com ([216.240.18.37]:7683 "EHLO mx2.netapp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756474AbYF0Ovg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 10:51:36 -0400
X-IronPort-AV: E=Sophos;i="4.27,715,1204531200"; 
   d="scan'208";a="948375"
Received: from smtp1.corp.netapp.com ([10.57.156.124])
  by mx2-out.netapp.com with ESMTP; 27 Jun 2008 07:51:26 -0700
Received: from svlexrs01.hq.netapp.com (svlexrs01.corp.netapp.com [10.57.156.158])
	by smtp1.corp.netapp.com (8.13.1/8.13.1/NTAP-1.6) with ESMTP id m5REpPLY018536;
	Fri, 27 Jun 2008 07:51:26 -0700 (PDT)
Received: from sacrsexc1-prd.hq.netapp.com ([10.99.115.27]) by svlexrs01.hq.netapp.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 27 Jun 2008 07:51:25 -0700
Received: from SACMVEXC2-PRD.hq.netapp.com ([10.99.115.17]) by sacrsexc1-prd.hq.netapp.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 27 Jun 2008 07:51:24 -0700
Received: from 10.58.52.120 ([10.58.52.120]) by SACMVEXC2-PRD.hq.netapp.com ([10.99.115.16]) with Microsoft Exchange Server HTTP-DAV ;
 Fri, 27 Jun 2008 14:50:29 +0000
Received: from heimdal.trondhjem.org by SACMVEXC2-PRD.hq.netapp.com; 27 Jun 2008 10:50:29 -0400
In-Reply-To: <20080627025715.GB19568@fieldses.org>
X-Mailer: Evolution 2.22.2 
X-OriginalArrivalTime: 27 Jun 2008 14:51:24.0735 (UTC) FILETIME=[456124F0:01C8D865]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86569>

On Thu, 2008-06-26 at 22:57 -0400, J. Bruce Fields wrote:
> On Thu, Jun 26, 2008 at 04:38:40PM -0700, Junio C Hamano wrote:
> > logank@sent.com writes:
> > 
> > > On Jun 26, 2008, at 1:56 PM, Junio C Hamano wrote:
> > >
> > >>> "The file shouldn't be short unless someone truncated it, or there
> > >>> is a bug in index-pack.  Neither is very likely, but I don't think
> > >>> we would want to retry pread'ing the same block forever.
> > >>
> > >> I don't think we would want to retry even once.  Return value of 0
> > >> from
> > >> pread is defined to be an EOF, isn't it?
> > >
> > > No, it seems to be a simple error-out in this case. We have 2.4.20
> > > systems with nfs-utils 0.3.3 and used to frequently get the same error
> > > while pushing. I made a similar change back in February and haven't
> > > had a problem since:
> > >
> > > diff --git a/index-pack.c b/index-pack.c
> > > index 5ac91ba..85c8bdb 100644
> > > --- a/index-pack.c
> > > +++ b/index-pack.c
> > > @@ -313,7 +313,14 @@ static void *get_data_from_pack(struct
> > > object_entry *obj)
> > > 	src = xmalloc(len);
> > > 	data = src;
> > > 	do {
> > > +		// It appears that if multiple threads read across NFS, the
> > > +		// second read will fail. I know this is awful, but we wait for
> > > +		// a little bit and try again.
> > > 		ssize_t n = pread(pack_fd, data + rdy, len - rdy, from + rdy);
> > > +		if (n <= 0) {
> > > +			sleep(1);
> > > +			n = pread(pack_fd, data + rdy, len - rdy, from + rdy);
> > > +		}
> > > 		if (n <= 0)
> > > 			die("cannot pread pack file: %s", strerror(errno));
> > > 		rdy += n;
> > >
> > > I use a sleep request since it seems less likely that the other thread
> > > will have an outstanding request after a second of waiting.
> > 
> > Gaah.  Don't we have NFS experts in house?  Bruce, perhaps?
> 
> Trond, you don't have any idea why a 2.6.9-42.0.8.ELsmp client (2.4.28
> server) might be returning spurious 0's from pread()?
> 
> Seems like everything is happening from that one client--the file isn't
> being simultaneously accessed from the server or from another client.

Is the file only being read, or could there be a simultaneous write to
the same file? I'm surmising this could be an effect resulting from
simultaneous cache invalidations: prior to Linux 2.6.20 or so, we
weren't rigorously following the VFS/VM rules for page locking, and so
page cache invalidation in particular could have some curious
side-effects.

Cheers
  Trond
-- 
Trond Myklebust
Linux NFS client maintainer

NetApp
Trond.Myklebust@netapp.com
www.netapp.com
