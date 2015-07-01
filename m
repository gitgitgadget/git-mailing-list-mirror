From: Lawrence Siebert <lawrencesiebert@gmail.com>
Subject: Re: [PATCH] --count feature for git shortlog
Date: Tue, 30 Jun 2015 20:00:53 -0700
Message-ID: <CAKDoJU42kDs3QXYjo7rJ-vLMJtUdv9AwttJLHnya+toG6cSatQ@mail.gmail.com>
References: <1435540922-12208-1-git-send-email-lawrencesiebert@gmail.com>
	<xmqq1tgvdt9u.fsf@gitster.dls.corp.google.com>
	<CAKDoJU4HcGoOS83MKwsQBXztYrDomMd9N-2SKc6iRyNhQQM5Eg@mail.gmail.com>
	<CAKDoJU4MHGa-c=F0m17rgWUCS2xFwiSb1pmDnYztoDnzRaRKCw@mail.gmail.com>
	<19801032cd7af95bc8030f54d740bf48@www.dscho.org>
	<20150630122323.GY18226@serenity.lan>
	<CAKDoJU4cEvWvfnFsvfOJ_P0UOrD3RpLK1NdfxaUPiDTWXYg-oA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	tanoku@gmail.com
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jul 01 05:00:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZA8Gh-0007bb-Bl
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 05:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752983AbbGADAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 23:00:55 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:36833 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264AbbGADAx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 23:00:53 -0400
Received: by oift81 with SMTP id t81so22430319oif.3
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 20:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=am/tOROY/RpeTXkUvhpGuiBeNzRUFhqMuUH6VUnVk4Q=;
        b=Bi5BNsGCD8/hsKiGqfuOvfMi1UA0JsgJ8E3s3GVBlQp0qvGfhbVVWiqZXcw1GWcRJc
         xDFIr84qogIDxtWSfn4P7NYOLr43zNRyJkakZM+vsbOp63sOvpuCW2m9vlFFgEibd7NO
         l4U5F83RCP0JqN+cm/rijJMXckiTH3LKgJXUtYPLKqOrt7igvgwbcF/Hs1eU2xFBSQD0
         OqvoYxfQUWNS7nNkuK08FiIg75lHUfM6RoQH/50nzE58QzZHNNT2v5FYG2JVl/3K+eyy
         1VHyUIDmraJjczbR0c7V5691zmmev57gQ+NACU60RX6HHIhEmFu4l+B5Uw/OX69KilBh
         jtFg==
X-Received: by 10.202.210.148 with SMTP id j142mr21678528oig.68.1435719653375;
 Tue, 30 Jun 2015 20:00:53 -0700 (PDT)
Received: by 10.76.153.101 with HTTP; Tue, 30 Jun 2015 20:00:53 -0700 (PDT)
In-Reply-To: <CAKDoJU4cEvWvfnFsvfOJ_P0UOrD3RpLK1NdfxaUPiDTWXYg-oA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273114>

Vincent, I'm ccing you because of --use-bitmap-index

John, Johannes,

I really appreciate both your thoughts.

`git rev-list --count HEAD -- "$FILENAME"` runs noticeably faster then
my patch code for `git shortlog --count`, git shortlog -s "$FILENAME"
| cut -f 1 | paste -sd+ -|bc, and faster than any use of piping to wc
-l mentioned so far.  Anyway I think Junio is quite right that my code
doesn't belong in shortlog, at least as it currently is.

I have some ideas for future work for myself, both code and
documentation changes.  I can detail it and get comments first, or
just submit patches and get comments after, whichever is the preferred
practice. One in particular is worth mentioning.

The following doesn't currently run:  `git rev-list --count
--use-bitmap-index HEAD`

This is an optional parameter for rev-list from commit
aa32939fea9c8934b41efce56015732fa12b8247 which can't currently be used
because of changes in parameter parsing, but which modifies `--count`
and which may be faster. I've gotten it working again, both by
changing the current repo code to make it work, and also by building
from that commit, and when I tested it on the whole repo, it seems
like it's less variable in speed then `git rev-list --count HEAD`. but
not necessarily consistently faster like tests suggested it was when
it was committed. Obviously I'm not testing on the same system as the
original committer, or with the same compiler, or even using the same
version of the linux kernel repo, so those may be a factor.  It may
also work better in a circumstance that I haven't accounted for, like
an older repo, on a per file basis when getting per file commit counts
for all files, or something like that.

I'm thinking I could submit a patch that makes it work again, and
leave it to the user to decide whether to use it or not.   There is
also a --test-bitmap option which compares the regular count with the
bitmap count. I'm not sure if the implication there was regression
testing or that --use-bitmap-index might give the wrong results in
certain circumstances.  Vincent, could you clarify?

Thanks,
Lawrence Siebert
http://www.github.com/gryftir

On Tue, Jun 30, 2015 at 5:23 AM, John Keeping <john@keeping.me.uk> wrote:
>
> On Tue, Jun 30, 2015 at 02:10:49PM +0200, Johannes Schindelin wrote:
> > On 2015-06-29 18:46, Lawrence Siebert wrote:
> >
> > > I appreciate your help. Okay, That all makes sense.
> > >
> > > I would note that something like:
> > >  git shortlog -s "$FILENAME:  | cut -f 1 | paste -sd+ - | bc
> > >
> > > seems like it run much faster then:
> > >
> > >  git log --oneline "$FILENAME" | wc -l
> >
> > How does it compare to `git rev-list -- "$FILENAME" | wc -l`?
>
> Or even `git rev-list --count HEAD -- "$FILENAME"`.
