From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [updated PATCH] Same default as cvsimport when using --use-log-author
Date: Tue, 29 Apr 2008 10:52:24 +0100
Message-ID: <20080429095213.GY5401@shadowen.org>
References: <20080427173246.10023.5687.stgit@aristoteles.cuci.nl> <7vbq3vf2k4.fsf@gitster.siamese.dyndns.org> <20080429061823.GE24171@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Stephen R. van den Berg" <srb@cuci.nl>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Apr 29 11:53:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqmWg-0005aq-VI
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 11:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbYD2JwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 05:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbYD2JwY
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 05:52:24 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:4535 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483AbYD2JwX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 05:52:23 -0400
Received: from localhost ([127.0.0.1] helo=pinky)
	by hellhawk.shadowen.org with esmtp (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1JqmVZ-0001uH-Fu; Tue, 29 Apr 2008 10:52:21 +0100
Content-Disposition: inline
In-Reply-To: <20080429061823.GE24171@muzzle>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80673>

On Mon, Apr 28, 2008 at 11:18:23PM -0700, Eric Wong wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
> > "Stephen R. van den Berg" <srb@cuci.nl> writes:
> > 
> > > git-svn supports an experimental option --use-log-author which currently
> > > results in:
> > >
> > > Author: foobaruser <unknown>
> > 
> > I have a question about this.  Is the "<unknown> coming from...
> > 
> > > This patches harmonises the result with cvsimport, and makes
> > > git-svn --use-log-author produce:
> > >
> > > Author: foobaruser <foobaruser>
> > > ...
> > > diff --git a/git-svn.perl b/git-svn.perl
> > > index b151049..846e739 100755
> > > --- a/git-svn.perl
> > > +++ b/git-svn.perl
> > > @@ -2434,6 +2434,9 @@ sub make_log_entry {
> > >  		} else {
> > >  			($name, $email) = ($name_field, 'unknown');
> > >  		}
> > 
> > ... this 'unknown' we see here?
> > 
> > > +	        if (!defined $email) {
> > > +		    $email = $name;
> > > +	        }
> > >  	}
> > 
> > I would think not -- if that is the case, the codepath you added as a fix
> > would not trigger.  Which means in some other cases, the 'unknown' we see
> > above in the context also still happens.  Is it a good thing?  Maybe we
> > would also want to make it consistently do "somebody <somebody>" instead,
> > by doing...
> > 
> > 	} else {
> > 		$name = $name_field;
> > 	}
> >         if (!defined $email) {
> > 	    $email = $name;
> >         }
> > 
> 
> I don't think Stephen's patch ever gets triggered, either.
> 
> This section of code was done by Andy, so I can't tell his motivations
> for using 'unknown' the way he did.

My motivation was that we had picked up a field which is supposed to be
in RFC822 From: format, ie Name <email>, and dispite trying pretty hard
we had not been able to find something that looked like an email to put
in the email field of the git author et al.  So we didn't really know,
hence 'unknown'.

That said it is not at all clear that putting 'unknown' in this field to
avoid putting an invalid email in this field makes much sense as it of
itself is just as invalid.  So I would probabally be just as happy with
your option here.

> $email does appear to get set correctly for the first two elsifs cases
> here in the existing code:
> 
> 		if (!defined $name_field) {
> 			#
> 		} elsif ($name_field =~ /(.*?)\s+<(.*)>/) {
> 			($name, $email) = ($1, $2);
> 		} elsif ($name_field =~ /(.*)@/) {
> 			($name, $email) = ($1, $name_field);
> 		} else {
> 			($name, $email) = ($name_field, $name_field);
> 
> So I propose the following one-line change instead of Stephen's:
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index b151049..301a5b4 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -2432,7 +2432,7 @@ sub make_log_entry {
>  		} elsif ($name_field =~ /(.*)@/) {
>  			($name, $email) = ($1, $name_field);
>  		} else {
> -			($name, $email) = ($name_field, 'unknown');
> +			($name, $email) = ($name_field, $name_field);
>  		}
>  	}
>  	if (defined $headrev && $self->use_svm_props) {
> 
> -- 
> Eric Wong

-apw
