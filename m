From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/4] Add map_user() and clear_mailmap() to mailmap
Date: Tue, 03 Feb 2009 22:50:04 -0800
Message-ID: <7v3aeu66hv.fsf@gitster.siamese.dyndns.org>
References: <cover.1233584536.git.marius@trolltech.com>
 <36adb0d2cc4c20c4efb3b03a912b27e67c166855.1233584536.git.marius@trolltech.com> <76e643ff7e99985ce46b6bf36ec967124d7fc6aa.1233584536.git.marius@trolltech.com> <53facc1773745ae477f15103718e08ea6a5ae58d.1233584536.git.marius@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 07:51:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUbc5-0006l0-Re
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 07:51:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbZBDGuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 01:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751535AbZBDGuO
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 01:50:14 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44534 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbZBDGuN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 01:50:13 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 902C9965D9;
	Wed,  4 Feb 2009 01:50:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D6632965D8; Wed,
  4 Feb 2009 01:50:06 -0500 (EST)
In-Reply-To: <53facc1773745ae477f15103718e08ea6a5ae58d.1233584536.git.marius@trolltech.com> (Marius Storm-Olsen's message of "Mon, 2 Feb 2009 15:32:09 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 11983940-F288-11DD-BCF3-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108300>

Marius Storm-Olsen <marius@trolltech.com> writes:

> map_user() allows to lookup and replace both email and
> name of a user, based on a new style mailmap file.
> The possible mailmap definitions now are:
>   proper_name <commit_email>                             // Old style
>   proper_name <proper_email> <commit_email>              // New style
>   proper_name <proper_email> commit_name <commit_email>  // New style
>
> map_email() operates the same as before, with the
> exception that it also will to try to match on a name
> passed in through the name return buffer.
>
> clear_mailmap() is needed to now clear the more complex
> mailmap structure.

Use of ample paragraph breaks would make it much easier to eyes.

    map_user() allows to lookup and replace both email and name of a user,
    based on a new style mailmap file.

    The possible mailmap definitions now are:

      proper_name <commit_email>                             # Old style
      proper_name <proper_email> <commit_email>              # New style
      proper_name <proper_email> commit_name <commit_email>  # New style

    map_email() operates the same as before, with the exception that it also
    will to try to match on a name passed in through the name return buffer.

    clear_mailmap() is needed to now clear the more complex mailmap structure.

Also, the example shows how lines would look line in a mailmap file.  I
would avoid giving a false impression that the parser should take C++
style comment introducer // by using '#' which is a documented one (I
suspect anything that follows the last angle bracket is simply ignored,
though).

> @@ -86,6 +95,27 @@ Jane Doe <jane@desktop.(none)>
>  Joe R. Developer <joe@random.com>

This context line was updated a few days ago (not a big deal, just in case
you didn't know).

> diff --git a/mailmap.c b/mailmap.c
> index 5aaee91..f593ff0 100644
> --- a/mailmap.c
> +++ b/mailmap.c
> @@ -2,7 +2,87 @@
>  #include "string-list.h"
>  #include "mailmap.h"
>  
> +#define DEBUG_MAILMAP 0
> +#if DEBUG_MAILMAP
> +#define debug_mm(...) fprintf(stderr, __VA_ARGS__)
> +#else
> +inline void debug_mm(const char *format, ...) {}
> +#endif

"static inline void ...";

> @@ -37,25 +117,65 @@ static int read_single_mailmap(struct string_list *map, const char *filename, ch
>...
> +		/* Locate 2nd name and email. Possible mappings in mailmap file are:
> +		 *   proper_name <commit_email>
> +		 *   proper_name <proper_email> <commit_email>
> +		 *   proper_name <proper_email> commit_name <commit_email>
> +		 */

	/*
         * We tend to write a multi line comment block
         * like this.
         */

> +		do {
> +			email2 = name2 = 0;
> +			right_bracket1 += 1;
> +			if ((left_bracket2 = strchr(right_bracket1, '<')) == NULL)
> +				continue;
> +			if ((right_bracket2 = strchr(left_bracket2 + 1, '>')) == NULL)
> +				continue;
> +			if (right_bracket2 == left_bracket2 + 1)
> +				continue;
> +			for (end_of_name = left_bracket2;
> +			     end_of_name != right_bracket1 && isspace(end_of_name[-1]);
> +			     end_of_name--)
> +				; /* keep on looking for name end */
> +			for (;
> +			     end_of_name != right_bracket1 && isspace(right_bracket1[0]);
> +			     right_bracket1++)
> +				; /* keep on looking for name start */
> +			if (end_of_name != right_bracket1) {
> +				name2 = xmalloc(end_of_name - right_bracket1 + 1);
> +				strlcpy(name2, right_bracket1, end_of_name - right_bracket1 + 1);
> +				char *tmp = name1;
> +				name1 = name2;
> +				name2 = tmp;
> +			}
> +			email2 = xmalloc(right_bracket2 - left_bracket2);
> +			for (i = 0; i < right_bracket2 - left_bracket2 - 1; i++)
> +				email2[i] = tolower(left_bracket2[i + 1]);
> +			email2[right_bracket2 - left_bracket2 - 1] = '\0';
> +			char *tmp = email1;
> +			email1 = email2;
> +			email2 = tmp;
> +		} while(0);

Yuck.  Is it just me or is this new codeblock especially denser than existing
code?  I wonder use of a few smaller helper functions (that the compiler
may be able to inline without being told for us) would make this easier to read
without funny-looking "do { ... if (...) continue; } while (0)" trick?

Two "char *tmp" in this scope are both decl-after-statement errors.
