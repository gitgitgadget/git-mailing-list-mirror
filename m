From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] gitweb: XSS vulnerability of RSS feed
Date: Mon, 12 Nov 2012 12:36:08 -0800
Message-ID: <7vmwymh83r.fsf@alter.siamese.dyndns.org>
References: <20121111232820.284510@gmx.net>
 <CAM9Z-n=6xsC7yiKJ+NU-CxNPxEXWmJzvXLUocgZgWPQnuK6G4Q@mail.gmail.com>
 <20121112202413.GD4623@sigill.intra.peff.net>
 <20121112202701.GE4623@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Drew Northup <n1xim.email@gmail.com>,
	glpk xypron <xypron.glpk@gmx.de>, git@vger.kernel.org,
	jnareb@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 12 21:36:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY0k5-0006tZ-GZ
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 21:36:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153Ab2KLUgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 15:36:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52625 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752958Ab2KLUgL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 15:36:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A440A42D;
	Mon, 12 Nov 2012 15:36:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1zRuuK5aARyPZYnTYQqEAp3uTmc=; b=gp10s+
	AzzuX29hZrSdbaX5jFIh1sAOwWymwKcb6VRemNmheerfQDwE8o8yUnkib9wNYAB4
	FuF1qFOLAer+YVQMBIQ9ESrHHICXzbAqTtAcji/RREjFHY7Z0UBTI1TsFI5sPEvs
	xxRQ752wiWItutAlIUEv6lV6Fd9DL9nN2Bm80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bul86LK1Xq/FQXRzzOBfkpCIwa0iNWZG
	GWJgHnsSXx8ya2PAPbYwt2yngf8IeHtBUfh2Ubl61ryX8IcME0mnsH25j4ZH7QsM
	tNlFHWwlNTmmJRf+lUOZp67lloWInHFCb7yuFHIuXrAoFankJvKj6YptnZfsMP8j
	n/GT0ow9lKE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC717A42C;
	Mon, 12 Nov 2012 15:36:10 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 697B1A42B; Mon, 12 Nov 2012
 15:36:10 -0500 (EST)
In-Reply-To: <20121112202701.GE4623@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 12 Nov 2012 15:27:01 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 97CE5238-2D08-11E2-9359-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209522>

Jeff King <peff@peff.net> writes:

> On Mon, Nov 12, 2012 at 03:24:13PM -0500, Jeff King wrote:
>
>> I think the right answer is going to be a well-placed call to esc_html.
>
> I'm guessing the right answer is this:
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 10ed9e5..a51a8ba 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -8055,6 +8055,7 @@ sub git_feed {
>  		$feed_type = 'history';
>  	}
>  	$title .= " $feed_type";
> +	$title = esc_html($title);
>  	my $descr = git_get_project_description($project);
>  	if (defined $descr) {
>  		$descr = esc_html($descr);
>
> but I did not test it (and I am not that familiar with gitweb, so it is
> a slight guess from spending 5 minutes grepping and reading).

Yeah, that looks correct, given the way how the other variables
emitted with the same "print" like $descr and $owner are formed.
