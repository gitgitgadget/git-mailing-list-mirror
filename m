From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [updated PATCH] Same default as cvsimport when using --use-log-author
Date: Mon, 28 Apr 2008 23:18:23 -0700
Message-ID: <20080429061823.GE24171@muzzle>
References: <20080427173246.10023.5687.stgit@aristoteles.cuci.nl> <7vbq3vf2k4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Stephen R. van den Berg" <srb@cuci.nl>, git@vger.kernel.org,
	Andy Whitcroft <apw@shadowen.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 08:19:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqjBr-0002zJ-IS
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 08:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754541AbYD2GSz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 02:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753794AbYD2GSy
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 02:18:54 -0400
Received: from hand.yhbt.net ([66.150.188.102]:53519 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754664AbYD2GSw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 02:18:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 998162DC08B;
	Mon, 28 Apr 2008 23:18:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vbq3vf2k4.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80651>

Junio C Hamano <gitster@pobox.com> wrote:
> "Stephen R. van den Berg" <srb@cuci.nl> writes:
> 
> > git-svn supports an experimental option --use-log-author which currently
> > results in:
> >
> > Author: foobaruser <unknown>
> 
> I have a question about this.  Is the "<unknown> coming from...
> 
> > This patches harmonises the result with cvsimport, and makes
> > git-svn --use-log-author produce:
> >
> > Author: foobaruser <foobaruser>
> > ...
> > diff --git a/git-svn.perl b/git-svn.perl
> > index b151049..846e739 100755
> > --- a/git-svn.perl
> > +++ b/git-svn.perl
> > @@ -2434,6 +2434,9 @@ sub make_log_entry {
> >  		} else {
> >  			($name, $email) = ($name_field, 'unknown');
> >  		}
> 
> ... this 'unknown' we see here?
> 
> > +	        if (!defined $email) {
> > +		    $email = $name;
> > +	        }
> >  	}
> 
> I would think not -- if that is the case, the codepath you added as a fix
> would not trigger.  Which means in some other cases, the 'unknown' we see
> above in the context also still happens.  Is it a good thing?  Maybe we
> would also want to make it consistently do "somebody <somebody>" instead,
> by doing...
> 
> 	} else {
> 		$name = $name_field;
> 	}
>         if (!defined $email) {
> 	    $email = $name;
>         }
> 

I don't think Stephen's patch ever gets triggered, either.

This section of code was done by Andy, so I can't tell his motivations
for using 'unknown' the way he did.

$email does appear to get set correctly for the first two elsifs cases
here in the existing code:

		if (!defined $name_field) {
			#
		} elsif ($name_field =~ /(.*?)\s+<(.*)>/) {
			($name, $email) = ($1, $2);
		} elsif ($name_field =~ /(.*)@/) {
			($name, $email) = ($1, $name_field);
		} else {
			($name, $email) = ($name_field, $name_field);

So I propose the following one-line change instead of Stephen's:

diff --git a/git-svn.perl b/git-svn.perl
index b151049..301a5b4 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2432,7 +2432,7 @@ sub make_log_entry {
 		} elsif ($name_field =~ /(.*)@/) {
 			($name, $email) = ($1, $name_field);
 		} else {
-			($name, $email) = ($name_field, 'unknown');
+			($name, $email) = ($name_field, $name_field);
 		}
 	}
 	if (defined $headrev && $self->use_svm_props) {

-- 
Eric Wong
