From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 1/2] git-send-email: two new options: to-cover,
 cc-cover
Date: Sun, 27 Apr 2014 21:36:43 +0300
Message-ID: <20140427183643.GB28551@redhat.com>
References: <1396548814-27278-1-git-send-email-mst@redhat.com>
 <xmqqa9c2qn6w.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 27 20:36:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeTvl-00029B-2E
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 20:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866AbaD0Sf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2014 14:35:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23368 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751249AbaD0Sf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2014 14:35:56 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3RIZtEG005755
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 27 Apr 2014 14:35:55 -0400
Received: from redhat.com (ovpn-116-40.ams2.redhat.com [10.36.116.40])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s3RIZrvs030010;
	Sun, 27 Apr 2014 14:35:54 -0400
Content-Disposition: inline
In-Reply-To: <xmqqa9c2qn6w.fsf@gitster.dls.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247220>

On Thu, Apr 03, 2014 at 11:31:51AM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > Allow extracting To/Cc addresses from cover letter.
> 
> Please say what you are doing with what you extract, which is the
> more important part of the objective.  Extracting is merely a step
> to achieve that.
> 
> s/.$/, to be used as To/Cc addresses of the remainder of the series./
> 
> or something.
> 

thanks, I did that in the new version.


> I think this will be a very handy feature.
> 
> If you have a series *and* you bothered to add To/Cc to the cover
> letter, it is likely that you want all the messages read by these
> people [*1*].
> 
> > @@ -1468,6 +1475,15 @@ foreach my $t (@files) {
> >  	@to = (@initial_to, @to);
> >  	@cc = (@initial_cc, @cc);
> >  
> > +	if ($message_num == 1) {
> > +		if (defined $cover_cc and $cover_cc) {
> > +			@initial_cc = @cc;
> > +		}
> > +		if (defined $cover_to and $cover_to) {
> > +			@initial_to = @to;
> > +		}
> > +	}
> > +
> 
> What is stored away with this code to @initial_cc/to includes:
> 
>  - what was given to @initial_cc/to before ll.1468-1469
>  - what was in @cc/to before ll.1468-1469
> 
> when we see the first message [*2*].  The former come from the
> command line --to/--cc, and the latter comes from the header lines
> of the first message.  Am I reading the code correctly?

Exactly.

> If that is the case, I think the updated code makes sense.
> 
> Thanks.
> 
> 
> [Footnote]
> 
> *1* Allowing this to be disabled is also a good thing this patch
>     does.  A 100 patch series that does a tree-wide clean-up may
>     have different set of people on To/Cc of individual patches, and
>     you may want the union of them on To/Cc on the cover letter, so
>     that a person may get the cover letter and a single patch that
>     relates to his area of expertise without having to see the
>     remainder.
> 
> *2* The first message may not necessarily be the cover letter.  Is
>     there a reliable way to detect that?


>  The user may want to send
>     out a series with only a few patches without any cover, and
>     taking To/Cc from the [PATCH 1/3] and propagating them to the
>     rest does not match what the documentation and the option name
>     claim to do.

Two things that come to mind:
	- check that subject has 0000/
		Needs some manual parsing, I don't like this much
	- check that there's no patch
		We could try running git mailinfo but it might give
		false negatives if cover letter happens to have
			---
			diff a/foo b/bar
		within it.
		Worth worrying about?

For now I simply updated the documentation.

-- 
MST
