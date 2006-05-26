From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/6] More accurately detect header lines in read_one_header_line
Date: Fri, 26 May 2006 00:29:22 -0700
Message-ID: <7vy7wpnt0t.fsf@assigned-by-dhcp.cox.net>
References: <m18xosjznu.fsf@ebiederm.dsl.xmission.com>
	<m14pzgjzlg.fsf@ebiederm.dsl.xmission.com>
	<m1zmh8ikym.fsf_-_@ebiederm.dsl.xmission.com>
	<m1verwikvj.fsf_-_@ebiederm.dsl.xmission.com>
	<m1r72kiksz.fsf_-_@ebiederm.dsl.xmission.com>
	<m1mzd8iklr.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 26 09:29:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjWlE-0005dq-27
	for gcvg-git@gmane.org; Fri, 26 May 2006 09:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030516AbWEZH3Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 May 2006 03:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030515AbWEZH3Y
	(ORCPT <rfc822;git-outgoing>); Fri, 26 May 2006 03:29:24 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:64948 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1030516AbWEZH3X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 May 2006 03:29:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060526072923.SJFE27327.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 26 May 2006 03:29:23 -0400
To: ebiederm@xmission.com (Eric W. Biederman)
In-Reply-To: <m1mzd8iklr.fsf_-_@ebiederm.dsl.xmission.com> (Eric
	W. Biederman's message of "Tue, 23 May 2006 13:53:20 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20800>

ebiederm@xmission.com (Eric W. Biederman) writes:

> Only count lines of the form '^.*: ' and '^From ' as email
> header lines. 

I am having trouble with this patch.

> diff --git a/mailinfo.c b/mailinfo.c
> index 99989c2..c642ff4 100644
> --- a/mailinfo.c
> +++ b/mailinfo.c
> @@ -385,20 +385,29 @@ static int read_one_header_line(char *li
>  {
>  	int ofs = 0;
>  	while (ofs < sz) {
> +		const char *colon;
>  		int peek, len;
>  		if (fgets(line + ofs, sz - ofs, in) == NULL)
> +			break;
>  		len = eatspace(line + ofs);
>  		if (len == 0)
> +			break;
> +		colon = strchr(line, ':');
> +		if (!colon || !isspace(colon[1])) {
> +			/* Readd the newline */
> +			line[ofs + len] = '\n';
> +			line[ofs + len + 1] = '\0';
> +			break;
>  		}

Because eatspace() eats the trailing space, although your commit
message say lines matching "^.*: " are headers, this does not
match the criteria:

        X-Spam-Checker-Version: SpamAssassin 3.1.1 (2006-03-10) on 
                gitster.siamese.dyndns.org
->      X-Spam-Level: 
        X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00
        	autolearn=ham version=3.1.1

Notice that the field body for this unstructured header
X-Spam-Level (an optional field) consists of a single
whitespace.  It will be gone because of eatspace() when your
check sees the line, so the header parsing stops prematurely.

Was there a particular reason you needed this change?  That is,
did you have to parse mail-looking input that does not have a
blank line between runs of headers and the body of the message?

If so, I'd at least like to remove the || !isspace(colon[1])
from the test.  After all, I do not think RFC2822 requires a
whitespace after the colon there.
