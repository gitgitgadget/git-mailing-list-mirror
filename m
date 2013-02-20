From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH v2 2/2] check-ignore.c, dir.c: fix segfault with '.'
 argument from repo root
Date: Wed, 20 Feb 2013 01:30:35 +0000
Message-ID: <20130220013035.GA7860@pacific.linksys.moosehall>
References: <CAOkDyE9VVuFn6B=Fe4XHxGCEW0MFgndx1X0+9hO36Soxb37YQw@mail.gmail.com>
 <1361301696-11307-1-git-send-email-git@adamspiers.org>
 <7vzjz03wid.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	Zoltan Klinger <zoltan.klinger@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 02:31:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7yWU-0007Lu-QG
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 02:31:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758753Ab3BTBai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 20:30:38 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:33713 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758410Ab3BTBah (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 20:30:37 -0500
Received: from localhost (c.2.7.1.0.6.0.3.6.a.7.2.5.6.9.7.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:7965:27a6:3060:172c])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 8452D55AFA;
	Wed, 20 Feb 2013 01:30:36 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vzjz03wid.fsf@alter.siamese.dyndns.org>
Received: by 10.182.122.106 with HTTP; Tue, 19 Feb 2013 17:15:05 -0800 (PST)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216670>

On Tue, Feb 19, 2013 at 7:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Adam Spiers <git@adamspiers.org> writes:
>
>> Fix a corner case where check-ignore would segfault when run with the
>> '.' argument from the top level of a repository, due to prefix_path()
>> converting '.' into the empty string.
>
> The description does not match what I understand is happening from
> the original report, though.

Why not?

> The above is more like this, no?
>
>     When check-ignore is run with the '.' argument from the top level of
>     a repository, it fed an empty string to hash_name() in name-hash.c
>     and caused a segfault, as the function kept reading forever past the
>     end of the string.

The only difference I can see between the two is that yours has
changed the phrase order and gives a bit more information.  I don't
see any disagreement between them though.

> A point to note is that it is not cleaer why it is a corner case to
> ask about a pathspec ".".  It is a valid question "Is the whole tree
> ignored by default?", isn't it?

It's probably valid, but I'm not the best judge of that.  It doesn't
make much sense to me why anyone would do that, and it seems very
unlikely it would be a common use case, therefore it's a corner case.
The next sentence then qualifies that:

>> It doesn't make much sense to
>> call check-ignore from the top level with '.' as a parameter, since
>> the top-level directory would never typically be ignored,
>
> And this sounds like a really bad excuse.

An excuse for what?  The final part of that sentence which you trimmed
made it clear that it was not an excuse for the segfault.  Your choice
of wording here sounds more like a personal attack than a technical
discussion - presumably unintentional, so I'll choose not to take
offense.

> If it were "it does not
> make *any* sense ... because the top level is *never* ignored", then
> the patch is a perfectly fine optimization that happens to work
> around the problem, but the use of "much" and "typically" is a sure
> sign that the design of the fix is iffy.  It also shows that the
> patch is not a fix, but is sweeping the problem under the rug, if
> there were a valid use case to set the top level to be ignored.

There *may* be a valid use case to set the top level to be ignored.
*I* can't think of one personally, therefore it doesn't make sense to
me to do so, but my intention was to avoid imposing my own personal
judgement on everyone else by preventing people from doing that.
However, in that case I now realise that check-ignore should report a
match, and my proposed patches do not do that.  Perhaps that is what
you meant by "sweeping the problem under the rug"?

> I wonder what would happen if we removed that "&& path[0]" check
> from the caller, not add the "assume the top is never ignored"
> workaround, and do something like this to the location that causes
> segv, so that it can give an answer when asked to hash an empty
> string?
>
>  name-hash.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/name-hash.c b/name-hash.c
> index d8d25c2..942c459 100644
> --- a/name-hash.c
> +++ b/name-hash.c
> @@ -24,11 +24,11 @@ static unsigned int hash_name(const char *name, int namelen)
>  {
>         unsigned int hash = 0x123;
>
> -       do {
> +       while (namelen--) {
>                 unsigned char c = *name++;
>                 c = icase_hash(c);
>                 hash = hash*101 + c;
> -       } while (--namelen);
> +       }
>         return hash;
>  }

Yep, that makes sense - that's what I meant when I said I was
wondering "whether hash_name() should do stricter input validation".

> Does the callchain that goes down to this function have other places
> that assume they will never see an empty string, like this function
> does, which I _think_ is the real issue?

Good question.  In the absence of a proper audit for similar issues,
it definitely makes sense to defensively program hash_name() (and any
other low-level functions which accept path strings).
