From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] Test fsck a bit harder
Date: Mon, 02 Mar 2009 23:31:06 -0800
Message-ID: <7v3advgj0l.fsf@gitster.siamese.dyndns.org>
References: <200902212021.37807.j6t@kdbg.org>
 <1235946763-15252-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Mar 03 08:32:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeP7N-0002eE-81
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 08:32:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbZCCHbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 02:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbZCCHbR
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 02:31:17 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33866 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912AbZCCHbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 02:31:16 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 665DE9E316;
	Tue,  3 Mar 2009 02:31:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C31BF9E314; Tue,
  3 Mar 2009 02:31:09 -0500 (EST)
In-Reply-To: <1235946763-15252-1-git-send-email-trast@student.ethz.ch>
 (Thomas Rast's message of "Sun, 1 Mar 2009 23:32:43 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 46B5ABD8-07C5-11DE-B749-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112011>

Thomas Rast <trast@student.ethz.ch> writes:

> Johannes Sixt wrote:
>> This is wrong: It does not test the exist status. In a pipeline, the shell 
>> looks only at the exit status of the last command. You really want this as
>> 
>>  	test_must_fail git fsck >out 2>&1 &&
>
> You're right.

And you still write this after the lesson?

> +test_expect_success 'branch pointing to non-commit' '
> +	git rev-parse HEAD^{tree} > .git/refs/heads/invalid &&
> +	git fsck 2>&1 | tee out &&
> +	grep "not a commit" out
> +'

> +git update-ref -d refs/heads/invalid
> +
> +cat > invalid-tag <<EOF
> +object ffffffffffffffffffffffffffffffffffffffff
> +type commit
> +tag invalid
> +tagger T A Gger <tagger@example.com> 1234567890 -0000
> +
> +This is an invalid tag.
> +EOF

Technically speaking, the tag is perfectly valid.  It just points to a
commit you do not have.

> +cat > wrong-tag <<EOF
> +object $(echo blob | git hash-object -w --stdin)
> +type commit
> +tag wrong
> +tagger T A Gger <tagger@example.com> 1234567890 -0000
> +
> +This is an invalid tag.
> +EOF

This is indeed invalid.

> +test_expect_success 'tag pointing to something else than its type' '
> +	tag=$(git hash-object -t tag -w --stdin < wrong-tag) &&
> +	echo $tag > .git/refs/tags/wrong &&
> +	test_must_fail git fsck >out 2>&1 &&
> +	grep "Object.*is a blob, not a commit" out
> +'
> +
> +rm .git/refs/tags/wrong

I'd rather want to see test_expect_success around this "rm", and replace
that rm with something more git-ish, like "tag -d" or "update-ref -d".

By the way, is it just me or would we want to reword the subject of the
commit to tame it a little bit?
