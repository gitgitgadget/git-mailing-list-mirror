From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] avoid exponential regex match for java and objc function names
Date: Wed, 17 Jun 2009 09:42:43 -0700
Message-ID: <7vab46rev0.fsf@alter.siamese.dyndns.org>
References: <20090617102332.GA32353@coredump.intra.peff.net>
	<1245248766-14867-1-git-send-email-bonzini@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, peff@peff.net
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jun 17 18:42:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGyDu-00069U-5O
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 18:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754597AbZFQQmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 12:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754757AbZFQQmm
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 12:42:42 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:38881 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbZFQQml (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 12:42:41 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090617164244.FHCL2915.fed1rmmtao103.cox.net@fed1rmimpo03.cox.net>;
          Wed, 17 Jun 2009 12:42:44 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 54ij1c00M4aMwMQ044ijyY; Wed, 17 Jun 2009 12:42:43 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=4bDDxhUQmTcA:10 a=mDV3o1hIAAAA:8
 a=Tj2VEP4F-haZHRVkptEA:9 a=xAMjntMCP5_qyC3HHoVxlxYhrc0A:4 a=ii61gXl28gQA:10
X-CM-Score: 0.00
In-Reply-To: <1245248766-14867-1-git-send-email-bonzini@gnu.org> (Paolo Bonzini's message of "Wed\, 17 Jun 2009 16\:26\:06 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121759>

Paolo Bonzini <bonzini@gnu.org> writes:

> In the old regex
>
> ^[ \t]*(([ \t]*[A-Za-z_][A-Za-z_0-9]*){2,}[ \t]*\([^;]*)$
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> you can backtrack arbitrarily from [A-Za-z_0-9]* into [A-Za-z_], thus
> causing an exponential number of backtracks.  Ironically it also causes
> the regex not to work as intended; for example "catch" can match the
> underlined part of the regex, the first repetition matching "c" and
> the second matching "atch".
>
> The replacement regex avoids this problem, because it makes sure that
> at least a space/tab is eaten on each repetition.  In other words,
> a suffix of a repetition can never be a prefix of the next repetition.

Thanks; nicely done.

Should I remove the "/* -- */" or is it for better readability I should
keep?

> Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
> ---
>  userdiff.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/userdiff.c b/userdiff.c
> index d556da9..57529ae 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -13,7 +13,8 @@ PATTERNS("html", "^[ \t]*(<[Hh][1-6][ \t].*>.*)$",
>  	 "[^<>= \t]+|[^[:space:]]|[\x80-\xff]+"),
>  PATTERNS("java",
>  	 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
> -	 "^[ \t]*(([ \t]*[A-Za-z_][A-Za-z_0-9]*){2,}[ \t]*\\([^;]*)$",
> +	 "^[ \t]*(([A-Za-z_][A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$",
> +	 /* -- */
>  	 "[a-zA-Z_][a-zA-Z0-9_]*"
>  	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
>  	 "|[-+*/<>%&^|=!]="
> @@ -25,7 +26,7 @@ PATTERNS("objc",
>  	 /* Objective-C methods */
>  	 "^[ \t]*([-+][ \t]*\\([ \t]*[A-Za-z_][A-Za-z_0-9* \t]*\\)[ \t]*[A-Za-z_].*)$\n"
>  	 /* C functions */
> -	 "^[ \t]*(([ \t]*[A-Za-z_][A-Za-z_0-9]*){2,}[ \t]*\\([^;]*)$\n"
> +	 "^[ \t]*(([A-Za-z_][A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$\n"
>  	 /* Objective-C class/protocol definitions */
>  	 "^(@(implementation|interface|protocol)[ \t].*)$",
>  	 /* -- */
> -- 
> 1.6.0.3
