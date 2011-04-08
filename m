From: Jeff King <peff@peff.net>
Subject: Re: Bug Report: git add
Date: Fri, 8 Apr 2011 15:15:54 -0400
Message-ID: <20110408191554.GA6516@sigill.intra.peff.net>
References: <4D9BA35E.6040204@dcook.org>
 <20110407005750.GC28813@sigill.intra.peff.net>
 <7vbp0ihnou.fsf@alter.siamese.dyndns.org>
 <20110407014819.GA12730@sigill.intra.peff.net>
 <7vlizmfrl1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Darren Cook <darren@dcook.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 21:16:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8HA3-0007J1-4v
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 21:16:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756243Ab1DHTP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 15:15:58 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36981
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752348Ab1DHTP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 15:15:57 -0400
Received: (qmail 3804 invoked by uid 107); 8 Apr 2011 19:16:45 -0000
Received: from 70-36-146-44.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.44)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Apr 2011 15:16:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Apr 2011 15:15:54 -0400
Content-Disposition: inline
In-Reply-To: <7vlizmfrl1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171146>

On Thu, Apr 07, 2011 at 12:28:26AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > @@ -139,8 +138,21 @@ static int lstat_cache_matchlen(struct cache_def *cache,
> >  			if (errno == ENOENT)
> >  				*ret_flags |= FL_NOENT;
> >  		} else if (S_ISDIR(st.st_mode)) {
> > -			last_slash_dir = last_slash;
> > -			continue;
> > +			struct stat junk;
> > +			struct strbuf gitdir = STRBUF_INIT;
> > +			strbuf_add(&gitdir, cache->path, match_len);
> > +			strbuf_addstr(&gitdir, "/.git");
> > +			if (lstat(gitdir.buf, &junk) < 0) {
> > +				if (errno == ENOENT) {
> > +					last_slash_dir = last_slash;
> > +					strbuf_release(&gitdir);
> > +					continue;
> > +				}
> > +				*ret_flags = FL_LSTATERR;
> > +			}
> > +			else
> > +				*ret_flags = FL_GITREPO;
> 
> This only checks "does the directory have .git in it?".

Yeah. I was trying to keep the test as inexpensive as possible, since
this is a very frequently called codepath. But really, doing a more
elaborate test shouldn't matter. The common case will be that the stat
fails, and we do nothing else.

I do worry about adding an extra lstat for each directory having
noticeable overhead. Maybe it doesn't matter because of the stat
caching, but I didn't measure.

> It probably is sufficient, but setup.c:is_git_directory() may do a more
> appropriate check, I think.  That ".git" thing could be a regular file
> (i.e. "gitdir: path"), so depending on the junk.st_mode, you may have to
> call read_gitfile_gently() on it before checking with is_git_directory().

I worry a little about the PATH_MAX check and die in is_git_directory. I
would hate for a deep hierarchy to start failing because of this extra
check. OTOH, it is only 5 extra characters to append ".git", so it is
unlikely that a path was that close to PATH_MAX but not exceeding it.

Similarly, read_gitfile_gently is anything but gentle. It die()s if we
can't open the '.git' file or it is in an invalid format, which would be
a regression here.

-Peff
