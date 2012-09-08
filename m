From: Robin Stocker <robin@nibor.org>
Subject: Re: [PATCH] cherry-pick: Append -x line on separate paragraph
Date: Sat, 8 Sep 2012 16:10:59 +0200 (CEST)
Message-ID: <1498324622.1357.1347113459304.JavaMail.root@bazinga.schuettel.ch>
References: <7vmx136cdc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 08 16:11:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TALkf-0000Tc-Sw
	for gcvg-git-2@plane.gmane.org; Sat, 08 Sep 2012 16:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717Ab2IHOLG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Sep 2012 10:11:06 -0400
Received: from cust.static.212-90-207-187.cybernet.ch ([212.90.207.187]:33741
	"EHLO bazinga.schuettel.ch" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751855Ab2IHOLE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Sep 2012 10:11:04 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by bazinga.schuettel.ch (Postfix) with ESMTP id 20C1D1C00A4;
	Sat,  8 Sep 2012 16:11:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at schuettel.ch
Received: from bazinga.schuettel.ch ([127.0.0.1])
	by localhost (bazinga.schuettel.ch [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o8IEy8cANvEF; Sat,  8 Sep 2012 16:10:59 +0200 (CEST)
Received: from bazinga.schuettel.ch (cust.static.212-90-207-187.cybernet.ch [212.90.207.187])
	by bazinga.schuettel.ch (Postfix) with ESMTP id 81EFB1C0053;
	Sat,  8 Sep 2012 16:10:59 +0200 (CEST)
In-Reply-To: <7vmx136cdc.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [213.188.53.99]
X-Mailer: Zimbra 6.0.10_GA_2692 (ZimbraWebClient - SAF3 (Linux)/6.0.10_GA_2692)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205013>

Junio C Hamano writes:
> Robin Stocker <robin@nibor.org> writes:
> 
> > Junio C Hamano writes:
> >> Robin Stocker <robin@nibor.org> writes:
> >>
> >> >  		if (opts->record_origin) {
> >> > + /* Some implementations don't terminate message with final \n,
> >> > so
> >> > add it */
> >> > + if (msg.message[strlen(msg.message)-1] != '\n')
> >> > + strbuf_addch(&msgbuf, '\n');
> >>
> >> I can agree that this is a good change.
> >>
> >> > + strbuf_addch(&msgbuf, '\n');
> >>
> >> But this is somewhat dubious. Even if what we are adding is merely
> >> an extra LF, that changes the mechanically generated output format
> >> and can break existing hooks that read from these generated commit
> >> log template.
> >
> > Hm, for a script to break because of an extra LF it would have to be
> > very badly written. If it looks for "\n(cherry picked ...", it would
> > still work. But I see the point.
> 
> If you approach this change from the "information left by -x is
> somehow useful" point of view, it wouldn't make any difference.
> Scripts can match "(cherry picked from ..." and glean useful
> information out of it, with or without an empty line around it.
> 
> But if you look at it from the other perspective [*1*], it makes a
> big difference. A script that wants to excise these lines used to
> be able to just delete such a line. With the proposed change, it
> also has to be aware of an empty line next to it.

Ok, didn't think that a script would want to remove such a line. It
makes sense when considering that it used to always add the line.
Thanks for explaining.

> >> Is there a reason better than "having an empty line there look
> >> better to _me_" to justify this change?
> >
> > Yes:
> 
> Then please have them in the proposed commit log message to justify
> the change. I think the following analysis I quoted from your
> message summarizes the motivation well.
> 
> > * If the original commit message consisted just of a summary line,
> >   the commit message after -x would then not have a blank second
> >   line, which is bad style, e.g.:
> >
> > The title of the original commit
> > (cherry picked ...)
> 
> This is very true. So we at least want an empty line added when the
> original is one-liner.
> 
> > * If the original message did not have any trailers, the appended
> >   text would stick to the last paragraph, even though it is a
> >   separate thing.
> 
> The other side of this argument is if there are trailers, we would
> not want an extra blank line. We need to look at the last paragraph
> of the log message and if it does not end with a trailer, we want an
> additional empty line.
> 
> > Maybe the solution is to detect if the original commit message
> > ends with a trailer and in that case keep the existing behavior
> > of not inserting a blank line?
> 
> Yeah, that sounds like a good change from "this makes the result
> look better" point of view.

How do you think we could best detect a tailer? Check if all
lines of the last paragraph start with /[\w-]+: /?

> > Oh, I like that proposal. I'd lean towards a new --trailer option I
> > think.
> >
> > It would have the same problem of having to append it on a separate
> > paragraph if the original commit message does not already have a
> > trailer though.
> 
> Yes. The logic would be the same. First terminate the incomplete
> last line, if any, and then look at the last paragraph of the commit
> log message (one liner is a natural degenerate case of this; its
> single-line title is the last paragraph) and if and only if it does
> not end with a trailer, add a blank line before adding the marker.
> 
> The only difference between the two would be how the "cherry-picked
> from" line is formatted.

Right.

I'm going to work on this and submit a new version of the patch. The
"Cherry-picked-from" change could then be made later on top of that.

> [Footnote]
> 
> *1* Originally, we added "(cherry picked from ..." by default, and
> had a switch to disable it; later we made it off by default and made
> it optional (and discouraged) with "-x" and this was for a reason.
> Unless the original commit object is also available to the reader of
> the history, the line is a useless noise, and many people are found
> to cherry-pick from their private branches; by definition, the line
> is useless in the resulting commit of such a cherry-pick.
