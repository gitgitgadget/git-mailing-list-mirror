From: Jeff King <peff@peff.net>
Subject: Re: Alternates corruption issue
Date: Fri, 3 Feb 2012 07:02:15 -0500
Message-ID: <20120203120215.GA31441@sigill.intra.peff.net>
References: <20120131193922.GA31551@sigill.intra.peff.net>
 <7v1uqf8vqu.fsf@alter.siamese.dyndns.org>
 <20120131204417.GA30969@sigill.intra.peff.net>
 <20120131214047.GA13547@burratino>
 <20120131214740.GA2465@sigill.intra.peff.net>
 <20120131215501.GF13252@burratino>
 <20120131220510.GA3253@sigill.intra.peff.net>
 <20120131222258.GG13252@burratino>
 <20120202215913.GA26727@sigill.intra.peff.net>
 <7vzkd0u4ik.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	"Hart, Darren" <darren.hart@intel.com>,
	"Ashfield, Bruce" <Bruce.Ashfield@windriver.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 13:02:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtHqh-0004lK-6E
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 13:02:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035Ab2BCMCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 07:02:23 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55111
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753302Ab2BCMCV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 07:02:21 -0500
Received: (qmail 30898 invoked by uid 107); 3 Feb 2012 12:09:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 Feb 2012 07:09:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Feb 2012 07:02:15 -0500
Content-Disposition: inline
In-Reply-To: <7vzkd0u4ik.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189749>

On Thu, Feb 02, 2012 at 04:47:31PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > @@ -324,8 +324,11 @@ const char *enter_repo(const char *path, int strict)
> >  			return NULL;
> >  		len = strlen(used_path);
> >  		for (i = 0; suffix[i]; i++) {
> > +			struct stat st;
> >  			strcpy(used_path + len, suffix[i]);
> > -			if (!access(used_path, F_OK)) {
> > +			if (!stat(used_path, &st) &&
> > +			    (S_ISREG(st.st_mode) ||
> > +			    (S_ISDIR(st.st_mode) && is_git_directory(used_path)))) {
> 
> Hmm, how would this change interact with
> 
> >  				strcat(validated_path, suffix[i]);
> >  				break;
> >  			}
> 
> 	gitfile = read_gitfile(used_path);
> 
> that appear after the context in the patch?

It assumes that any file named ".git" is worth reading and selecting.
And then later we actually read_gitfile to find out if it's worth-while.
There is no change of behavior from before the patch, as we would
similarly notice the file (without checking if it's a real gitfile) and
then later read it and possibly fail.

However, with the ordering change, there is a technically a regression
in one case: a random file "foo" next to a repo "foo.git". Saying "git
ls-remote foo" used to prefer "foo.git", and will now select the file
"foo" only to fail.

The code-path in clone's get_repo_path handles this properly (it checks
that the path is really a valid gitfile before finishing the loop). The
gitfile-reading from later in enter_repo could be hoisted into the loop.
If was trying to make a less-invasive change; if we're going to do that
much rewriting, it probably makes sense to factor out the logic from
get_repo_path and have them share the code.

Thanks for noticing. I saw this issue when I was writing the original
version of the patch, and meant to revisit it and at least document it
in the commit message, but I ended up forgetting.

-Peff
