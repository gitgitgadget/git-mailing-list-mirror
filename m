From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Interpret :/<pattern> as a regular expression
Date: Tue, 12 Jun 2007 21:52:40 -0700
Message-ID: <7vr6ogh2w7.fsf@assigned-by-dhcp.pobox.com>
References: <Pine.LNX.4.64.0706130148080.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 13 06:52:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyKqa-0002es-0B
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 06:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531AbXFMEwn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 00:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752565AbXFMEwm
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 00:52:42 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:59839 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415AbXFMEwm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 00:52:42 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070613045242.XVXV4247.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Wed, 13 Jun 2007 00:52:42 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Assg1X00A1kojtg0000000; Wed, 13 Jun 2007 00:52:41 -0400
In-Reply-To: <Pine.LNX.4.64.0706130148080.4059@racer.site> (Johannes
	Schindelin's message of "Wed, 13 Jun 2007 01:50:22 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50012>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> diff --git a/sha1_name.c b/sha1_name.c
> index d9188ed..f1ba194 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -611,6 +611,8 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
>  {
>  	struct commit_list *list = NULL, *backup = NULL, *l;
>  	int retval = -1;
> +	regex_t regexp;
> +	regmatch_t regmatch[1];
>  
>  	if (prefix[0] == '!') {
>  		if (prefix[1] != '!')

Because you are not extracting any match substring, I do not
think you would need regmatch[] there.

> @@ -622,6 +624,8 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
>  	for_each_ref(handle_one_ref, &list);
>  	for (l = list; l; l = l->next)
>  		commit_list_insert(l->item, &backup);
> +	if (regcomp(&regexp, prefix, REG_EXTENDED))
> +		return error("invalid regexp: %s", prefix);
>  	while (list) {
>  		char *p;
>  		struct commit *commit;

Why EXTENDED?

I think our code prefer traditional regexp by default, but in
places where extended behaviour is truly useful (e.g. grepping
for bulk of text) have command line option to enable extended.
Of course, extended SHA-1 notation has no chance to do "command
line option", but it somehow feels inconsistent.

Also you probably want REG_NEWLINE.

> @@ -630,7 +634,9 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
>  		parse_object(commit->object.sha1);
>  		if (!commit->buffer || !(p = strstr(commit->buffer, "\n\n")))
>  			continue;
> -		if (!prefixcmp(p + 2, prefix)) {
> +		if (!regexec(&regexp, p + 2, 1, regmatch, 0) &&
> +				printf("match: %d\n", regmatch[0].rm_so) &&
> +				regmatch[0].rm_so == 0) {
>  			hashcpy(sha1, commit->object.sha1);
>  			retval = 0;
>  			break;

Do we want to detect return value other than REG_NOMATCH from
regexec() when it does not return zero?

Please lose the debugging printf() before submitting.

> @@ -639,6 +645,7 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
>  	free_commit_list(list);
>  	for (l = backup; l; l = l->next)
>  		clear_commit_marks(l->item, ONELINE_SEEN);
> +	regfree(&regexp);
>  	return retval;
>  }
>  

Also I think you would want to fix get_sha1_oneline() so that it
not to refuse to work without save_commit_buffer.  These are to
parse user supplied strings (it would be crazy for scripts to
throw hundreds of ':/random string' to drive git -- it must come
from the end user), and the user has every right to use this
syntax, if he wants to, to specify the starting point for a
command that deliberately turns off save_commit_buffer to save
memory, because the command knows ithat t will traverse tons of
commits without needing the contents of the commit buffer.

After parse_object(), if commit->buffer is NULL, read the buffer
with read_sha1_file() yourself to look for match (and if you did
so you are also responsible for discarding it yourself).
