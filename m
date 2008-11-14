From: Ian Hilt <ian.hilt@gmx.com>
Subject: Re: [PATCH v2] Edit recipient addresses with the --compose flag
Date: Fri, 14 Nov 2008 11:58:42 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811141143360.2651@maintenance05.msc.mcgregor-surmount.com>
References: <1226544602-1839-1-git-send-email-ian.hilt@gmx.com> <7vskpwia91.fsf@gitster.siamese.dyndns.org> <alpine.LFD.2.00.0811132013530.6125@sys-0.hiltweb.site> <7v7i77f0f8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 18:00:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L121c-0004U8-FU
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 18:00:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbYKNQ6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 11:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751523AbYKNQ6s
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 11:58:48 -0500
Received: from mail.gmx.com ([74.208.5.67]:45714 "HELO mail.gmx.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751511AbYKNQ6s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 11:58:48 -0500
Received: (qmail invoked by alias); 14 Nov 2008 16:58:45 -0000
Received: from mail.mcgregor-surmount.com [70.61.40.162]
  by mail.gmx.com (mp-us005) with SMTP; 14 Nov 2008 11:58:45 -0500
X-Authenticated: #47758715
X-Provags-ID: V01U2FsdGVkX1+sIKYxqAqsvAJsn84+CHy7k0dvb9cS9iBLVoWXO5
	XtU4kfxiil0NwC
In-Reply-To: <7v7i77f0f8.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100987>

On Thu, 13 Nov 2008, Junio C Hamano wrote:
> Ian Hilt <ian.hilt@gmx.com> writes:
> > On Wed, 12 Nov 2008, Junio C Hamano wrote:
> >> Ian Hilt <ian.hilt@gmx.com> writes:
> >> 
> >> > Sometimes specifying the recipient addresses can be tedious on the
> >> > command-line.  This commit allows the user to edit the recipient
> >> > addresses in their editor of choice.
> >> >
> >> > Signed-off-by: Ian Hilt <ian.hilt@gmx.com>
> >> > ---
> >> > Here's an updated commit with improved regex's from Junio and Francis.
> >> 
> >> This heavily depends on Pierre's patch, so I am CC'ing him for comments.
> >> Until his series settles down, I cannot apply this anyway.
> >
> > I didn't realize this was such a bad time to submit this patch.
> 
> It is not a bad time.  I just won't be able to apply it right away, but
> people (like Pierre) who are interested in send-email enhancement can help
> improving your patch by reviewing.

And improvement it needs.

> >> Why does the user must keep "Cc:" in order for this new code to pick up
> >> the list of recipients?  ...
> >> 
> >>     cc              =       "Cc:" address-list CRLF
> >>     bcc             =       "Bcc:" (address-list / [CFWS]) CRLF
> >>     address-list    =       (address *("," address)) / obs-addr-list
> >
> > I think you're mistaken here.  It is entirely possible to delete the Cc
> > and Bcc lines with no ill effect.
> 
> You have this piece of code
> 
> >> > +	if ($c_file =~ /^To:\s*(\S.+?)\s*\nCc:/ism) {
> >> > +		@tmp_to = get_recipients($1);
> >> > +	}
> 
> to pick up the "To: " addressees.  If your user deletes Cc: line, would
> that regexp still capture them in @tmp_to?  How?

Wow.  I don't know why I didn't catch that.  You're right.

> > determine if $cc is equal to ''.  If it's not, then it will use it.
> 
> Ah, somehow I thought C2 you are writing into (message.final) was used as
> the final payload, but you are right.  The foreach () loop at the toplevel
> reads them and interprets them.
> 
> >> I think the parsing code you introduced simply suck.  Why isn't it done as
> >> a part of the main loop to read the same file that already exists?
> >
> > Multiline recipient fields.
> 
> So you were trying to handle folded headers after all, I see.
> 
> But if you were to go that route, I think you are much better off doing so
> by enabling the header folding for all the header lines in the while (<C>)
> loop that currently reads one line at a time.
> 
> I however hove to wonder why we are not using any canned e-mail header
> parser for this part of the code.  Surely there must be a widely used one
> that everybody who writes Perl uses???

I thought about this, but I didn't want to introduce another dependency.
I'm sure there's an easy way to do this stuff but I just don't have
enough perl know-how yet.

In any case, I think this concept needs serious work considering the
points that have been raised.  I don't have a lot of time to devote to
this however much I would like to complete it sooner than later.  So for
now, unless someone else wants to take up the mantle, I think it would
be better to put this patch aside.
