From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update SVN.pm
Date: Wed, 16 Apr 2014 12:13:21 -0700
Message-ID: <xmqq61m9gka6.fsf@gitster.dls.corp.google.com>
References: <20140416141605.GA9692@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stepan Kasal <kasal@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Apr 16 21:13:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaVH1-0000vx-S7
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 21:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755921AbaDPTN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 15:13:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58534 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751307AbaDPTNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 15:13:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76D767D5CA;
	Wed, 16 Apr 2014 15:13:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HfcLWH1/nu+dbAQDtlRDQQWRz9I=; b=oS1YgK
	FCXRKTOimjJDWORnyrYn73rcVVK0abkD/bNrChbymkTY7M4xeMZ33Ycs9TvVtd9D
	9e+AHbQuqEhUGV+SdsxfIlrozG3vlqQDR4bON/kojASOHB3Krj8yXvpQbE0yMNCA
	uPZmPJlHN0Vtw4yC17CTKK3PExcAPm49mM9vs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uP+s45dPiOxzj1om4NhFERVXs212jvni
	Vn8DKC6oyvtuE3dW6O9Oikw2BoaZX4X0wpbBf151D+yxCgznciXliWy+fdPkdkLk
	ei9aI9qPXg9mmyvXoym/chDZMl5vizAzW4LxC8abnNk1DIQEyIOv4vIdON+C0YB9
	84KTtyIZNn0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 60D2C7D5C9;
	Wed, 16 Apr 2014 15:13:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F36917D5C8;
	Wed, 16 Apr 2014 15:13:22 -0400 (EDT)
In-Reply-To: <20140416141605.GA9692@camelia.ucw.cz> (Stepan Kasal's message of
	"Wed, 16 Apr 2014 16:16:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2E66EC74-C59B-11E3-ACAF-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246377>

Stepan Kasal <kasal@ucw.cz> writes:

> From: RomanBelinsky <belinsky.roman@gmail.com>
> Date: Tue, 11 Feb 2014 18:23:02 +0200
>
> fix parsing error for dates like:
> 2014-01-07T5:58:36.048176Z
> previous regex can parse only:
> 2014-01-07T05:58:36.048176Z
> reproduced in my svn repository during conversion.

Interesting.  What other strange forms can they record in their
repositories, I have to wonder.  Can they do

    2014-01-07T5:8:6.048176Z

for example?  I am wondering if it is simpler and less error prone
to turn all these "we only accept two digits" into "\d+" not only
for the hour part but also minute and second parts.

> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
> ---
>  perl/Git/SVN.pm | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
> index a59564f..09cff13 100644
> --- a/perl/Git/SVN.pm
> +++ b/perl/Git/SVN.pm
> @@ -1321,7 +1321,7 @@ sub get_untracked {
>  sub parse_svn_date {
>  	my $date = shift || return '+0000 1970-01-01 00:00:00';
>  	my ($Y,$m,$d,$H,$M,$S) = ($date =~ /^(\d{4})\-(\d\d)\-(\d\d)T
> -	                                    (\d\d)\:(\d\d)\:(\d\d)\.\d*Z$/x) or
> +	                                    (\d\d?)\:(\d\d)\:(\d\d)\.\d*Z$/x) or
>  	                                 croak "Unable to parse date: $date\n";
>  	my $parsed_date;    # Set next.
