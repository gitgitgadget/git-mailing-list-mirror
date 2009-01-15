From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] checkout: implement "-" shortcut name for last branch
Date: Thu, 15 Jan 2009 12:50:43 -0800
Message-ID: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org>
References: <1231977976-8739-1-git-send-email-trast@student.ethz.ch>
 <1231978322-21228-1-git-send-email-trast@student.ethz.ch>
 <7vocy8s51o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jan 15 21:52:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNZCk-0006W0-Am
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 21:52:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933341AbZAOUu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 15:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934206AbZAOUu4
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 15:50:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33289 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763747AbZAOUux (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 15:50:53 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A879F1C9C3;
	Thu, 15 Jan 2009 15:50:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6A0E31C9A8; Thu,
 15 Jan 2009 15:50:45 -0500 (EST)
In-Reply-To: <7vocy8s51o.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 15 Jan 2009 12:11:31 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 30CAA3E4-E346-11DD-8D7A-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105877>

Junio C Hamano <gitster@pobox.com> writes:

> So I think it is just the matter of coming up with a clever syntax that
> works on reflogs to name the nth last branch we were on and teach that
> syntax to both get_sha1() and resolve_ref().
>
> With the attached illustration patch,
>
>      $ git checkout junk
>      $ git chekcout master
>      $ git checkout @{-1}
>
> will take you back to junk branch.  It probably would serve as a starting
> point, if anybody is interested.
>
> NOTE!
> ...
>  * interpret_nth_last_branch() is not hooked to get_sha1() codepath in
>    this patch, so this is still only applicable to "git checkout".  But it
>    should be trivial to do so.
> ...
> +/*
> + * This reads "@{-N}" syntax, finds the name of the Nth previous
> + * branch we were on, and places the name of the branch in the given
> + * buf and returns 0 if successful.
> + *
> + * If the input is not of the accepted format, it returns a negative
> + * number to signal an error.
> + */
> +int interpret_nth_last_branch(const char *name, struct strbuf *buf)

A few more things to note.

 * interpret_nth_last_branch() probably should return how many bytes it
   consumed, instead of returning 0 in the successful case.  This is to
   allow things like "git merge @{-1}~2" to be easily parsed, either by
   "git merge" itself into "git merge junk~2", which would result in
   "Merge branch junk (early part)", or by get_sha1() which would result
   in "Merge commit deadbeefacebeads".

 * I mentioned resolve_ref() may need to be told about this syntax but I
   do not think it is necessary.  If a command that can take an arbitrary
   refname or committish in the most general case does something special
   when the end user input is a branch name ("git checkout" is a prime
   example for this, but "git merge" also has this property, illustrated
   by the previous "Merge branch junk" example), these commands has to do
   their own special case logic before the user input hits get_sha1() or
   resolve_ref() anyway (setup_branch_path() in builtin-checkout.c is a
   good example of this), and such special case logic can and probably
   should use interpret_nth_last_branch() directly.
