From: Jeff King <peff@peff.net>
Subject: Re: git clone NonExistentLocation
Date: Fri, 18 Feb 2011 01:11:33 -0500
Message-ID: <20110218061133.GA25847@sigill.intra.peff.net>
References: <4D5CE3E7.5030101@atlas-elektronik.com>
 <4D5D1715.5020707@drmicha.warpmail.net>
 <4D5D1A04.4090107@atlas-elektronik.com>
 <4D5D1BCB.3010003@drmicha.warpmail.net>
 <AANLkTin3Pf4XD_gbwxPzW4uff9SbDWJdGug6jM_SHDo+@mail.gmail.com>
 <4D5D5275.5070501@drmicha.warpmail.net>
 <20110218040152.GA25466@sigill.intra.peff.net>
 <7vd3mp6ftp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 07:11:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqJZJ-0004oA-8j
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 07:11:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649Ab1BRGLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 01:11:40 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:32991 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752295Ab1BRGLi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 01:11:38 -0500
Received: (qmail 28961 invoked by uid 111); 18 Feb 2011 06:11:37 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 18 Feb 2011 06:11:37 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Feb 2011 01:11:33 -0500
Content-Disposition: inline
In-Reply-To: <7vd3mp6ftp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167177>

On Thu, Feb 17, 2011 at 10:02:10PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think the patch below is the right fix.
> > ...
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> >  builtin/clone.c        |    5 ++++-
> >  t/t5701-clone-local.sh |   13 +++++++++++++
> >  2 files changed, 17 insertions(+), 1 deletions(-)
> >
> > diff --git a/builtin/clone.c b/builtin/clone.c
> > index 60d9a64..55785d0 100644
> > --- a/builtin/clone.c
> > +++ b/builtin/clone.c
> > @@ -412,8 +412,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
> >  	path = get_repo_path(repo_name, &is_bundle);
> >  	if (path)
> >  		repo = xstrdup(make_nonrelative_path(repo_name));
> > -	else if (!strchr(repo_name, ':'))
> > +	else if (!strchr(repo_name, ':')) {
> > +		if (!file_exists(repo_name))
> > +			die("repository '%s' does not exist", repo_name);
> >  		repo = xstrdup(make_absolute_path(repo_name));
> > +	}
> >  	else
> >  		repo = repo_name;
> >  	is_local = path && !is_bundle;
> 
> Thanks, but I am confused.
> 
> The stuff goes through make_absolute_path() so we must be certain that
> this has to be a local filesystem entity _if_ it is a repository.
> 
> But when will we see a file at repo_name in this new codepath?  In what
> situation would get_repo_path(repo_name, &is_bundle) return NULL but the
> added file_exists(repo_name) would yield true to bypess your die()?

Hmm, good point. I didn't look carefully enough into get_repo_path. It
is not really about finding a repo, but rather about finding a directory
or filename. Plus, my file_exists() isn't quite right, anyway. We really
want to make sure $repo_name.git, $repo_name.bundle, etc don't exist.
But get_repo_path has already done that for us, so we should just trust
its output.

> diff --git a/builtin/clone.c b/builtin/clone.c
> index 60d9a64..2ee1fa9 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -413,7 +413,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	if (path)
>  		repo = xstrdup(make_nonrelative_path(repo_name));
>  	else if (!strchr(repo_name, ':'))
> -		repo = xstrdup(make_absolute_path(repo_name));
> +		die("repository '%s' does not exist", repo_name);
>  	else
>  		repo = repo_name;
>  	is_local = path && !is_bundle;

Yeah, I think that is a better fix.

-Peff
