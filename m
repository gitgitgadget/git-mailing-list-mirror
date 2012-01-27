From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Don't search files with an unset "grep" attribute
Date: Fri, 27 Jan 2012 01:35:03 -0500
Message-ID: <20120127063503.GA23934@sigill.intra.peff.net>
References: <7vy5sy8e0y.fsf@alter.siamese.dyndns.org>
 <1327359555-29457-1-git-send-email-conrad.irwin@gmail.com>
 <7vaa5d4mce.fsf@alter.siamese.dyndns.org>
 <20120125214625.GA4666@sigill.intra.peff.net>
 <4F21831C.7060609@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Conrad Irwin <conrad.irwin@gmail.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jan 27 07:35:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqfP1-0006p3-P0
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 07:35:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453Ab2A0GfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jan 2012 01:35:08 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46359
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750948Ab2A0GfH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 01:35:07 -0500
Received: (qmail 2594 invoked by uid 107); 27 Jan 2012 06:42:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 27 Jan 2012 01:42:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Jan 2012 01:35:03 -0500
Content-Disposition: inline
In-Reply-To: <4F21831C.7060609@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189199>

On Thu, Jan 26, 2012 at 05:45:16PM +0100, Michael Haggerty wrote:

> I think decisions such as whether to include an imported module in "git
> diff" output is a personal preference and should not be decided at the
> level of the git project.

You're right. I thought of it as an annotation that the project could
mark via .gitattributes, or the user could mark via .git/info/attributes.
But that is not following the right split of responsibility for
attributes and config. The attributes should annotate "this isn't really
part of the regular git code base" or "this is really part of the
nedmalloc codebase". And then the _config_ should say "when I am
grepping, I am not interested in nedmalloc". I.e.:

  # mark a set of paths with an attribute
  echo "compat/nedmalloc external" >>.gitattributes

  # and then ignore that attribute for this grep
  git grep --exclude-attr=external 

  # or for all greps
  git config --add grep.exclude external

and git doesn't even have to care about what the attribute is called.
It's between the project and the user how they want to annotate their
files, and how they want to feed them to grep.

Or any other program, for that matter. I wonder if this could also be a
more powerful way of grouping files to be included or excluded from diff
pathspecs. Something like (and I'm just talking off the top of my head,
so there may be some syntactic conflicts here):

  # annotate some files
  cat >>.gitattributes <<-\EOF
  t/t????-*.sh test-script
  t/lib-*.sh test-script
  t/test-lib.sh test-script
  EOF

  # and then consider the tagged files to be a group, and look only at
  # that group
  git log :attr:test-script

  # ditto, but imagine we had the negative pathspecs Duy has proposed
  git log :~attr:test-script

That seems kind of cool to me. But maybe it is getting into crazy
over-engineering. I like the idea that we don't need a new option to
grep or diff; rather it is simply a new syntax for mentioning paths.

> The in-tree .gitattributes files should, by and large, just *describe*
> the files and leave it to users to associate policies with the tags
> (or at least make it possible for users to override the policies) via
> .git/info/attributes.  For example, the repository could set an
> "external=nedmalloc" attribute on all files under compat/nedmalloc,
> and users could themselves configure a macro "[attr]external -diff
> -grep" (or maybe something like "[attr]external=nedmalloc -diff
> -grep") if that is their preference.

So obviously I took what you were saying here and ran with it above. But
I do disagree with one thing here: the attributes should be giving some
tag to the paths, but the actual decision about whether to grep should
be part of the _config_. That's the usual split we have for all of the
other attributes, and I think it makes sense and has worked well.

> Is it really common to want to use the same argument on multiple macros
> without also wanting to set other things specifically?  If not, then
> there is not much reason to complicate macros with argument support.

I dunno. I admit my attribute usage tends to just match by extension,
and I generally only have one or two such lines.

> For example, I do something like
> 
>     [attr]type-python type=python text diff=python check-ws
>     *.py type-python
> 
>     [attr]type-makefile type=makefile text diff check-ws -check-tab
>     Makefile.* type-makefile
> 
> for the main file types in my repository, and it is not very cumbersome.

I think it's not a big deal if you are making your own macros. I was
more concerned that people would want to use the "binary" macro to get
the "-grep" automagic, but could not do so because they don't want
"-diff", but rather "diff=foo".

Anyway, after reading your response and thinking on it more, I think
"-grep" is totally the wrong way to go.  If the files are marked binary,
then grep should be respecting "-diff" or the "diff.*.binary" config. If
we want to do more advanced exclusion, then the right place for that is
the config file (or the weird :attr pathspec thing I mentioned above).

> "type-python" and "type=python" seem redundant but they are not.
> "type-python" is needed so that it can be used as a macro.
> "type=python" makes it easier to inquire about the type of a file using
> something like "git check-attr type -- PATH" rather than having to
> inquire about each possible type-* attribute.  It might be nice to
> support a slightly extended macro definition syntax like
> 
>     [attr]type=python text diff=python check-ws
>     *.py type=python
> 
>     [attr]type=makefile text diff check-ws -check-tab
>     Makefile.* type=makefile
> 
> (i.e., macros that are only triggered for particular values of an
> attribute).

I don't think there's any semantic reason why that is not workable. It's
simply not syntactically allowed at this point.

-Peff
