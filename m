From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/3] t3700: avoid racy git situation
Date: Fri, 9 Nov 2007 03:00:57 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711090258530.4362@racer.site>
References: <Pine.LNX.4.64.0711081213580.4362@racer.site>
 <Pine.LNX.4.64.0711081414160.4362@racer.site> <47331E65.9010209@viscovery.net>
 <Pine.LNX.4.64.0711081511440.4362@racer.site> <7vbqa431vj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	krh@redhat.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 04:01:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqK7v-0004v0-50
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 04:01:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758213AbXKIDBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 22:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754228AbXKIDBG
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 22:01:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:58065 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753686AbXKIDBF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 22:01:05 -0500
Received: (qmail invoked by alias); 09 Nov 2007 03:01:03 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp018) with SMTP; 09 Nov 2007 04:01:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+0uA9IWuu02NCjAxBdsgaozkaYo2jNzvUnk4PS/R
	FbIZceL8xBG87G
X-X-Sender: gene099@racer.site
In-Reply-To: <7vbqa431vj.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64122>

Hi,

On Thu, 8 Nov 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > The problem is that the index has the same timestamp as the file "foo".
> >
> > Therefore, git cannot tell if "foo" is up-to-date in the index, since 
> > it could have been modified (and indeed is) just a fraction of a 
> > second later than the index was last updated.
> >
> > And since diff-index, as called from the test script, does not 
> > generate a diff, but really only determines if the index information 
> > suggests that the files are up-to-date, there is not really much you 
> > can do.
> >
> > This is our good old friend, the racy git problem.
> 
> That sounds very wrong.
> 
> What happened to the ce_smudge_racily_clean_entry() call that is
> done from write_index()?

And sure enough I am wrong.  My patch assumes that it was the second 
diff-index which failed, the one after "git add --refresh".

Alas, in shell "a && b && c && d || e" will execute e if a fails.  So 
after debugging this a bit more carefully, it seems that it is indeed the 
missing update_index --refresh that Kristian mentioned, which leads to 
this error.

And my patch is wrong.

Ciao,
Dscho
