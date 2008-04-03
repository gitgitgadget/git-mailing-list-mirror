From: Kevin Green <Kevin.T.Green@morganstanley.com>
Subject: Re: [PATCH] git-p4: Fix race between p4_edit and p4_change
Date: Thu, 3 Apr 2008 14:45:38 -0400
Message-ID: <20080403184537.GH22542@morganstanley.com>
References: <20080401222856.GA22542@morganstanley.com> <200804032032.39860.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Thu Apr 03 20:46:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhUS7-00006E-Gk
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 20:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385AbYDCSpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 14:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751910AbYDCSpk
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 14:45:40 -0400
Received: from pimtabh1.ms.com ([199.89.64.101]:52900 "EHLO pimtabh1.ms.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751832AbYDCSpj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 14:45:39 -0400
Received: from pimtabh1 (localhost.ms.com [127.0.0.1])
	by pimtabh1.ms.com (output Postfix) with ESMTP id 6CC60484DA;
	Thu,  3 Apr 2008 14:45:38 -0400 (EDT)
Received: from ny0030as01 (unknown [144.203.194.92])
	by pimtabh1.ms.com (internal Postfix) with ESMTP id 47C01A9401A;
	Thu,  3 Apr 2008 14:45:38 -0400 (EDT)
Received: from hn315c1n6 (localhost [127.0.0.1])
	by ny0030as01 (msa-out Postfix) with ESMTP id 38A5EAE49EF;
	Thu,  3 Apr 2008 14:45:38 -0400 (EDT)
Received: from menevado.ms.com (unknown [144.203.222.190])
	by ny0030as01 (msa-in Postfix) with ESMTP id 19CD78A0029;
	Thu,  3 Apr 2008 14:45:38 -0400 (EDT)
Received: (kgreen@localhost) by menevado.ms.com (8.12.11.20060308/sendmail.cf.client v1.05) id m33Ijcds003947; Thu, 3 Apr 2008 14:45:38 -0400
X-Authentication-Warning: menevado.ms.com: kgreen set sender to Kevin.T.Green@morganstanley.com using -f
Mail-Followup-To: Simon Hausmann <simon@lst.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200804032032.39860.simon@lst.de>
User-Agent: Mutt/1.5.6i
X-Anti-Virus: Kaspersky Anti-Virus for MailServers 5.5.15/RELEASE, bases: 03042008 #610375, status: clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78770>

On 04/03/08 14:32:32, Simon Hausmann wrote:
> On Wednesday 02 April 2008 00:28:56 Kevin Green wrote:
> > Hi,
> >
> > Ran into a nasty race today with git-p4.  The changelist Files: section was
> > showing up empty and it turned out to be a race between the p4_edit and
> > p4_change -o, e.g.
> >
> > $ p4 edit $file && p4 change -o
> >
> > will show no files in the Files: section.
> >
> > I attach a patch after my .sig as a suggested fix.  It simply loops over
> > the p4_changes -o as long as we're not finding any files (and we always
> > should since we just did a p4_edit!); sleeping for 3 secs in between to
> > allow Perforce to catch up with itself.
> 
> I don't mind the workaround in general as I agree this race is a bit nasy, but 
> shouldn't the sleep only happen if we didn't find any files? Right now even 
> if the server reacted immediately we still sleep for three seconds.
> 

Oops.  You're absolutely correct and that's not what I intended...  (darn
Python whitespace ;)

I didn't catch that logic error in my testing because I was expecting it to
sleep anyhow...

> 
> Last but not least we could of course also generate the entire Files: section 
> ourselves, using 'p4 change -o' just to get the rest of the template right.
> 
> I almost prefer the last approach, since we know the base depot path and the 
> relative paths of all edited/added files.
> 
> What do you think?
> 

Thank you...  That's the right approach.  Stop as soon as we get to the Files:
section and then just add in the depot + filepath string for each change...


--Kevin
