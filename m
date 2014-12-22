From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use wc instead of awk to count subtrees in t0090-cache-tree
Date: Mon, 22 Dec 2014 15:34:26 -0800
Message-ID: <xmqq4msn6yyl.fsf@gitster.dls.corp.google.com>
References: <1419270744-1408-1-git-send-email-bdwalton@gmail.com>
	<xmqqd27b6zd3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: dturner@twopensource.com, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 00:34:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3CUj-00053C-1o
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 00:34:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753545AbaLVXe3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 18:34:29 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50172 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751884AbaLVXe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 18:34:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C77EC299F7;
	Mon, 22 Dec 2014 18:34:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nl3EJNXoYmBhF19hK7mcGZI2R3U=; b=JtC4Al
	W9ouMRgv4TQKYtAx29zkqkmWY4yhJzILd4wI3wDMzE8QSbu5tr4uFkeAYIPrO1cu
	+2xvb8cIMWVSTAkl1vtR1RC/yMZoNiXGL/ABZBDe9ZG1MOMkPoqpgXnPThV4h+EO
	wKCsJgPjeQ2wnUoQRpYjAFGXkleOk7OG563c8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NSlEmX8eYuA6el0VAJm2Eu6SYzIxllR8
	2HQlIjqegFV4MznyYnhCfeJJTsqYP/kmq351AY4Lm4uFtEwK3Y51j91D2kPa+Hga
	kUcbgMQW5wwVVnH3+/EJ03ckGAKxz4i37XSYBHhUMT6bTd/OHV/f0MSzzefM6Xj0
	HzN+CTB/0po=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BEE2E299F6;
	Mon, 22 Dec 2014 18:34:27 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 45625299F5;
	Mon, 22 Dec 2014 18:34:27 -0500 (EST)
In-Reply-To: <xmqqd27b6zd3.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 22 Dec 2014 15:25:44 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 11B4B806-8A33-11E4-BAE0-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261701>

Junio C Hamano <gitster@pobox.com> writes:

> From: Ben Walton <bdwalton@gmail.com>
>
> The awk statements previously used in this test weren't compatible
> with the native versions of awk on Solaris:
>
>     echo "dir" | /bin/awk -v c=0 '$1 {++c} END {print c}'
>     awk: syntax error near line 1
>     awk: bailing out near line 1
>
>     echo "dir" | /usr/xpg4/bin/awk -v c=0 '$1 {++c} END {print c}'
>     0
>
> And with GNU awk for comparison:
>
>     echo "dir" | /opt/csw/gnu/awk -v c=0 '$1 {++c} END {print c}'
>     1
>
> Work it around by using $1 != "" to state more explicitly that we
> are skipping empty lines.

By the way, I was hoping (eh, what kind of hope is that???) that $1
alone is not a kosher POSIX way but a GNUism, but that does not seem
to be the case.  POSIX has this [*1*]

    When an expression is used in a Boolean context, if it has a
    numeric value, a value of zero shall be treated as false and any
    other value shall be treated as true. Otherwise, a string value
    of the null string shall be treated as false and any other value
    shall be treated as true. A Boolean context shall be one of the
    following:

and among the "Boolean context" listed is:

    * An expression used as a pattern (as in Overall Program Structure)

So the example with /usr/xpg4/bin/awk does not seem to be a
behaviour from a conformant implementationd, and it seems to be
correct to label this as "work it around by ..." (not "avoid using
GNUism").

We learn new things every day (not that I really wanted to learn
glitches in various implementations of awk) ;-).

Thanks.


[Reference]

*1* http://pubs.opengroup.org/onlinepubs/9699919799/utilities/awk.html
