From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Tue, 19 Apr 2016 23:00:17 -0700
Message-ID: <xmqqfuugyg3y.fsf@gitster.mtv.corp.google.com>
References: <1461013950-12503-1-git-send-email-sbeller@google.com>
	<1461013950-12503-3-git-send-email-sbeller@google.com>
	<20160419050342.GA19439@sigill.intra.peff.net>
	<CAGZ79kbzg7SmJHFpxeJNKmLaEEw+irCxUedo45jGx8G8fmPtKg@mail.gmail.com>
	<20160419170624.GA3999@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 20 08:00:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aslBY-0005R5-VU
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 08:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435AbcDTGAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 02:00:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57732 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752692AbcDTGAU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 02:00:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EAC2F15E17;
	Wed, 20 Apr 2016 02:00:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PelRL/5ME6CZHHKu5EDpUzNT51I=; b=Yj++lt
	MAJq5uKBSDDceEOTRnTKr2G8kIKAHTiwC9fpXYiLUL+t/kPwv3CAB5Uc0YP0yauu
	mr5XL+Hbn0bCcE0hC/s03tqB56EtqT0dz3NWaZQ0IQczLngEGW+VRLm4YE1qklbl
	vZo3KoTwhGz8cAs8besHJN0P4o8JFXRwWwpkw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kyVcAN/ZyVUrhRid4+OHWHmYSkgesSdR
	4gGqm/hGw9+RFIcsYN/jGneL7d9YGVkVUYeTaE2gLz8FtDoNE8YRUQsKML/Dnp0j
	v8J0dW39pLWSuFIQnkWpJi6oGl8DV/FJYVcTA2tWJj0Ihc7edLOn/G9rzpRul+F0
	tURhIFKmlJE=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DF2B015E16;
	Wed, 20 Apr 2016 02:00:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 33D6215E15;
	Wed, 20 Apr 2016 02:00:18 -0400 (EDT)
In-Reply-To: <20160419170624.GA3999@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 19 Apr 2016 13:06:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 28B4DE16-06BD-11E6-8339-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291983>

Jeff King <peff@peff.net> writes:

> I mean that if you save any old patch-ids from "git patch-id", they
> won't match up when compared with new versions of git. We can probably
> ignore it, though. This isn't the first time that patch-ids might have
> changed, and I think the advice is already that one should not count on
> them to be stable in the long term.

Another thing that this *will* break is the patch signature upload
protocol k.org uses to allow Linus, Greg, et al. on the road with
limited hotel wifi bandwidth to prepare patch-X-test1.gz and
patch-X-test1.sign file.  They can locally tag X-test1, prepare
"git diff X X-test1 | gzip -n >patch-X-test1.gz" and sign the
result, and upload _only_ the detached signature after pushing.

They can tell k.org, when uploading the detached signature, to
recreate the patchfile by running the same "git diff" to save the
bandwidth of sending the same thing twice (as they have to "push"
anyway, having to send the generated patch is a pure overhead).

Having said all that, kup(1) users are already warned that the
textual diff produced by "git diff-tree -p" (which is mentioned in
the documentation of the tool) varies across versions of Git and
the above "optimization" would not work unless both ends have the
same version of Git, so it may not be too big an issue for them.
They have already been burned once when we corrected "git archive"
output in the past (they obviously have the same optimization to
sign tarballs, and the kup(1) mechanism relies to have byte-for-byte
identical output).
