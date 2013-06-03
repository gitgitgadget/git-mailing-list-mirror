From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 2/6] send-email: fix suppress-cc=self on cccmd
Date: Mon, 3 Jun 2013 19:15:56 +0300
Message-ID: <20130603161556.GA16750@redhat.com>
References: <1369897638-27299-1-git-send-email-mst@redhat.com>
 <1369897638-27299-3-git-send-email-mst@redhat.com>
 <7v7gibjieh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 18:15:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjXPy-0005OJ-TR
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 18:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759401Ab3FCQP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 12:15:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25422 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759038Ab3FCQP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 12:15:27 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r53GFOfG017673
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 3 Jun 2013 12:15:25 -0400
Received: from redhat.com (vpn1-4-128.ams2.redhat.com [10.36.4.128])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id r53GFMbL003198;
	Mon, 3 Jun 2013 12:15:23 -0400
Content-Disposition: inline
In-Reply-To: <7v7gibjieh.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226228>

On Mon, Jun 03, 2013 at 08:58:14AM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > When cccmd is used, old-style suppress-from filter
> > is applied by the newer suppress-cc=self isn't.
> > Fix this up.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  git-send-email.perl | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/git-send-email.perl b/git-send-email.perl
> > index bd13cc8..a138615 100755
> > --- a/git-send-email.perl
> > +++ b/git-send-email.perl
> > @@ -1462,7 +1462,7 @@ sub recipients_cmd {
> >  		$address =~ s/^\s*//g;
> >  		$address =~ s/\s*$//g;
> >  		$address = sanitize_address($address);
> > -		next if ($address eq $sanitized_sender and $suppress_from);
> > +		next if ($address eq $sender and $suppress_cc{'self'});
> 
> If $suppress_from is defined, $suppress_cc{'self'} gets its value,
> so the latter half of this change is very understandable.
> 
> The original comparison uses $address that is "sanitized" (whose
> definition is roughly "mangled/quoted with rfc2047 etc to fit on
> To/Cc headers") against $sanitized_sender, which means for a
> 
>     $sender = 'Michael S. Tsirkin <mst@redhat.com>';
> 
> we used
> 
>     $sanitized_sender = '"Michael S. Tsirkin" <mst@redhat.com>';
> 
> for comparison, but the new code does not quote the $recipient_name
> part inside dq for the single dot after the middle name.  Is this a
> desirable change?

What I tried to do here is split the changes to small
chunks and I picked a chunk of a later patch in an earlier one
by mistake.

So this is fixed up by patch 4/6
in the series, which redefines sender to have
the sanitized value, everywhere.

I guess I'll have to repost moving this former
chunk to patch 4.


> >  		push @addresses, $address;
> >  		printf("($prefix) Adding %s: %s from: '%s'\n",
> >  		       $what, $address, $cmd) unless $quiet;
