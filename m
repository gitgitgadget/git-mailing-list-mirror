From: "Li Yang-r58472" <LeoLi@freescale.com>
Subject: RE: gitweb not friendly to firefox?
Date: Fri, 2 Mar 2007 18:27:54 +0800
Message-ID: <989B956029373F45A0B8AF02970818902DA81D@zch01exm26.fsl.freescale.net>
References: <7vabyweypw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Cc: "Jakub Narebski" <jnareb@gmail.com>, <rea-git@codelabs.ru>,
	"Raimund Bauer" <ray@softwarelandschaft.com>, <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 02 11:26:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN4yE-00073A-Nf
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 11:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423005AbXCBK0f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 05:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423004AbXCBK0f
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 05:26:35 -0500
Received: from de01egw02.freescale.net ([192.88.165.103]:45589 "EHLO
	de01egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423002AbXCBK0f convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Mar 2007 05:26:35 -0500
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id l22AQVgL017965
	for <git@vger.kernel.org>; Fri, 2 Mar 2007 03:26:32 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net [10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l22AQU6b005184
	for <git@vger.kernel.org>; Fri, 2 Mar 2007 04:26:30 -0600 (CST)
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <7vabyweypw.fsf@assigned-by-dhcp.cox.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: gitweb not friendly to firefox?
Thread-Index: AcdctANPY7NV02RiTo6RI16Wq3ecMQAAIvsA
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41183>

> -----Original Message-----
> From: Junio C Hamano [mailto:junkio@cox.net]
> Sent: Friday, March 02, 2007 6:18 PM
> To: Li Yang-r58472
> Cc: Jakub Narebski; rea-git@codelabs.ru; Raimund Bauer;
git@vger.kernel.org
> Subject: Re: gitweb not friendly to firefox?
> 
> "Li Yang-r58472" <LeoLi@freescale.com> writes:
> 
> > Hi Jakub,
> >
> > Problem sovled, using the following patch.  I'm not an expert of
perl,
> > so I don't know if it is problem of the gitweb or problem with my
perl
> > environment.  My environment is perl-5.8.0 and perl-CGI-2.81.
> >
> > Signed-off-by: Li Yang<leoli@freecale.com>
> > ---
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index 653ca3c..8c9a291 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -591,7 +591,7 @@ sub esc_html ($;%) {
> >         my %opts = @_;
> >
> >         $str = to_utf8($str);
> > -       $str = escapeHTML($str);
> > +       $str = $cgi->escapeHTML($str);
> >         if ($opts{'-nbsp'}) {
> >                 $str =~ s/ /&nbsp;/g;
> >         }
> >
> 
> This is puzzling....
> 
>  (1) we have two call sites of escapeHTML(), but your patch
>      touches only one.
> 
>  (2) we do "use CGI qw(:standard :escapeHTML -nosticky);"
>      upfront, presumably after doing this when we say
>      escapeHTML() it means the same as CGI::escapeHTML().
> 
>  (3) we do "$cgi = new CGI" upfront.
> 
> So I am wondering how the patch can have any effect...
> 
> I am not saying that I do not believe you when you say the patch
> fixes the problem for you.  I just do not understand why and I
> hate not knowing why something works.

Here is the phenomenon I observed. In CGI.pm,
# Escape HTML -- used internally
'escapeHTML' => <<'END_OF_FUNC',
sub escapeHTML {
         # hack to work around  earlier hacks
         push @_,$_[0] if @_==1 && $_[0] eq 'CGI';
         my ($self,$toencode,$newlinestoo) = CGI::self_or_default(@_);
         return undef unless defined($toencode);
         return $toencode if ref($self) && !$self->{'escape'};
         $toencode =~ s{&}{&amp;}gso;
         $toencode =~ s{<}{&lt;}gso;
         $toencode =~ s{>}{&gt;}gso;
         $toencode =~ s{"}{&quot;}gso;
         my $latin = uc $self->{'.charset'} eq 'ISO-8859-1' ||
                     uc $self->{'.charset'} eq 'WINDOWS-1252';
         if ($latin) {  # bug in some browsers
                $toencode =~ s{'}{&#39;}gso;
                $toencode =~ s{\x8b}{&#8249;}gso;
                $toencode =~ s{\x9b}{&#8250;}gso;
                if (defined $newlinestoo && $newlinestoo) {
                     $toencode =~ s{\012}{&#10;}gso;
                     $toencode =~ s{\015}{&#13;}gso;
                }
         }
         return $toencode;
}
END_OF_FUNC

The escapeHTML() returns on " return $toencode if ref($self) &&
!$self->{'escape'};".  So the $self->{'ecscape'} = 0.  However,
$cgi->{'escape'} = 1.  So I know, the $self is not the $cgi in gitweb,
but another CGI with 'escape' undefined.

- Leo
