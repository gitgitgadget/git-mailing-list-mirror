From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH 2/5] daemon: if one of the standard fds is missing open it to /dev/null
Date: Thu, 13 Jul 2006 16:04:30 +0200
Message-ID: <E1G11nq-00076g-Aa@moooo.ath.cx>
References: <E1G0zj7-0001c1-8q@moooo.ath.cx> <E1G0znB-0002IO-61@moooo.ath.cx> <20060713152725.7a5081df.froese@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 13 16:05:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G11nw-0004wP-Li
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 16:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbWGMOEd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 10:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbWGMOEd
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 10:04:33 -0400
Received: from moooo.ath.cx ([85.116.203.178]:4032 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1751525AbWGMOEd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Jul 2006 10:04:33 -0400
To: Edgar Toernig <froese@gmx.de>
Mail-Followup-To: Edgar Toernig <froese@gmx.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060713152725.7a5081df.froese@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23836>

Edgar Toernig <froese@gmx.de> wrote:
> Matthias Lederhofer wrote:
> >
> > +/* if any standard file descriptor is missing open it to /dev/null */
> > +static void sanitize_stdfds(void)
> > +{
> > +	int devnull = -1, i;
> > +	struct stat buf;
> > +	for (i = 0; i < 3; ++i) {
> > +		if (fstat(i, &buf) != -1)
> > +			continue;
> > +		if (devnull == -1 &&
> > +			(devnull = open("/dev/null", O_RDWR, 0)) == -1)
> > +			die("open /dev/null failed: %s", strerror(errno));
> > +		if (dup2(devnull, i) != i)
> > +			die("dup2 failed: %s", strerror(errno));
> > +	}
> > +	if (devnull != -1)
> > +		close(devnull);
> > +}
> 
> This looks broken.  The open will return i as this is
> the lowest free fd.  I don't know what POSIX says
> about dup2(i,i) but anyway, you close it at the end
> which completely defeats the intent of the function.
> 
> How's this?
> 
> 	devnull = open("/dev/null", O_RDWR, 0);
> 	if (devnull == 0)
> 		devnull = dup(devnull);
> 	if (devnull == 1)
> 		devnull = dup(devnull);
> 	if (devnull == -1)
> 		die("open/dup /dev/null failed: %s", strerror(errno));
> 	if (devnull > 2)
> 		close(devnull);

You're right (also for the daemonize function to use sanitize_stdfds).
The code looks good to me, this could also be done using a while-loop
(making it a little bit shorter, I don't know what is easier to read):

    devnull = open("/dev/null", O_RDWR, 0);
    while (devnull != -1 && devnull < 2)
        dup(devnull);
    if (devnull == -1)
        die("..");
    close(devnull);

(This is similar to what Andre Noll posted.)

I'll correct and resend those patches later.
