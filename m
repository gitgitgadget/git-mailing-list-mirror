From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cvsexportcommit: be graceful when "cvs status" reorders
 the arguments
Date: Mon, 18 Feb 2008 17:54:27 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802181627340.30505@racer.site>
References: <alpine.LSU.1.00.0802180127100.30505@racer.site> <7vbq6fvudp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Martin Langhoff <martin@catalyst.net.nz>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 18:55:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRAD1-0004UF-07
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 18:55:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554AbYBRRym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 12:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752552AbYBRRyl
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 12:54:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:35044 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752409AbYBRRyl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 12:54:41 -0500
Received: (qmail invoked by alias); 18 Feb 2008 17:54:39 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp015) with SMTP; 18 Feb 2008 18:54:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19uB0oQCi1uJ3e9h5IbZKWb1RVvmXNXGuHW/KoC+f
	mgGGIcgVayk7IF
X-X-Sender: gene099@racer.site
In-Reply-To: <7vbq6fvudp.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74322>

Hi,

On Sun, 17 Feb 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > 	Feel free to criticise/educate me on my Perl style.
> 
> Here it goes ;-)

Very much appreciated.

> > +    # "cvs status" reorders the parameters, notably when there are multiple
> > +    # arguments with the same basename.  So be precise here.
> > +    while (@canstatusfiles) {
> > +      my @canstatusfiles2 = ();
> > +      my %basenames = ();
> > +      for (my $i = 0; $i <= $#canstatusfiles; $i++) {
> 
> The "$index <= $#array" termination condition feels so Perl4-ish.
> 
> 	for (my $i = 0; $i < @canstatusfiles; $i++) {

It looks nicer, granted.  But because of my use of splice(), it does not 
work.  However, it seems that I introduced another breakage there...

So this is how I will do it: have a hash with all remaining fullnames, and 
"delete" them when they are done.

> > +        my $name = $canstatusfiles[$i];
> 
> > +	my $basename = $name;
> > +	$basename =~ s/.*\///;
> 
> The script uses File::Basename upfront so perhaps just simply...

I tried that.  But as the file need not exist, "basename" went on strike.

So I'll keep the (ugly) version.

> 	my $basename = basename($name);
> 
> > +	$basename = "no file " . $basename if (grep {$_ eq $basename} @afiles);
> 
> Huh?  Perl or no Perl that is too ugly a hack...  What special treatment 
> do "added files" need?  We would want to make sure that the files are 
> not reported from "cvs status"?

To the contrary, they _are_ reported, with an ugly "no file " prepended.  

So in order to verify those, I have to make sure that there is no file 
named "no file <blabla>", which would not be distinguishable from the 
reported for the non-existing file "<blabla>".

But I'll just use your %added idea.

> > +	chomp($basename);
> 
> Huh?  Perhaps you wanted to chomp at the very beginning of the loop?

No, I want to do that after the "no file " prepending.  Because that is 
the way "cvs status" reports them... with no good way for me to tell how 
much leading/trailing white space there is.

But you're right, I should add a test to verify that a filename with 
leading spaces is added correctly.

So I will do that.

> > +	if (!defined($basenames{$basename})) {
> > +	  $basenames{$basename} = $name;
> > +	  push (@canstatusfiles2, $name);
> > +	  splice (@canstatusfiles, $i, 1);
> > +	  $i--;
> >          }
> > +      }
> 
> > +      my @cvsoutput;
> > +      @cvsoutput = xargs_safe_pipe_capture([@cvs, 'status'], @canstatusfiles2);
> > +      foreach my $l (@cvsoutput) {
> > +          chomp $l;
> > +          if ( $l =~ /^File:\s+(.*\S)\s+Status: (.*)$/ ) {
> > +            $cvsstat{$basenames{$1}} = $2 if defined($basenames{$1});
> > +          }
> > +      }
> 
> I think "exists $hash{$index}" would be easier to read and more
> logical here and also if () condition above.

Right.

Thanks for your review,
Dscho
