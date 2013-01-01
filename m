From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Replace git-cvsimport with a rewrite that fixes major
 bugs.
Date: Tue, 01 Jan 2013 13:54:39 -0800
Message-ID: <7vfw2k8t7k.fsf@alter.siamese.dyndns.org>
References: <20130101172645.GA5506@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Tue Jan 01 22:55:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tq9nd-000770-TB
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 22:55:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495Ab3AAVyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 16:54:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55082 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752461Ab3AAVym (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 16:54:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 880ED9DDB;
	Tue,  1 Jan 2013 16:54:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=od1ZKBWtscDE7YZVgnbpzy7/uR4=; b=Neb5Zy
	hHDAu2V7ZgojPdDBRgqxN9+kb6Ulm4Us7hws5Qjwjj7RMg4l/gqpmRMGlRdbIt4T
	vL7MxFzZlwOMGSjDHCBx84S23NcEaHkfXF1RB79sqrA4kdveCLnckyv+pb+Uv33o
	TAQvJv5+7KtNAnSuAR3sJvBffymij0/mpg82M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AzZvmbKNKvcLgEEG+VJvlpJndclEkCG8
	OYYu6DLQlDZVVJJoihgyp7L/ERc9MgyqNQh8PODF4fOamXOR3VkD3hX2wGTaXVRy
	7oia/9xeP7/EWQKeRtOgN4viSYbewizeV1+m3bz2XF9pAJo9V7b4k3E4LeT81CrX
	zsy7x4JcpUE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A32D9DDA;
	Tue,  1 Jan 2013 16:54:41 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2A779DD8; Tue,  1 Jan 2013
 16:54:40 -0500 (EST)
In-Reply-To: <20130101172645.GA5506@thyrsus.com> (Eric S. Raymond's message
 of "Tue, 1 Jan 2013 12:26:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D8184DE0-545D-11E2-B9A4-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212455>

"Eric S. Raymond" <esr@thyrsus.com> writes:

> The combination of git-cvsimport and cvsps had serious problems.
> Among these were:
>
> (1) Analysis of branchy repos was buggy in multiple ways in both
>     programs, leading to incorrect repo translations.
>
> (2) Even after a correct branch analysis, extra (redundant) fileops
>     would often be generated on the new-branch side.
>
> (3) Inability to report more than one tag pointing to the same revision.
>
> (4) Failure in certain cases of clock-skew reported by the t9603 test.
>
> (5) Failure to use commitids for changeset ordering in cases were this
>     would have prevented clock skew from causing incorrect grouping.
>
> Problems 2-5 and portions of problem 1 have been solved by a major
> rewrite of cvsps (the 3.x release series); it now emits a git
> fast-import stream.

So..., is this a flag-day patch?

After this is merged, users who have been interoperating with CVS
repositories with the older cvsps have to install the updated cvsps
before using a new version of Git that ships with it?  As long as
they update both cvsps and cvsimport, they can continue using the
existing repository to get updates from the same upstream CVS
repository without losing hisory continuity?

I would have preferred an addition of "git cvsimport-new" (or rename
of the existing one to "git cvsimport-old"), with additional tests
that compare the results of these two implemenations on simple CVS
history that cvsimport-old did *not* screw up, to ensure that (1)
people with existing set-up can choose to keep using the old one,
perhaps by tweaking their process to use cvsimport-old, and (2) the
updated one will give these people the identical conversion results,
as long as the history they have been interacting with do not have
the corner cases that trigger bugs in older cvsps.

Or am I being too conservative?
