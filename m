From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rm bug?
Date: Wed, 30 Oct 2013 12:01:12 -0700
Message-ID: <xmqqob66bn2f.fsf@gitster.dls.corp.google.com>
References: <155154AA-15E8-49E8-8261-6295AC6F6CF7@csail.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eunsuk Kang <eskang@csail.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 30 20:01:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbb17-000748-KY
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 20:01:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133Ab3J3TBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 15:01:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57045 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751951Ab3J3TBR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 15:01:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EAF9642D8A;
	Wed, 30 Oct 2013 15:01:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7URwdj7U6oWN5hff04nCqoa4Bnk=; b=Qvk9ei
	SUFkEyL/+YAJT5OwzFV5sCYbp2drMmg5N6BztxWnTHNqzmnd+yPFzX8LOt6EHJPe
	wWov+eC4ce965UqbAKXF7UDv0KSZy4PIU2t/4ONT1os9AdPw464lz8aQr7JHUL3C
	scYBQIob0shnnB696HoubY6bihNteMh1riY9A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mFmh8oLyTeZRDivho5Wj6tog7gLfKPKC
	Rz68FTnhBLC5kmjF5ZrurxcY1som8yyoV60wfMVPMbNGW4HJBAYzk9xDT53nH5FF
	0r9VoV15UBzNpB5tituNmsCIOYRsSXBiFpci0r4w8Qn39Nyxk/kC6q2Yi3cg9Ie9
	45WenfZJ8Fk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D82E542D89;
	Wed, 30 Oct 2013 15:01:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E02642D86;
	Wed, 30 Oct 2013 15:01:16 -0400 (EDT)
In-Reply-To: <155154AA-15E8-49E8-8261-6295AC6F6CF7@csail.mit.edu> (Eunsuk
	Kang's message of "Wed, 30 Oct 2013 01:23:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A72DA470-4195-11E3-9CDA-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237055>

Eunsuk Kang <eskang@csail.mit.edu> writes:

> My understanding was that running "git rm" on a file will delete
> all ancestors of the file that are empty directories from the file
> system.

Not really.

We do recurse up to see if a/b/ and then a/ has become a useless
empty directory when we did remove a/b/c from the working tree, but
when we did not have to remove a/b/c (because you have already
removed it), we assume that you know what you are doing and do
nothing to the leading directories.

This behaviour is not because we suspect that you might want to
retain a/ or a/b/; it is just we do not even bother.  So it is
entirely plausible that a patch to actually bother checking the
leading directories to see if they have become or they already were
empty directories and remove them, if done cleanly, may be a welcome
change. At least, that would make things consistent between the
cases where you have already manually removed the file a/b/c on the
working tree and where the command removed in response to your
direct request to remove the same file a/b/c.
