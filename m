From: Jeff King <peff@peff.net>
Subject: Re: leaky cherry-pick
Date: Tue, 10 Jan 2012 14:50:17 -0500
Message-ID: <20120110195017.GA19961@sigill.intra.peff.net>
References: <20120109223737.GA1589@padd.com>
 <CALkWK0nwE0c6qVvbauPrjmb3NX4NDeGSrvrC2ry2bjMeM4Hr0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 20:50:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkhiD-0004yy-MD
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 20:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479Ab2AJTuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 14:50:20 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33924
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932308Ab2AJTuT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 14:50:19 -0500
Received: (qmail 13593 invoked by uid 107); 10 Jan 2012 19:57:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jan 2012 14:57:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jan 2012 14:50:17 -0500
Content-Disposition: inline
In-Reply-To: <CALkWK0nwE0c6qVvbauPrjmb3NX4NDeGSrvrC2ry2bjMeM4Hr0A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188288>

On Tue, Jan 10, 2012 at 10:58:45AM +0530, Ramkumar Ramachandra wrote:

> Interesting- I wonder where .gitattributes parsing code fits into all
> this.  The purpose of bootstrap _attr_stack() is to populate
> attr_stack for its callers.  Lots of memory allocation happening in
> handle_attr_line() -- that information is returned to
> bootstrap_attr_stack().  We have to keep backtracking until that
> information is provably useless and free it.  Hm, convert_attrs() (in
> convert.c) is a common caller in both cases, but the populated
> attr_stack is local to attr.c; I wonder if this is the problem.  If my
> hunch is right, it should be a trivial fix (caution: untested):
> 
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> 
> diff --git a/attr.c b/attr.c
> index 76b079f..12e3824 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -745,6 +745,7 @@ int git_check_attr(const char *path, int num,
> struct git_attr_check *check)
>  		check[i].value = value;
>  	}
> 
> +	drop_attr_stack();
>  	return 0;
>  }

I don't think this is right. The attr_stack is intentionally kept in
place after a lookup as a cache, because callers are very likely to
lookup nearby filenames. The first thing we do is pop unrelated parts of
the stack, keep the early bits, and then push any new needed
directories.

So if you do a lookup for "foo/bar/baz/file1", the stack afterwards would
be:

  $GIT_DIR/info/attributes
  foo/bar/baz/.gitattributes
  foo/bar/.gitattributes
  foo/.gitattributes
  .gitattributes
  [builtins]

If you then do a lookup for "foo/bar/baz/file2", it can use the exact
same stack without looking for or reparsing the attribute files. If you
then do a lookup for "foo/bar/bleep/file", it pops only the entry for
"foo/bar/baz/.gitattributes", and pushes only the entry for
"foo/bar/bleep/.gitattributes".

The calling code _could_ say "btw, I am done with attributes now, so
free the memory". But we don't bother, since it's a small amount of
memory, and other parts of the code may want it later.

-Peff
