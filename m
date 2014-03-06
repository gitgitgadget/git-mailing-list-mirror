From: Jeff King <peff@peff.net>
Subject: Re: [BUG] Halt during fetch on MacOS
Date: Thu, 6 Mar 2014 16:16:45 -0500
Message-ID: <20140306211645.GA11926@sigill.intra.peff.net>
References: <CAFFUb6X455R4OD5FKnVFHFmvTyRqtV300bc=a8Xs03agM+=uLQ@mail.gmail.com>
 <CAFFUb6ViYitJC1sjL_nyWY1RHuJKURfcZ+_5Zk2kr+suh+txZg@mail.gmail.com>
 <xmqqk3c7yyku.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Conley Owens <cco3@android.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 22:16:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLfex-0006Vo-MG
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 22:16:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753895AbaCFVQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 16:16:48 -0500
Received: from cloud.peff.net ([50.56.180.127]:34345 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753890AbaCFVQr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 16:16:47 -0500
Received: (qmail 32240 invoked by uid 102); 6 Mar 2014 21:16:46 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 06 Mar 2014 15:16:46 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Mar 2014 16:16:45 -0500
Content-Disposition: inline
In-Reply-To: <xmqqk3c7yyku.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243553>

On Thu, Mar 06, 2014 at 10:24:49AM -0800, Junio C Hamano wrote:

> > OK, I've tried using my own build from master, and I still get the same results.
> >
> > I've done a little more investigation and discovered it always hangs at:
> > `atexit(notify_parent);` in `run-command.c:start_command`
> > when running:
> > trace: run_command: 'git-remote-https' 'aosp'
> > 'https://android.googlesource.com/platform/external/tinyxml2'
> >
> > Could this have to do with the atexit implementation?  (eg. limit on
> > the number of functions that can be registered, etc)
> 
> Thanks.
> 
> An interesting theory indeed.  I read that an implementation is
> supposed to take at least ATEXIT_MAX (32) calls to atexit(3); while
> I do think we register functions with atexit(3) from multiple places
> in our code, I doubt we would be making that many.

It seems awfully weird that it would _hang_ in such a case, though. That
sounds more like hitting a mutex that's internal to atexit(), or
something similar.

Conley, can you see if dropping that atexit clears up the problem (you
should be OK without it; git will just fail to notice the child's
exec failure with as much detail).

-Peff
