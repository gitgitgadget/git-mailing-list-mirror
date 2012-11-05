From: Pete Wyckoff <pw@padd.com>
Subject: Re: checkout-index: unable to create file foo (File exists)
Date: Mon, 5 Nov 2012 12:53:40 -0500
Message-ID: <20121105175340.GA889@padd.com>
References: <k6ulre$bko$1@ger.gmane.org>
 <20121104221018.GB9160@padd.com>
 <5097DA5C.9020603@interlinx.bc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
X-From: git-owner@vger.kernel.org Mon Nov 05 18:53:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVQs2-0006Fc-64
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 18:53:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754129Ab2KERxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2012 12:53:45 -0500
Received: from honk.padd.com ([74.3.171.149]:55342 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750901Ab2KERxo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2012 12:53:44 -0500
Received: from arf.padd.com (unknown [50.55.148.232])
	by honk.padd.com (Postfix) with ESMTPSA id 38716D02;
	Mon,  5 Nov 2012 09:53:43 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id E395822B86; Mon,  5 Nov 2012 12:53:40 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <5097DA5C.9020603@interlinx.bc.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209078>

brian@interlinx.bc.ca wrote on Mon, 05 Nov 2012 10:25 -0500:
> On 12-11-04 05:10 PM, Pete Wyckoff wrote:
> > Which network filesystem and OS are you using?
> 
> The filesystem is Lustre.  So not only is it networked, it is
> distributed where the namespace and data store are handled by different
> nodes, to it's not at all as atomic as NFS-on-(say-)ext4.  Given that,
> it's entirely possible to imagine a scenario where a namespace (MDT in
> the Lustre nomenclature) operation could get interrupted after the
> namespace entry has been created but before the open(2) completes.  So
> the question here is who's responsibility is it to handle that situation?

That's all in the filesystem.  Hopefully it doesn't really work
like that because the fs is incosistent at this point.

ERESTARTSYS handling is done entirely in the kernel, not in glibc
and not git.  A possible in-kernel fix is not to handle any
signals (except KILL) when waiting for the open mechanics to
finish.

> > The third option is
> > that there is a bug in the filesystem client.
> 
> Yep.  But before we can go on to determining a bug, the proper/expected
> behavior needs to be determined.  I guess that's taking this a bit OT
> for this list though.  I'm not really sure where else to go to determine
> this though.  :-(

You could toss this to lustre support.  Or try first to come up
with a reduced testcase with lots of opens and SIGALRMs racing
against each other.  Maybe xfstests or some other suite might
also tickle the bug.

I don't think it is feasible to try to handle this error
condition in applications.

		-- Pete
