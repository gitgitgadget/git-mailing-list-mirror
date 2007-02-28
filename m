From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] Do not change the file type if the filesystem does not support symlinks.
Date: Wed, 28 Feb 2007 18:40:07 +0100
Message-ID: <200702281840.07893.johannes.sixt@telecom.at>
References: <11726125012895-git-send-email-johannes.sixt@telecom.at> <1172612504272-git-send-email-johannes.sixt@telecom.at> <Pine.LNX.4.63.0702272352080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 18:40:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMSn8-00026v-HA
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 18:40:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933282AbXB1RkN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 12:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933293AbXB1RkN
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 12:40:13 -0500
Received: from smtp3.noc.eunet-ag.at ([193.154.160.89]:59759 "EHLO
	smtp3.noc.eunet-ag.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933289AbXB1RkL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 12:40:11 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.noc.eunet-ag.at (Postfix) with ESMTP
	id 69BCA36B62; Wed, 28 Feb 2007 18:40:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 2299D121FE;
	Wed, 28 Feb 2007 18:40:08 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0702272352080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40973>

On Tuesday 27 February 2007 23:54, Johannes Schindelin wrote:
> On Tue, 27 Feb 2007, Johannes Sixt wrote:
> > diff --git a/read-cache.c b/read-cache.c
> > index 605b352..f09ee2e 100644
> > --- a/read-cache.c
> > +++ b/read-cache.c
> > @@ -116,7 +116,8 @@ static int ce_match_stat_basic(struct cache_entry
> > *ce, struct stat *st)
> >
> >  	switch (ntohl(ce->ce_mode) & S_IFMT) {
> >  	case S_IFREG:
> > -		changed |= !S_ISREG(st->st_mode) ? TYPE_CHANGED : 0;
> > +		if (trust_symlink_fmt && !S_ISREG(st->st_mode))
> > +			changed |= TYPE_CHANGED;
>
> Really? If the cache entry says S_IFREG we should not expect a symlink
> here, right?

Don't know what I was smoking here. This hunk just doesn't need to be there at 
all...

>
> > @@ -125,7 +126,8 @@ static int ce_match_stat_basic(struct cache_entry
> > *ce, struct stat *st) changed |= MODE_CHANGED;
> >  		break;
> >  	case S_IFLNK:
> > -		changed |= !S_ISLNK(st->st_mode) ? TYPE_CHANGED : 0;
> > +		if (trust_symlink_fmt && !S_ISLNK(st->st_mode))
> > +			changed |= TYPE_CHANGED;
>
> This does not handle the case symlink->directory, right?

Something like:

		if (!S_ISLNK(st->st_mode) &&
		    (trust_symlink_fmt || !S_ISREG(st->st_mode)))
			changed |= TYPE_CHANGE;

BTW, considering the size of the entire patch series, I'm thinking of 
submitting it in a single patch.

-- Hannes
