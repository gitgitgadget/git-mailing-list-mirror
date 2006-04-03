From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Solaris cloning woes partly diagnosed
Date: Sun, 2 Apr 2006 20:06:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604021951310.23419@g5.osdl.org>
References: <7vy7yol0nk.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604021118210.3050@g5.osdl.org> <Pine.LNX.4.64.0604021159110.3050@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 03 05:06:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQFOY-0006w5-Hu
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 05:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWDCDGG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 23:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWDCDGG
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 23:06:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26767 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751266AbWDCDGF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Apr 2006 23:06:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k33361EX001543
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 2 Apr 2006 20:06:01 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k33360WJ032562;
	Sun, 2 Apr 2006 20:06:00 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0604021159110.3050@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18303>



On Sun, 2 Apr 2006, Linus Torvalds wrote:
>  
> -	while (fgets(line, sizeof(line), stdin) != NULL) {
> +	for (;;) {
>  		unsigned char sha1[20];
> +
> +		if (!fgets(line, sizeof(line), stdin)) {
> +			if (feof(stdin))
> +				break;
> +			if (!ferror(stdin))
> +				die("fgets returned NULL, not EOF, not error!");
> +			if (errno == EINTR)
> +				continue;
> +			die("fgets: %s", strerror(errno));

While it shouldn't actually matter, I just realized that this incredibly 
anal sequence isn't actually quite anal enough, sinceit really should have 
a "clearerr(stdin)" for the continue case when we ignore the EINTR thing.

Otherwise, some stdio implementation might just decide to continue to 
return NULL from fgets(), since the error indicator is technically sticky. 
I don't know if they do so, but it's entirely possible.

So I'd almost suggest something like

	char *safe_fgets(char *s, int size, FILE *stream)
	{
		for (;;) {
			if (fgets(s, size, stream))
				return s;
			if (feof(stream))
				return NULL;
			if (!ferror(stream))
				die("fgets returned NULL, not EOF, not error!");
			if (errno != EINTR)
				die("fgets: %s", strerror(errno));
			clearerr(stream);
		}
	}

which sbould then hopefully work as a sane fgets()-replacement for broken 
environments.

(And then we can just do

	while (safe_fgets(..))

like normal people again, and not be afraid of strange stdio 
implementations).

		Linus
