From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 06/19] git_remote_helpers: push all refs during a
 non-local export
Date: Wed, 8 Jun 2011 18:19:10 -0400
Message-ID: <20110608221908.GB15530@sigill.intra.peff.net>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
 <1307558930-16074-7-git-send-email-srabbelier@gmail.com>
 <20110608194205.GI27715@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 00:19:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUR5v-000054-HW
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 00:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756489Ab1FHWTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 18:19:18 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55285
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751895Ab1FHWTS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 18:19:18 -0400
Received: (qmail 5186 invoked by uid 107); 8 Jun 2011 22:19:25 -0000
Received: from m9a2036d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.32.154)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Jun 2011 18:19:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Jun 2011 18:19:10 -0400
Content-Disposition: inline
In-Reply-To: <20110608194205.GI27715@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175469>

On Wed, Jun 08, 2011 at 02:42:05PM -0500, Jonathan Nieder wrote:

> Sverre Rabbelier wrote:
> 
> > --- a/git_remote_helpers/git/non_local.py
> > +++ b/git_remote_helpers/git/non_local.py
> > @@ -63,7 +63,7 @@ class NonLocalGit(object):
> >          if not os.path.exists(path):
> >              die("could not find repo at %s", path)
> >  
> > -        args = ["git", "--git-dir=" + path, "push", "--quiet", self.repo.gitpath]
> > +        args = ["git", "--git-dir=" + path, "push", "--quiet", self.repo.gitpath, "--all"]
> >          child = subprocess.Popen(args)
> 
> Does this deal with forced (non-fast-forward) pushes?  (Not a
> complaint, just curious.)

No, nor can it. The problem is that any information about the ref
mapping or force-state is lost. All the helper sees is that stuff got
put into the staging repo, and it has to move it over.

If we do a fix that allows "refs/heads/foo:refs/heads/bar", then it
should also properly allow "+refs/heads/foo:refs/heads/bar". Which I
think means changing the single "export" command in the ref-helper to
something like:

  export refs/heads/foo
  export refs/heads/foo:refs/heads/bar
  export +refs/heads/force

-Peff
