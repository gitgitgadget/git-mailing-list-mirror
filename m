From: =?UTF-8?B?RmxvcmlhbiBLw7ZiZXJsZQ==?= <FloriansKarten@web.de>
Subject: Re: [JGIT PATCH v2 14/24] Added the class IgnoreRuleListFactory.
Date: Tue, 13 May 2008 12:19:45 +0200
Message-ID: <48296B41.9020105@web.de>
References: <1210623222-24908-1-git-send-email-florianskarten@web.de> <1210623222-24908-15-git-send-email-florianskarten@web.de> <20080513010844.GE29038@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 13 12:20:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvrcm-0007YR-Bf
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 12:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454AbYEMKTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 06:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752199AbYEMKTx
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 06:19:53 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:35718 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546AbYEMKTw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 06:19:52 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id DAF2FDEDB3F6;
	Tue, 13 May 2008 12:19:50 +0200 (CEST)
Received: from [84.150.119.39] (helo=[192.168.1.50])
	by smtp05.web.de with asmtp (WEB.DE 4.109 #226)
	id 1Jvrbq-0004aa-00; Tue, 13 May 2008 12:19:50 +0200
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
In-Reply-To: <20080513010844.GE29038@spearce.org>
X-Enigmail-Version: 0.95.6
X-Sender: FloriansKarten@web.de
X-Provags-ID: V01U2FsdGVkX1/QC/zkFM6DZShXEqNdA22J4EddRNQy+f/asU5m
	pM8i5WpdXbdhQ8oyXLXpD7SL87aRT0byYDXpMPSrA3yU9xW6BO
	AF07HUT0Ogih3dCYtRhA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82014>

Shawn O. Pearce wrote:
> Florian Koeberle <florianskarten@web.de> wrote:
>> +/**
>> + * This class can be used to create lists of {@link Rule} objects from lines of
>> + * .gitignore like files.
>> + * 
>> + */
>> +class IgnoreRuleListFactory {
>> +
>> +	List<Rule> createIgnoreRuleList(Iterable<String> lineIterable) {
>> +		LinkedList<Rule> rules = new LinkedList<Rule>();
>> +		for (String line : lineIterable) {
>> +			final String trimmedLine = line.trim();
>> +			if (trimmedLine.startsWith("#")) {
>> +				continue;
>> +			}
>> +			if (trimmedLine.length() == 0) {
>> +				continue;
>> +			}
>> +			rules.add(0, createRule(trimmedLine));
>> +		}
>> +		return rules;
>> +	}
>> +
>> +	List<Rule> createIgnoreRuleList(List<File> files)
>> +			throws FileNotFoundException {
>> +		final List<String> lines = new ArrayList<String>();
>> +		for (File file : files) {
>> +			Scanner scanner = new Scanner(file);
>> +			try {
>> +				while (scanner.hasNextLine()) {
>> +					lines.add(scanner.nextLine());
>> +				}
>> +			} finally {
>> +				scanner.close();
>> +			}
>> +		}
>> +		return createIgnoreRuleList(lines);
>> +	}
> 
> Why go through all this work to buffer the lines we don't care about
> (starting with # or are blank) when we could just discard them in the
> inside of createIgnoreRuleList and then create the rule right away?
I did this to reduce complexity and to increase modularity.
The method createIgnoreRuleList(Iterable<String> lineIterable) can now 
be tested without the need to create files. Also it is so possible to 
read the patterns from different sources.

If you worry about memory usuage I could create some kind of 
RulesBuilder class:

public class RulesBuilder {
	private final List<Rule> rules;
	private RuleListToObjectConverter converter;

	// method used by tests:
	public void addIgnoreRule(String ignoreRuleLine) {
		
	}
  	public void addIgnoreRuleFile(File) {
		// reads file and calls addIgnoreRule
	}

	public void addIncludeRuleOfAddCommand(String pattern) {
	}

	public void addIgnoreGitDirectoryRule() {
	}

	public Rules buildRules() {
		return converter.convertToObject(rules);
	}
}

This would have the advantages:
* all Rule creating code at one place.
* There is no need to keep the original lines in memory.
* It's easy to create rules for testing purposes.
* It's easy to create Factories like AddRulesFactory.

> 
>> +	private Rule createRule(String trimmedLine) {
>> +		final boolean exclude;
>> +		String patternString;
>> +		if (trimmedLine.startsWith("!")) {
>> +			exclude = false;
>> +			patternString = trimmedLine.substring(1);
>> +		} else {
>> +			exclude = true;
>> +			patternString = trimmedLine;
>> +		}
> 
> I suspect this code would be easier to follow if you just accepted
> changing the method parameter, such as:
> 
> 	private Rule createRule(String pattern) {
> 		boolean exclude = true;
> 		if (pattern.startsWith("!)) {
> 			pattern = pattern.substring(1);
> 			exclude = false;
> 		}
If I remember correctly Intellij IDEA marks per default cases where you 
change a parameter. So it looks like that there are style guides which 
are against the practice of changing the values of parameters.

That and the fact that you can't make exclude final now where the reason 
why I wrote it the otherway.
> 
>> +		final boolean matchDirectoriesOnly;
>> +		if (patternString.endsWith("/")) {
>> +			matchDirectoriesOnly = true;
>> +			patternString = patternString.substring(0,
>> +					patternString.length() - 1);
>> +		} else {
>> +			matchDirectoriesOnly = false;
>> +		}
>> +
>> +		final FilePattern pattern;
>> +		if (patternString.contains("/")) {
>> +			if (patternString.startsWith("/")) {
>> +				patternString = patternString.substring(1);
>> +			}
> 
> "foo/bar" will always end up in this code-path and will not match
> in all levels of the tree if I follow your code correctly.
> 
> An ignore rule in the top level of "foo/bar" should ignore any entry
> named "bar" within a directory "foo" at any level of the tree, even
> if it is 35 directories down from the root.  Isn't ComplexFilePattern
> about the absolute (starts with "/") cases only?
Yes, ComplexFilePattern is about that cases only.

I implemented it that way, becasue git behave the same way:
* create the follwing file: a/a/b/test.txt
* add the line "a/b" to .gitignore
* add a and notice that it adds the test.txt file.

> 
>> +			final StringTokenizer stringTokenizer = new StringTokenizer(
>> +					patternString, "/");
>> +			final List<String> patternList = new ArrayList<String>();
>> +			while (stringTokenizer.hasMoreTokens()) {
>> +				final String token = stringTokenizer.nextToken();
>> +				patternList.add(token);
>> +			}
> 
> StringTokenizer is more-or-less replaced by String.split("/"), with
> the split method being the more preferred method of doing this.
> 
Ok
