From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cherry-pick: Append -x line on separate paragraph
Date: Tue, 04 Sep 2012 11:43:28 -0700
Message-ID: <7vsjaxaasv.fsf@alter.siamese.dyndns.org>
References: <739367481.1229.1346778500787.JavaMail.root@bazinga.schuettel.ch>
 <1244407605.1231.1346779006295.JavaMail.root@bazinga.schuettel.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Stocker <robin@nibor.org>
X-From: git-owner@vger.kernel.org Tue Sep 04 20:43:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8y68-0000Jh-3h
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 20:43:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757519Ab2IDSnc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 14:43:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34625 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757506Ab2IDSnb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 14:43:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C439968F;
	Tue,  4 Sep 2012 14:43:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dNAGniHw9ch8yocbhPPqZZIdogc=; b=cORIce
	gLGyrQpfXyKEw7DkZZ5k67FnZ8zaVqFg+llNlFnDmHb9ZWwSWMZ3jmqovd1IDMnj
	qIzP95qMqQE+C+IDSP80IBQDkMsK2irSRjFNY4dPyhYGqWITDh4pfGGjgcjW1Ovn
	qVbQ/ARYQ/FsVYwtGiKjmJHU+WxFanOpV/Tqc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IeXwbuBbKSTVDG0H+VgEuwrEHNYmY+2N
	eoSylpzJrnKxY850MRWVHLF3kASH+it1uKPPXPzlraIIoc7ACPF7G7ye8vgWRDBk
	rRxSgfHGkCuuOnUMXjAJB9wWUJCQ7DbnNqqbOnqZUhd3ki4eGE5044eNx6M2ilBE
	XGtMDFSnulw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A0EF968D;
	Tue,  4 Sep 2012 14:43:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D61F4968A; Tue,  4 Sep 2012
 14:43:29 -0400 (EDT)
In-Reply-To: <1244407605.1231.1346779006295.JavaMail.root@bazinga.schuettel.ch> (Robin
 Stocker's message of "Tue, 4 Sep 2012 19:16:46 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6BB29D5E-F6C0-11E1-8F47-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204762>

Robin Stocker <robin@nibor.org> writes:

>  		if (opts->record_origin) {
> +			/* Some implementations don't terminate message with final \n, so add it */
> +			if (msg.message[strlen(msg.message)-1] != '\n')
> +				strbuf_addch(&msgbuf, '\n');

I can agree that this is a good change.

> +			strbuf_addch(&msgbuf, '\n');

But this is somewhat dubious.  Even if what we are adding is merely
an extra LF, that changes the mechanically generated output format
and can break existing hooks that read from these generated commit
log template.

Is there a reason better than "having an empty line there look
better to _me_" to justify this change?

>  			strbuf_addstr(&msgbuf, "(cherry picked from commit ");
>  			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
>  			strbuf_addstr(&msgbuf, ")\n");

Having said that, I've seen proposals to update this message to
format more like the other trailers, so that we would see this:

	The title of the original commit

	The log message taken from the original
        commit comes here.

	Signed-off-by: First person who signed off the original
        Signed-off-by: Another person who signed off the original
        Cherry-picked-from: a9bbc121ea850e49d52ba3cb5a6b7f8077d195d2
        
in the editor, to allow you to add your own Sign-off at the end to
make it look like this:

	The title of the original commit

	The log message taken from the original
        commit comes here.

	Signed-off-by: First person who signed off the original
        Signed-off-by: Another person who signed off the original
        Cherry-picked-from: a9bbc121ea850e49d52ba3cb5a6b7f8077d195d2
	Signed-off-by: Me who did the cherry-pick

I think that might be a worthwhile thing to do perhaps as an
optional behaviour (e.g. perhaps triggered with a new option
"--trailer", or with the same "-x" but only when "cherry-pick.origin
= trailer" configuration is set, or something).  At that point, the
output will look vastly different to existing hooks and those who
care how this field looks like are forced to be updated, but as long
as it is an opt-in feature, it may be worth it.
