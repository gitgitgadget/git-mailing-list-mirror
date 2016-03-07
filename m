From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] git reset --hard gives clean working tree
Date: Mon, 07 Mar 2016 14:34:26 -0800
Message-ID: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
References: <Message-Id=xmqqio26nqk8.fsf@gitster.mtv.corp.google.com>
	<1455207366-24892-1-git-send-email-tboegi@web.de>
	<xmqqy4arw089.fsf@gitster.mtv.corp.google.com>
	<56DA896A.3050201@web.de>
	<xmqqtwklwdrh.fsf@gitster.mtv.corp.google.com>
	<56DA986B.6040003@web.de>
	<xmqqr3fotyhu.fsf@gitster.mtv.corp.google.com>
	<xmqqpov6puv7.fsf@gitster.mtv.corp.google.com>
	<xmqqlh5upt6q.fsf@gitster.mtv.corp.google.com>
	<56DD42AE.2010200@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 07 23:34:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ad3jW-0005F4-Gu
	for gcvg-git-2@plane.gmane.org; Mon, 07 Mar 2016 23:34:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260AbcCGWeb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Mar 2016 17:34:31 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61258 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753390AbcCGWe3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Mar 2016 17:34:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0D0604B863;
	Mon,  7 Mar 2016 17:34:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=cMuuTnEWKxdx
	JlcrSuCdhRN9Hx8=; b=t+O8sk9XwRwGGkhsTp0jnevMBQp3k7T5T39JuGfvUFMJ
	5byfV1V63DFHffu5NHWzhhicTYzXWa/zpP/q91QKbDnddJV5zVUg63iDzeGbM7gv
	Orea2U+suXlamPxgXyPvL99aapla81wDOnZiJpHcqMgKaI9fONqYalv6sRUE0oM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=WShyH8
	A8GV0n79Dsv83M0HemMb5qv8Og0DtV5kYh3BVSHpSZ/noWI9jF7AjqjwIzs/mI8l
	kQKBf4e8lAfd/tNXZ11biT2+S/Bs4QAUzSbhPEiTEOicxSW3Ow/yBdJjl8C1wF6Z
	yiXRQ/08/iH7871oayyiU3YgyABenTgBaiNHk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 046324B862;
	Mon,  7 Mar 2016 17:34:28 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4A61D4B861;
	Mon,  7 Mar 2016 17:34:27 -0500 (EST)
In-Reply-To: <56DD42AE.2010200@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Mon, 07 Mar 2016 09:58:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C01EDFCA-E4B4-11E5-8E8A-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288404>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> The major question, at least on my side, is where to hook in
> "can_clobber()" ?

There are different ways the existing commands ensure that they do
not lose local modifications.

 * Some (like unpack-trees code that is used by "merge") do
   refresh_cache() upfront and then ask ce_uptodate() if the
   contents in the working tree match the indexed contents.
   unpack-trees.c::verify_uptodate_1() has a call to ce_uptodate()
   and returns early when true (i.e. if "git add" would result in
   the same index entry), but then does a double-check with
   ie_match_stat(), which essentially asks the "does an add result
   in the same index entry?" again.

 * Others (like apply) do not do the tree-wide refresh_cache(), but
   asks "does an add result in the same index entry" by calling
   ce_match_stat(), which is a thin wrapper to ie_match_stat(), in
   builtin/apply.c::verify_index_match().

These places need to learn that there is a case where
ie_match_stat() says "'git add' would change the index, i.e. working
tree file is different" but the working tree file can still be
clobbered because 'checkout' would produce the same contents in the
working tree.

But stepping back a bit, I no longer am sure if such a loosening is
desirable.  Imagine that you implemented such loosening and allowed
a patch to be applied to the index (and the result checked out to
the working tree).  What would the result of "diff --cached" be
after doing so?  Would it contain only the change described in the
patch you just accepted?  If that is the case, it would be OK, but
if the change from the patch gets mixed with the "fix incorrectly
recorded data in the index" change that you would have recorded if
you did "git add" from the working tree without applying the patch,
then that would not be a desirable outcome, I would suspect.  You
would rather want to first commit the "fix incorrectly recorded data
in the index" as a separate preparatory step and then want to apply
the patch.  So...
