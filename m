From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] introduce git root
Date: Fri, 5 Dec 2014 04:27:52 -0500
Message-ID: <20141205092752.GC32112@peff.net>
References: <CAJFMrCEciWXhBb36MVeFPi7Y7D=9zQ2xGPpiyUz9y4_hOh_taw@mail.gmail.com>
 <vpqoaro99xd.fsf@anie.imag.fr>
 <xmqqd284rryz.fsf@gitster.dls.corp.google.com>
 <CAP8UFD2jES1i+6zOt1gXqTWFy1UHu2GBwAisQktd_Ymbj9Db2g@mail.gmail.com>
 <20141202070415.GC1948@peff.net>
 <xmqqd282m09j.fsf@gitster.dls.corp.google.com>
 <20141204092251.GC27455@peff.net>
 <xmqqlhmntf02.fsf@gitster.dls.corp.google.com>
 <20141204211232.GC19953@peff.net>
 <CAP8UFD2P9P9zL=irZ-7uPD6+bEhxaiABowh0O3RT01Ov3VqT6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Arjun Sreedharan <arjun024@gmail.com>,
	Philip Oakley <philipoakley@iee.org>, Git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 10:28:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwpBD-0007NJ-Nt
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 10:28:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752413AbaLEJ15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 04:27:57 -0500
Received: from cloud.peff.net ([50.56.180.127]:48834 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751232AbaLEJ1z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 04:27:55 -0500
Received: (qmail 20360 invoked by uid 102); 5 Dec 2014 09:27:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Dec 2014 03:27:55 -0600
Received: (qmail 13510 invoked by uid 107); 5 Dec 2014 09:27:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Dec 2014 04:27:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Dec 2014 04:27:52 -0500
Content-Disposition: inline
In-Reply-To: <CAP8UFD2P9P9zL=irZ-7uPD6+bEhxaiABowh0O3RT01Ov3VqT6w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260861>

On Fri, Dec 05, 2014 at 03:27:17AM +0100, Christian Couder wrote:

> For example, to chose the editor all the following could apply:
> 
> GIT_SEQUENCE_EDITOR env variable
> sequence.editor config variable
> GIT_EDITOR env variable
> core.editor config variable
> VISUAL env variable
> EDITOR env variable
> editor configured at compile time
> 
> and the user or our own scripts right now cannot easily know which
> editor should be used when editing the sequence list.

I think we're violently agreeing.

Taking all of those inputs and computing the final value for a
git-sequence editor is exactly what "git var" should be doing. IMHO it
is a bug that when GIT_SEQUENCE_EDITOR was introduced, there was not a
matching update to compute it from "git var" (I didn't even know
sequence.editor existed until now!).

I am not opposed to that at all; that's the point of "git var", and the
"computables" we are talking about. I am only opposed to mixing the
namespace for computables with config. I.e., there is no point in asking
"git var" for the core.editor config. It is not a computable value, and
we already have a way of accessing it (git-config, which can also
_write_ the value, something that git-var will never be able to do for
computable values).

> > I do not think "git var --exec-path" is a good idea, nor GIT_EXEC_PATH
> > for the environment-variable confusion you mentioned. I was thinking of
> > just creating a new namespace, like:
> >
> >   git var exec-path
> >   git var author-ident
> 
> I agree that this is nice, but I wonder what we would do for the
> sequence editor and the default editor.
> Maybe:
> 
> git var sequence-editor
> git var editor

Again, I think we're mostly agreeing. Context and hierarchy and falling
back are good things. Whatever we call the variables, "editor" and
"sequence-editor" and "foo-editor" should have a predictable and
consistent form. I like the idea of "foo-editor" automatically falling
back to "editor" even if we don't know what "foo" is.

But the one place I do not agree is:

> I think "sequence.editor" and "core.editor" are better because:
> 
> - they use the same syntax as the config variables, so they are easier
> to remember and to discover, and

I really don't like using "core.editor" here, because it has the same
name as a config variable, but it is _not_ the config variable. It
happens to use the config variable as one of the inputs to its
computation, but in many cases:

  git config core.editor

and

  git var core.editor

will produce different values. They are entirely different namespaces.
Using the same syntax and name seems unnecessarily confusing to me. Even
still using dotted hierarchies, but giving them different names (e.g.,
"editor", "editor.sequence", "editor.foo") would make it more obvious
that they are not the same thing.

-Peff
