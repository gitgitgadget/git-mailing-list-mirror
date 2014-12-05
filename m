From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git bundle vs git rev-list
Date: Fri, 05 Dec 2014 15:01:46 -0800
Message-ID: <xmqqlhmlog4l.fsf@gitster.dls.corp.google.com>
References: <CAL3By--xYnXFUdDP3MDxAxvfeBT3ArFrdAV=apzdWg6_kiD2Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jesse Hopkins <jesse.hops@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 00:02:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx1sv-0008Q5-AI
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 00:02:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753556AbaLEXBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 18:01:51 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54926 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752669AbaLEXBs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 18:01:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D888124B0B;
	Fri,  5 Dec 2014 18:01:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YigTq8khm0rCxpa+0FsptHG7CF4=; b=h1YG7s
	+o6Gax1q55jYmeExW60T6Y3jSw8O2qrxGBT9HEGplpXPpNZaWUrl0dM1lom/sr8a
	WY3k6ErCo9JjbzKEXUB6Ul87USNuB4zG8XRGZhUMRpv8IDlf6zu0qfG8B5j7wVUh
	OzvBjpycKaBh+PW7o31aLEm0DXNXVvCCYGrCc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=munBEpQcTONh/aV0WtnqIJXdgOMzD2Hz
	eFS5nw3/I7qcpe80FUTgyDWTkB+VsbOCz+xgU3+YMp5wg9PLb3BcO8NMredYuN3K
	4q3HRABJgKm0xynmlfnMi5JEs2uzey3nwvePqUl+C49NMznkIcwgqif9YAe0O0cF
	FQOdaovxED0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CE5A424B0A;
	Fri,  5 Dec 2014 18:01:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 58DB224B09;
	Fri,  5 Dec 2014 18:01:47 -0500 (EST)
In-Reply-To: <CAL3By--xYnXFUdDP3MDxAxvfeBT3ArFrdAV=apzdWg6_kiD2Yg@mail.gmail.com>
	(Jesse Hopkins's message of "Fri, 5 Dec 2014 15:36:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B07A9FBE-7CD2-11E4-A38C-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260910>

Jesse Hopkins <jesse.hops@gmail.com> writes:

> 2. Is there a way to list commits contained in the bundle file itself?
>  This seems like it would be more robust than trying to re-create the
> commit list via 'git rev-list'.

"git bundle list-heads o.bndl" shows the positive endpoints, but
there is no corresponding "git bundle list-prereq" that shows the
prerequisite commits.

Running "git bundle verify o.bndl" in an empty directory will show
the negative endpoints that are required to be in the receiving
repository in its error message, e.g.

    $ git bundle verify ~/w/git.git/o.bndle
    error: Repository lacks these prerequisite commits:
    error: bf404025edf1d7f5a69aa07cbaa88622e9d528df 
    error: 15ab2081fff5b234ec5705a8645d39c1fdcf204c 
    ...

so collecting them would be one way to substitute "list-prereq".

Once you learned the positive and negative endpoints, running "git
rev-list --objects $positive_ones --not $negative_ones" should list
all the objects contained in the bundle.
