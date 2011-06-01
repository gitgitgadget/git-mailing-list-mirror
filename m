From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2011, #14; Tue, 31)
Date: Wed, 01 Jun 2011 12:21:09 -0700
Message-ID: <7v62opgxy2.fsf@alter.siamese.dyndns.org>
References: <7vhb8aij91.fsf@alter.siamese.dyndns.org>
 <4DE5E1C3.8000904@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jun 01 21:21:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRqyr-00063D-Mv
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 21:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753896Ab1FATVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 15:21:20 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62725 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632Ab1FATVT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 15:21:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6701B4FE7;
	Wed,  1 Jun 2011 15:23:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2r3mc4nK8ajjU2uNPt9oK1xfsqU=; b=RfAVTX
	KRHTG4CyCIaqrsQPKROMV3t/HaAHBdthm9GUXV36PcXI4NnJn2L7sVu9s93g9mMM
	m8tS3QuLX+MsIqGNPSTQ8dqSM1kmnzdyTHqv1USO4damuBJgNrLQiAFnsLmIhsKe
	x2b/ACKmfHfKHgecyTv4dalJnNTlil96X1lvg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pR+yOnbX82g64nIfN1foIAo1r0cQB89D
	0rC6U3wkO8uvvNgmtxqlZKccgc3XXbavoEMVhebOtvwjsWt185193rjPegGIIjhW
	aSZSbcJCd3Iu9gYO35Y9a1Ej9NmLXLenIk4Adzpk5gNz8MCsPv1caLy7f1Al9NGg
	jrFmC2Z2uZo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 31D494FE0;
	Wed,  1 Jun 2011 15:23:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0D1E94FDE; Wed,  1 Jun 2011
 15:23:19 -0400 (EDT)
In-Reply-To: <4DE5E1C3.8000904@viscovery.net> (Johannes Sixt's message of
 "Wed, 01 Jun 2011 08:52:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9E578136-8C84-11E0-93C0-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174893>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 6/1/2011 0:43, schrieb Junio C Hamano:
>> * ef/maint-win-verify-path (2011-05-27) 3 commits
>>  - verify_path: consider dos drive prefix
>>  - real_path: do not assume '/' is the path seperator
>>  - A Windows path starting with a backslash is absolute
>> 
>> J6t had a reasonable question in the discussion; has it been resolved?
>
> This particular question is resolved; I consider "verify_path: consider
> dos drive prefix" a good change. But I haven't had a chance to review the
> effects of the other two changes, yet.

The second one replaces strrchr(buf, '/') with find_last_dir_sep(buf),
which I imagine would be a good change for Windows. If you are dealing
with a pathname that came directly from the end user, you may see a
backslash instead of a slash. If you are dealing with a pathname that is
normalized earlier to use slashes, as you cannot have a backslash as a
path component anyway, the change will not hurt, either (except for a
slight performance penalty). The same thing can be said for the "starting
with a backslash" patch.

 $ git grep -e "strrchr(.*, '/')" -e "strchr(.*, '/')"

will show a handful of instances that are not covered by the patch, that
may or may not be converted in a similar way. I suspect that many of the
hits are reading paths we internally generate (either by reading from the
index or walking trees, concatenating paths components found with '/' in
between) and should not have to be (and should not be) touched.
