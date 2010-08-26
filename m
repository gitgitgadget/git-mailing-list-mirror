From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Regression in git log with multiple authors
Date: Thu, 26 Aug 2010 12:05:52 -0700
Message-ID: <7veidlkxdb.fsf@alter.siamese.dyndns.org>
References: <AANLkTikONxneEgF5m+m6100pwzThTnaiAB+OFzYufcC2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Emil Sit <sit@emilsit.net>
X-From: git-owner@vger.kernel.org Thu Aug 26 21:06:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oohm1-0004Hx-TW
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 21:06:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136Ab0HZTGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 15:06:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64776 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604Ab0HZTF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 15:05:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F0DCFD09FD;
	Thu, 26 Aug 2010 15:05:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9J3Wy/IlG5/t+LZGFu4GdUdQQ3E=; b=ob99ir
	TONx8N0hy8TKQzDkQaXGq3oxyyy51/m01LxIDvc/ol8sNXPFThnrbqXPUP7k1s5c
	cQ51KFTqxRRY5xzvaxZi6PdW59m3+cdnJhGFajhwCo83l7W2uZcqszLwN2xe6qeZ
	bgS9wccS3xkF3gL3cDLJgIjsEdI6Gk2S3DpUk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ICgh3zG3MlCDOJ856sFS5ZjlFWYSCaEG
	8CWsBTSHQMwOTO+/5/GI17XNU3OTI75G6H70eIqhGuT3McRHcvGp1BGoxpif4LBZ
	1xB3xZa/0kV+AUVHFl61h+KvyW6SRIjCgdpVsGrT5/OnQ5sFUCvTMiAH+sqmOdKF
	3u0Swya2UVw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C8029D09FB;
	Thu, 26 Aug 2010 15:05:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E8AA0D09FA; Thu, 26 Aug
 2010 15:05:53 -0400 (EDT)
In-Reply-To: <AANLkTikONxneEgF5m+m6100pwzThTnaiAB+OFzYufcC2@mail.gmail.com>
 (Emil Sit's message of "Thu\, 26 Aug 2010 13\:39\:45 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F4D4A334-B144-11DF-9BED-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154556>

Emil Sit <sit@emilsit.net> writes:

> Commit 80235ba79ef43349f455cce869397b3e726f4058 introduced a
> regression in a corner case for git log --author when multiple authors
> are specified.  Prior to 1.7.0.3, if I wanted to find all commits done
> by a series of authors, I could simply specify "git log --author=a1
> --author=a2" to get all commits done by a1 and a2.  However, in the
> latest releases, this finds nothing.

That is more or less deliberate, not in the sense that the patch wanted to
forbid looking for multiple authors but in the sense that the patch wanted
to apply the "grep" terms as intersection, not as union.

In the olden days,

    log --author=me --committer=him --grep=this --grep=that

used to be turned into:

    (OR (HEADER-AUTHOR me)
        (HEADER-COMMITTER him)
        (PATTERN this)
        (PATTERN that))

showing my patches that do not have any "this" nor "that", which was
totally bogus and useless.

80235ba ("log --author=me --grep=it" should find intersection, not union,
2010-01-17) improved it greatly to turn the same into:

    (all-match (HEADER-AUTHOR me)
	       (HEADER-COMMITTER him)
	       (OR
	         (PATTERN this)
                 (PATTERN that)))

That is, "show only patches by me committed by him that have either this
or that", which is a lot more natural thing to ask.  So simply reverting
the commit is out of question.

But I do not think it is a bad idea if you turned

    log --author=me --author=her --committer=him --committer=you --grep=this

into

    (all-match (OR
		(HEADER-AUTHOR me)
		(HEADER-AUTHOR her))
               (OR
	        (HEADER-COMMITTER him)
	        (HEADER-COMMITTER you))
	       (OR
	         (PATTERN this)))

as it is obvious that with multiple authors (or committers) the command
line is asking for union among them.
