From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH v2 14/24] Added the class IgnoreRuleListFactory.
Date: Mon, 12 May 2008 21:08:44 -0400
Message-ID: <20080513010844.GE29038@spearce.org>
References: <1210623222-24908-1-git-send-email-florianskarten@web.de> <1210623222-24908-15-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Florian Koeberle <florianskarten@web.de>
X-From: git-owner@vger.kernel.org Tue May 13 03:09:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvj1Q-0001RV-Af
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 03:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756492AbYEMBIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 21:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756436AbYEMBIt
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 21:08:49 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44440 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756347AbYEMBIs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 21:08:48 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jvj0N-000275-KR; Mon, 12 May 2008 21:08:35 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 03C6920FBAE; Mon, 12 May 2008 21:08:44 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1210623222-24908-15-git-send-email-florianskarten@web.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81976>

Florian Koeberle <florianskarten@web.de> wrote:
> +/**
> + * This class can be used to create lists of {@link Rule} objects from lines of
> + * .gitignore like files.
> + * 
> + */
> +class IgnoreRuleListFactory {
> +
> +	List<Rule> createIgnoreRuleList(Iterable<String> lineIterable) {
> +		LinkedList<Rule> rules = new LinkedList<Rule>();
> +		for (String line : lineIterable) {
> +			final String trimmedLine = line.trim();
> +			if (trimmedLine.startsWith("#")) {
> +				continue;
> +			}
> +			if (trimmedLine.length() == 0) {
> +				continue;
> +			}
> +			rules.add(0, createRule(trimmedLine));
> +		}
> +		return rules;
> +	}
> +
> +	List<Rule> createIgnoreRuleList(List<File> files)
> +			throws FileNotFoundException {
> +		final List<String> lines = new ArrayList<String>();
> +		for (File file : files) {
> +			Scanner scanner = new Scanner(file);
> +			try {
> +				while (scanner.hasNextLine()) {
> +					lines.add(scanner.nextLine());
> +				}
> +			} finally {
> +				scanner.close();
> +			}
> +		}
> +		return createIgnoreRuleList(lines);
> +	}

Why go through all this work to buffer the lines we don't care about
(starting with # or are blank) when we could just discard them in the
inside of createIgnoreRuleList and then create the rule right away?

> +	private Rule createRule(String trimmedLine) {
> +		final boolean exclude;
> +		String patternString;
> +		if (trimmedLine.startsWith("!")) {
> +			exclude = false;
> +			patternString = trimmedLine.substring(1);
> +		} else {
> +			exclude = true;
> +			patternString = trimmedLine;
> +		}

I suspect this code would be easier to follow if you just accepted
changing the method parameter, such as:

	private Rule createRule(String pattern) {
		boolean exclude = true;
		if (pattern.startsWith("!)) {
			pattern = pattern.substring(1);
			exclude = false;
		}

> +		final boolean matchDirectoriesOnly;
> +		if (patternString.endsWith("/")) {
> +			matchDirectoriesOnly = true;
> +			patternString = patternString.substring(0,
> +					patternString.length() - 1);
> +		} else {
> +			matchDirectoriesOnly = false;
> +		}
> +
> +		final FilePattern pattern;
> +		if (patternString.contains("/")) {
> +			if (patternString.startsWith("/")) {
> +				patternString = patternString.substring(1);
> +			}

"foo/bar" will always end up in this code-path and will not match
in all levels of the tree if I follow your code correctly.

An ignore rule in the top level of "foo/bar" should ignore any entry
named "bar" within a directory "foo" at any level of the tree, even
if it is 35 directories down from the root.  Isn't ComplexFilePattern
about the absolute (starts with "/") cases only?

> +			final StringTokenizer stringTokenizer = new StringTokenizer(
> +					patternString, "/");
> +			final List<String> patternList = new ArrayList<String>();
> +			while (stringTokenizer.hasMoreTokens()) {
> +				final String token = stringTokenizer.nextToken();
> +				patternList.add(token);
> +			}

StringTokenizer is more-or-less replaced by String.split("/"), with
the split method being the more preferred method of doing this.

-- 
Shawn.
