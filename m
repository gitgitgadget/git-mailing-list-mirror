From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] peel_onion(): add support for <rev>^{tag}
Date: Tue, 3 Sep 2013 16:07:37 -0400
Message-ID: <20130903200737.GA18928@sigill.intra.peff.net>
References: <1378100551-892-1-git-send-email-rhansen@bbn.com>
 <20130903070546.GC3608@sigill.intra.peff.net>
 <52262C37.3030406@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 22:07:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGwt7-0003gK-Fg
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 22:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760271Ab3ICUHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 16:07:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:58007 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759990Ab3ICUHk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 16:07:40 -0400
Received: (qmail 25842 invoked by uid 102); 3 Sep 2013 20:07:40 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Sep 2013 15:07:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Sep 2013 16:07:37 -0400
Content-Disposition: inline
In-Reply-To: <52262C37.3030406@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233772>

On Tue, Sep 03, 2013 at 02:36:39PM -0400, Richard Hansen wrote:

> I have a patch submission question:  Is it OK that I didn't use the
> '--in-reply-to' argument to 'git send-email' when I sent the v3 reroll?
>  Should I have marked it as a reply to the v2 email?  Or should I have
> marked it as a reply to your review of the v2 email?

I generally prefer if they are kept in the same thread, for two reasons:

  1. People reading v3 may want to refer back to v2. You can provide a
     link to the previous discussion in the archive, but in-reply-to is
     a machine-readable way of doing the same thing (so it also works in
     people's MUAs without having to jump out to the archive).

  2. People reading v2 may be doing so after v3 has been published, and
     of course v2 cannot have linked to v3 at the time it was written.
     If the reader has a threaded MUA (or uses gmane), then the two are
     grouped together, and they can easily see that reading v2 carefully
     may be a waste of time, as it is already obsolete.

Between replying to the review versus the original patch, I don't have a
preference (any decent reader should group the whole thread, which is
enough to accomplish either of the above two).

> Done.  I see by your reply that my fear of going a bit overboard in the
> test was justified.  :)  I don't mind rerolling if you'd prefer a
> simpler test.

I think what you have is fine (modulo dropping the "&& true", which I
somehow failed to notice on first read). It is more thorough, and I do
not think it hurts the readability of the end result (i.e., I can still
tell what the point of the test is). But I am happy either way (I only
mentioned the simpler version because you asked).

> For future reference, is there a preference for putting tests of a new
> feature in a separate commit?  In the same commit?  Doesn't really matter?

I usually put them in the same commit for a small enhancement or fix
like this. Seeing the test along with the change often helps the reader
understand what the patch is doing by providing a concrete example.

Sometimes for a set of changes that needs a large set of refactoring
patches, I'll introduce a group of related failing tests at the
beginning (using test_expect_failure), and then mark them as
expect_success as they are fixed by individual commits.

So you can use your judgement about how the split will communicate to
the reviewer (and later readers of the commit history). But the one
thing you _can't_ do is introduce a failing test and mark it as
expect_success. We try to keep "make test" successful in each commit,
which lets people bisect the history more easily.

> > I wonder if we could do even better with:
> > 
> >   const char *x;
> >   ...
> >   if ((x = skip_prefix(sp, commit_type)) && *x == '}')
> > 
> > which avoids the magic lengths altogether
> 
> Not bad, especially since skip_prefix() already exists.

I'll post a follow-up patch in a second.

> There's also this awkward approach, which would avoid strlen() altogether:
> 
> commit.h:
> 
>     extern const char *commit_type;
>     extern const size_t commit_type_len;
> 
> commit.c:
> 
>     const char commit_type_array[] = "commit";
>     const char *commit_type = &commit_type_array[0];
>     const size_t commit_type_len = sizeof(commit_type_array) - 1;

That is a little manual and awkward for my tastes. skip_prefix() is
an inline specifically so that the compiler _can_ optimize out the
strlen in such cases, without us having to resort to writing the code
ourselves. So if we cared about the strlen here (and I don't think we
do), it would be cleaner to simply convert commit_type to a macro,
static string literal, or static constant array.

-Peff
