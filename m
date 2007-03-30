From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-mailinfo fixes for patch munging
Date: Fri, 30 Mar 2007 14:19:42 -0700
Message-ID: <7vmz1uzaxd.fsf@assigned-by-dhcp.cox.net>
References: <20070330161845.GI11029@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Don Zickus <dzickus@redhat.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 23:20:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXOWN-00083i-FP
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 23:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005AbXC3VUO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 17:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753994AbXC3VTs
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 17:19:48 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:46864 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753825AbXC3VTn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 17:19:43 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070330211944.WXLW373.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Fri, 30 Mar 2007 17:19:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id h9Ki1W00P1kojtg0000000; Fri, 30 Mar 2007 17:19:43 -0400
In-Reply-To: <20070330161845.GI11029@redhat.com> (Don Zickus's message of
	"Fri, 30 Mar 2007 12:18:45 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43499>

Don Zickus <dzickus@redhat.com> writes:

> Don't translate the patch to UTF-8, instead preserve the data as is.  Also
> allow overwriting the primary mail headers (addresses Linus's concern).  
>
> I also revert a test case that was included in the original patch.  Now it
> makes sense why it was the way it was. :)
>
> Cheers,
> Don

Thanks.  Sign-off would have been nice.

> diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
> index d94578c..71b6457 100644
> --- a/builtin-mailinfo.c
> +++ b/builtin-mailinfo.c
> @@ -294,14 +294,14 @@ static char *header[MAX_HDR_PARSED] = {
>  	"From","Subject","Date",
>  };
>  
> -static int check_header(char *line, char **hdr_data)
> +static int check_header(char *line, char **hdr_data, int overwrite)
>  {
>  	int i;
>  
>  	/* search for the interesting parts */
>  	for (i = 0; header[i]; i++) {
>  		int len = strlen(header[i]);
> -		if (!hdr_data[i] &&
> +		if ((!hdr_data[i] || overwrite) &&
>  		    !strncasecmp(line, header[i], len) &&
>  		    line[len] == ':' && isspace(line[len + 1])) {
>  			/* Unwrap inline B and Q encoding, and optionally

This check_header is called from each multi-part boundary with
overwrite=1, so if you have two parts and you have From: or
Subject: in the multi-part header (not in-body), wouldn't they
overwrite what we already have?  That is not desired, I would
think.

For non multi-part case, what we traditionally have done is:

	* Take Subject:, Date:, and From: from RFC2822 headers
          to prime the title and authorship information.

	* The first lines of the body of the message (i.e. after
          the blank line that separates 2822 headers and the
          body) can look like the above header lines to
          override.

	* A line that does not look like an overriding in-body
          header line is the first line of the commit log
          message.  After that, nothing is taken as an
          overriding in-body header.

For a multi-part, I think we only processed the first part as
the commit log message, potentially starting with the overriding
in-body headers.  In other words, in-body headers are what the
user *types* to override what the MUA says in RFC2822 headers.
As the stuff that follow the multi-part boundary (like
content-type and transfer encoding) are of the MUA kind, I
suspect we do not want it to override what the sender said in
the earlier parts of the message.

> @@ -614,6 +614,7 @@ static int find_boundary(void)
>  
>  static int handle_boundary(void)
>  {
> +	char newline[]="\n";
>  again:
>  	if (!memcmp(line+content_top->boundary_len, "--", 2)) {
>  		/* we hit an end boundary */
> @@ -628,7 +629,7 @@ again:
>  					"can't recover\n");
>  			exit(1);
>  		}
> -		handle_filter("\n");
> +		handle_filter(newline);
>  
>  		/* skip to the next boundary */
>  		if (!find_boundary())

These two hunks certainly do not hurt, but why?  Is this about
the constness of the first parameter to handle_filter() and its
call chain?

Having said that, the result of the patch is much better.  

In fact, I couldn't "git am" this patch (the part that reverts
the test vector) with the current tip of 'master' because of the
breakage you are fixing with it ;-).

Now I can.  So I'd probably take this patch for now.
