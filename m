From: Alexey Shumkin <zapped@mail.ru>
Subject: Re: [PATCH] send-email: Honor multi-part email messages
Date: Wed, 21 Sep 2011 00:19:25 +0400
Message-ID: <20110921001925.03a83d3a@zappedws>
References: <1316507347-6693-1-git-send-email-zapped@mail.ru>
	<7v1uvb6mn9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 20 22:19:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R66n2-0008OM-TS
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 22:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751635Ab1ITUTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 16:19:32 -0400
Received: from smtp13.mail.ru ([94.100.176.90]:45906 "EHLO smtp13.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751375Ab1ITUTc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 16:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail;
	h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date; bh=z746nyVVxEXSD6tzYfu51LdJ2l1hiN5eQuOH9X/mLK0=;
	b=B02ANeVXjSngRw93Y1nELT7dbWiLGFroEKQ6HZPc29/wV3bejonfCVJWJM/y69gvnaYY+wVlMUcdHFueQqo0oF2QcHGA90lcVg0ZDCEWFZkw0f8rIulprFbA0zH7uw2c;
Received: from [91.77.15.134] (port=46847 helo=zappedws)
	by smtp13.mail.ru with psmtp 
	id 1R66mv-0008U0-00; Wed, 21 Sep 2011 00:19:29 +0400
In-Reply-To: <7v1uvb6mn9.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; i386-redhat-linux-gnu)
X-Spam: Not detected
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181791>

> Alexey Shumkin <zapped@mail.ru> writes:
> 
> > diff --git a/git-send-email.perl b/git-send-email.perl
> > index 98ab33a..1abf4a4 100755
> > --- a/git-send-email.perl
> > +++ b/git-send-email.perl
> > @@ -1403,12 +1403,17 @@ sub file_has_nonascii {
> >  
> >  sub body_or_subject_has_nonascii {
> >  	my $fn = shift;
> > +	my $multipart = 0;
> >  	open(my $fh, '<', $fn)
> >  		or die "unable to open $fn: $!\n";
> >  	while (my $line = <$fh>) {
> >  		last if $line =~ /^$/;
> > +		if ($line
> > =~ /^Content-Type:\s*multipart\/mixed.*$/) {
> > +			$multipart = 1;
> > +		}
> >  		return 1 if $line =~ /^Subject.*[^[:ascii:]]/;
> >  	}
> > +	return 0 if $multipart;
> 
> Looks as if you can lose the extra variable and return 0 immediately
> when you find a line with that Content-Type inside the loop.
Well, as I understand "current" algorithm:
1. It assumes that file is one-part email message
2. Function searches non-ASCII characters in Subject header
3. If none then it looks non-ASCII characters at message body

my changes are to skip looking at message body of a multi-part
message as it has parts with their own Content-Type headers

The said above in details:
1. To set flag when we meet Content-Type: multipart/mixed header
2. After we processed all headers and did not found non-ASCII characters
in a Subject we take a look at this flag and exit with 0
if it is a multi-part message
