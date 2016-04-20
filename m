From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Wed, 20 Apr 2016 09:09:53 -0700
Message-ID: <xmqqpotkw9bi.fsf@gitster.mtv.corp.google.com>
References: <1461013950-12503-1-git-send-email-sbeller@google.com>
	<1461013950-12503-3-git-send-email-sbeller@google.com>
	<20160419050342.GA19439@sigill.intra.peff.net>
	<CAGZ79kbzg7SmJHFpxeJNKmLaEEw+irCxUedo45jGx8G8fmPtKg@mail.gmail.com>
	<20160419170624.GA3999@sigill.intra.peff.net>
	<CA+P7+xp60r6Tsv0_=Qy6Wo39MmXMbCba7g5goPQD-e8FNaaEjw@mail.gmail.com>
	<xmqqoa95xknc.fsf@gitster.mtv.corp.google.com>
	<20160420161028-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Keller <jacob.keller@gmail.com>, Jeff King <peff@peff.net>,
	Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 18:10:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asuhV-0004fp-Uk
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 18:10:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbcDTQJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 12:09:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54175 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750804AbcDTQJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 12:09:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B2275125C8;
	Wed, 20 Apr 2016 12:09:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cQf/51TSaNkm8YZ67jUVwqq1W9o=; b=mBqti4
	fRH+NONAgRjdXqcInGzVR9y7owvLN1l3QG1knQ/oU3DTb7fQOprCAkOucEqXXKSg
	oIAJpKqH2Dk1agx/xQm20FhtpbzMx2CtXAKt0bjai9WyoeRPdlCfOe+rbTFGlp+F
	SFgjVcRn95jI7lov70Nwk+XXK1A32OnxB8xvg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H62LdzCGSZB0nd2LNEbyiPFHYrSq+FR7
	E27zntMIYVjD7u67/4q3uql+drDBiA46G9mi7jmOqnSLMaVKNYZcMSh41JlgbLSl
	eRZDnZWefh2rNQ0buPJO3cS1NxbQ+NZfYVOls0tK1BrPz5kulxoeAtDczIMsstAP
	SG0BkUMh1Z8=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AA6C0125C7;
	Wed, 20 Apr 2016 12:09:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E73B3125C6;
	Wed, 20 Apr 2016 12:09:54 -0400 (EDT)
In-Reply-To: <20160420161028-mutt-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Wed, 20 Apr 2016 16:12:08 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5223C01E-0712-11E6-8361-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292035>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> FWIW IIRC what that commit is about is ability to reorder the chunks in
> a patch without changing patch-id. Not about keeping id stable across
> git revisions.

OK, but "reorder the chunks" is not meant to stay to be the _ONLY_
purpose for an option whose name is a broad "--[un]stable", but
merely one (and only) possible cause of patch-id instability that
happened to be noticed as an issue back then and was dealt with that
commit, no?  In other words, the intent of the "--stable" feature is
to give a stable ID that is not affected by random end-user settings
(e.g. diff.orderfile) and if somebody invents a new configurable knob
in the future, they are supposed to pay attention to the "--stable"
feature or existing users who do use "--stable" will be broken, no?

I can still buy "--stable is not about stability across versions of
Git"--it makes our job easier ;-)  I just want to make sure that
"--stable is about stability inside a single version of Git that
patch ID for the same commit will stay the same and unaffected by
random end-user configuration knobs".

Which in turn would mean that we won't have to worry about this
option in patch-id as long as we remove the diff.compactionheuristic
configuration and command line option once the developers are done
experimenting with their heuristics code.
