From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v3 02/23] Added the class FileNameMatcher and a test class for it.
Date: Fri, 23 May 2008 22:34:11 +0200
Message-ID: <1211574872-23676-3-git-send-email-florianskarten@web.de>
References: <1211574872-23676-1-git-send-email-florianskarten@web.de>
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 23 22:36:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jzdzx-0006CA-Mg
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 22:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757632AbYEWUes (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 16:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756674AbYEWUer
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 16:34:47 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:45420 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756464AbYEWUeh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 16:34:37 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id B8161DC4A341
	for <git@vger.kernel.org>; Fri, 23 May 2008 22:34:34 +0200 (CEST)
Received: from [84.150.81.80] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JzdyD-0005iq-02; Fri, 23 May 2008 22:34:33 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1211574872-23676-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX1/uMkWW0jg7vbjnuErVKdFpyUHk80mcmIkV68ng
	8U5y3kSBnWQ9i0gHRmi8gAFoNpcYenTjJGl1nTk9svC4goQtEt
	NmKV1WBMdhaOO+txNYnw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82738>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../org/spearce/jgit/lib/FileNameMatcherTest.java  |  311 ++++++++++++++++
 .../src/org/spearce/jgit/lib/FileNameMatcher.java  |  376 ++++++++++++++++++++
 2 files changed, 687 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/FileNameMatcherTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/FileNameMatcher.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/FileNameMatcherTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/FileNameMatcherTest.java
new file mode 100644
index 0000000..fb0d8b2
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/FileNameMatcherTest.java
@@ -0,0 +1,311 @@
+package org.spearce.jgit.lib;
+
+import org.spearce.jgit.errors.InvalidPatternException;
+
+import junit.framework.TestCase;
+
+public class FileNameMatcherTest extends TestCase {
+
+	private void assertMatch(final String pattern, final String input,
+			final boolean matchExpected,
+			final boolean extendResultInNoMatchExpected)
+			throws InvalidPatternException {
+		final FileNameMatcher matcher = new FileNameMatcher(pattern, null);
+		matcher.extendStringToMatch(input);
+		assertEquals(matchExpected, matcher.isMatch());
+		assertEquals(extendResultInNoMatchExpected, matcher
+				.willExtendResultInNoMatch());
+	}
+
+	private void assertFileNameMatch(final String pattern, final String input,
+			final char excludedCharacter, final boolean matchExpected,
+			final boolean extendResultInNoMatchExpected)
+			throws InvalidPatternException {
+		final FileNameMatcher matcher = new FileNameMatcher(pattern,
+				new Character(excludedCharacter));
+		matcher.extendStringToMatch(input);
+		assertEquals(matchExpected, matcher.isMatch());
+		assertEquals(extendResultInNoMatchExpected, matcher
+				.willExtendResultInNoMatch());
+	}
+
+	public void testVerySimplePatternCase0() throws Exception {
+		assertMatch("", "", true, true);
+	}
+
+	public void testVerySimplePatternCase1() throws Exception {
+		assertMatch("ab", "a", false, false);
+	}
+
+	public void testVerySimplePatternCase2() throws Exception {
+		assertMatch("ab", "ab", true, true);
+	}
+
+	public void testVerySimplePatternCase3() throws Exception {
+		assertMatch("ab", "ac", false, true);
+	}
+
+	public void testVerySimplePatternCase4() throws Exception {
+		assertMatch("ab", "abc", false, true);
+	}
+
+	public void testVerySimpleWirdcardCase0() throws Exception {
+		assertMatch("?", "a", true, true);
+	}
+
+	public void testVerySimpleWildCardCase1() throws Exception {
+		assertMatch("??", "a", false, false);
+	}
+
+	public void testVerySimpleWildCardCase2() throws Exception {
+		assertMatch("??", "ab", true, true);
+	}
+
+	public void testVerySimpleWildCardCase3() throws Exception {
+		assertMatch("??", "abc", false, true);
+	}
+
+	public void testVerySimpleStarCase0() throws Exception {
+		assertMatch("*", "", true, false);
+	}
+
+	public void testVerySimpleStarCase1() throws Exception {
+		assertMatch("*", "a", true, false);
+	}
+
+	public void testVerySimpleStarCase2() throws Exception {
+		assertMatch("*", "ab", true, false);
+	}
+
+	public void testSimpleStarCase0() throws Exception {
+		assertMatch("a*b", "a", false, false);
+	}
+
+	public void testSimpleStarCase1() throws Exception {
+		assertMatch("a*c", "ac", true, false);
+	}
+
+	public void testSimpleStarCase2() throws Exception {
+		assertMatch("a*c", "ab", false, false);
+	}
+
+	public void testSimpleStarCase3() throws Exception {
+		assertMatch("a*c", "abc", true, false);
+	}
+
+	public void testManySolutionsCase0() throws Exception {
+		assertMatch("a*a*a", "aaa", true, false);
+	}
+
+	public void testManySolutionsCase1() throws Exception {
+		assertMatch("a*a*a", "aaaa", true, false);
+	}
+
+	public void testManySolutionsCase2() throws Exception {
+		assertMatch("a*a*a", "ababa", true, false);
+	}
+
+	public void testManySolutionsCase3() throws Exception {
+		assertMatch("a*a*a", "aaaaaaaa", true, false);
+	}
+
+	public void testManySolutionsCase4() throws Exception {
+		assertMatch("a*a*a", "aaaaaaab", false, false);
+	}
+
+	public void testVerySimpleGroupCase0() throws Exception {
+		assertMatch("[ab]", "a", true, true);
+	}
+
+	public void testVerySimpleGroupCase1() throws Exception {
+		assertMatch("[ab]", "b", true, true);
+	}
+
+	public void testVerySimpleGroupCase2() throws Exception {
+		assertMatch("[ab]", "ab", false, true);
+	}
+
+	public void testVerySimpleGroupRangeCase0() throws Exception {
+		assertMatch("[b-d]", "a", false, true);
+	}
+
+	public void testVerySimpleGroupRangeCase1() throws Exception {
+		assertMatch("[b-d]", "b", true, true);
+	}
+
+	public void testVerySimpleGroupRangeCase2() throws Exception {
+		assertMatch("[b-d]", "c", true, true);
+	}
+
+	public void testVerySimpleGroupRangeCase3() throws Exception {
+		assertMatch("[b-d]", "d", true, true);
+	}
+
+	public void testVerySimpleGroupRangeCase4() throws Exception {
+		assertMatch("[b-d]", "e", false, true);
+	}
+
+	public void testVerySimpleGroupRangeCase5() throws Exception {
+		assertMatch("[b-d]", "-", false, true);
+	}
+
+	public void testTwoGroupsCase0() throws Exception {
+		assertMatch("[b-d][ab]", "bb", true, true);
+	}
+
+	public void testTwoGroupsCase1() throws Exception {
+		assertMatch("[b-d][ab]", "ca", true, true);
+	}
+
+	public void testTwoGroupsCase2() throws Exception {
+		assertMatch("[b-d][ab]", "fa", false, true);
+	}
+
+	public void testTwoGroupsCase3() throws Exception {
+		assertMatch("[b-d][ab]", "bc", false, true);
+	}
+
+	public void testTwoRangesInOneGroupCase0() throws Exception {
+		assertMatch("[b-ce-e]", "a", false, true);
+	}
+
+	public void testTwoRangesInOneGroupCase1() throws Exception {
+		assertMatch("[b-ce-e]", "b", true, true);
+	}
+
+	public void testTwoRangesInOneGroupCase2() throws Exception {
+		assertMatch("[b-ce-e]", "c", true, true);
+	}
+
+	public void testTwoRangesInOneGroupCase3() throws Exception {
+		assertMatch("[b-ce-e]", "d", false, true);
+	}
+
+	public void testTwoRangesInOneGroupCase4() throws Exception {
+		assertMatch("[b-ce-e]", "e", true, true);
+	}
+
+	public void testTwoRangesInOneGroupCase5() throws Exception {
+		assertMatch("[b-ce-e]", "f", false, true);
+	}
+
+	public void testIncompleteRangesInOneGroupCase0() throws Exception {
+		assertMatch("a[b-]", "ab", true, true);
+	}
+
+	public void testIncompleteRangesInOneGroupCase1() throws Exception {
+		assertMatch("a[b-]", "ac", false, true);
+	}
+
+	public void testIncompleteRangesInOneGroupCase2() throws Exception {
+		assertMatch("a[b-]", "a-", true, true);
+	}
+
+	public void testCombinedRangesInOneGroupCase0() throws Exception {
+		assertMatch("[a-c-e]", "b", true, true);
+	}
+
+	/**
+	 * The c belongs to the range a-c. "-e" is no valid range so d should not
+	 * match.
+	 * 
+	 * @throws Exception
+	 *             for some reasons
+	 */
+	public void testCombinedRangesInOneGroupCase1() throws Exception {
+		assertMatch("[a-c-e]", "d", false, true);
+	}
+
+	public void testCombinedRangesInOneGroupCase2() throws Exception {
+		assertMatch("[a-c-e]", "e", true, true);
+	}
+
+	public void testInversedGroupCase0() throws Exception {
+		assertMatch("[!b-c]", "a", true, true);
+	}
+
+	public void testInversedGroupCase1() throws Exception {
+		assertMatch("[!b-c]", "b", false, true);
+	}
+
+	public void testInversedGroupCase2() throws Exception {
+		assertMatch("[!b-c]", "c", false, true);
+	}
+
+	public void testInversedGroupCase3() throws Exception {
+		assertMatch("[!b-c]", "d", true, true);
+	}
+
+	public void testFilePathSimpleCase() throws Exception {
+		assertFileNameMatch("a/b", "a/b", '/', true, true);
+	}
+
+	public void testFilePathCase0() throws Exception {
+		assertFileNameMatch("a*b", "a/b", '/', false, true);
+	}
+
+	public void testFilePathCase1() throws Exception {
+		assertFileNameMatch("a?b", "a/b", '/', false, true);
+	}
+
+	public void testFilePathCase2() throws Exception {
+		assertFileNameMatch("a*b", "a\\b", '\\', false, true);
+	}
+
+	public void testFilePathCase3() throws Exception {
+		assertFileNameMatch("a?b", "a\\b", '\\', false, true);
+	}
+
+	public void testReset() throws Exception {
+		final String pattern = "helloworld";
+		final FileNameMatcher matcher = new FileNameMatcher(pattern, null);
+		matcher.extendStringToMatch("helloworld");
+		assertEquals(true, matcher.isMatch());
+		assertEquals(true, matcher.willExtendResultInNoMatch());
+		matcher.resetStringToMatch();
+		matcher.extendStringToMatch("hello");
+		assertEquals(false, matcher.isMatch());
+		assertEquals(false, matcher.willExtendResultInNoMatch());
+		matcher.extendStringToMatch("world");
+		assertEquals(true, matcher.isMatch());
+		assertEquals(true, matcher.willExtendResultInNoMatch());
+		matcher.extendStringToMatch("to much");
+		assertEquals(false, matcher.isMatch());
+		assertEquals(true, matcher.willExtendResultInNoMatch());
+		matcher.resetStringToMatch();
+		matcher.extendStringToMatch("helloworld");
+		assertEquals(true, matcher.isMatch());
+		assertEquals(true, matcher.willExtendResultInNoMatch());
+	}
+
+	public void testCreateMatcherForSuffix() throws Exception {
+		final String pattern = "helloworld";
+		final FileNameMatcher matcher = new FileNameMatcher(pattern, null);
+		matcher.extendStringToMatch("hello");
+		final FileNameMatcher childMatcher = matcher.createMatcherForSuffix();
+		assertEquals(false, matcher.isMatch());
+		assertEquals(false, matcher.willExtendResultInNoMatch());
+		assertEquals(false, childMatcher.isMatch());
+		assertEquals(false, childMatcher.willExtendResultInNoMatch());
+		matcher.extendStringToMatch("world");
+		assertEquals(true, matcher.isMatch());
+		assertEquals(true, matcher.willExtendResultInNoMatch());
+		assertEquals(false, childMatcher.isMatch());
+		assertEquals(false, childMatcher.willExtendResultInNoMatch());
+		childMatcher.extendStringToMatch("world");
+		assertEquals(true, matcher.isMatch());
+		assertEquals(true, matcher.willExtendResultInNoMatch());
+		assertEquals(true, childMatcher.isMatch());
+		assertEquals(true, childMatcher.willExtendResultInNoMatch());
+		childMatcher.resetStringToMatch();
+		assertEquals(true, matcher.isMatch());
+		assertEquals(true, matcher.willExtendResultInNoMatch());
+		assertEquals(false, childMatcher.isMatch());
+		assertEquals(false, childMatcher.willExtendResultInNoMatch());
+		childMatcher.extendStringToMatch("world");
+		assertEquals(true, matcher.isMatch());
+		assertEquals(true, matcher.willExtendResultInNoMatch());
+		assertEquals(true, childMatcher.isMatch());
+		assertEquals(true, childMatcher.willExtendResultInNoMatch());
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/FileNameMatcher.java b/org.spearce.jgit/src/org/spearce/jgit/lib/FileNameMatcher.java
new file mode 100644
index 0000000..4177e27
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/FileNameMatcher.java
@@ -0,0 +1,376 @@
+package org.spearce.jgit.lib;
+
+import java.util.ArrayList;
+import java.util.Collections;
+import java.util.List;
+import java.util.ListIterator;
+import java.util.regex.Matcher;
+import java.util.regex.Pattern;
+
+import org.spearce.jgit.errors.InvalidPatternException;
+
+/**
+ * This class can be used to match filenames against fnmatch like patterns. It
+ * is not thread save.
+ */
+public class FileNameMatcher {
+	private static final List<Head> EMPTY_HEAD_LIST = Collections.emptyList();
+
+	private List<Head> headsStartValue;
+
+	private List<Head> heads;
+
+	/**
+	 * {{@link #extendStringToMatchByOneCharacter(char)} needs a list for the
+	 * new heads, allocating a new array would be bad for the performance, as
+	 * the method gets called very often.
+	 * 
+	 */
+	private List<Head> listForLocalUseage;
+
+	/**
+	 * 
+	 * @param headsStartValue
+	 *            must be a list which will never be modified.
+	 */
+	private FileNameMatcher(final List<Head> headsStartValue) {
+		this.headsStartValue = headsStartValue;
+		this.heads = new ArrayList<Head>(headsStartValue.size());
+		this.heads.addAll(this.headsStartValue);
+		this.listForLocalUseage = new ArrayList<Head>(headsStartValue.size());
+	}
+
+	/**
+	 * @param patternString
+	 *            must contain a pattern which fnmatch would accept.
+	 * @param invalidWildgetCharacter
+	 *            if this parameter isn't null then this character will not
+	 *            match at wildcards(* and ? are wildcards).
+	 * @throws InvalidPatternException
+	 *             if the patternString contains a invalid fnmatch pattern.
+	 */
+	public FileNameMatcher(final String patternString,
+			final Character invalidWildgetCharacter)
+			throws InvalidPatternException {
+		this(createHeadsStartValues(patternString, invalidWildgetCharacter));
+	}
+
+	private static List<Head> createHeadsStartValues(
+			final String patternString, final Character invalidWildgetCharacter)
+			throws InvalidPatternException {
+		List<Head> nextHeadsSuggestion = new ArrayList<Head>(2);
+		nextHeadsSuggestion.add(LastHead.INSTANCE);
+
+		final char previosChracter = '\n';
+		int i = patternString.length() - 1;
+		while (i >= 0) {
+			final char c = patternString.charAt(i);
+
+			switch (c) {
+			case '*': {
+				if (previosChracter != '*') {
+					final AbstractHead head = createWildCardHead(invalidWildgetCharacter);
+					nextHeadsSuggestion.add(head);
+					head.setNewHeads(nextHeadsSuggestion);
+				}
+				break;
+			}
+			case '?': {
+				final AbstractHead head = createWildCardHead(invalidWildgetCharacter);
+				head.setNewHeads(nextHeadsSuggestion);
+				nextHeadsSuggestion = new ArrayList<Head>(2);
+				nextHeadsSuggestion.add(head);
+				break;
+			}
+			case ']': {
+				final String groupPattern = extractGroupPatternWithoutBrackets(
+						patternString, i);
+				i -= groupPattern.length() + 1;
+				final AbstractHead head = new GroupHead(groupPattern);
+				head.setNewHeads(nextHeadsSuggestion);
+				nextHeadsSuggestion = new ArrayList<Head>(2);
+				nextHeadsSuggestion.add(head);
+				break;
+			}
+			case '[': {
+				final String message = String
+						.format("There is no closing ] for the character [ at "
+								+ i);
+				throw new InvalidPatternException(message, patternString);
+			}
+			default: {
+				final CharacterHead head = new CharacterHead(c);
+				head.setNewHeads(nextHeadsSuggestion);
+				nextHeadsSuggestion = new ArrayList<Head>(2);
+				nextHeadsSuggestion.add(head);
+			}
+			}
+			i--;
+
+		}
+		return nextHeadsSuggestion;
+	}
+
+	private static String extractGroupPatternWithoutBrackets(
+			final String patternString, int closingBracketIndex)
+			throws InvalidPatternException {
+		int start = closingBracketIndex - 1;
+		while (start >= 0) {
+			final char possibleStartCharacter = patternString.charAt(start);
+			if (possibleStartCharacter == '[') {
+				break;
+			}
+			if (possibleStartCharacter == ']') {
+				final String message = String
+						.format(
+								"Found two ] characters at %s and %s without a [ character between.",
+								String.valueOf(start), String
+										.valueOf(closingBracketIndex));
+				throw new InvalidPatternException(message, patternString);
+			}
+			start--;
+		}
+		if (start < 0) {
+			final String message = String
+					.format(
+							"Found a ] character at %s but no [ character infront of it.",
+							String.valueOf(closingBracketIndex));
+			throw new InvalidPatternException(message, patternString);
+		}
+		final String groupPatternWithOutBrackets = patternString.substring(
+				start + 1, closingBracketIndex);
+		return groupPatternWithOutBrackets;
+	}
+
+	private static AbstractHead createWildCardHead(
+			final Character invalidWildgetCharacter) {
+		if (invalidWildgetCharacter != null)
+			return new RestrictedWildCardHead(invalidWildgetCharacter
+					.charValue());
+		else
+			return new WildCardHead();
+	}
+
+	private void extendStringToMatchByOneCharacter(final char c) {
+		final List<Head> newHeads = listForLocalUseage;
+		newHeads.clear();
+		List<Head> lastAddedHeads = null;
+		for (int i = 0; i < heads.size(); i++) {
+			final Head head = heads.get(i);
+			final List<Head> headsToAdd = head.getNextHeads(c);
+			// Why the next performance optimization isn't wrong:
+			// Some times two heads return the very same list.
+			// We save future effort if we don't add these heads again.
+			// This is the case with the heads "a" and "*" of "a*b" which
+			// both can return the list ["*","b"]
+			if (headsToAdd != lastAddedHeads) {
+				newHeads.addAll(headsToAdd);
+				lastAddedHeads = headsToAdd;
+			}
+		}
+		listForLocalUseage = heads;
+		heads = newHeads;
+	}
+
+	/**
+	 * 
+	 * @param stringToMatch
+	 *            extends the string which is matched against the patterns of
+	 *            this class.
+	 */
+	public void extendStringToMatch(final String stringToMatch) {
+		for (int i = 0; i < stringToMatch.length(); i++) {
+			final char c = stringToMatch.charAt(i);
+			extendStringToMatchByOneCharacter(c);
+		}
+	}
+
+	/**
+	 * Resets this matcher to it's state right after construction.
+	 */
+	public void resetStringToMatch() {
+		heads.clear();
+		heads.addAll(headsStartValue);
+	}
+
+	/**
+	 * 
+	 * @return a {@link FileNameMatcher} instance which uses the same pattern
+	 *         like this matcher, but has the current state of this matcher as
+	 *         reset and start point.
+	 */
+	public FileNameMatcher createMatcherForSuffix() {
+		final List<Head> copyOfHeads = new ArrayList<Head>(heads.size());
+		copyOfHeads.addAll(heads);
+		return new FileNameMatcher(copyOfHeads);
+	}
+
+	private interface Head {
+		/**
+		 * 
+		 * @param c
+		 *            the character which decides which heads are returned.
+		 * @return a list of heads based on the input.
+		 */
+		public abstract List<Head> getNextHeads(char c);
+	}
+
+	private static abstract class AbstractHead implements Head {
+		private List<Head> newHeads = null;
+
+		protected abstract boolean matches(char c);
+
+		/**
+		 * 
+		 * @param newHeads
+		 *            a list of {@link Head}s which will not be modified.
+		 */
+		public final void setNewHeads(List<Head> newHeads) {
+			if (this.newHeads != null)
+				throw new IllegalStateException("Property is already non null");
+			this.newHeads = newHeads;
+		}
+
+		public List<Head> getNextHeads(char c) {
+			if (matches(c))
+				return newHeads;
+			else
+				return EMPTY_HEAD_LIST;
+		}
+	}
+
+	private static final class LastHead implements Head {
+		static final Head INSTANCE = new LastHead();
+
+		/**
+		 * Don't call this constructor, use {@link #INSTANCE}
+		 */
+		private LastHead() {
+			// defined because of javadoc and visibility modifier.
+		}
+
+		public List<Head> getNextHeads(char c) {
+			return EMPTY_HEAD_LIST;
+		}
+
+	}
+
+	private static final class CharacterHead extends AbstractHead {
+		private final char expectedCharacter;
+
+		protected CharacterHead(final char expectedCharacter) {
+			this.expectedCharacter = expectedCharacter;
+		}
+
+		@Override
+		protected final boolean matches(final char c) {
+			return c == expectedCharacter;
+		}
+
+	}
+
+	private static final class WildCardHead extends AbstractHead {
+		@Override
+		protected final boolean matches(final char c) {
+			return true;
+		}
+	}
+
+	private static final class RestrictedWildCardHead extends AbstractHead {
+		private final char excludedCharacter;
+
+		RestrictedWildCardHead(final char excludedCharacter) {
+			this.excludedCharacter = excludedCharacter;
+		}
+
+		@Override
+		protected final boolean matches(final char c) {
+			return c != excludedCharacter;
+		}
+	}
+
+	private static final class GroupHead extends AbstractHead {
+		private final List<CharacterRange> ranges;
+
+		private final boolean inverse;
+
+		GroupHead(String pattern) {
+			this.ranges = new ArrayList<CharacterRange>();
+			this.inverse = pattern.startsWith("!");
+			if (inverse) {
+				pattern = pattern.substring(1);
+			}
+			final Pattern regexPattern = Pattern.compile("[^-][-][^-]");
+			final Matcher matcher = regexPattern.matcher(pattern);
+			while (matcher.find()) {
+				final String rangeString = matcher.group(0);
+				final char start = rangeString.charAt(0);
+				final char end = rangeString.charAt(2);
+				ranges.add(new CharacterRange(start, end));
+				pattern = matcher.replaceFirst("");
+				matcher.reset(pattern);
+			}
+			// pattern contains now no ranges
+			for (int i = 0; i < pattern.length(); i++) {
+				final char c = pattern.charAt(i);
+				ranges.add(new CharacterRange(c, c));
+			}
+		}
+
+		@Override
+		protected final boolean matches(final char c) {
+			for (CharacterRange range : ranges) {
+				if (range.inRange(c)) {
+					return !inverse;
+				}
+			}
+			return inverse;
+		}
+
+		private static final class CharacterRange {
+			private final char start;
+
+			private final char end;
+
+			CharacterRange(char start, char end) {
+				this.start = start;
+				this.end = end;
+			}
+
+			boolean inRange(char c) {
+				return start <= c && c <= end;
+			}
+
+		}
+	}
+
+	/**
+	 * 
+	 * @return true, if the string currently beeing matched does match.
+	 */
+	public boolean isMatch() {
+		final ListIterator<Head> headIterator = heads
+				.listIterator(heads.size());
+		while (headIterator.hasPrevious()) {
+			final Head head = headIterator.previous();
+			if (head == LastHead.INSTANCE) {
+				return true;
+			}
+		}
+		return false;
+	}
+
+	/**
+	 * 
+	 * @return true, if the string beeing matched will not match when the string
+	 *         gets extended.
+	 */
+	public boolean willExtendResultInNoMatch() {
+		for (int i = 0; i < heads.size(); i++) {
+			if (heads.get(i) != LastHead.INSTANCE) {
+				return false;
+			}
+		}
+		return true;
+	}
+}
-- 
1.5.4.3
