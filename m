From: Jeff King <peff@peff.net>
Subject: Re: [BUG] Filenames with single colon being treated as remote
 repository
Date: Mon, 22 Apr 2013 11:35:17 -0400
Message-ID: <20130422153516.GB11886@sigill.intra.peff.net>
References: <20130421045329.GB30538@WST420>
 <20130421060538.GB10429@elie.Belkin>
 <20130421124511.GA1933@sigill.intra.peff.net>
 <7vd2tnvk2x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	William Giokas <1007380@gmail.com>, git@vger.kernel.org,
	fsckdaemon@gmail.com, Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 17:35:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUIm5-0004uh-Fr
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 17:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754569Ab3DVPfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 11:35:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:46223 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754102Ab3DVPfT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 11:35:19 -0400
Received: (qmail 19609 invoked by uid 102); 22 Apr 2013 15:35:27 -0000
Received: from 99-108-225-125.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.225.125)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 22 Apr 2013 10:35:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Apr 2013 11:35:17 -0400
Content-Disposition: inline
In-Reply-To: <7vd2tnvk2x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222028>

On Sun, Apr 21, 2013 at 11:01:58AM -0700, Junio C Hamano wrote:

> > I think the rule could be something like:
> >
> >   1. If it looks like a URL ("^scheme://"), it is.
> >
> >   2. Otherwise, if it is a path in the filesystem, it is.
> >
> >   3. Otherwise, if it has a colon, it's host:path
> >
> >   4. Otherwise, barf.
> >
> > where the interesting bit is the ordering of 2 and 3.  It seems like
> > "git clone" follows the order above with get_repo_path. But we do not
> > seem to follow it in git_connect, where we prefer 3 over 2.
> 
> At least for a string whose "host" part does not have any slash,
> switching the rules 2 and 3 in git_connect() would be a regression,
> no?  "frotz:/srv/git/git.git" has been the way to talk to host frotz
> for a long time, and if you want to talk to a local directory that
> is a subdirectory of "frotz:/" directory you have in your $cwd, you
> can disambiguate by saying "./frotz:/srv/git/git.git" or something.

Yeah, it would be a regression for fetch, though "git clone frotz:/srv"
is already broken if that file exists; it turns into `realpath
frotz:/srv` before we even feed it into the fetch machinery.

So I think one reasonable path would be:

  1. Do not treat "host:path" as ssh if "host" has a slash, which should
     not regress anybody. It does not allow unadorned relative paths
     with colons, but it lets you use absolute paths or "./" to
     disambiguate.

  2. Teach git-clone to ask the transport code to parse the source repo
     spec, and decide from that whether it is local or not. That would
     harmonize the implementations and avoid errors when you _did_ mean
     to use ssh, but "host:path" happens to exist in your filesystem. I
     also would not be surprised if there are problems with
     URL-encoding, but maybe clone handles that properly (I didn't
     check).

And the "host contains slash" rule is pretty easy to explain in the
documentation, which is good.

-Peff
