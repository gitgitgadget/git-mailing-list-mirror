From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "Publishing your work" questions?
Date: Sat, 20 Aug 2005 09:12:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508200911250.3317@g5.osdl.org>
References: <200508201457.00725.alan@chandlerfamily.org.uk>
 <Pine.LNX.4.58.0508200821220.3317@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 20 18:12:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6VxK-00051j-QD
	for gcvg-git@gmane.org; Sat, 20 Aug 2005 18:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbVHTQMV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Aug 2005 12:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbVHTQMV
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Aug 2005 12:12:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50365 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932359AbVHTQMU (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Aug 2005 12:12:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7KGCBjA016346
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 20 Aug 2005 09:12:12 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7KGCBYu017778;
	Sat, 20 Aug 2005 09:12:11 -0700
To: Alan Chandler <alan@chandlerfamily.org.uk>
In-Reply-To: <Pine.LNX.4.58.0508200821220.3317@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 20 Aug 2005, Linus Torvalds wrote:
> 
> But yes, you _should_ be able to do it with that ultra-simplistic login 
> shell. Probably just a 5-liner main() function or something.

This is entirely untested, and a lot more than five lines of code. Edit 
until it works.

		Linus

----
#include <unistd.h>
#include <string.h>
#include <stdlib.h>

static char *parse_argument(char *orig)
{
	int i;
	int len = strlen(orig);

	/* We only accept properly quoted arguments */
	if (len < 2 || orig[0] != '\'' || orig[len-1] != '\'')
		exit(2);
	orig[len-1] = 0;
	orig++;
	len -= 2;

	/*
	 * Go look for quoted single-ticks. They are always
	 * quoted as '\'', we don't accept anything else
	 */
	for (i = 0; len ; i++, len--) {
		char c = orig[i];
		if (c != '\'')
			continue;
		if (len < 4 || memcmp(orig+i, "'\\''", 4))
			exit(2);
		len -= 3;
		memmove(orig+1, orig+4, len+1);
	}
	return orig;
}

int main(int argc, char **argv)
{
	int i;
	char *cmd, *arg;

	if (argc < 2)
		exit(1);
	i = 2;
	cmd = argv[1];
	if (!strcmp(cmd, "-c"))
		cmd = argv[i++];

	/* We're not going to allow anything else */
	if (argc != i)
		exit(1);

	/*
	 * Right now we only accept "upload" commands, but
	 * we could have some maintenance commands too, to
	 * create new archives or delete old ones..
	 */
	if (strncmp(cmd, "git-upload-pack ", 16))
		exit(1);

	arg = parse_argument(cmd+16);
	execlp("git-upload-pack", "git-upload-pack", arg, NULL);
	exit(3);
}
