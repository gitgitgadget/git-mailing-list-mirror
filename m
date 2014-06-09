From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: do not insert third header
Date: Mon, 09 Jun 2014 16:25:26 -0700
Message-ID: <xmqqa99ld5sp.fsf@gitster.dls.corp.google.com>
References: <20140607080940.GA8858@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Stepan Kasal <kasal@ucw.cz>
X-From: git-owner@vger.kernel.org Tue Jun 10 01:25:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu8we-0005zU-DW
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 01:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934263AbaFIXZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 19:25:35 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60516 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932562AbaFIXZc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 19:25:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2AE2F1D477;
	Mon,  9 Jun 2014 19:25:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=aIIKiBz5NHBKd39QWvXCnwjeHec=; b=cNF8js7koHdz/ragJAfT
	ecenGROG6XTRoj7iyXXWnf3W1Q9K61IyEwzlvY2TMnn4t4ZJgXF12jG8oxJwPnO5
	hi4Z0dFTMz4wTJEZq6dUoqvePV1wCBiQmP3YpQSkYQadMbDwsg/g0Hq1Oa7yf3Ur
	ROKiyE4XEmOZ8FmCUE0QmsU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=IeRI50kPfQkJbT9DccE9qdyN/Ywe3Km9QSB7bm184aiHFr
	7WJZWJf/fAtEiQ3+LJZA0zSy2TINa9lhTHrIyDeigykUyKzdeC2Q2ryn1E+XjtSe
	uhfpg6YAjJNabu0ONwaYwPsm9FTZNTBr0HZQ8HNq+wLJSstpkyl8pvCfJAejU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 228991D476;
	Mon,  9 Jun 2014 19:25:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 55BDA1D471;
	Mon,  9 Jun 2014 19:25:28 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 578268F6-F02D-11E3-ACC5-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251143>

Stepan Kasal <kasal@ucw.cz> writes:

> It is sometimes desirable to insert several header lines at the top of
> the body, e.g., if From or Date differs from the mail header.
> (Linus even recommends to use this second header for all kernel
> submissions.)
>
> send-email has a minimal support for this; make sure it is not applied
> when there is a second header already inserted in the patch file.

I have a slight suspicion that you are reading the recommendation
wrong.  We do not recommend to record these in-body headers in the
message of the commit object (the recommendation is to prepend
in-body headers to the message of the commit object when sending it
out for review---it pretty much assumes that the underlying commit
does not have these in-body headers that are used only during the
transit over e-mail forwarding chain).

But your patch seems to assume that the input message to send-email
already has the in-body header.  Doesn't that indicate a misuse of
the tool, making this new "feature" smell more like a way to
encourage such a misuse by covering up the result?

I dunno.

>
> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
> ---
>  git-send-email.perl | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 9949db0..891df13 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1456,7 +1456,9 @@ foreach my $t (@files) {
>  	}
>  
>  	if (defined $sauthor and $sauthor ne $sender) {
> -		$message = "From: $author\n\n$message";
> +		if ($message !~ m/^From: /) {
> +			$message = "From: $author\n\n$message";
> +		}
>  		if (defined $author_encoding) {
>  			if ($has_content_type) {
>  				if ($body_encoding eq $author_encoding) {
