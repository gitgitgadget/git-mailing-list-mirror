From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] sha1_name: get_sha1_with_context learns to follow symlinks
Date: Fri, 08 May 2015 14:22:39 -0700
Message-ID: <xmqqsib6ix28.fsf@gitster.dls.corp.google.com>
References: <1431108819-6831-1-git-send-email-dturner@twopensource.com>
	<1431108819-6831-2-git-send-email-dturner@twopensource.com>
	<CAPig+cRzXQp_afDrOdKrUQ-=DD1P_UcDzs8aSZnTfesd7R20wQ@mail.gmail.com>
	<CAPc5daXmJSfdB_eyQ5ppVp2NhYGZvPChGAyn4p2hEde=4x9EEQ@mail.gmail.com>
	<xmqq6182ke9i.fsf@gitster.dls.corp.google.com>
	<20150508203952.GA13457@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 08 23:22:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqpjK-0006Pq-8y
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 23:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186AbbEHVWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 17:22:42 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61956 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753006AbbEHVWl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 17:22:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 000204E1FC;
	Fri,  8 May 2015 17:22:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FHOGzKryc2dvYP7378+BNjlrvnk=; b=YMVD+r
	iy7/WAUOidrMtMAFSslP7Do5EkNM6UTW0rjRdy+m69U6DF9dmEzV3BR3Ja5fA7tN
	sjV4JFf1LnKXTrutaeYRFrgjBuuHAqOzXTiNXaQWKrbznOv9QwuVJ7AjuitZI/ww
	e21xnRdIbvxNIaxrXtf2ks2qAS+HBaPZ9qcLo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gYUW+MNm3sMTVD8aBkB8OZ0ZEdbQPysK
	X63zsDXPRcic1dGGK17R7dChhagBtVVfNGHe1W3hCdl3RzmTRuygxpAnjqsFYtI3
	bKMqvc6nhLh7YaSKqnqxZp3N61UR+INqgIrvWgqqEL/AGbYuY+D9IYGRtUDDSG2G
	YMI/KOXcMSk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ED31B4E1FB;
	Fri,  8 May 2015 17:22:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 505C44E1FA;
	Fri,  8 May 2015 17:22:40 -0400 (EDT)
In-Reply-To: <20150508203952.GA13457@peff.net> (Jeff King's message of "Fri, 8
	May 2015 16:39:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5B6DAB78-F5C8-11E4-9F63-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268675>

Jeff King <peff@peff.net> writes:

> On Fri, May 08, 2015 at 01:25:45PM -0700, Junio C Hamano wrote:
>
>> Perhaps something like the attached patch is a good idea (I used
>> "BUG:" for now), I wonder?
>> 
>>  Documentation/CodingGuidelines | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> Yeah, this looks good (and we definitely prefer BUG:, though I am
> responsible for over 1/3 of the existing incidences).
>
> I have been tempted to provide a macro or function for it, and have it
> actually call abort() to trigger a coredump. I.e., basically assert(),
> except unconditional but you get to write a more useful message.
>
> So all of the sites would just become:
>
>   BUG("frotz() called with NULL pointer to xyzzy parameter");
>
> or similar.

Yeah, that sounds more sensible (especially the abort() part).
