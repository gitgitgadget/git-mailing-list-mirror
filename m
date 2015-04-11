From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] t4059: test 'diff --cc' with a change from only few parents
Date: Sat, 11 Apr 2015 13:04:58 -0700
Message-ID: <xmqqmw2ea0t1.fsf@gitster.dls.corp.google.com>
References: <1428006853-21212-1-git-send-email-max@max630.net>
	<1428076716-4449-1-git-send-email-max@max630.net>
	<1428076716-4449-2-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Sat Apr 11 22:05:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yh1eb-00013R-Vi
	for gcvg-git-2@plane.gmane.org; Sat, 11 Apr 2015 22:05:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752791AbbDKUFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2015 16:05:04 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53747 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755458AbbDKUFD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2015 16:05:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5707C45801;
	Sat, 11 Apr 2015 16:05:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Wn2uW8wQuaTpzQhInYwSnsvGsqg=; b=QEzsYt
	Wo8TqJwikgdSCAdWOz8VLXDmXd2lMN3cg9Vl1VBvOTDjBRR6Ld9D1nOqJWKqL7et
	KJoGBIlAIjDEHfcBFmR8IVdU3cqufo2eRWxp3yIkOrSOg5ZLu2ZjTQ0abYYr+FQV
	aFRibe6sIii05EnyNvuR3gqHb9F4kw+0LlJfA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lStCTZTRR4LXzIjB+XwVwlvmUu3cghyL
	f8SOC+b5B2tfXDF5fdgN7DQ26gsIt2vG6rFHRRBnDrySxswL0a4A4jAnuWCmidnH
	KlnqDm0CoF1Hu9RmodLe9tor0wASggGD8Cf5PbujkHI7ADxKpj8B10HB6Fweqd76
	dbR9KKjzO2w=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C716457FA;
	Sat, 11 Apr 2015 16:05:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 045D9457F7;
	Sat, 11 Apr 2015 16:04:59 -0400 (EDT)
In-Reply-To: <1428076716-4449-2-git-send-email-max@max630.net> (Max Kirillov's
	message of "Fri, 3 Apr 2015 18:58:33 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0878FAD2-E086-11E4-B48D-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267031>

Max Kirillov <max@max630.net> writes:

> If `git diff --cc` is used with 2 or more parents, then
> it shows all hunks which have changed compared to at least 2 parents.
> Which is reasonable, because those places are likely places for
> conflicts, and it should be displayed how they were resolved.
> But, preliminary path filtering passes a path only it was changed
> compared to each parent. So, if a hunk which has not changed compared to
> some of parents is shown if there are more changed hunks in the file,
> but not shown if it is the only change.
>
> This looks inconsistent and for some scenarios it is desirable to show
> such changes.
>
> Add the test which demonstrates the issue.
>
> Signed-off-by: Max Kirillov <max@max630.net>
> ---
>  t/t4059-diff-cc-not-affected-by-path-filtering.sh | 108 ++++++++++++++++++++++
>  1 file changed, 108 insertions(+)
>  create mode 100755 t/t4059-diff-cc-not-affected-by-path-filtering.sh
>
> diff --git a/t/t4059-diff-cc-not-affected-by-path-filtering.sh
> b/t/t4059-diff-cc-not-affected-by-path-filtering.sh
> new file mode 100755
> index 0000000..3e6e59b
> --- /dev/null
> +++ b/t/t4059-diff-cc-not-affected-by-path-filtering.sh
> @@ -0,0 +1,108 @@
...
> +	test_seq 11 | sed -e "s/^7/7change1/" -e "s/^11/11change2/" >long/base &&
> +	git add long/base &&
> + test_seq 11 | sed -e "s/^7/7change1/" -e "s/^11/11change2/" -e
> "s/^2/2change1/" >long/win1 &&
> +	git add long/win1 &&
> + test_seq 11 | sed -e "s/^7/7change1/" -e "s/^11/11change2/" -e
> "s/^2/2change2/" >long/win2 &&
> +	git add long/win2 &&
> + test_seq 11 | sed -e "s/^7/7change1/" -e "s/^11/11change2/" -e
> "s/^2/2merged/" >long/merge &&
> +	git add long/merge &&
> + test_seq 11 | sed -e "s/^7/7change1/" -e "s/^11/11change2/" -e
> "/^2/d" >long/delete &&
> +	git add long/delete &&
> + test_seq 11 | sed -e "s/^7/7change1/" -e "s/^11/11change2/" -e
> "s/^2/2change1/" >long/only1 &&
> +	git add long/only1 &&
> + test_seq 11 | sed -e "s/^7/7change1/" -e "s/^11/11change2/" -e
> "s/^2/2change2/" >long/only2 &&

Hmph.  Is it gmane who is munging these lines?

The other copy of this message I received in my mbox (which I read
in the same MUA) does not seem to have this corruption, and I do not
expect vger.kernel.org to do this kind of munging without getting
yelled at by the kernel folks.

Anyway, thanks; I'll take a deeper look once I got a chance to.
