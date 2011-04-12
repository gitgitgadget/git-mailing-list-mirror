From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 5/3] Alternative --dirstat implementation, based on
 diffstat analysis
Date: Tue, 12 Apr 2011 15:22:49 -0700
Message-ID: <7vr597nm86.fsf@alter.siamese.dyndns.org>
References: <7vtye834al.fsf@alter.siamese.dyndns.org>
 <BANLkTim9U4cOnV+5=Mp-2g_M6+JOiM5e7A@mail.gmail.com>
 <BANLkTi=yYU+v1Xx_YO6kpC8+1ukOdwb6SQ@mail.gmail.com>
 <201104130003.02869.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Apr 13 00:23:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9lzK-0000CE-TD
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 00:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932660Ab1DLWXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2011 18:23:05 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40063 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932097Ab1DLWXE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 18:23:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D8BD4542C;
	Tue, 12 Apr 2011 18:24:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AUUB6zpZwM6BrvP6Kma/MEccCyk=; b=VW5C/J
	Z1FyPdDf650tCMRAR2PJslAcgjL6Z25XULKOZzZEN/YJ0tTR6/qvK0KOpH/EJSMi
	H+yok4miSn8aqVr3zPeOoBXNI/HKWrRwquDcYraM5B++Nn204I0LeJWhnepEYGk5
	L3PGwnoDjc7zK/gV4p6+dRFC0XYXnQdfCLkro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fL4J9SgYV3Oc1VGCYBQcb9j9rsRPDz9b
	pewvkMRRmyfma3aLlZr6Qg19icqugxZ4wbzv1bzAmHaoUuFQ0vzczJJhJCbocGot
	gy0VtK80BiIGjI9m2rQqFGNR+jOQ8cbZ49b2NBeisk1IleNOKO85URAIrtz8J4pi
	Zgzx/zslqEY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 901CF542B;
	Tue, 12 Apr 2011 18:24:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2EFCD542A; Tue, 12 Apr 2011
 18:24:48 -0400 (EDT)
In-Reply-To: <201104130003.02869.johan@herland.net> (Johan Herland's message
 of "Wed, 13 Apr 2011 00:03:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B173A450-6553-11E0-A466-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171423>

Johan Herland <johan@herland.net> writes:

> So, how should we count binary files in the diffstat version of
> --dirstat?

IIRC, the reason Linus used the "change" (not "lines") damage computation
in dirstat was exactly for this reason.

Comparing and combining the damage as number of lines and changed bytes
simply does not make much sense, so my gut answer to this question is "we
shouldn't".  The --numstat mode punts exactly for this reason, to avoid
tempting people to add numbers up without thinking and getting nonsense
results.

I suspect that any heuristics is as good as your divide-by-64; you
probably could run count_lines(one->data, one->size) in the text diff
codepath in builtin_diffstat() to keep a running average of the line
lengths of the files involved, but I do not think it is worth it.
