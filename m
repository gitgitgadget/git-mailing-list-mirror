From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] config: allow including config from repository blobs
Date: Thu, 26 Jan 2012 12:22:59 -0500
Message-ID: <20120126172259.GB5278@sigill.intra.peff.net>
References: <20120126073547.GA28689@sigill.intra.peff.net>
 <20120126074208.GD30474@sigill.intra.peff.net>
 <4F211C0C.7060400@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jan 26 18:23:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqT2U-0006mx-4x
	for gcvg-git-2@lo.gmane.org; Thu, 26 Jan 2012 18:23:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379Ab2AZRXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jan 2012 12:23:05 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45843
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752088Ab2AZRXE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 12:23:04 -0500
Received: (qmail 27352 invoked by uid 107); 26 Jan 2012 17:30:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Jan 2012 12:30:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jan 2012 12:22:59 -0500
Content-Disposition: inline
In-Reply-To: <4F211C0C.7060400@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189155>

On Thu, Jan 26, 2012 at 10:25:32AM +0100, Johannes Sixt wrote:

> Am 1/26/2012 8:42, schrieb Jeff King:
> > +static int handle_ref_include(const char *ref, void *data)
> > +{
> > +	unsigned char sha1[20];
> > +	char *buf;
> > +	unsigned long size;
> > +	enum object_type type;
> > +	int ret;
> > +
> > +	if (get_sha1(ref, sha1))
> > +		return 0;
> > +	buf = read_sha1_file(sha1, &type, &size);
> > +	if (!buf)
> > +		return error("unable to read include ref '%s'", ref);
> > +	if (type != OBJ_BLOB)
> > +		return error("include ref '%s' is not a blob", ref);
> > +
> > +	ret = git_config_from_buffer(git_config_include, data, ref, buf, size);
> > +	free(buf);
> > +	return ret;
> > +}
> 
> What happens if a ref cannot be resolved, for example due to repository
> corruption? Does git just emit an error and then carries on, or does it
> always die? Can I run at least git-fsck in such a case?

Names which do not resolve are explicitly ignored, because I wanted to
flexibility in specifying the includes. E.g., you might say put:

  [include]
          ref = refs/config

in your ~/.gitconfig, and then only use the feature in some of your
repositories (I'm not sure if that is a good idea yet in practice or
not. But as I said before, I think of this is a building block, and I'd
like people to experiment and see if it fills their needs).

Obviously the trade-off is that we would silently ignore a typo in the
object name.

However, I did explicitly return an error for a failure to find a sha1,
or a non-blob sha1, as those are more severe configuration errors (where
the former is basically repository corruption). We only return an error
here, but git_config will eventually die() because of it, noting the
file and line number where the include happened[1].

It's then up to you to fix the config file before you can continue using
git. You can do so by hand, but I think using "git config" to do so will
not work; even though it correctly does not expand includes while
writing, the git wrapper incidentally reads the config before actually
running the config command.

We already have similar problems where setting a bool option to a
non-bool value will cause many git commands git to die (e.g., try
setting "color.ui" to "foo"). But it's less often an issue, because
unless the config option you have messed up is very basic (like
core.bare), you can still run "git config".

So it's certainly recoverable if you are comfortable editing the config
file. But we could also make it a little friendlier by turning those
errors into warnings, at the minor cost of making errors less
noticeable.

-Peff

[1] The error reporting just shows the source of the deepest file,
    because git_parse_file will actually call die(). So if I have a
    .git/config that includes a ref that includes another ref that has
    an error, I see only:

      $ git config foo.value
      error: include ref 'HEAD:subdir' is not a blob
      fatal: bad config file line 5 in HEAD:config

    But solving the problem without git is hard. I know the problem is
    in the ref, but I can't edit the ref. The source of the include
    chain has to come from a file I can edit outside of git (since we
    always start from the files), but I'm not told which file included
    it.

    So it would be a little nicer to say something like:

      error: include ref 'HEAD:subdir' is not a blob (at HEAD:config, line 5)
      error: included file 'HEAD:config' had errors at .git/config, line 9
      fatal: unable to parse configuration

    which shows the complete trail, and you know to edit .git/config. In
    practice, I don't know if it is much of an issue. There are only 3
    places that git actually reads config from, and it is likely that
    you just edited one.
