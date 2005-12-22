From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Introduce core.sharedrepository
Date: Thu, 22 Dec 2005 23:59:47 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512222356540.12681@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0512222313070.12044@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vaceshi18.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 23 00:00:00 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpZPg-0007xl-IA
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 23:59:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030354AbVLVW7t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 17:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbVLVW7t
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 17:59:49 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:6080 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030354AbVLVW7s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 17:59:48 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5AB1D13F951; Thu, 22 Dec 2005 23:59:47 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 411D99E3CB; Thu, 22 Dec 2005 23:59:47 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2CD209E3C9; Thu, 22 Dec 2005 23:59:47 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 228FF13F951; Thu, 22 Dec 2005 23:59:47 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vaceshi18.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13978>

Hi,

On Thu, 22 Dec 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > +static int make_group_writable(const char *path)
> > +{
> > +	struct stat st;
> > +
> > +	if (lstat(path, &st) < 0)
> > +		return -1;
> > +	if (st.st_mode & S_IWUSR)
> > +		st.st_mode |= S_IWGRP;
> > +	if (S_ISDIR(st.st_mode))
> > +		st.st_mode |= S_ISGID;
> > +	if (chmod(path, st.st_mode) < 0)
> > +		return -2;
> > +	return 0;
> > +}
> 
> Perhaps g+sx not just g+s on directories.

Okay:

        if (S_ISDIR(st.st_mode))
                st.st_mode |= S_ISGID | S_IXGRP;

> > +
> >  int safe_create_leading_directories(char *path)
> >  {
> >  	char *pos = path;
> > @@ -64,6 +79,10 @@ int safe_create_leading_directories(char
> >  				*pos = '/';
> >  				return -1;
> >  			}
> > +		if (shared_repository && make_group_writable(path)) {
> > +			*pos = '/';
> > +			return -2;
> > +		}
> 
> Wouldn't this safe_create_leading_directories("/pub/git.git/objects")
> try chmod "/pub" and fail?

Yes.

How about an "else" in front of the "if"? Like so:

                if (mkdir(path, 0777) < 0)
                        if (errno != EEXIST) {
                                *pos = '/';
                                return -1;
                        }
                else if (shared_repository && make_group_writable(path)) {
                        *pos = '/';
                        return -2;
                }

You want me to resend the patch?

Ciao,
Dscho
