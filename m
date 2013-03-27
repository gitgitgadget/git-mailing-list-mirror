From: Rob Hoelz <rob@hoelz.ro>
Subject: Re: [PATCH] push: Alias pushurl from push rewrites
Date: Wed, 27 Mar 2013 17:29:09 -0500
Message-ID: <20130327172909.532a30b6@hoelz.ro>
References: <20130327122216.5de0c336@hoelz.ro>
	<20130327182345.GD28148@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	josh@joshtriplett.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 23:29:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKyqv-0004fa-6v
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 23:29:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754460Ab3C0W3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 18:29:13 -0400
Received: from hoelz.ro ([66.228.44.67]:40243 "EHLO mail.hoelz.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754156Ab3C0W3M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 18:29:12 -0400
Received: from localhost.localdomain (108-234-129-20.lightspeed.milwwi.sbcglobal.net [108.234.129.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.hoelz.ro (Postfix) with ESMTPSA id DDF1C280F3;
	Wed, 27 Mar 2013 18:29:10 -0400 (EDT)
In-Reply-To: <20130327182345.GD28148@google.com>
X-Mailer: Claws Mail 3.9.0 (GTK+ 2.24.16; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219343>

On Wed, 27 Mar 2013 11:23:45 -0700
Jonathan Nieder <jrnieder@gmail.com> wrote:

> Rob Hoelz wrote:
> 
> > --- a/remote.c
> > +++ b/remote.c
> > @@ -465,7 +465,11 @@ static void alias_all_urls(void)
> >  		if (!remotes[i])
> >  			continue;
> >  		for (j = 0; j < remotes[i]->pushurl_nr; j++) {
> > -			remotes[i]->pushurl[j] =
> > alias_url(remotes[i]->pushurl[j], &rewrites);
> > +			char *copy =
> > xstrdup(remotes[i]->pushurl[j]);
> > +			remotes[i]->pushurl[j] =
> > alias_url(remotes[i]->pushurl[j], &rewrites_push);
> > +			if (!strcmp(copy, remotes[i]->pushurl[j]))
> > +				remotes[i]->pushurl[j] =
> > alias_url(remotes[i]->pushurl[j], &rewrites);
> > +			free(copy);
> 
> Interesting.
> 
> Suppose I configure
> 
> 	[url "git://anongit.myserver.example.com/"]
> 		insteadOf = myserver.example.com:
> 	[url "myserver:"]
> 		pushInsteadOf = myserver.example.com:
> 
> The above code would make the insteadOf rule apply instead of
> pushInsteadOf, even when pushing.  Perhaps something like the
> following would work?

Are you sure?  I create a copy, and compare the copy to the new URL.
If they're the same (pushInsteadOf not found), I then use the insteadOf
mapping to perform the alteration.  Did I introduce a bug?
