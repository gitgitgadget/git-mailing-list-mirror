From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 1/4] commit: --fixup option for use with rebase
 --autosquash
Date: Thu, 23 Sep 2010 10:56:10 -0700
Message-ID: <7vsk10qr7p.fsf@alter.siamese.dyndns.org>
References: <1285262076-20134-1-git-send-email-patnotz@gmail.com>
 <1285262076-20134-2-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Pat Notz" <patnotz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 23 19:57:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oyq2Z-0007Fy-Na
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 19:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756015Ab0IWR4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 13:56:21 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51166 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755902Ab0IWR4T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 13:56:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E878D802E;
	Thu, 23 Sep 2010 13:56:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8OrkT9o/98OmmXV49tZhNpHS/ig=; b=QFVOOj
	GohkTawt5Rc6QR9DqTC/kdNIqmkT72mlsIfbJPxmK7v1n6lmbxtUC9CBKMaQQOIB
	MjzJ6FACRRjs6ysqDL70LuTyB3youC4ZmGMiH39TWxQ+DOa0xEmGa9Z0hxji7vtW
	leyiCe3pjypSZyRfNWtntf1V0eXRURqLLMzRA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d5vcotLAUQkb/WG6XdOUdWZu6Sh/YCvp
	dkdLP1lMbzW4xm8vJbcW5AWEJisZ3PQWqT2PywKJifKh1VUEE7i80N485LW0PGP/
	zoRgssVV+RFzx1c4JX59nxJ1/c96Y3bQysimVG37JwMEJB/O00P9gisKtddbDU1+
	diPbcqtu3HI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 44789D802C;
	Thu, 23 Sep 2010 13:56:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 85FA6D802B; Thu, 23 Sep
 2010 13:56:12 -0400 (EDT)
In-Reply-To: <1285262076-20134-2-git-send-email-patnotz@gmail.com> (Pat
 Notz's message of "Thu\, 23 Sep 2010 11\:14\:33 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DC02281A-C73B-11DF-B36B-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156891>

"Pat Notz" <patnotz@gmail.com> writes:

> +	} else if (fixup_message) {
> +		unsigned char sha1[20];
> +		struct commit *commit;
> +		struct pretty_print_context ctx = {0};
> +		if (get_sha1(fixup_message, sha1))
> +			die("could not lookup commit %s", fixup_message);
> +		commit = lookup_commit_reference(sha1);
> +		if (!commit || parse_commit(commit))
> +			die("could not parse commit %s", fixup_message);
> +		format_commit_message(commit, "fixup! %s\n\n", &sb, &ctx);
> +		hook_arg1 = "message";


I notice that the above is a half-copy-and-paste from "if (use_message)"
codepath that handles -c/-C.  A few issues to think about (i.e. not
complaints; I haven't thought about them myself):

 (1) Is it worth refactoring the original instead of copying;

 (2) What happens/should happen when the original commit is encoded
     differently from the current commit encoding?  -c/-C codepath takes
     pains to re-encode.  Should we do so somewhere in this codepath, too?

 (3) If the answer to (2) is "Yes", notice that format_commit_message()
     does not re-encode the commit log message ("log" output codepath uses
     pretty.c::pretty_print_commit(), which reencodes for log output
     encoding).  Maybe we need an option to tell format_commit_message()
     to do so?

The last is not exactly an issue this patch alone should address, but I
thought I'd better mention it anyway.

My knee-jerk answers to the above are:

 (1) The first handful of lines in this new "if (fixup_message)" codeblock
     up to "die" might want to use a helper function shared with the
     existing "if (use_message)" codepath;

 (2) We probably want to re-encode to the log output encoding the string
     we receive from format_commit_message() in this codepath.

 (3) No need yet.
