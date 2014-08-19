From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Issuing warning when hook does not have execution permission
Date: Tue, 19 Aug 2014 09:52:23 -0700
Message-ID: <xmqqegwcwhfc.fsf@gitster.dls.corp.google.com>
References: <CAPyMVO+a+R-+UDVuNSfhyB=PX-NUZbt6VGXfOv19-mDKTqfj6g@mail.gmail.com>
	<20140819080002.GB7712@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Babak M <babak@melon.com.au>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 19 18:53:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJmej-0006jJ-Gi
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 18:53:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396AbaHSQwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 12:52:35 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55367 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751822AbaHSQwe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 12:52:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8267633F1C;
	Tue, 19 Aug 2014 12:52:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wQfiWzO7JIP4ssDKr6gRBW8CY28=; b=D/BkoC
	BHHo78dFd25vjqRjtmP+jLHhiSOWMpTCX1d71M+SOmSoosBoykp1lGHX4Fcz/qte
	Hy5YO8GV64y4kNvEChHgn//8pdI983DipffA0BLgONzuTIPSfZZU9YDdYOLexPRi
	CtKZBY2AbBGOXQBJivS16VeJIBxRUy5zd9N6k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WjyPdtiO3oeeXwxIG8hzqz6b329mDw2E
	3emzIUL/08i8WBKl+Lu+TCCpom0JvBg1z2kPGll9UwntWbRYEkZOuaJ2G1vUsL+U
	v0e5EY0nkKDd/i4hl5+I3bDuz9poWCqLMAP/NS4YTk7h8NJaWdCFH6IBEgwUXmc7
	uLK86C55Q/A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 77D4533F1B;
	Tue, 19 Aug 2014 12:52:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9CE5733F17;
	Tue, 19 Aug 2014 12:52:25 -0400 (EDT)
In-Reply-To: <20140819080002.GB7712@peff.net> (Jeff King's message of "Tue, 19
	Aug 2014 04:00:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 32731BC0-27C1-11E4-8A16-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255501>

Jeff King <peff@peff.net> writes:

> On Tue, Aug 19, 2014 at 04:05:21PM +1000, Babak M wrote:
>
>> I saw that if a hook file is present in .git/hooks and it does not
>> have execution permissions it is silently ignored.
>> 
>> I thought it might be worthwhile issuing a warning such as "Warning:
>> pre-commit hook exists but it cannot be executed due to insufficient
>> permissions".
>> 
>> Not sure if this has been discussed before. I searched the archive but
>> didn't see anything.
>> 
>> Thoughts, suggestions? Is there anything like that already?
>
> Once upon a time we shipped sample hooks with their execute bits turned
> off, and such a warning would have been very bad.
>
> These days we give them a ".sample" extension (because Windows installs
> had trouble with the execute bit :) ), so I think it should be OK in
> theory. Installing a new version of git on top of an old one with "make
> install" does not clean up old files. So somebody who has continuously
> upgraded their git via "make install" to the same directory would have
> the old-style sample files. Under your proposal, they would get a lot of
> warnings.
>
> However, that change came in v1.6.0, just over 6 years ago. We can
> probably discount that (and if it does happen, maybe it is time for that
> someone to clean up the other leftover cruft from past git installs).

The above all sounds very sensible.

We have another code path that looks for an executable, finds one
with no execute permission and decides not to execute it, and I
wonder if we should use the same criteria to decide to give (or not
give) a warning as the one used in the other code path (i.e. looking
up "git-foo" executable when the user runs "git foo").
