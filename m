From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: refuse touching a file beyond symlink
Date: Fri, 30 Jan 2015 12:32:07 -0800
Message-ID: <xmqqsiesau2g.fsf@gitster.dls.corp.google.com>
References: <CA+5PVA7rVy6Li_1haj1QmGG0D6avLB5Xej=2YGt6K-11kKHR5A@mail.gmail.com>
	<CA+5PVA4bs6CYU8MHn1JqBjnb-5wYJT2Tjqa65=v2uSPL8c7dYw@mail.gmail.com>
	<CA+55aFxbY21vBbPs5qCFPT1HSBbaeS+Z2Fr9So1r3rXrMWe_ZQ@mail.gmail.com>
	<xmqqzj94lx7z.fsf@gitster.dls.corp.google.com>
	<xmqqa914klg0.fsf@gitster.dls.corp.google.com>
	<xmqqfvauf7ej.fsf@gitster.dls.corp.google.com>
	<xmqqtwzadrj8.fsf@gitster.dls.corp.google.com>
	<xmqqa911e2ot.fsf_-_@gitster.dls.corp.google.com>
	<20150130181153.GA25513@peff.net>
	<xmqq61bocao1.fsf@gitster.dls.corp.google.com>
	<20150130200731.GC30738@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Josh Boyer <jwboyer@fedoraproject.org>,
	"Linux-Kernel\@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	twaugh@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: linux-kernel-owner@vger.kernel.org Fri Jan 30 21:32:22 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YHIEn-0000L1-J0
	for glk-linux-kernel-3@plane.gmane.org; Fri, 30 Jan 2015 21:32:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759611AbbA3UcL (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 30 Jan 2015 15:32:11 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59614 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753005AbbA3UcJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2015 15:32:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 05A3732237;
	Fri, 30 Jan 2015 15:32:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BdWnpIdH81axjIRylWPWotvEqMQ=; b=S8CO60
	tNDShukFWUyYgoez3MYMNrCTWC1FHjV/bEnA0spz3xBnGiSawgfoY0JKTorpTm+c
	S99WXe2RKGFLagqypFeafxWQTx/i7ER84NWvPzOXcthj/5Nz0t5IqpGac3f0rK8e
	lXEl1mw1waoHxkREHZ4ha+qpCTHMMaunvflAk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cQ2DEhILWTx/CgWqQx52GI93hmIFUcOL
	RNSwsikFfw5zSJjf4TjAx9dkUZvqCHI5tGq8TKpdV4AbI40lbqyTbraE4c67NN5y
	mdS+vZXvKJ0/am5K5zBTQuvbWdBjFHjHRKUhby32uT3BpobWvjItTmcEZnETXQ9x
	7DZZYTn2kuU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EF91932236;
	Fri, 30 Jan 2015 15:32:08 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5A4F032230;
	Fri, 30 Jan 2015 15:32:08 -0500 (EST)
In-Reply-To: <20150130200731.GC30738@peff.net> (Jeff King's message of "Fri,
	30 Jan 2015 15:07:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0FC1089C-A8BF-11E4-988F-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263196>

Jeff King <peff@peff.net> writes:

> Hrm. That only works in the current code because we apply the deletion
> in the directory (and then clean up the now-empty directory) first. So I
> think you would need to check the paths progressively as you apply them,
> since those other parts of the diff "haven't happened yet".

Just to make sure that I am not hallucinating, I added this one:

diff --git a/t/t4114-apply-typechange.sh b/t/t4114-apply-typechange.sh
index ebadbc3..83ddf62 100755
--- a/t/t4114-apply-typechange.sh
+++ b/t/t4114-apply-typechange.sh
@@ -119,4 +119,12 @@ test_expect_success 'directory becomes symlink' '
 test_debug 'cat patch'
 
 
+test_expect_success 'directory becomes symlink' '
+	git checkout -f foo-becomes-a-directory &&
+	printf "%s\n" foo/baz foo >order &&
+	git diff-tree -Oorder -p HEAD foo-symlinked-to-bar >patch &&
+	git apply --index <patch
+	'
+test_debug 'cat patch'
+
 test_done

It is a copy of the original, only forcing the patches in the input
in the opposite order.

Having said that and also having read your two-phase internal
application change, I think that two-phase thing is probably a good
way to go (we may even want to ignore "previous_patch()" stuff, as
its "was_deleted()" and "tobe_deleted()" are all about "force the
application of a later patch to depend on the result of application
of an earlier patch").
