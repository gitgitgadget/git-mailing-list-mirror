From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] http-push: remove remote locks on exit signals
Date: Sat, 24 May 2008 00:17:23 +0200
Message-ID: <20080523221723.GA4366@localhost>
References: <20080522195546.GA29911@localhost> <7vod6wr95y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 24 00:24:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jzffz-0001jU-Pj
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 00:23:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754920AbYEWWWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 18:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754971AbYEWWWh
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 18:22:37 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:63008 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067AbYEWWWg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 18:22:36 -0400
Received: by fg-out-1718.google.com with SMTP id 19so551973fgg.17
        for <git@vger.kernel.org>; Fri, 23 May 2008 15:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        bh=+iPMxArGYQExRmZLOMhqaIvruw8lHfG3xaE0AwlI20g=;
        b=nUsMLfQu85oxa/7xpcGJmW7aptEsJ2jBq4pFDpHxJe2tmwfvZ5Uhj/UbKCZTcga7crCqrUTGJ3XD2Aarfc3NSs7bP5fXOEo4ALhIKp2OFeRxuMD3MxknRBbG1qx4jNFHjjE0531tSgsXVl0eMXNZrSmYo5V+FNhNTm7ARW/gJbE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=tdXMBb020zPsBUAl6Iz6Eeu1Fe4Xct99pxBzWHPKk7Dgbz1JqE/IeAscfK2kATERFnGYm+mhxETinDeTzaL2RuPPKe5OOqrpJeuwwvgSiYV89nHoFALhea7uRID0ojxwOfZ479wQkYi46uMirzTkWRWPkPyiBgernVlmgVe7oo0=
Received: by 10.86.31.18 with SMTP id e18mr655707fge.41.1211581352500;
        Fri, 23 May 2008 15:22:32 -0700 (PDT)
Received: from darc.dyndns.org ( [88.117.101.65])
        by mx.google.com with ESMTPS id d6sm7529530fga.2.2008.05.23.15.22.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 23 May 2008 15:22:30 -0700 (PDT)
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1JzfZj-0001FI-Ja; Sat, 24 May 2008 00:17:23 +0200
Content-Disposition: inline
In-Reply-To: <7vod6wr95y.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82762>

Hi,

On Fri, May 23, 2008 at 02:40:41PM -0700, Junio C Hamano wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
> > +static void remove_locks_on_signal(int signo)
> > +{
> > +	remove_locks();
> > +	signal(SIGINT, SIG_DFL);
> > +	raise(signo);
> > +}
> > +
> 
> If you caught signo, shouldn't you be resetting that signo not SIGINT?

True. I suppose we should fix that in remove_lock_file_on_signal() as well,
then? It does exactly the same thing.

> >  static void remote_ls(const char *path, int flags,
> >  		      void (*userFunc)(struct remote_ls_ctx *ls),
> >  		      void *userData);
> > @@ -2255,6 +2273,8 @@ int main(int argc, char **argv)
> >  		goto cleanup;
> >  	}
> >  
> > +	signal(SIGINT, remove_locks_on_signal);
> > +
> 
> and you may care more than just INT but perhaps HUP and others?

SIGINT was bothering me the most, because I often kill http-push by pressing
Ctrl+C. I also considered adding SIGQUIT, but decided against it because
normally I press Ctrl+\ only if I want the program to quit _right now_ and
Ctrl+C does not work. On the other hand, sending the signal twice will
terminate http-push either way.

I don't know in which situation SIGHUP would come into play.

Regards,
Clemens
