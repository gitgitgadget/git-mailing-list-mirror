From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V2 4/5] git-grep: Learn PCRE
Date: Thu, 05 May 2011 09:55:14 -0700
Message-ID: <7vei4d9jf1.fsf@alter.siamese.dyndns.org>
References: <1304546421-25439-1-git-send-email-michal.kiedrowicz@gmail.com>
 <1304546421-25439-5-git-send-email-michal.kiedrowicz@gmail.com>
 <7vk4e6c5rh.fsf@alter.siamese.dyndns.org>
 <BANLkTik6pcz696xJyoOju8a3ToResLF+3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
	Git List <git@vger.kernel.org>,
	Martin Langhoff <martin.langhoff@gmail.com>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Thu May 05 18:55:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI1pv-0006c7-I4
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 18:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754404Ab1EEQza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 12:55:30 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49498 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478Ab1EEQz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 12:55:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4376656AF;
	Thu,  5 May 2011 12:57:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HRua9cnV4J6qeEWOnhVY+XckkGM=; b=meJZHR
	d47qvGhWmA1lDsQENIXXtcAKOusJBlZ5OjQQ4vHuH1jgQYfk+Z+2lvgmlP45NYY9
	EZm5ZDLLu9udOTyGQ5JBBpSHiA/xja/ZfBcN59SrxAGNFSR0Bq0nsPhWZDs7SyP5
	4ZxNw1ilXxL1zJCOtHtKcA1h8p+kPt9zm8b0k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=akSo1t8GI444MZhnqhUEpfBj323cYr77
	MitLf8QdYykDnLJ6XlJm63M/Ll6dSN6RP1jzX24UxrZgxmKONaq63tA6lDiA1ieJ
	yWWl8QKWwzsBFYw9sdPdDrpbk0XyGxrceOaIk2fBwExy7zDSDq9GbCBVztV91z+I
	TAcyvhHd0Bs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0011456AA;
	Thu,  5 May 2011 12:57:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A388956A4; Thu,  5 May 2011
 12:57:20 -0400 (EDT)
In-Reply-To: <BANLkTik6pcz696xJyoOju8a3ToResLF+3w@mail.gmail.com> (Bert
 Wesarg's message of "Thu, 5 May 2011 07:47:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C0E2A638-7738-11E0-8E42-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172848>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> I would also suggest to share the space between regex_t and the
> (pcre*,pcre_extra*) tuple, like i did in my patch titled 'prepare for
> re-using the space...' from May 2. Sacrificing one bit to indicate
> that this is a pcre compiled pattern should not hurt, because there
> are bits left.

It might be an excessive over-engineering, though.

Unlike "struct object" that need to stay in-core and grow proportionally
to the size of the history being traversed, grep_pat corresponds to one
item from the pattern specified on the command line. If it makes the code
harder to read because we end up constantly dereferencing union members
(and no, "#define pcre_regexp u.pcre_regexp" is not a solution), the
resulting 8-to-16 bytes saved per pattern may not be worth it.
