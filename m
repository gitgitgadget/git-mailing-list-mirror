From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] run-command: factor out running_main_thread function
Date: Mon, 15 Apr 2013 22:53:40 -0400
Message-ID: <20130416025340.GB20932@sigill.intra.peff.net>
References: <20130415230651.GA16670@sigill.intra.peff.net>
 <20130415230816.GB11267@sigill.intra.peff.net>
 <20130416014504.GD3262@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 04:53:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URw1n-0002Pp-RW
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 04:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935480Ab3DPCxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 22:53:48 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47435 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935467Ab3DPCxr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 22:53:47 -0400
Received: (qmail 32731 invoked by uid 107); 16 Apr 2013 02:55:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 15 Apr 2013 22:55:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Apr 2013 22:53:40 -0400
Content-Disposition: inline
In-Reply-To: <20130416014504.GD3262@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221349>

On Mon, Apr 15, 2013 at 06:45:04PM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > --- a/run-command.c
> > +++ b/run-command.c
> > @@ -603,7 +603,7 @@ static NORETURN void die_async(const char *err, va_list params)
> >  {
> >  	vreportf("fatal: ", err, params);
> >  
> > -	if (!pthread_equal(main_thread, pthread_self())) {
> > +	if (!running_main_thread()) {
> >  		struct async *async = pthread_getspecific(async_key);
> >  		if (async->proc_in >= 0)
> >  			close(async->proc_in);
> > @@ -614,6 +614,19 @@ static NORETURN void die_async(const char *err, va_list params)
> >  
> >  	exit(128);
> >  }
> > +
> > +int running_main_thread(void)
> > +{
> > +	return pthread_equal(main_thread, pthread_self());
> > +}
> 
> Would it make sense to do something like
> 
> 	return !main_thread_set || pthread_equal(...);
> 
> in case someone tries to call this before the first start_async call?

I considered that, but assumed that pthread_equal would always return
false against the zeroed out static main_thread. Mostly because we
appeared not to be bothering with such a check already.  But actually,
in the existing code, it is only checked from die_async, which is only
put into place when we _do_ start a thread, so we would never hit this
code path without main_thread being set.

So yes, a check probably would make sense. However, I think I'm
convinced that we should drop this in favor of using thread-local
storage for the "dying" counter. So this patch can just go away.

Thanks for reviewing this version, though.

-Peff
