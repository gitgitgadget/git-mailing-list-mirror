From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: don't call methods on undefined values
Date: Thu, 12 Sep 2013 23:09:45 -0700
Message-ID: <xmqqd2odl0ba.fsf@gitster.dls.corp.google.com>
References: <1378673674-97212-1-git-send-email-sandals@crustytoothpaste.net>
	<xmqqli363pwp.fsf@gitster.dls.corp.google.com>
	<20130909224950.GA101065@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, artagnon@gmail.com, mst@redhat.com
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Fri Sep 13 08:09:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKMZm-00027j-0m
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 08:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134Ab3IMGJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 02:09:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39099 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751467Ab3IMGJt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 02:09:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 010F03E263;
	Fri, 13 Sep 2013 06:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=xwYridb205O+rUzW6Bk+/sOPdnI=; b=pbdjPN1IzXDCSPaWKwZs
	g9+VDEnSMETV8YxisjgPjLIXjJW23hTB7+eLoXsK9mRKlL0tIg2ufgrfAI0lDlaP
	oHRjdUmMelPNGY6IL5TrKEEwiXnimGTQAY9/fELXPohOSl1A9tWdb64sKS3fi/Fi
	KP8k0PlueCv3FXnSd8WLFJs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Kv6HUvuEAgIrCSZ5ypt9rn82SQ1tfmOb1n9LtjQak8u0di
	sE/GuwRG8k0OaeesClBHstG4loyr5/79mzfFGwMD5jnk/DFee2aYOhVjP1rLMGfO
	dwl09sb2IuC3uYAJ4wJiKtjrxoQRCChg50uCYONu7IfPSigx9YAJ6Tt0s6Gvc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD7593E260;
	Fri, 13 Sep 2013 06:09:48 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E7FB3E254;
	Fri, 13 Sep 2013 06:09:48 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 17F83826-1C3B-11E3-81A1-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234733>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Mon, Sep 09, 2013 at 09:45:10AM -0700, Junio C Hamano wrote:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> > --- a/git-send-email.perl
>> > +++ b/git-send-email.perl
>> > @@ -1234,7 +1234,7 @@ X-Mailer: git-send-email $gitversion
>> >  				if ($smtp->code == 220) {
>> >  					$smtp = Net::SMTP::SSL->start_SSL($smtp,
>> >  									  ssl_verify_params())
>> > -						or die "STARTTLS failed! ".$smtp->message;
>> > +						or die "STARTTLS failed! ".IO::Socket::SSL::errstr();
>> 
>> I agree that $smtp->message may be bogus at this point, but could
>> "require IO::Socket::SSL" have failed on us in ssl_verify_params?
>> In that degraded mode, we do not do SSL peer verification, but
>> otherwise we would still attempt to talk with the peer, and in such
>> a case, IO::Socket::SSL would not be available to us at this point,
>> no?
>
> Since Net::SMTP::SSL uses IO::Socket::SSL (in fact, it is an
> IO::Socket::SSL), we can be guaranteed that it is, in fact, available at
> this point.  I guess strictly we don't need that require in
> IO::Socket::SSL since we'll already be guaranteed that it exists by the
> require of Net::SMTP::SSL.

That "require" came from around $gmane/230533, which was about
making sure the update to pacify newer Net::SMTP::SSL does not break
folks with older packages, I think.

I just didn't/don't know the history of Net::SMTP::SSL, and that was
where my comments came from.

As long as "Net::SMTP::SSL uses IO::Socket::SSL" has been true since
the ancient past, I agree that that 'require' of the latter does not
need to be guarded by an 'eval'; at that point, we are already in
the Net::SMTP::SSL codepath.  And your patch I replied to should be
the right thing to do.

Thanks for clarifying.
