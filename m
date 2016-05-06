From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] rev-parse tests: add tests executed from a subdirectory
Date: Fri, 06 May 2016 15:10:07 -0700
Message-ID: <xmqqy47m25z4.fsf@gitster.mtv.corp.google.com>
References: <1462541720-79553-1-git-send-email-rappazzo@gmail.com>
	<1462541720-79553-2-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com, szeder@ira.uka.de
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 07 00:10:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aynww-0007TP-BW
	for gcvg-git-2@plane.gmane.org; Sat, 07 May 2016 00:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758653AbcEFWKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 18:10:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63770 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758408AbcEFWKL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 18:10:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C78181A732;
	Fri,  6 May 2016 18:10:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nwRRlZ+dzYX6P9ekZa+PYjiBIl8=; b=xsmY7j
	HIfqHMt9oFdxmofDWI0FeOc6/VLoT1BmZsgDXkAembP3LwJstx/dSVNTUQkbvxXC
	hsJhdw16YJuF5bnK/0J5ekWxmKTCj4OvZkzuPhVGuKt+ZLfu0Mg5gNP2YO6dwMbn
	FKufai/b60pdwIp3p5VN0Xpe9txk9lwTVa1W8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r7xtlE/dUNxtscQPdJgwl6XTcAT6wo5C
	hDvMWizBHycl/Vx/XfUHzwLdLSzG3XlFFgzSTYEztIGT2mr4m8mNYfqpzuSezZaK
	gs84/yGM976iw/zseWRGvK4BJ78Lkxd02zjgyr+4n6/kqXZS2NvmG6k72omwUEmU
	/WV3PZVikSg=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BFDB01A731;
	Fri,  6 May 2016 18:10:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 49D191A730;
	Fri,  6 May 2016 18:10:09 -0400 (EDT)
In-Reply-To: <1462541720-79553-2-git-send-email-rappazzo@gmail.com> (Michael
	Rappazzo's message of "Fri, 6 May 2016 09:35:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4BDEED38-13D7-11E6-95B7-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293863>

Michael Rappazzo <rappazzo@gmail.com> writes:

> t1500-rev-parse contains envrionment leaks (changing dir without
> changing back, setting config variables, etc).  Add a test to clean this
> up up so that future tests can be added without worry of any setting
> from a previous test.

This is a wonderful thing to do, but...

>  test_rev_parse toplevel false false true '' .git
>  
> @@ -84,4 +85,41 @@ test_rev_parse 'GIT_DIR=../repo.git, core.bare = true' true false false ''
>  git config --unset core.bare
>  test_rev_parse 'GIT_DIR=../repo.git, core.bare undefined' false false true ''
>  
> +test_expect_success 'cleanup from the previous tests' '
> +	cd .. &&
> +	rm -r work &&

Instead of cleaning things up like this, could you please please
please fix these existing tests that chdir around without being in a
subshell?  If the "previous tests" failed before going down as this
step expects, the "cd .. && rm -r" can make things worse.

> +	mv repo.git .git &&
> +	unset GIT_DIR &&
> +	unset GIT_CONFIG &&

The spirit of this change is to make the test more independent from
the effects of what happened previously.  Use sane_unset so that
we do not have to worry about previous step that may have failed
before it has a chance to set GIT_DIR and GIT_CONFIG (which would
cause these unset to fail).

> +	git config core.bare $original_core_bare

Is this (rather, the capturing of $original_core_bare up above)
necessary?  We are in the default 'trash' repository when the
capturing happens, and we know it is not a bare repository, right?
