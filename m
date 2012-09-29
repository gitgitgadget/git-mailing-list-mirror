From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] longest_ancestor_length(): use string_list_split()
Date: Fri, 28 Sep 2012 22:43:30 -0700
Message-ID: <7vtxuhidtp.fsf@alter.siamese.dyndns.org>
References: <1348688090-13648-1-git-send-email-mhagger@alum.mit.edu>
 <1348688090-13648-4-git-send-email-mhagger@alum.mit.edu>
 <7vr4pnnkux.fsf@alter.siamese.dyndns.org> <5066863E.1030005@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Sep 29 07:43:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THpq3-0005U4-IR
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 07:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400Ab2I2Fne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 01:43:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59765 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753107Ab2I2Fnd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2012 01:43:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F5F29379;
	Sat, 29 Sep 2012 01:43:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V3sZUnwDnSvU6l3mCj5c0IQm2ok=; b=bG2P4+
	YDQ8ITxqG9jeUsw/htnszwKvAW4YGviX13Kj2/+Y1TnMBKD+voqPYhH7ZWqpgxKY
	1A7eT141I6Js/VjRcU0zcnJZHqVQoWEBv8aHhknNqUQg0H4qArREyi4qVTllAo6U
	oT5kWO8VRZJl+Dy0bfFKsM+QlU8E7KyfvseVg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NBQf8AMj6reiYsvuAwVE+YYZB90k2mA4
	1nROAvCTDiil4Yw4QUdSXaufzau51vTwYMQnBcOuIL6Jx9IHqELnplDAWIAt8T99
	J+Fu9p6EfrjRg4QhY9D+hIbTCWLNS6/SxRjx5mlyPRH73URtVTES1XUCcUMd1Jn6
	u0S7pQ/m2/c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F14E59372;
	Sat, 29 Sep 2012 01:43:32 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50F439371; Sat, 29 Sep 2012
 01:43:32 -0400 (EDT)
In-Reply-To: <5066863E.1030005@alum.mit.edu> (Michael Haggerty's message of
 "Sat, 29 Sep 2012 07:25:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9A83B9D8-09F8-11E2-9C03-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206629>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 09/28/2012 12:48 AM, Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> 
>>> -	for (colon = ceil = prefix_list; *colon; ceil = colon+1) {
>>> -		for (colon = ceil; *colon && *colon != PATH_SEP; colon++);
>>> -		len = colon - ceil;
>>> +	string_list_split(&prefixes, prefix_list, PATH_SEP, -1);
>>> +
>>> +	for (i = 0; i < prefixes.nr; i++) {
>>> +		const char *ceil = prefixes.items[i].string;
>>> +		int len = strlen(ceil);
>>> +
>> 
>> Much nicer than the yucky original ;-)
>
> If your winky-smiley implies irony, then I would like to object.

No irony.  The original was hard to read, especially with the for
loop that does in-line strchr() on a single line.  The updated one
is much easier to read.

> normalize_path_copy() can only shrink paths, not grow them.  So the
> length check on ceil guarantees that the result of normalize_path_copy()
> will fit in buf.

OK.

Thanks.
