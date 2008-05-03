From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/5] diff.c: Fix --color-words showing trailing
 deleted words at another line
Date: Sat, 03 May 2008 11:01:23 -0700
Message-ID: <7v7iebuv0s.fsf@gitster.siamese.dyndns.org>
References: <46dff0320805020726y2592732cj9aef0111e5b2288a@mail.gmail.com>
 <1209815828-6548-1-git-send-email-pkufranky@gmail.com>
 <1209815828-6548-2-git-send-email-pkufranky@gmail.com>
 <1209815828-6548-3-git-send-email-pkufranky@gmail.com>
 <1209815828-6548-4-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 03 20:03:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsM4r-0001we-QM
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 20:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765797AbYECSBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 14:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765531AbYECSBi
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 14:01:38 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56149 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765727AbYECSBh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 14:01:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id ABF5A2D68;
	Sat,  3 May 2008 14:01:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C6B4C2D63; Sat,  3 May 2008 14:01:30 -0400 (EDT)
In-Reply-To: <1209815828-6548-4-git-send-email-pkufranky@gmail.com> (Ping
 Yin's message of "Sat, 3 May 2008 19:57:06 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F73061EE-193A-11DD-B758-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81108>

Ping Yin <pkufranky@gmail.com> writes:

> With --color-words, following example will show deleted word "bar" at
> another line. (<r> represents red)
> ------------------
> $ git diff
> - foo bar
> + foo
> $ git diff --color-words
> foo
> <r>bar</r>
> ------------------

Minor style nit, but commit log is not asiidoc and the horizontal bars are
distracting.  Just use a blank line either ends to separate the example
from the descriptive text, and indent the example by a few places.

> This wrong behaviour is a bug in fn_out_diff_words_aux which always

"This wrong behaviour is a bug" is a very roundabout way to say it. "This
is caused by a bug in ..."?

> Instead, we always supress the newline when using print_word, and in
> fn_out_diff_words_aux, a newline is shown only in following cases:
>
>   - true minus.suppressed_newline followd by a line beginning with
>     '-', ' ' or '@' (i.e. not '+')
>   - true plus.suppressed_newline followd by a line beginning with
>     '+', ' ' or '@' (i.e. not '-')

Hmm, that may describe _what_ the updated code _does_, but does not
explain why/how it is an improvement.

For this kind of change we really would need tests to illustrate various
inputs and desired output for them.

> diff --git a/diff.c b/diff.c
> index b5f7141..11316fe 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -409,6 +409,7 @@ static void print_word(FILE *file, struct diff_words_buffer *buffer, int len, in
>  static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
>  {
>  	struct diff_words_data *diff_words;
> +	char cm;
>  	struct diff_words_buffer *dm, *dp;
>  	FILE *df;

These nondescriptive two letter variable names make the logic very hard to
follow.  What does cm represent in the new code?  Let's see....  (spends a
few minutes to follow the code)... Ah, it is just a randomly named
temporary variable of "char" type and do not have long-term meaning of any
significance, and could have been named "c" or "ch" or whatever.  Heck,
the code fooled me because it looked like it was named similarly to the dm
and dp nearby.

Not a demonstration of "cm" being named poorly, but this wasted few
minutes shows that dm and dp are named very poorly.
