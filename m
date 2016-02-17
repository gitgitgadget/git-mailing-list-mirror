From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/20] Delete directories left empty after ref deletion
Date: Tue, 16 Feb 2016 16:08:53 -0800
Message-ID: <xmqqfuwskxka.fsf@gitster.mtv.corp.google.com>
References: <cover.1455626201.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 17 01:09:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVpfw-0003Sa-Kp
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 01:09:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933393AbcBQAI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 19:08:56 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50912 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933243AbcBQAI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 19:08:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 06D1B441DD;
	Tue, 16 Feb 2016 19:08:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4lmNGyo2kJLW+Jm7nDR6Yigcy/g=; b=UT2KOP
	R+RlkleMv7V57tgZD3zSDR/+6DeM7vATfzCCFaYPc46dQIr/N5X8h16KzWvbh+Tm
	ZnK6sbrlA33ao64XnmYBn13LeqOsRuseSqYsTiYm77ygrxeavnbb2xpM250c3NqL
	RA8QHzH5dchcUaAYQqzdZT8iLzIUQw3yhcVrc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WPXY7Tqpz1ZIh5uujR/4f9Dfch/em/4Q
	XpiRscGJbjnWyT+VUUmEiomwzG3dFSJlujPzvGZKFeInJxgJ+vvkNyIf9MSoMOWp
	4qGlM2BFDG//ieYfa80iB3laSQUClPxibwH+Z5B7q9z7PafFqEV7EaO8BDxaF47K
	qVqyCI5CiTc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F0C1F441DC;
	Tue, 16 Feb 2016 19:08:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 663CB441DB;
	Tue, 16 Feb 2016 19:08:54 -0500 (EST)
In-Reply-To: <cover.1455626201.git.mhagger@alum.mit.edu> (Michael Haggerty's
	message of "Tue, 16 Feb 2016 14:22:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A1C38F44-D50A-11E5-947B-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286462>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Previously, we were pretty sloppy about leaving empty directories
> behind (under both $GIT_DIR/refs and $GIT_DIR/logs) when deleting
> references. Such directories could accumulate essentially forever.
> It's true that `pack-refs` deletes directories that it empties, but if
> a directory is *already* empty, then `pack-refs` doesn't remove it. It
> is also true that if an empty directory gets in the way of the
> creation of a *new* reference, then it is deleted. But otherwise there
> is no systematic cleanup of empty directories.

I had an impression that all of the above are deliberate design
decision, perhaps except "pack-refs do not go into an already empty
one", as the races between creation into an directory that is about
to become empty by ongoing deletion are unpleasant to deal with.

> This patch series makes the reference update machinery more aggressive
> about deleting empty directories under $GIT_DIR/refs and under
> $GIT_DIR/logs when deleting references and/or reflogs. This doesn't
> eliminate all situations where empty directories can be left behind
> [3], but it covers the worst offenders.

Good!!  As long as it is done in a correctly non-racy way, that is.

> As prelude to the main change, there are a number of patches that make
> the *creation* of reflog directories more robust against races. Since
> we want to delete such directories more aggressively, we have to worry
> more about a race between a process that is creating a new reflog, and
> another process that might be deleting the containing directory at the
> same time. (We already had protection against this sort of race for
> reference creation, but not for reflog creation.)

Yup.

> And since I got tired of writing the same code over and over, I
> abstracted the code for retrying directory creation into a new
> function, raceproof_create_file().

Nice.

I do not think I can get to the meat of the series tonight, but am
looking forward to reading it over.

Thanks.
