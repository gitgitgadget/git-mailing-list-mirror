From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH] interpret-trailers: add option for in-place editing
Date: Thu, 7 Jan 2016 13:42:17 +0100
Message-ID: <20160107124216.GK29125@distanz.ch>
References: <1452087258-3893-1-git-send-email-tobias.klauser@zhinst.com>
 <CAPig+cSvD-TAd6365wxycUcTBehL-81a0WWosz4mVr1-HKCqGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tobias Klauser <tobias.klauser@zhinst.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 13:42:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aH9th-0006wF-5j
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 13:42:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753139AbcAGMmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 07:42:24 -0500
Received: from sym2.noone.org ([178.63.92.236]:33730 "EHLO sym2.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752773AbcAGMmW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2016 07:42:22 -0500
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 3pbnJX38x7zQWhF; Thu,  7 Jan 2016 13:42:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAPig+cSvD-TAd6365wxycUcTBehL-81a0WWosz4mVr1-HKCqGQ@mail.gmail.com>
X-Editor: Vi IMproved 7.3
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283478>

On 2016-01-06 at 20:02:23 +0100, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Jan 6, 2016 at 8:34 AM, Tobias Klauser
> <tobias.klauser@zhinst.com> wrote:
> > Add a command line option --in-place to support in-place editing akin to
> > sed -i.  This allows to write commands like the following:
> >
> >   git interpret-trailers --trailer "X: Y" a.txt > b.txt && mv b.txt a.txt
> >
> > in a more concise way:
> >
> >   git interpret-trailers --trailer "X: Y" --in-place a.txt
> >
> > Also add the corresponding documentation and tests.
> 
> In addition to Matthieu's comments...
> 
> > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> > ---
> > diff --git a/trailer.c b/trailer.c
> > @@ -856,19 +858,28 @@ void process_trailers(const char *file, int trim_empty, struct string_list *trai
> >
> >         lines = read_input_file(file);
> >
> > +       if (in_place) {
> > +               fp = fopen(file, "w");
> > +               if (!fp)
> > +                       die_errno(_("could not open file '%s' for writing"), file);
> > +       }
> 
> The input file should be considered precious, but this implementation
> plays too loosely with it. If the user interrupts the program or a
> die() somewhere within the "trailers" code aborts the program before
> the output file is written, then the original file will be
> irrecoverably lost. Users won't be happy about that.

Indeed, I didn't consider this. Thanks a lot for pointing this out.

> Instead, this code should go through the standard dance of writing the
> output to a new file (with some unique temporary name) and then, only
> once the output has been successfully written in full, rename the new
> file atop the old.

Ok, will do this for v2. I guess with the help of the functions from
tempfile.h it should be fairly easy to implement...

Thanks for your review!
