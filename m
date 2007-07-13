From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] make git-send-email.perl handle email addresses with
	no names when Email::Valid is present
Date: Thu, 12 Jul 2007 23:34:14 -0700
Message-ID: <20070713063414.GN24317@kroah.com>
References: <20070713041749.GA28824@kroah.com> <7vr6ncrh22.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 13 08:32:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9Eh6-0005HZ-8j
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 08:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbXGMGb4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 02:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751829AbXGMGb4
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 02:31:56 -0400
Received: from canuck.infradead.org ([209.217.80.40]:35559 "EHLO
	canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbXGMGb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 02:31:56 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174] helo=localhost)
	by canuck.infradead.org with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1I9Eh0-0003g8-2T; Fri, 13 Jul 2007 02:31:54 -0400
Content-Disposition: inline
In-Reply-To: <7vr6ncrh22.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52365>

On Thu, Jul 12, 2007 at 10:47:17PM -0700, Junio C Hamano wrote:
> Greg KH <greg@kroah.com> writes:
> 
> > When using git-send-email.perl on a changeset that has:
> > 	Cc: <stable@kernel.org>
> > in the body of the description, and the Email::Valid perl module is
> > installed on the system, the email address will be deemed "invalid" for
> > some reason (Email::Valid isn't smart enough to handle this?) and
> > complain and not send the address the email.
> 
> That appears to be the case.
> 
>         bad foo
>         bad <foo@bar.baz>
>         ok  foo@bar.baz
>         ok  Foo <foo@bar.baz>
> 
> > Anyway, this tiny patch fixes this problem for me.  Note, my perl-foo is
> > quite week, so this could probably be easily done in one line for those
> > with better reg-ex skills.
> 
> > --- a/git-send-email.perl
> > +++ b/git-send-email.perl
> > @@ -410,6 +410,9 @@ sub extract_valid_address {
> >  	return $address if ($address =~ /^($local_part_regexp)$/);
> >  
> >  	if ($have_email_valid) {
> > +		if ($address =~ s/^<//) {
> > +			$address =~ s/>$//;
> > +		}
> >  		return scalar Email::Valid->address($address);
> >  	} else {
> 
> I'd probably do:
> 
> 	if ($have_email_valid) {
> 		$address =~ s/^<(.*)>$/$1/;

Ah, yeah, that looks better :)

Thanks for the fix,

greg k-h
