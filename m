From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/5] add the ability to select more email header fields to output
Date: Mon, 12 Mar 2007 17:55:02 -0700
Message-ID: <7vveh6nes9.fsf@assigned-by-dhcp.cox.net>
References: <11737291282223-git-send-email-dzickus@redhat.com>
	<11737291281648-git-send-email-dzickus@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Don Zickus <dzickus@redhat.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 01:55:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQvID-0001Sk-Hu
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 01:55:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548AbXCMAzF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 20:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752594AbXCMAzF
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 20:55:05 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:56571 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752548AbXCMAzE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 20:55:04 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070313005504.IGVU321.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Mon, 12 Mar 2007 20:55:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id a0v21W00h1kojtg0000000; Mon, 12 Mar 2007 20:55:03 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42101>

Don Zickus <dzickus@redhat.com> writes:

> This is useful when scripts need more than just the basic email headers to
> parse.  By specifying the "-x=" option, one can search and output any header
> field they want.

It probably is useful, but that is rather difficult to judge,
unless you have a specific use in the scripts (am/applymox).

> @@ -870,6 +871,8 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
>  	def_charset = (git_commit_encoding ? git_commit_encoding : "utf-8");
>  	metainfo_charset = def_charset;
>  
> +	for (top=0; header[top]; top++){ ; }
> +
>  	while (1 < argc && argv[1][0] == '-') {
>  		if (!strcmp(argv[1], "-k"))
>  			keep_subject = 1;
> @@ -879,7 +882,10 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
>  			metainfo_charset = NULL;
>  		else if (!prefixcmp(argv[1], "--encoding="))
>  			metainfo_charset = argv[1] + 11;
> -		else
> +		else if (!prefixcmp(argv[1], "-x=")) {
> +			header[top] = xmalloc(256*sizeof(char));
> +			strncpy(header[top++], argv[1]+3, 256);

Return "-ETOOMANYEXTRAHEADERSHEADERS" when top overflows,
perhaps?

You seem to omit SP around '=' in initializers (the first part
of for loop and "typename var=init" at the beginning of block)
but not in an assignment expression used as a freestanding
statement.  Is this recommended by some coding style I am not
aware of, or it it just your habit?  It is somewhat irritating
to my eyes, although they might be syntactically different class
and you might be using one from the other consistently (but in
[1/5] some SP around '=' in assignments are omitted, and there
does not seem to be any such consistency).

And a micronit on [1/5] in the series.  I do not think "less
than zero" comment applies to what is being done, and I do not
think it needs to be explained what the code is doing by
checking return value from strcasestr() with NULL.

+	char boundary[256];
+
+	/* the only time this return less than zero is when 
+	   /line/ does not contain "text/"
 	 */
-	if (strcasestr(line, "boundary=")) {
-		fprintf(stderr, "Not handling nested multipart message.\n");
-		exit(1);
+	if (strcasestr(line, "text/") == NULL)
+		 message_type = TYPE_OTHER;

I think 3, 4, and 5 are good changes too.  Will apply with the
abovementioned micronit fixups and let's cook them in 'next'.
