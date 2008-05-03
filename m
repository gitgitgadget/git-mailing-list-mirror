From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] --color-words: Make the word characters configurable
Date: Sat, 03 May 2008 10:43:22 -0700
Message-ID: <7vmyn7uvut.fsf@gitster.siamese.dyndns.org>
References: <46dff0320805012128l6cb15e1ekd40f84a9eac724d1@mail.gmail.com>
 <1209736766-8029-1-git-send-email-pkufranky@gmail.com>
 <alpine.DEB.1.00.0805031501290.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ping Yin <pkufranky@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 03 19:44:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsLmu-0004PH-8U
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 19:44:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932551AbYECRne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 13:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbYECRnd
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 13:43:33 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53679 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932527AbYECRnc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 13:43:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DC4793E3E;
	Sat,  3 May 2008 13:43:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id F01143E3C; Sat,  3 May 2008 13:43:25 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0805031501290.30431@racer> (Johannes
 Schindelin's message of "Sat, 3 May 2008 15:03:17 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 71314C40-1938-11DD-BB28-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81103>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Now, you can specify which characters are to be interpreted as word 
> characters with "--color-words=A-Za-z", or by setting the config variable 
> diff.wordCharacters.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
> 	I would have preferred an approach like this.

Hmmm...

> diff --git a/README b/README
> index 548142c..0e325e2 100644
> --- a/README
> +++ b/README
> @@ -4,7 +4,7 @@
>  
>  ////////////////////////////////////////////////////////////////
>  
> -"git" can mean anything, depending on your mood.
> +"git" cann mean anything, depending on your mood.

Heh.

> @@ -456,7 +514,7 @@ static void diff_words_show(struct diff_words_data *diff_words)
>  	plus.ptr = xmalloc(plus.size);
>  	memcpy(plus.ptr, diff_words->plus.text.ptr, plus.size);
>  	for (i = 0; i < plus.size; i++)
> -		if (isspace(plus.ptr[i]))
> +		if (!word_character[(unsigned char)plus.ptr[i]])
>  			plus.ptr[i] = '\n';
>  	diff_words->plus.current = 0;

I do not think there is much difference between specifying the set of word
characters and the set of non-word characters, especially as long as your
definition of "character" is limited to 8-bit bytes.  By enumerating word
characters, your patch is letting the user specify non word characters
that are remainder from the 256-element set.  By the way, I think you
meant to do the same for the "minus" side a few lines above this hunk.

I commented on the patch from Ping earier about a quite different issue.
I was wondering if we can avoid losing the non-word character information.
The original code replaces any isspace byte with LF, but a whitespace is a
whitespace is a whitespace so there won't be much loss of information, but
making the above isspace() configurable means that now you are going to
drop non-space non-word characters from the output set.

Instead of dropping the original character and replacing it with LF,
I thought a more sensible approach would be to _insert_ a line break
between runs of word characters and non-word characters (while probably
dropping a LF in the original).  That is, instead of what the current
implementation of the above loop does to "ab  c d" (i.e. rewrite it to
"ab\n\nc\nd"), rewrite it to "ab\n  \nc\n \nd".  Which feels more consistent
with the way how \b should work.
