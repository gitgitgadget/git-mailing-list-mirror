From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] git reset --hard gives clean working tree
Date: Mon, 07 Mar 2016 00:51:09 -0800
Message-ID: <xmqqlh5upt6q.fsf@gitster.mtv.corp.google.com>
References: <Message-Id=xmqqio26nqk8.fsf@gitster.mtv.corp.google.com>
	<1455207366-24892-1-git-send-email-tboegi@web.de>
	<xmqqy4arw089.fsf@gitster.mtv.corp.google.com>
	<56DA896A.3050201@web.de>
	<xmqqtwklwdrh.fsf@gitster.mtv.corp.google.com>
	<56DA986B.6040003@web.de>
	<xmqqr3fotyhu.fsf@gitster.mtv.corp.google.com>
	<xmqqpov6puv7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 07 09:51:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acqsn-00050K-KD
	for gcvg-git-2@plane.gmane.org; Mon, 07 Mar 2016 09:51:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163AbcCGIvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2016 03:51:13 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57446 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752046AbcCGIvM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2016 03:51:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 490E546379;
	Mon,  7 Mar 2016 03:51:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QEhqWg8eon2p1sjuI1fabvaIZrU=; b=xX9Zqv
	CvuuTmGIwE8dVke4YQgyRK175kd2jux51/FFCxqm88SO1Yx81f+3+OAqsPdYSnfZ
	GgvU3il1oXVP2OaSNRw/BkVBFsi6B0624SkzjYmwV3FFdNrdgH2mNscVJk9LgLwP
	DeboVzmtcxlk5sJI6sjOe2jVwClJrWyLwVKXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qXmqoLbRHVcoGGGIuzKGET0X7qhp1wbJ
	rQuwLCVyg0zQHwgyyBP4I+ffFlvOwDwWhmzmWyif9kNXNnRQrxwqt9Rksxcf9wBG
	tR/4ZeGXX63la2+2+YCAXeoIsHKdw44pJprHlGV+leKG7mZoaS8Z5KQO1L4xoph+
	h/+U2Exntg4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3FAF746378;
	Mon,  7 Mar 2016 03:51:11 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AF28E46376;
	Mon,  7 Mar 2016 03:51:10 -0500 (EST)
In-Reply-To: <xmqqpov6puv7.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 07 Mar 2016 00:14:52 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BD75EED0-E441-11E5-B7D7-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288384>

Junio C Hamano <gitster@pobox.com> writes:

> Perhaps we can introduce a new function can_clobber() that has the
> same function signature as ce_uptodate() and update the callers in
> apply and unpack-trees (there may be others) to call it instead when
> they want to see if they can clobber the working tree file that
> corresponds to the cache entry.

By the way, I do not want see ie_match_stat() modified to work like
the can_clobber() I outlined in the previous message, which in turn
means that immediately after "git reset --hard" or "git checkout" 
when your convert_to_git() and convert_to_working_tree() do not
roundtrip, you _must_ see differences in "git diff".

This is for (at least) two reasons.

 * "git diff" (compare between the index and the working tree) is
   meant as a preview of how the indexed contents will be modified
   if you did "git add" with what you currently have in your working
   tree at the path.  In a "conversions do not roundtrip" situation,
   your "git add" will be modifying the contents in the index, so we
   should actively be showing what modification we will be making.

   One way of "fixing" the situation without changing either the
   working tree contents or the indexed contents is to fix your
   convert-to-git settings to make the conversions round-trip, and
   then you would stop seeing the changes you would make when you do
   "git add".  Not showing any diff when can_clobber() is true but
   ce_uptodate() is false would make "git diff" less useful when the
   user makes this correction.

 * "git add" of a path can legitimately optimize itself by not
   adding a path that is ce_uptodate().  Mixing ie_match_stat()
   with can_clobber() logic would mark such a "conversions do not
   roundtrip" path as ce_uptodate(), and prevent the user from
   "fixing" the incorrect index entry by running "git add".
