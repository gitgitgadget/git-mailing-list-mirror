From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Errors GITtifying GCC and Binutils
Date: Thu, 23 Mar 2006 13:48:42 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603231347440.26286@g5.osdl.org>
References: <Pine.LNX.4.64.0603230758260.26286@g5.osdl.org>
 <BAYC1-PASMTP0912D2287AB923F3338969AEDE0@CEZ.ICE> <Pine.LNX.4.64.0603231134160.26286@g5.osdl.org>
 <20060323.133120.69312511.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: seanlkml@sympatico.ca, keithp@keithp.com, hpa@zytor.com,
	jbglaw@lug-owl.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 23 22:49:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMXfv-0002tC-Lg
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 22:49:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbWCWVs5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 16:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbWCWVs4
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 16:48:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55269 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964938AbWCWVs4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Mar 2006 16:48:56 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2NLmhDZ020743
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 23 Mar 2006 13:48:43 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2NLmg3Q029306;
	Thu, 23 Mar 2006 13:48:42 -0800
To: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060323.133120.69312511.davem@davemloft.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17877>



On Thu, 23 Mar 2006, David S. Miller wrote:
> 
> > Yeah, I'm not counting things like Eclipse etc. I'm talking about "plain 
> > SCM" environments, ie just basic SVN or CVS. What are we missing in that 
> > department? (The only thing I can think of is a diff colorizer, which some 
> > prople seem to really want).
> 
> gitk does color the diffs already, or are we talking about some
> "side-by-side" multiple window thing showing "before" on the
> left and "after" on the right?

I think we're just talking about 

	git diff | git colorize

like this (and then integrating it a bit better).

		Linus

--- colorize.c ---
#include "cache.h"

#define BUFSIZE 128

#define NORMAL	""
#define BOLD	"\033[1m"
#define UL	"\033[4m"

#define GRAYBG	"\033[47m"

#define BLACK	"\033[30m"
#define RED	"\033[31m"
#define GREEN	"\033[32m"
#define YELLOW	"\033[33m"
#define BLUE	"\033[34m"
#define MAGENTA	"\033[35m"
#define CYAN	"\033[36m"
#define WHITE	"\033[37m"
#define RESET	"\033[m"

enum linetype {
	UNKNOWN,
	HEAD,
	FRAGHEAD,
	ADD,
	REMOVE,
	UNCHANGED,
};

static const char *tput[][2] = {
	[UNKNOWN] =	{ NORMAL, NORMAL "\n" },
	[HEAD] =	{ BOLD,   RESET "\n" },
	[FRAGHEAD] =	{ GRAYBG, RESET "\n" },
	[ADD] =		{ GREEN,  RESET "\n" },
	[REMOVE] =	{ RED,    RESET "\n" },
	[UNCHANGED] =	{ NORMAL, NORMAL "\n" },
};

static void colorize(FILE *in, FILE *out)
{
	char buffer[BUFSIZE];
	const char *end = NULL;
	int in_fragment = 0;

	while (fgets(buffer, BUFSIZE, in)) {
		int type = UNKNOWN;
		int eoln, len = strlen(buffer);
		const char *begin;

		if (!len)
			break;
		eoln = buffer[len-1] == '\n';
		if (eoln)
			buffer[--len] = 0;

		/* Did we have a partial line from before? */
		if (end) {
			fputs(buffer, out);
			if (!eoln)
				continue;
			fputs(end, out);
			end = NULL;
			continue;
		}

		if (in_fragment) {
			in_fragment--;
			switch (buffer[0]) {
			case '+':
				type = ADD;
				break;
			case '-':
				type = REMOVE;
				break;
			case ' ':
				type = UNCHANGED;
				break;
			case '\\':
				type = UNCHANGED;
				break;
			default:
				in_fragment = 0;
			}
		}
		if (type == UNKNOWN) {
			if (!strncmp(buffer, "@@ ", 3)) {
				type = FRAGHEAD;
				/* We should parse the line numbers */
				in_fragment = INT_MAX;
			}
			if (!strncmp(buffer, "+++ ", 4) ||
			    !strncmp(buffer, "--- ", 4) ||
			    !strncmp(buffer, "diff ", 5))
				type = HEAD;
		}

		begin = tput[type][0];
		end = tput[type][1];
		fputs(begin, out);
		fputs(buffer, out);
		if (!eoln)
			continue;
		fputs(end, out);
		end = NULL;
	}
	if (end)
		fputs(end, out);
}

int main(int argc, char **argv)
{
	colorize(stdin, stdout);
	return 0;
}
