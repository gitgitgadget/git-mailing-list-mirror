From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] git-send-email: fix handling of special characters
Date: Fri, 24 May 2013 00:19:54 +0300
Message-ID: <20130523211954.GD31421@redhat.com>
References: <20130523135418.GA20741@redhat.com>
 <7vk3mpeaok.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 23 23:19:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfcvD-00028o-8z
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 23:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759092Ab3EWVTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 17:19:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:17844 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758830Ab3EWVTe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 17:19:34 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4NLJXq0032586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 23 May 2013 17:19:33 -0400
Received: from redhat.com (vpn-202-161.tlv.redhat.com [10.35.202.161])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id r4NLJU3p014659;
	Thu, 23 May 2013 17:19:32 -0400
Content-Disposition: inline
In-Reply-To: <7vk3mpeaok.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225297>

On Thu, May 23, 2013 at 12:52:11PM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > When patch sender's name has special characters,
> > git send-email did not quote it before matching
> > against the author name.
> > As a result it would produce mail like this:
> >
> > 	Date: Thu, 23 May 2013 16:36:00 +0300
> > 	From: "Michael S. Tsirkin" <mst@redhat.com>
> > 	To: qemu-devel@nongnu.org
> > 	Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > 	Subject: [PATCH 0/9] virtio: switch to linux headers
> > 	Message-Id: <1369316169-20181-1-git-send-email-mst@redhat.com>
> >
> > 	From: "Michael S. Tsirkin" <mst@redhat.com>
> >
> > Fix by sanitizing before matching to patch author name.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  git-send-email.perl | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/git-send-email.perl b/git-send-email.perl
> > index bd13cc8..c4dc438 100755
> > --- a/git-send-email.perl
> > +++ b/git-send-email.perl
> > @@ -1400,7 +1400,8 @@ foreach my $t (@files) {
> >  		$subject = quote_subject($subject, $auto_8bit_encoding);
> >  	}
> >  
> > -	if (defined $author and $author ne $sender) {
> > +	my $sanitized_sender = sanitize_address($sender);
> > +	if (defined $author and $author ne $sanitized_sender) {
> >  		$message = "From: $author\n\n$message";
> >  		if (defined $author_encoding) {
> >  			if ($has_content_type) {
> 
> Is $author already sanitized at this point in the code?  I see it
> was unwrapped with unquote_rfc2047 after it was read from the From:
> line; will it always be the same as sanitize_address($author) would
> return, and if not, would you rather compare between sanitized
> versions of sender and author, no?

Yes. I'll have to look at the code more closely.
In my testing author here is "Michael S. Tsirkin" <mst@redhat.com>
so it matches the sanitized sender.
Of course that's because my name does not have non-ascii,
just a dot.

> Also, isn't the $sender the same during the whole outer loop that
> iterates over @files?  Do we need to apply sanitize_address() on it
> over and over for each and every logical line in the @header?
> 
> This comment also applies to the other patch but they probably
> should become a single patch anyway, I guess?

OK so now you are ok with this last bit, right?
