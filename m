From: Junio C Hamano <gitster@pobox.com>
Subject: Re: (bug?) Inconsistent workdir file timestamps after initial clone.
Date: Tue, 11 Dec 2012 13:27:24 -0800
Message-ID: <7vy5h47003.fsf@alter.siamese.dyndns.org>
References: <50C79D1F.1080709@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 22:28:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiXMt-0004Nf-Sv
	for gcvg-git-2@plane.gmane.org; Tue, 11 Dec 2012 22:28:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972Ab2LKV1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 16:27:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64142 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753389Ab2LKV13 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 16:27:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D0A7AFCB;
	Tue, 11 Dec 2012 16:27:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Wj4ckyDCMiMMcGA4oP+lbDcMGrc=; b=WxQWSY
	dp42qvCsvogQM1Yp3nf3iKBZSm7h97chVeNCiG1W8G6foDnkNe059o38Ydu8YTLL
	lUKhTkT2H2eX0cAzEKUwUX+Mi1RJaoELJA5mtbhWhyGmJSjQeos8gAs1AVBTOCdi
	lPgM+Pt49lQ+i2IRwAN8wBglpyJpWlqgD5wFs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sqDRsebJ4IdgrJDbJmNqIALdMgHu8bIK
	Nm7uHhawBjzHRim8Z8dLm+kAdFY/38HGFJsJA+zUgh7b+7Gj6NAR83bxis2axYlX
	qmaeJXM2LUDSs9GPQINctvc9hELQeAeShHkAUvafQcW0MCHpxM8uIZbhTeaoe3fN
	5U1wc89VGvE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B2C3AFCA;
	Tue, 11 Dec 2012 16:27:28 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9515DAFC9; Tue, 11 Dec 2012
 16:27:27 -0500 (EST)
In-Reply-To: <50C79D1F.1080709@xiplink.com> (Marc Branchaud's message of
 "Tue, 11 Dec 2012 15:52:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8FEDB4B8-43D9-11E2-8D44-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211300>

Marc Branchaud <marcnarc@xiplink.com> writes:

> Occasionally when doing a fresh clone of a repo, if the clock ticks at just
> the wrong time the checked-out files end up with different timestamps.
>
> The effect of this can be that, when "make" is run in the workdir it'll
> decide that some files are out of date and try to rebuild them.
>
> (In our particular case, our automated build-bot cloned a submodule of some
> third-party (i.e. not our) code, where a Makefile.in got an earlier timestamp
> than its dependent Makefile.am, so "configure && make" then tried to rebuild
> Makefile.in and the build failed because our build environment has the wrong
> version of automake.)

Even if you somehow arrange Makefile.in and Makefile.am to have the
same timestamp, wouldn't it be up to your "make" to decide which one
is newer?  Certainly Makefile.in is not newer than Makefile.am, and
it is free to try rebuilding it.

Also if you do this after any operation:

    $ rm Makefile.am
    $ git checkout Makefile.am

you will have Makefile.am that is newer than your Makefile.in and
you will end up attempting to rebuild it.

The timestamp of a working tree file records the time at which it
was created in your working tree.  It does not have any relation to
the commit or author timestamp of the commit you check it out of.
If this command:

    $ git checkout @{1.dacade.ago} Makefile.am

gave your Makefile.am an ancient timestamp, it will break your
build.

While not including files that can be rebuilt from the source may be
the ideal solution, I've seen projects hide rules to rebuild such a
"generated but needs special tools to build" and/or a "generated but
normal developers do not have any business rebuilding" file (in your
case, Makefile.in) in their Makefiles from the normal targets (like
"make all") for this exact reason, when they choose to distribute
such files by including in their commits.
