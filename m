From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/6] config: return configset value for current_config_
 functions
Date: Thu, 26 May 2016 20:41:46 -0400
Message-ID: <20160527004146.GA4996@sigill.intra.peff.net>
References: <20160518223712.GA18317@sigill.intra.peff.net>
 <20160518224323.GD22443@sigill.intra.peff.net>
 <20160519000821.GA22543@sigill.intra.peff.net>
 <CACsJy8Ad=yN6aLkH9B6ujUNUvPT-b+jw+CwJORD5Fh1jYeOUZQ@mail.gmail.com>
 <xmqq7fegydmf.fsf@gitster.mtv.corp.google.com>
 <20160526165033.GA20355@sigill.intra.peff.net>
 <xmqqd1o8wwk3.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 27 02:41:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b65qb-0002HM-RS
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 02:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755595AbcE0Alu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 20:41:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:44951 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755357AbcE0Alt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 20:41:49 -0400
Received: (qmail 25842 invoked by uid 102); 27 May 2016 00:41:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 May 2016 20:41:49 -0400
Received: (qmail 24867 invoked by uid 107); 27 May 2016 00:41:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 May 2016 20:41:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2016 20:41:46 -0400
Content-Disposition: inline
In-Reply-To: <xmqqd1o8wwk3.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295706>

On Thu, May 26, 2016 at 10:36:44AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The problem is running test-config inside of a git alias. The
> > bin-wrappers will set the exec-path to the root-level of git's build
> > directory, which the git binary will then stick at the front of the
> > $PATH.
> 
> I was wondering why exec-path does not point at bin-wrappers in the
> first place.
> 
> A wrapper script needs to know where the real thing lives in order
> to "exec" (or "exec gdb") anyway, and it hardcodes the path to it.
> It happens to use GIT_EXEC_PATH to shorten the hardcoded path it
> uses when it does "exec", but it does not have to.
> 
> Wouldn't we want to see "git" use any of these wrapped ones when it
> invokes a non-builtin subcommand when it does so normally, honoring
> GIT_EXEC_PATH?  Pointing GIT_EXEC_PATH at the top-level means that
> wrappers are bypassed for such an invocation (if what is run happens
> to have executable at the top-level), and possibly a totally wrong
> thing is run (when we start generating the binaries in different
> directories, which is what we are seeing here).

I think the issue is that bin-wrappers serves two purposes. One is for
testing, but the other is for people who run git directly without
installing. For us to set GIT_EXEC_PATH to bin-wrappers, it would have
to have all of the git-* external programs, which would then put them
all in the $PATH of people doing the no-install thing.

That's certainly not insurmountable. Either we can tell them to live
with it, or we can break out a separate wrapper directory that serves as
a pseudo-exec-path.

> > So the simplest solution really is: don't do that. The only debate
> > in my mind is whether this is rare enough that it won't bite
> > somebody again in the future, or if we should look into a solution
> > that makes this Just Work.
> 
> I think it was you who alluded to revamping the test framework along
> the lines of preparing a "test installation" (aka "make install"
> with DESTDIR set to somewhere) and making bin-wrappers to point into
> that installation (or if we are testing an installed Git that may be
> different from what we have source for, that final installed
> location).  An installed version of Git will not have test-* helpers
> so they need to come from a freshly built source tree, not from
> "test installation" or "installed Git".  There may be other details
> that need to be worked out, but as a longer term direction that may
> not be a bad idea.

I think you can make it even simpler by not really doing a "make
install", but just linking or bin-wrappering a fake exec-path. It would
be great if we could truly just "make install" into a fake area and test
that (dropping bin-wrappers entirely), but git cares too much about some
hard-coded paths, I think. We'd have to first have a truly relocatable
binary.

-Peff
