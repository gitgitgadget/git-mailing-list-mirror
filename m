From: Jan Viktorin <viktorin@rehivetech.com>
Subject: Re: [PATCH v1] send-email: provide whitelist of SMTP AUTH
 mechanisms
Date: Mon, 3 Aug 2015 12:24:32 +0200
Organization: RehiveTech
Message-ID: <20150803122432.21066d73@pcviktorin.fit.vutbr.cz>
References: <1438385617-29159-1-git-send-email-viktorin@rehivetech.com>
	<CAPig+cT842GAFFM-wfjSU1ZiOevDCOPNDWxux6-vqtdr=3F4qw@mail.gmail.com>
	<20150801201950.5d8c1951@jvn>
	<CAPig+cQwgYYYYsszaRdJDwFLLB0PmiDQ_WTa+Nzzoq0U1zuMiA@mail.gmail.com>
	<20150802184353.2a5da936@jvn>
	<xmqqwpxd8rz2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 12:27:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMCxS-0008W5-RH
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 12:27:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752840AbbHCK06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 06:26:58 -0400
Received: from w-smtp-out-7.wedos.net ([46.28.106.5]:39540 "EHLO
	we2-f167.wedos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751982AbbHCK06 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 06:26:58 -0400
Received: from ([147.229.13.147])
        by we2-f167.wedos.net (WEDOS Mail Server mail2) with ASMTP (SSL) id QWD00151;
        Mon, 03 Aug 2015 12:26:51 +0200
In-Reply-To: <xmqqwpxd8rz2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275161>

On Sun, 02 Aug 2015 11:28:49 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Jan Viktorin <viktorin@rehivetech.com> writes:
> 
> > Authen::SASL gives:
> >
> > No SASL mechanism found
> >  at /usr/share/perl5/vendor_perl/Authen/SASL.pm line 77.
> >  at /usr/share/perl5/core_perl/Net/SMTP.pm line 207.
> >
> > The SASL library does not check validity of mechanisms'
> > names (or I did not find it). It just tries to load one
> > that matches both the ours and the server side ones.
> > ...
> > I would like to include the regex check based on RFC 4422
> > as I've already mentioned. at least, it filters out the
> > unwanted characters like '/', '.', etc.
> 
> Hmm, is there a way to ask Authen::SASL what SASL mechanism the
> installed system supports?  If so, the enhancement you are adding
> could be
> 
> 	my @to_use;
> 	if ($smtp_auth_whitelist is supplied) {
> 		my @installed = Authen::SASL::list_mechanisms();
>                 for (@installed) {
>                 	if ($_ is whitelisted) {
> 				push @to_use, $_;
> 			}
> 		}
> 	}
> 
> and @to_use can later be supplied when we open the connection as the
> list of mechanisms we allow the library to pick.
> 
> Just my $.02

I didn't find a way how to determine what mechanisms are supported by SASL.
This is a way how it looks for a mechanism (I think) on new():

Authen/SASL/Perl.pm

 57   my @mpkg = sort {
 58     $b->_order <=> $a->_order
 59   } grep {
 60     my $have = $have{$_} ||= (eval "require $_;" and $_->can('_secflags')) ? 1 : -1;
 61     $have > 0 and $_->_secflags(@sec) == @sec
 62   } map {
 63     (my $mpkg = __PACKAGE__ . "::$_") =~ s/-/_/g;
 64     $mpkg;
 65   } split /[^-\w]+/, $parent->mechanism
 66     or croak "No SASL mechanism found\n";

It just loads a package based on the names we provide. So it seems, the library
has no clue about the existing mechanisms. This would be possible by reading the
proper directory with packages which seems to be quite wierd anyway.

-- 
   Jan Viktorin                  E-mail: Viktorin@RehiveTech.com
   System Architect              Web:    www.RehiveTech.com
   RehiveTech
   Brno, Czech Republic
