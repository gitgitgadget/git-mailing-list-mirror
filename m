From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Don't search files with an unset "grep" attribute
Date: Wed, 25 Jan 2012 16:46:26 -0500
Message-ID: <20120125214625.GA4666@sigill.intra.peff.net>
References: <7vy5sy8e0y.fsf@alter.siamese.dyndns.org>
 <1327359555-29457-1-git-send-email-conrad.irwin@gmail.com>
 <7vaa5d4mce.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Conrad Irwin <conrad.irwin@gmail.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 25 22:46:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqAfr-0004UI-F8
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 22:46:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923Ab2AYVqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jan 2012 16:46:30 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44656
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750835Ab2AYVq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2012 16:46:29 -0500
Received: (qmail 20295 invoked by uid 107); 25 Jan 2012 21:53:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 25 Jan 2012 16:53:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jan 2012 16:46:26 -0500
Content-Disposition: inline
In-Reply-To: <7vaa5d4mce.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189127>

On Mon, Jan 23, 2012 at 10:59:45PM -0800, Junio C Hamano wrote:

> Conrad Irwin <conrad.irwin@gmail.com> writes:
> > I used to use this approach, hooking into the "diff" attribute directly to mark
> > a file as binary, however that was clearly a hack.
> 
> After thinking about this a bit more, I have to say I disagree that it is
> a hack.

I kind of agree.

The biggest problem is that the name is wrong.  The "diff.*.command"
option really is about generating a diff between two blobs of a certain
type. But "diff.*.textconv" and "diff.*.binary" are really just
attributes of the file, and may or may not have to do with generating a
diff. Ditto for diff.*.funcname, I think.

You argue, and I agree, that if we are talking about attributes of the
files and not diff-specific things, then other parts of git can and
should make use of that information.

So if this was all spelled:

  $ cat .gitattributes
  *.pdf filetype=pdf
  $ cat .git/config
  [filetype "pdf"]
          binary = true
          textconv = pdf2txt

I think it would be a no-brainer that those type attributes should apply
to "git grep".

So maybe the first step on this path would be to introduce something
like "filetype" as a new attribute, have "diff" respect its settings,
and recommend people set up filetypes as appropriate. Or maybe that just
makes things more confusing in the long run, and we are better off
simply accepting that the name is slightly misleading. But either way,
it seems clear that git should be respecting gitattributes at the very
least to mark files as binary (and I think we already use funcname
patterns; textconv is a slightly stickier subject, so I'll address that
below).

But what I'm not sure I agree with is that the idea of "I don't want to
include path X in my grep" maps to "just mark the file as binary". For
example, in git we carry around a lot of code in compat/ that comes from
other places. I generally don't want to see grep results from
compat/nedmalloc/, because that isn't git code.

But should I mark everything in compat/nedmalloc as binary? I don't
think so. I _do_ want to see changes in nedmalloc in "git log" or "git
diff". They don't bother me because they're infrequent, and we still
want to produce regular text patches for the list when they come up. But
because nedmalloc contains a lot of lines of code (even though they
don't change a lot), it happens to produce a lot of uninteresting
matches when grepping.

>  - The user has flexibility to set "diff" and "grep" independently, which
>    is an unnecessary complication [*1*]; and

In the nedmalloc case, if we are to have "grep" and "diff" attributes
that behave similarly, you potentially do want to set them differently.
It would be nice to be able to treat them differently in the cases you
wanted to, but not _have_ to do so. Attribute macros can almost
implement this. You could add "-grep" to binary. But you can't (as far
as I know) do "macro=foo" to handle arbitrary diff drivers. I suspect we
could extend the rules to allow macros that take an argument and pass it
to their constituent attributes.

However, I think this is the wrong road to go down. You would want
macros like this _if_ you have grep and diff attributes that basically
do the same thing (e.g., marking a file as binary for diff versus binary
for grep). But I think that's a wrong road to go down. More likely a
file is binary or it is not binary, and the problem is conflating "file
is binary" with "I do not usually want to grep this file".

I'd much rather see grep inherit diff's file attributes unconditionally
(whether we still call them "diff" or not), and add a grep attribute
that is about "usually this is worth grepping". And then have a
tri-state command-line option for grep to either include uninteresting
things, exclude them, or to give terse output for them (mention that
there were matches in foo.c, but not each one). Probably defaulting to
terse output.

That makes the case you presented work out of the box: things marked as
binary for diffing look binary to grep, and we give the usual terse
"binary file matches" output. The user doesn't have to do anything.  For
more complex cases like nedmalloc, you can still achieve the "this is
text, but it's usually boring" behavior. And if you really want to do a
thorough grep, you can just "git grep --exclude=none".

> So let's step back a bit and take a look at the handling of files for
> which you do not want to see patch output and/or you do not want to see
> grep hits, in a fictional but realisitic use scenario.
> [...]

I think this is a nice user story, and it fits in with your suggested
git behavior. But I think there are other stories, too, like the
nedmalloc one. And it would be nice to make them work without hurting
the simplicity of the case you mentioned.

> If you think about it this way from the very high level description of the
> problem, aka, end user's point of view, it is fairly clear that tying the
> "binary" attribute to "git grep" to allow us to override the built-in
> buffer_is_binary() call you see in grep.c gives the most intuitive result,
> without forcing the user to do anything more than they are already doing.

This is not a complaint about the core of your point, but rather an
aside that should be considered: how many people are really using the
binary macro attribute? Personally, I never use it, because when I mark
something with a "diff" attribute, it is because I am telling git about
a specific diff driver (usually textconv). Otherwise I don't bother
setting attributes at all, because git's binary detection tends to be
good.  This leaves me without setting "-text", of course, but I don't
generally care because I don't do CRLF conversion at all.

So I think it is worth considering not just people setting "binary", but
how users of just "diff" (both "-diff" and "diff=foo") will want things
to work.

> Suppose that this binary blob firmware came with an API manual formatted
> in PDF, xyzzy.pdf, also supplied by the vendor. It is also kept in the
> repository, but again, running textual diff between updated versions of
> the PDF documentation would not be very useful. I however may have a
> textconv filter defined for it to grab the text by running pdf2ascii.
> 
> Now if my "git show --textconv xyzzy.pdf" has an output line that says a
> string "XYZZY API 2.0" was added to the current version, wouldn't it be
> natural for me to expect that "git grep --textconv 'XYZZY API' xyzzy.pdf"
> to find it [*4*]?

This is an interesting concept. As a user of textconv, I already have
some specialized grep tools for matching inside binary files (e.g., I
have a tool that greps within exif tags of images). But being able to do
so with "git grep", and even at an arbitrary revision, is kind of neat.

I would worry about turning it on by default, since the results could be
misleading. In particular, your pattern "foo" might be in the binary
file but not in the textconv'd version, leading you to think you had
found all instances of "foo" but had not (or much more subtle, things
like line breaks really matter during the conversion if you are going to
be using "grep -C").

Making it available by "--textconv" seems reasonable to me, though. The
only inconsistency is that it's on by default for "git show", but would
not be for "git grep".

Perhaps I am being overly paranoid on the "misleading" bit above. It
seems to me that grep has the room to be a lot more subtle, because an
omission from the output is considered "did not match". But you could
construct equally weird scenarios for "git show" (e.g., you changed
"foo" to "bar" but that part did not appear in the textconv portion.
Which is really a quality-of-implementation issue for your textconv
filter).

> As an added bonus, if you truly want to omit _any_ hit from "git grep" for
> your minified.js files, you can easily do so. Just define a textconv
> filter that yields an empty string for them, and "grep --textconv" won't
> produce any matches, not even "Binary file ... matches".

Clever. But then you will never ever see a diff for that file, either,
because we will consider all changes to be empty (actually, I didn't
check, but you may get the diff header without any content, similar to
the stat-dirty entries).

-Peff
