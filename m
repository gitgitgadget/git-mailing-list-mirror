From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH v2 11/24] Added the class FNMatchPattern.
Date: Mon, 12 May 2008 20:38:32 -0400
Message-ID: <20080513003832.GD29038@spearce.org>
References: <1210623222-24908-1-git-send-email-florianskarten@web.de> <1210623222-24908-12-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Florian Koeberle <florianskarten@web.de>
X-From: git-owner@vger.kernel.org Tue May 13 02:39:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JviYJ-0002b1-QM
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 02:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753646AbYEMAig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 20:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754517AbYEMAig
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 20:38:36 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38757 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753586AbYEMAif (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 20:38:35 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JviX8-0008Rb-NV; Mon, 12 May 2008 20:38:22 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 26F2620FBAE; Mon, 12 May 2008 20:38:32 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1210623222-24908-12-git-send-email-florianskarten@web.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81975>

Florian Koeberle <florianskarten@web.de> wrote:
> +/**
> + * This class represents a pattern which should work like the fnmatch method.
> + * <code>new FNMatchPattern(exp).matches(input)</code> should do the same like
> + * <code>fnmatch(exp, input, 0) == 0</code>
> + * 
> + * As this isn't a one to one code port, but written based on the documentation
> + * of fnmatch it can be that the behavior of this class differ in some corner
> + * cases from the behavior of the fnmatch function.
> + */
> +public class FNMatchPattern {
> +
> +	private final Pattern regexPattern;

For what it is worth, I got a performance improvement by declaring
that such classes like FNMatchPattern are _not_ threadsafe and
storing a Matcher rather than a Pattern.  Then on each test you
can just reset the Matcher and evaluate it again.

This was worthwhile enough that I went back into RevFilter and
added a clone() method so you can safely clone a RevFilter graph
to create a new set of instances for another thread.

Consider using a Matcher here.  Ignore rule matching with a lot
of patterns will bottleneck things like working directory status
operations.

> +	private static String toRegexString(String fnmatchPattern) {
> +		final StringBuilder regexStringBuilder = new StringBuilder();
> +		char perviosCharacter = 0;
> +		for (int i = 0; i < fnmatchPattern.length(); i++) {
> +			final char c = fnmatchPattern.charAt(i);
> +			switch (c) {
> +			case '^':
> +				if (perviosCharacter == '[') {
> +					regexStringBuilder.append('!');
> +				} else {
> +					regexStringBuilder.append("\\x5E");
> +				}
> +				break;
> +			case '.':
> +				regexStringBuilder.append("\\x2E");
> +				break;
> +			case '*':
> +				regexStringBuilder.append(".*");
> +				break;
> +			default:
> +				regexStringBuilder.append(c);
> +			}
> +			perviosCharacter = c;
> +		}
> +		return regexStringBuilder.toString();

Huh.  So the fnmatchPattern of "foo?" will match the name "fo"
in this implementation, but it does not in my C library's fnmatch
function:

	$ cat fnmatch.c 
	#include <fnmatch.h>
	#include <stdio.h>

	int main(int argc, char *argv[]) {
		const char *pattern = argv[1];
		const char *name = argv[2];
		printf("%s on %s = %i\n", pattern, name, fnmatch(pattern, name, 0));
		return 0;
	}
	$ ./fnmatch 'foo?' 'fo'
	foo? on fo = 1

There are plenty more cases like that as too many of the regex
operators are leaking through. All of the regex operators need to
be treated as literals in the regex pattern.

-- 
Shawn.
