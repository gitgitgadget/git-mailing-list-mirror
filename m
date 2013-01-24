From: Jeff King <peff@peff.net>
Subject: Re: segmentation fault (nullpointer) with git log --submodule -p
Date: Thu, 24 Jan 2013 18:27:21 -0500
Message-ID: <20130124232721.GA16036@sigill.intra.peff.net>
References: <20130123143816.GA579@krypton.darkbyte.org>
 <20130123200222.GB19832@sigill.intra.peff.net>
 <510124F5.9090505@atlas-elektronik.com>
 <CACsJy8B9O=A26_=sv1JEYdtazsWa4khZkqpTgFSSTs_RGGPZqQ@mail.gmail.com>
 <51013FDD.5030004@atlas-elektronik.com>
 <CACsJy8CEofqi9S8-SDx_O+Ko0i56aRZ4KEJrVnbFum6zzsJrJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan =?utf-8?B?TsOkd2U=?= <stefan.naewe@atlas-elektronik.com>,
	Armin <netzverweigerer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathon Mah <jmah@me.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 00:27:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyWD4-0006S1-9h
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 00:27:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756699Ab3AXX1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 18:27:25 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48629 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164Ab3AXX1X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 18:27:23 -0500
Received: (qmail 24644 invoked by uid 107); 24 Jan 2013 23:28:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Jan 2013 18:28:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2013 18:27:21 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8CEofqi9S8-SDx_O+Ko0i56aRZ4KEJrVnbFum6zzsJrJg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214471>

On Thu, Jan 24, 2013 at 09:14:47PM +0700, Nguyen Thai Ngoc Duy wrote:

> >>> I did. My bisection told me this is the suspect:
> >>>
> >>> ccdc603 (parse_object: try internal cache before reading object db)
> >>
> >> diff --git a/object.c b/object.c
> >> index d8d09f9..6b06297 100644
> >> --- a/object.c
> >> +++ b/object.c
> >> @@ -191,10 +191,15 @@ struct object *parse_object(const unsigned char *sha1)
> >>         enum object_type type;
> >>         int eaten;
> >>         const unsigned char *repl = lookup_replace_object(sha1);
> >> -       void *buffer = read_sha1_file(sha1, &type, &size);
> >> +       void *buffer;
> >> +       struct object *obj;
> >> +
> >> +       obj = lookup_object(sha1);
> >> +       if (obj && obj->parsed)
> >> +               return obj;
> >>
> >> Any chance obj->parsed is 1 but ((struct commit*)obj)->buffer is NULL?
> >> What if you change that "if" to
> >>
> >> if (obj && obj->parsed && (obj->type != OBJ_COMMIT || ((struct commit
> >> *)obj)->buffer))
> >>
> >
> > No more segfault!
> 
> Sweet. I have no idea how that fixes it. Maybe Jeff can give some
> explanation after he wakes up.

Ugh. I think I know why it fixes it. We free the commit's buffer as part
of the log traversal, but then later want to access it as part of the
diff. We presumably call parse_object somewhere in the middle to make
sure it is parsed.

Before ccdc603, a side effect of parse_object is that even for a parsed
object, we would fill in the buffer field of a commit or tree. See
parse_object_buffer:

        } else if (type == OBJ_COMMIT) {
                struct commit *commit = lookup_commit(sha1);
                if (commit) {
                        if (parse_commit_buffer(commit, buffer, size))
                                return NULL;
                        if (!commit->buffer) {
                                commit->buffer = buffer;
                                eaten = 1;
                        }
                        obj = &commit->object;
                }

When this patch was originally proposed, I wrote[1]:

  On Thu, Jan 05, 2012 at 01:55:22PM -0800, Junio C Hamano wrote:
  > > So I think it is safe short of somebody doing some horrible manual
  > > munging of a "struct object".
  >
  > Yeah, I was worried about codepaths like commit-pretty-printing
  > might be mucking with the contents of commit->buffer, perhaps
  > reencoding the text and then calling parse_object() to get the
  > unmodified original back, or something silly like that. But the
  > lookup_object() call at the beginning of the parse_object() already
  > prevents us from doing such a thing, so we should be OK, I would
  > think.

  [...]

  What saves you is that the parse_*_buffer functions all do nothing
  when the object.parsed flag is set, and the code I added makes sure
  that object.parsed is set in the object that lookup_object returns.

  So yeah, anytime you tweak the contents of commit->buffer but don't
  unset the "parsed" flag, you are asking for trouble.

Which is true, but obviously I missed that in addition to calling
parse_*_buffer, which will be a no-op, we _also_ set the buffer
independently. So parse_object was functioning in a belt-and-suspenders
for that case. And I think this is probably the same root cause as the
segfault which came up here:

  http://thread.gmane.org/gmane.comp.version-control.git/214366

So what to do?

We can revert ccdc603, but I do not think we need to. We can catch the
problematic cases with something like your patch, but still get the
optimization when the buffer really is already filled in. I think we'd
need to extend your patch to handle trees, too, to be totally correct.

But there are still some loose ends that I note:

  1. Making such a change would be parse_object erring on the side of
     providing the buffer. But it doesn't actually know if the buffer is
     desired or not. For instance, upload-pack benefited from this
     optimization, but does not need save_commit_buffer on at all. So
     commit->buffer is _always_ NULL there, and that's just fine; we
     really don't need to read the object.

     Now this may be a bad example, because due to my follow-on patches,
     we avoid calling parse_object at all in most cases, so I don't
     think it matters any longer to upload-pack. But I suspect there are
     other places with similar circumstances. Fundamentally parse_object
     doesn't know what the caller is interested in.

  2. This means that parse_commit and parse_object behave differently in
     this regard. The former will leave the buffer unfilled. Meaning we
     may still have issues with code paths that munge the buffer without
     resetting the parsed flag, independent of ccdc603 and fixing this.

To me, these highlight that our commit->buffer management is fragile and
is largely about guessing in various circumstances whether somebody will
later want the buffer. I'm not sure of the right solution, though. It
seems like something that inherently blurs the lines between bits of
code (e.g., how should "log" know that a submodule diff might later want
to see the same entry? Should we optimistically free and then make it
easier for the later user to reliably ensure the buffer is primed? Or
should we err on the side of keeping it in place?).

-Peff

[1] http://article.gmane.org/gmane.comp.version-control.git/188000
