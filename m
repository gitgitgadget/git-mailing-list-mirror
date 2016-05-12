From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] submodule groups
Date: Wed, 11 May 2016 17:00:27 -0700
Message-ID: <xmqqd1osi1r8.fsf@gitster.mtv.corp.google.com>
References: <1462928397-1708-1-git-send-email-sbeller@google.com>
	<xmqq4ma5l526.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kY3S6SmJOMQ7RAKw0yTvicY=Y1VRRGdm5uK9+Eb7W+Ykg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 12 02:00:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0e3P-0005cR-R9
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 02:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbcELAAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 20:00:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55834 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751324AbcELAAb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 20:00:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 47A861A8B1;
	Wed, 11 May 2016 20:00:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y+h40Ezsn0egsayVg+hapOyeFIA=; b=Q02oSs
	TftJKS7KMlzuMKz5wR0w2fBSMi8MXKb6jH6nBt7pxj4cKCtGjw18wRtRszJBuO48
	S26QMHOWJZ0801+v5NTrFNqzXU8yqZCsZCAj8Brap7w/Jl8WPOWqcyV8wEyDZDKo
	q0Sgv7Q86hi6da12vmPJebJCFSnP8iwWOBZXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OniQlExtv9fOTewseNXbqMMLDRlTZLmv
	O6PQOvqyRspF2Be2CWzIrYhLud8WdTp/uG3eAMdEWdmoj9NRecnFK1tNEd/dhMB+
	bQx8w2biuRrnTAUHTjt7llyTNLNNJEPWUhtCwcpQfjgpCeWmx0HbqNuoNXmZXobN
	r3z2IBwODvc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F8621A8B0;
	Wed, 11 May 2016 20:00:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A61871A8AF;
	Wed, 11 May 2016 20:00:29 -0400 (EDT)
In-Reply-To: <CAGZ79kY3S6SmJOMQ7RAKw0yTvicY=Y1VRRGdm5uK9+Eb7W+Ykg@mail.gmail.com>
	(Stefan Beller's message of "Wed, 11 May 2016 16:07:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 89FCFC6C-17D4-11E6-AB65-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294381>

Stefan Beller <sbeller@google.com> writes:

>     git submodule--helper matches-submodulespec sub0 ./.
> ./:(exclude)*0 *label-sub0
>
> which should test if the first argument (sub0) matches the submodulespec
> which follows.

This, according to that "OR'ed together" definition, asks to find a
submodule

    - whose path matches pathspec ./. ./:(exclude)*0; or
    - is labeled with label-sub0.

So I'd say it is natural sub0 matches if its path is at sub0 and has
a label label-sub0.

You could instead choose to use "AND'ed together" semantics, but
that would break expectation by those who expect "This OR that"
behaviour.  Unless you are willing to support --and/--or/(/) like
"git grep" does to express a way to combine hits from individual
terms, that is an inherent limitation.

I'd suggest not to over-engineer this.  Go back and imagine how
"/bin/ls" would work is a good sanity check to gauge what complexity
levels ordinary users would feel comfortable to handle.

"ls a b" would give union of what "ls a" and "ls b" would output,
there is no negation, and the users won't die from having to say "ls
[A-Za-qs-z]*" to exclude files whose names begin with 'r'.
