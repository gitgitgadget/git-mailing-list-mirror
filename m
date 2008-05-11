From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH 1/5] mktag.c: adjust verify_tag parameters
Date: Sun, 11 May 2008 11:39:46 -0700
Message-ID: <7vmymw3cst.fsf@gitster.siamese.dyndns.org>
References: <1210299589-10448-1-git-send-email-drafnel@example.com>
 <3712867.1210299524581.JavaMail.teamon@b301.teamon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brandon Casey <casey@nrlssc.navy.mil>
To: drafnel@gmail.com
X-From: git-owner@vger.kernel.org Sun May 11 20:40:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvGTd-0001qd-2Y
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 20:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756966AbYEKSkB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 14:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756944AbYEKSkB
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 14:40:01 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60613 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756750AbYEKSkA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 14:40:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B1878261F;
	Sun, 11 May 2008 14:39:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id DE0A0261C; Sun, 11 May 2008 14:39:53 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A7CC3812-1F89-11DD-B088-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81811>

drafnel@gmail.com writes:

> From: Brandon Casey <casey@nrlssc.navy.mil>
>
> The size parameter should be a size_t since it is a string length.

Correct.

> There is no reason that the buffer argument should not be constant except
> for the nul termination that is performed in the first few lines of this
> function. This is not necessary, since a valid c string must always be
> nul terminated and we can check whether we have exceeded the caller's
> size parameter at the end of parsing the buffer.

Wait a minute.  The point of passing a stringlet as a tuple of <pointer to
the beginning, length> is that you may not have a valid C string to begin
with, isn't it?  We shouldn't be assuming that reading past the given size
is Ok --- you may not be lucky enough to have any NUL byte after the given
string before you hit the page boundary and encounter unmapped page.

The generic-looking argument you made is bogus, but for this particular
code it is true, as the parameter you are passing to the function is
prepared by strbuf_read() which gives you a NUL terminated buffer.

So the code is correct -- justification is not.

> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ---
>  mktag.c |   11 ++++++++---
>  1 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/mktag.c b/mktag.c
> index 0b34341..5489ad6 100644
> --- a/mktag.c
> +++ b/mktag.c
> @@ -39,7 +39,7 @@ static int verify_object(unsigned char *sha1, const char *expected_type)
>  #define PD_FMT "%td"
>  #endif
>  
> -static int verify_tag(char *buffer, unsigned long size)
> +static int verify_tag(const char *buffer, size_t size)
>  {
>  	int typelen;
>  	char type[20];
> @@ -50,8 +50,6 @@ static int verify_tag(char *buffer, unsigned long size)
>  	if (size < 84)
>  		return error("wanna fool me ? you obviously got the size wrong !");
>  
> -	buffer[size] = 0;
> -
>  	/* Verify object line */
>  	object = buffer;
>  	if (memcmp(object, "object ", 7))
> @@ -145,6 +143,13 @@ static int verify_tag(char *buffer, unsigned long size)
>  		return error("char" PD_FMT ": trailing garbage in tag header",
>  			tagger_line - buffer);
>  
> +	/*
> +	 * Make sure we haven't advanced past what the caller said the
> +	 * buffer size was.
> +	 */
> +	if (tagger_line - buffer >= size)
> +		return error("char" PD_FMT ": tag truncated", size);
> +
>  	/* The actual stuff afterwards we don't care about.. */
>  	return 0;
>  }
> -- 
> 1.5.5.67.g9a49
