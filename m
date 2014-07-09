From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] use new config API for worktree configurations of submodules
Date: Wed, 09 Jul 2014 15:04:50 -0700
Message-ID: <xmqqegxu9ojh.fsf@gitster.dls.corp.google.com>
References: <20140628095800.GA89729@book.hvoigt.net>
	<20140628100321.GD89729@book.hvoigt.net>
	<xmqqy4w38v6r.fsf@gitster.dls.corp.google.com>
	<20140709195547.GA3081@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, "W. Trevor King" <wking@tremily.us>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu Jul 10 00:05:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4zz3-0007dD-Sv
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 00:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755278AbaGIWE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 18:04:58 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64914 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752795AbaGIWE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 18:04:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EE6982898B;
	Wed,  9 Jul 2014 18:04:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G3gDyaPZ2w/pKI0RxbI7emp1lO4=; b=dG/pVA
	d49NzUdne6z7jcUP/vJEZt8pnz0mS4vSbfvdzD2u4wmQSMHFHJ3EY7T2AzXFuPak
	faZXtpNwd/LCyaBoZMePCoHHwdyXglne1WH4TdnvCaBaZFECYStEhqhQtnWdwr/i
	6DkQxxpIO2/9NcpgUsqgTiML5AYcDXHeQPklU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=otJ2fNwEP/5ZY9tYm0MjKjNdWaDkqVdu
	GLacqOZB4zHbI5RNILscMW+Yy/7fwcjLnm6VulTkOrjZ2S+JOzYZhuO/Yukvg6zj
	qHYdbdU48+sgsvKGG2+aQqYa7EKq7UNVuAyYDH77yIJlo+YGPxf2MFR41uk9HYHg
	Zb1knH6Pt5o=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E42BB2898A;
	Wed,  9 Jul 2014 18:04:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 753A228986;
	Wed,  9 Jul 2014 18:04:36 -0400 (EDT)
In-Reply-To: <20140709195547.GA3081@sandbox-ub> (Heiko Voigt's message of
	"Wed, 9 Jul 2014 21:55:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 03FFB946-07B5-11E4-B970-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253162>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> On Tue, Jul 08, 2014 at 01:14:20PM -0700, Junio C Hamano wrote:
>> Heiko Voigt <hvoigt@hvoigt.net> writes:
>> 
>> > diff --git a/builtin/checkout.c b/builtin/checkout.c
>> > index 07cf555..03ea20d 100644
>> > --- a/builtin/checkout.c
>> > +++ b/builtin/checkout.c
>> > @@ -18,6 +18,7 @@
>> >  #include "xdiff-interface.h"
>> >  #include "ll-merge.h"
>> >  #include "resolve-undo.h"
>> > +#include "submodule-config.h"
>> >  #include "submodule.h"
>> >  #include "argv-array.h"
>> >  
>> 
>> Hmph.  What is this change about?  
>> 
>> Nobody in checkout.c needs anything new, yet we add a new include?
>
> This is because I moved the parse_submodule_config_option() function
> into the submodule-config.c module. This was necessary so all parsed
> submodule values are stored in the cache with the null_sha1. We use
> static functions from this module to do this and thats thats the reason
> for the move. 
>
>> > diff --git a/diff.c b/diff.c
>> > index f72769a..f692a3c 100644
>> > --- a/diff.c
>>  ...
>> Likewise.
>
> Same as above.

Can there be any caller that include and use submodule-config.h that
does not need anythjing from submodule.h?  Or vice versa?

It just did not look like these two headers describe independent
subsystems but they almost always have to go hand-in-hand.  And if
that is the case, perhaps it is not such a good idea to add it as a
new header.  That was where my question came from.

> Does that make the improvements in my series clear for you? I would wait
> until my recursive fetch series is ready so we have real uses. Since
> there are others (namely Jens or submodule support for 'git archive')
> that need it I think it makes sense to review and merge this separately
> into master so they have a stable API to code against.

Sure.  If we have sufficient amount of client code to judge the
goodness of the API design against, there is no need to wait until
all possible client code becomes ready.
