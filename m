From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC-PATCHv6 4/4] pathspec: allow querying for attributes
Date: Tue, 17 May 2016 10:34:04 -0700
Message-ID: <xmqq37pgy4fn.fsf@gitster.mtv.corp.google.com>
References: <20160517031353.23707-1-sbeller@google.com>
	<20160517031353.23707-5-sbeller@google.com>
	<xmqqvb2dxomo.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbYB_4KO+XpYa0OhAcU63Q2M2kLWa03HcxeYS1HJOgfZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 17 19:34:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2iss-00078z-NI
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 19:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbcEQReO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 13:34:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60607 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751638AbcEQReN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 13:34:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 97C7F1A0E1;
	Tue, 17 May 2016 13:34:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HVVRWU3QjRrwRBdA/9o/iB0YFhE=; b=cMSBkM
	Kh0gKM+8GMBc0+G2N6jah1unpC+O+3xu0iRDt2YUcM6AhW9/3Bm60E/S9dYLoJs4
	IbtRjV0JJS5OOIp7p8htHmr0i9DlxcKc9xYQF93INsLpPFGE+S5XJMZ0FqDPUiMO
	aZIUl6sTApRfmPZ6mjbfYr5Ia+JMksQ+F4/jw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HWjWVsFdkbiIXxIZYp0s6qJ8Fy7jx2C6
	bKbxnSLvyFG6PbXMBc05xITF4LEWiYEueQKGO2IdNvzL/8ASLMi01Jumk+h5MIVf
	OTQBa0q3A2+Twoi43pcw3Qb8FZX6AQps78CHYox+DWnEgwf2lYU0sYhM1cDdJwfy
	Lh1skPryPzk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8FD391A0E0;
	Tue, 17 May 2016 13:34:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 174341A0DF;
	Tue, 17 May 2016 13:34:07 -0400 (EDT)
In-Reply-To: <CAGZ79kbYB_4KO+XpYa0OhAcU63Q2M2kLWa03HcxeYS1HJOgfZw@mail.gmail.com>
	(Stefan Beller's message of "Tue, 17 May 2016 10:03:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8E923384-1C55-11E6-8A60-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294882>

Stefan Beller <sbeller@google.com> writes:

>> Then while parsing ":(attr:VAR1=VAL1 -VAR2 VAR3...)path/to/dir/",
>
> This syntax is not pleasant to parse IMHO as it is not clear if the token
> after white space (-VAR2 here) is another attribute or the next part of
> the list of VAR1, ...

Remove the ambiguity by declaring that the list is always whitespace
separated.  No whitespace in var, no whitespace in val, no quoting.

The set of attributes with values expected to be used in the
pathspec "attribute match" magic, I do not think there is anything
that wants such a random arbitrary string.  The value side of an
attribute with value, e.g. "eol=crlf", "conflict-marker-size=7", is
designed to be a token that our C code is prepared to parse.

In other words, if you match the parsing semantics of parse_attr()
in attr.c, you are OK.  The attribute subsystem will not give users
anything that is more complex than what that routine is prepared to
parse, and that is a "whitespace separated list, no whitespace in
attribute names, no whitespace in values, no quoting".
