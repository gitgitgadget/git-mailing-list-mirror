From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: git interpret-trailers with multiple keys
Date: Sun, 10 Apr 2016 20:06:59 +0300
Message-ID: <20160410195958-mutt-send-email-mst@redhat.com>
References: <20160406191054-mutt-send-email-mst@redhat.com>
 <vpqlh4qbrnt.fsf@anie.imag.fr>
 <20160406201509-mutt-send-email-mst@redhat.com>
 <xmqq1t6iy6p9.fsf@gitster.mtv.corp.google.com>
 <20160406212940-mutt-send-email-mst@redhat.com>
 <CAP8UFD0Pw+yhO1jZTAbMkZ5d-usu3rx5N0Se=PNL=N7DD-BPcA@mail.gmail.com>
 <20160410182750-mutt-send-email-mst@redhat.com>
 <CAP8UFD1hSg9RXLavzQgff-QioVU28_ZYhrfAvrhzNe8zXwwv5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 10 19:07:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apIpL-0001NC-P4
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 19:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755353AbcDJRHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 13:07:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50498 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754716AbcDJRHD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 13:07:03 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 179453B70A;
	Sun, 10 Apr 2016 17:07:03 +0000 (UTC)
Received: from redhat.com (vpn1-5-25.ams2.redhat.com [10.36.5.25])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u3AH70uU022915;
	Sun, 10 Apr 2016 13:07:01 -0400
Content-Disposition: inline
In-Reply-To: <CAP8UFD1hSg9RXLavzQgff-QioVU28_ZYhrfAvrhzNe8zXwwv5w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291180>

On Sun, Apr 10, 2016 at 06:57:53PM +0200, Christian Couder wrote:
> On Sun, Apr 10, 2016 at 11:32 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Wed, Apr 06, 2016 at 10:28:21PM -0400, Christian Couder wrote:
> >> On Wed, Apr 6, 2016 at 3:30 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >> > On Wed, Apr 06, 2016 at 10:42:42AM -0700, Junio C Hamano wrote:
> >> >> "Michael S. Tsirkin" <mst@redhat.com> writes:
> >> >>
> >> >> > On Wed, Apr 06, 2016 at 06:58:30PM +0200, Matthieu Moy wrote:
> >> >> >> "Michael S. Tsirkin" <mst@redhat.com> writes:
> >> >> >>
> >> >> >> > I have this in .git/config
> >> >> >> >
> >> >> >> > [trailer "r"]
> >> >> >> >         key = Reviewed-by
> >> >> >> >         command = "echo \"Michael S. Tsirkin <mst@redhat.com\""
> >> >> >> > [trailer "s"]
> >> >> >> >         key = Signed-off-by
> >> >> >> >         command = "echo \"Michael S. Tsirkin <mst@redhat.com\""
> >> >> >> >
> >> >> >> > whenever I run git interpret-trailers -t r I see these lines added:
> >> >> >> >
> >> >> >> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com
> >> >> >> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com
> >> >> >> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com
> >> >> >> >
> >> >> >> > Why is Reviewed-by repeated?  Bug or feature?
> >> >> >>
> >> >> >> The first two lines are added unconditionally:
> >> >> >>
> >> >> >> $ echo | git interpret-trailers
> >> >> >>
> >> >> >> Reviewed-by: Michael S. Tsirkin <mst@redhat.com
> >> >> >> Signed-off-by: Michael S. Tsirkin <mst@redhat.com
> >> >> >>
> >> >> >> The last line is added because you've asked for it with --trailer r.
> >>
> >> Yes, and because the default is to add the trailer at the end.
> >>
> >> >> >> I don't think it's currently possible to get the behavior you seem to
> >> >> >> expect, ie. to define trailer tokens fully (key and value) in your
> >> >> >> config file but use them only on request.
> >>
> >> Yes, because you could define for example a function like this:
> >>
> >> reviewed() {
> >>     git interpret-trailers --trailer 'Reviewed-by: Michael S. Tsirkin
> >> <mst@redhat.com>' --in-place "$@"
> >> }
> >>
> >> So it is kind of easy already to make things requestable.
> >
> > Not if any commands are configured. interpret-trailers will
> > insist on running them in any case.
> 
> If one want something requestable instead of automatic, one should
> definitely not configure any command.

Then one can't set any values, only keys.

> >> If people really want some configured trailers to be used only on
> >> request, it is possible to add a config option for that.
> >
> > this is not what the documentation says though:
> 
> What I meant is that we could create new options called maybe
> trailer.autocommands and trailer.<token>.autocommands that default to
> 'true' and if 'false' the command would not be run automatically and
> the corresponding trailer would not be added.
> 
> > I would say that if people really want to run all trailers while also
> > passing some on command line, *that* should be a config option.
> > Current default violates the principle of least surprise.
> 
> Current default is documented and is the most powerful default.

I'm not sure what makes you say that. What makes it the most powerful?

> Yes, it might be surprising though.
> >> >> >> (BTW, I think you wanted a closing > at the end)
> >> >> >
> >> >> > Is this worth fixing? It doesn't look like a behaviour anyone
> >> >> > would want...
> >> >>
> >> >> CC'ing Christian who's done the "trailers" thing.
> >> >>
> >> >> Personally, I do not think adding any configured trailers without
> >> >> being asked is a sensible behaviour, but it is likely that people
> >> >> already depend on it, as we seem to see "How do I configure to
> >> >> always add this and that trailer?" from time to time.  I do not
> >> >> think it is unreasonable to disable the "automatically add
> >> >> everything that is configured" when the command line arguments ask
> >> >> for some specific trailer, but I haven't thought deeply about it.
> >> >>
> >> >> An additional (uninformed) observation is that the 'echo' looks like
> >> >> an ugly workaround for the lack of "always use this string as the
> >> >> value" configuration.
> >> >
> >> > Or at least a default.
> >> >
> >> >> Perhaps next to trailer.<token>.command, we
> >> >> would need trailer.<token>.value?
> >>
> >> Yeah, that is possible too.
> >> It could be bit redundant if we already have a config option to say if
> >> the trailer has to be requested.
> >
> > Seems unrelated - if one just wants a string, using echo as
> > a command is inefficient and inconvenient.
> 
> Efficiency is not very high in the list for this kind of things. Also
> when these features were developed, many people wanted different
> powerful things and many people said they could help develop them
> though very few did help. So if you think trailer.<token>.value is
> really needed you are welcome to develop it.
> 
> Thanks,
> Christian.
