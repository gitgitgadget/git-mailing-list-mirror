From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git gc --aggressive led to about 40 times slower "git log --raw"
Date: Tue, 18 Feb 2014 12:59:43 -0800
Message-ID: <xmqqzjlocf28.fsf@gitster.dls.corp.google.com>
References: <CAEjYwfU==yYtQBDzZzEPdvbqz1N=gZtbMr5ccRaC_U7NfViQLA@mail.gmail.com>
	<87r470ssuc.fsf@fencepost.gnu.org>
	<CACsJy8D9tws_gu6yWVdz3t+Vfg5-9iorptn4BLnTL3b+YWcHzQ@mail.gmail.com>
	<87ioscsoow.fsf@fencepost.gnu.org> <20140218155842.GA7855@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, Duy Nguyen <pclouds@gmail.com>,
	Christian Jaeger <chrjae@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 18 22:00:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFrmU-0004wh-Em
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 22:00:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623AbaBRVAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 16:00:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46676 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751930AbaBRVAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 16:00:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5188F6DCF2;
	Tue, 18 Feb 2014 16:00:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OzdWYz9rp8PVzoKN2KWmvUVz7Ns=; b=ye8Fuo
	1HQC8+/T5CIquOTSqDKWtCmmh4KqCVBgkS6CY/Vc+lugaUs73iyiWhE8lP8icb7R
	nDrTyEpeu1XujFlWM2ueH66JMtTdBgL/M+wVGDD0KeEO58Zs1odeHXzBv1lYMTis
	VjPvWuiJoL+I5GxqWv/0/sRs2Ppruohbuk1s0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rnvQM+5Db/5U/Bvroo8tn6Hf4XcgdtQi
	wxAvBCCNCbqq9IREtlAPDUajzj2Q7IkvZOlCJCilyxlAZKVDl/D9HFJo8pGyHeuj
	U4s8gqhECxUJy3ZRmX5z52tw6Jrf1k5DdoWmFXkUeZFK6GiazFzkVEN80JT9AvuS
	6p4zsuFl718=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6CED6DCE8;
	Tue, 18 Feb 2014 16:00:09 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA3176DCAC;
	Tue, 18 Feb 2014 15:59:56 -0500 (EST)
In-Reply-To: <20140218155842.GA7855@google.com> (Jonathan Nieder's message of
	"Tue, 18 Feb 2014 07:59:22 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9F57AE16-98DF-11E3-896C-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242353>

Jonathan Nieder <jrnieder@gmail.com> writes:

> David Kastrup wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>
>>> Likely because --aggressive passes --depth=250 to pack-objects. Long
>>> delta chains could reduce pack size and increase I/O as well as zlib
>>> processing signficantly.
> [...]
>> Compression should reduce rather than increase the total amount of
>> reads.
>
> --depth=250 means to allow chains of "To get this object, first
> inflate this object, then apply this delta" of length 250.
>
> That's absurdly long, and doesn't even help compression much in
> practice (many short chains referring to the same objects tends to
> work fine).  We probably shouldn't make --aggressive do that.
> Something like --depth=10 would make more sense.

Yes, my thinking indeed.

I didn't know --agressive was so aggressive myself, as I personally
never use it. "git repack -a -d -f --depth=32 window=4000" is what I
often use, but I suspect most people would not be patient enough for
that 4k window.

Let's do something like this first and then later make --depth
configurable just like --width, perhaps?  For "aggressive", I think
the default width (hardcoded to 250 but configurable) is a bit too
narrow.

 builtin/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 6be6c8d..0d010f0 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -204,7 +204,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 
 	if (aggressive) {
 		argv_array_push(&repack, "-f");
-		argv_array_push(&repack, "--depth=250");
+		argv_array_push(&repack, "--depth=20");
 		if (aggressive_window > 0)
 			argv_array_pushf(&repack, "--window=%d", aggressive_window);
 	}
