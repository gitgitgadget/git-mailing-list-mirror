From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] sequencer: factor code out of revert builtin
Date: Sun, 13 Nov 2011 15:10:17 -0800
Message-ID: <7vvcqnmxeu.fsf@alter.siamese.dyndns.org>
References: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
 <1320510586-3940-2-git-send-email-artagnon@gmail.com>
 <20111106001232.GC27272@elie.hsd1.il.comcast.net>
 <CALkWK0n7v15n_s3CNq1Qu3LHjYkV-ENAkv2b+oB+VBkyV+Sphw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 14 00:10:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPjC2-0003hP-Fi
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 00:10:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124Ab1KMXKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Nov 2011 18:10:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60116 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752809Ab1KMXKU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2011 18:10:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A9760541F;
	Sun, 13 Nov 2011 18:10:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U+m839LSwJUk8cN50w8Q2uDALCA=; b=NENPb2
	yoIPegqDhJPXCMaTz2ZPJ2QT9eBA+aLbmhTni0TaLTlyYmGtZuOGSiF9A92XayeI
	D2YZO3rnjX2HJf5mCFYc6MhndjDbkrznUMLWza3dLSoVF7r9kjEYWTYytQdWOm76
	gYgVLGwxVtX+e7nJ4jTbpJIGh7avxHzHNIN60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GtxYemmgXQboUEQIxTqKeH3OFGATZvAu
	8uuRXPqdN9F5tWxBPDa0x8lf0spq5Du2AE3ePV84dc1HLJyfQTu/ky1n01RC3ZJh
	Kz+4/8uvOUX4ItpjnbaLOHmM8pTkbqV0jLO9+w3F4PT24eVhpThEDNn40avItpHa
	lf6ch6v/bzk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0774541E;
	Sun, 13 Nov 2011 18:10:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 34BD0541C; Sun, 13 Nov 2011
 18:10:19 -0500 (EST)
In-Reply-To: <CALkWK0n7v15n_s3CNq1Qu3LHjYkV-ENAkv2b+oB+VBkyV+Sphw@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Sun, 13 Nov 2011 16:10:12 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A7BC8AE2-0E4C-11E1-8ADB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185353>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>> Why did sequencer.h move to after dir.h?
>
> 1. I like the convention of including the "foo.h" as the last header
> in "foo.c".

I do not think it is a good convention. The implementation of "foo.c" may
need to include many other headers for its own use of other APIs, and the
declarations in "foo.h" may depend on some types declared in some of them,
but by definition the latter is a subset of the former. Having "foo.h" at
the end of "foo.c" makes it difficult for others to tell between the two.

A user of foo.h API should need to include only git-compat-util.h and
foo.h to be able to use foo.h API in the ideal world, even though it may
need to include other headers to use other APIs defined in them.

A workable alternative in a world that is not so perfect for a user of
"foo.h" API is to include git-compat-util.h and what "foo.h" needs before
including "foo.h" and then other headers it needs. I think the current
source code takes this approach.

With that observation, it would probably make more sense if "foo.c"
included the headers in the following order:

 - git-compat-util.h (or the prominent ones like "cache.h" that is known
   to include it at the beginning);
 - Anything the declarations in "foo.h" depends on;
 - "foo.h" itself; and finally
 - Other headers that "foo.c" implementation needs.

That way, people who want to use "foo.h" can guess what needs to be
included before using "foo.h" a lot more easily.
