From: Ian Hilt <ian.hilt@gmx.com>
Subject: Re: [PATCH v2] Edit recipient addresses with the --compose flag
Date: Thu, 13 Nov 2008 21:10:43 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811132013530.6125@sys-0.hiltweb.site>
References: <1226544602-1839-1-git-send-email-ian.hilt@gmx.com> <7vskpwia91.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 03:12:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0oAY-0001Wb-Rm
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 03:12:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbYKNCLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 21:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbYKNCLD
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 21:11:03 -0500
Received: from mail.gmx.com ([74.208.5.67]:33458 "HELO mail.gmx.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751345AbYKNCLB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 21:11:01 -0500
Received: (qmail invoked by alias); 14 Nov 2008 02:10:58 -0000
Received: from cpe-75-185-223-130.woh.res.rr.com [75.185.223.130]
  by mail.gmx.com (mp-us003) with SMTP; 13 Nov 2008 21:10:58 -0500
X-Authenticated: #47758715
X-Provags-ID: V01U2FsdGVkX18DBqgaOfkDCvLd9vOqwkFtYgabPLy+nNJCPnrdms
	B7cHU0as/Eqf90
In-Reply-To: <7vskpwia91.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.45
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100946>

On Wed, 12 Nov 2008, Junio C Hamano wrote:
> Ian Hilt <ian.hilt@gmx.com> writes:
> 
> > Sometimes specifying the recipient addresses can be tedious on the
> > command-line.  This commit allows the user to edit the recipient
> > addresses in their editor of choice.
> >
> > Signed-off-by: Ian Hilt <ian.hilt@gmx.com>
> > ---
> > Here's an updated commit with improved regex's from Junio and Francis.
> 
> This heavily depends on Pierre's patch, so I am CC'ing him for comments.
> Until his series settles down, I cannot apply this anyway.

I didn't realize this was such a bad time to submit this patch.

> > @@ -489,6 +492,9 @@ GIT: for the patch you are writing.
> >  GIT:
> >  GIT: Clear the body content if you don't wish to send a summary.
> >  From: $tpl_sender
> > +To: $tpl_to
> > +Cc: $tpl_cc
> > +Bcc: $tpl_bcc
> >  Subject: $tpl_subject
> >  In-Reply-To: $tpl_reply_to
> >  
> > @@ -512,9 +518,31 @@ EOT
> >  	open(C,"<",$compose_filename)
> >  		or die "Failed to open $compose_filename : " . $!;
> >  
> > +	local $/;
> > +	my $c_file = <C>;
> > +	$/ = "\n";
> > +	close(C);
> > +
> > +	my (@tmp_to, @tmp_cc, @tmp_bcc);
> > +
> > +	if ($c_file =~ /^To:\s*(\S.+?)\s*\nCc:/ism) {
> > +		@tmp_to = get_recipients($1);
> > +	}
> 
> Why "\S.+?" and not "\S.*?"?  A local user whose login name is 'q' is
> disallowed?

True.  Thanks for pointing this out.

> Why does the user must keep "Cc:" in order for this new code to pick up
> the list of recipients?  In other words, you are forbidding the user from
> removing the entire "Cc:" line, even when the message should not be Cc'ed
> to anywhere.  Instead there has to remain an empty Cc: line.  Worse yet,
> such an empty "Cc:" line is printed to C2 with your patch and eventually
> fed to sendmail.  I think it is a violation of 2822 to have Cc: that is
> empty, as the format is specified as:
> 
>     cc              =       "Cc:" address-list CRLF
>     bcc             =       "Bcc:" (address-list / [CFWS]) CRLF
>     address-list    =       (address *("," address)) / obs-addr-list

I think you're mistaken here.  It is entirely possible to delete the Cc
and Bcc lines with no ill effect.  It is also possible to leave them in
and not add any addresses and the code won't feed these empty lines to
sendmail.  In the subroutine send_message, I believe a check is made to
determine if $cc is equal to ''.  If it's not, then it will use it.  The
Bcc list is even simpler.  It is gathered into @recipients via
unique_email_list().  If it's empty, nothing happens.

> > +	if ($c_file =~ /^Cc:\s*(\S.+?)\s*\nBcc:/ism) {
> > +		@tmp_cc = get_recipients($1);
> > +	}
> > +	if ($c_file =~ /^Bcc:\s*(\S.+?)\s*\nSubject:/ism) {
> > +		@tmp_bcc = get_recipients($1);
> > +	}
> 
> Exactly the same comment applies to Bcc and Subject part of the parsing.
> 
> I think the parsing code you introduced simply suck.  Why isn't it done as
> a part of the main loop to read the same file that already exists?

Multiline recipient fields.

I know rfc 2822 that you cited above specifies that the address list not
contain a CRLF but as a terminator.  However, I thought that for
readability's sake it would be good to enable the user to introduce a
line break into the recipient field.  This is why I used the regex's the
way I did and slurp'd the file rather than worked on it line-by-line.

> Unlike your additional code above that reads the whole file into a scalar
> only to discard, the existing main loop processes one line at a file
> (which should be more memory efficient), and you are not handling the
> header continuation line anyway, processing one line at a time would make
> your code much simpler (for one thing, you do not have to do /sm at all).
> Also it won't be confused as your version would if the message happens to
> have "To:" or "Cc:" in the message part, thanks to $in_body variable check
> that is already in the code.

I definitely agree.  I started out coding exactly this way but then
thought about Pierre's comment about bloated To and Cc fields.  This is
why I wanted to allow the user to introduce line breaks into the
recipient fields.  It's a lot easier to read a nicely formatted email
list if there are a lot of addresses.

As a second thought, I probably should have put RFC into the subject of
this patch.

And as far as my code's recipient regex matching the body of the
message, I'll try to find a solution.  It may not be possible to do
multiline recipient fields without this problem.  Thanks for reviewing
this.
