From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v2 15/24] Added a Rules interface implementation and a factory for it.
Date: Mon, 12 May 2008 22:13:33 +0200
Message-ID: <1210623222-24908-16-git-send-email-florianskarten@web.de>
References: <1210623222-24908-1-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 12 22:22:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JveQG-0006mx-Cy
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 22:15:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758286AbYELUOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 16:14:08 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757892AbYELUN4
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 16:13:56 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:40264 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756031AbYELUNw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 16:13:52 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id AED03DECA18C
	for <git@vger.kernel.org>; Mon, 12 May 2008 22:13:48 +0200 (CEST)
Received: from [84.150.98.143] (helo=localhost.localdomain)
	by smtp05.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JveP6-00016x-00; Mon, 12 May 2008 22:13:48 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1210623222-24908-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX19KXuWAmcircMdMX0gS/HTxiy4trm81+RcfWZMB
	a8QuTZYqX1b7mnv5e5KbtyxMsmUHyv0Og+gR9NpffP4QhwiWSe
	YtA8rhkUiODwaJw4JXzQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81924>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../treewalk/rules/RuleListToObjectConverter.java  |  130 ++++++++++++=
++++++++
 .../jgit/treewalk/rules/RulesImplementation.java   |   86 ++++++++++++=
+
 2 files changed, 216 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/treewalk/rule=
s/RuleListToObjectConverter.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/treewalk/rule=
s/RulesImplementation.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/RuleL=
istToObjectConverter.java b/org.spearce.jgit/src/org/spearce/jgit/treew=
alk/rules/RuleListToObjectConverter.java
new file mode 100644
index 0000000..b67beff
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/RuleListToOb=
jectConverter.java
@@ -0,0 +1,130 @@
+/*
+ *  Copyright (C) 2008 Florian K=C3=B6berle
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public
+ *  License, version 2, as published by the Free Software Foundation.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public
+ *  License along with this library; if not, write to the Free Softwar=
e
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  021=
10-1301
+ */
+package org.spearce.jgit.treewalk.rules;
+
+import java.util.ArrayList;
+import java.util.Iterator;
+import java.util.List;
+
+/**
+ * This class converts a list of {@link Rule} objects into a {@Rules} =
object.
+ * During the conversion some optimizations are done:
+ * <ul>
+ * <li>Rules which can never match are removed. e.g. There is no need =
to check
+ * the rule "/a" in the directory b.</li>
+ * <li>The list is cut at the first rule which match always. *.txt\n/a=
 for
+ * example would result in an internal list "ignore all, ignore *.txt"=
 which is
+ * then reduced to "ignore all".</li>
+ * <li>Ignore rules which are direcly before an "ignore all" all rule =
are
+ * removed. /a\n*.txt for example would result in an intern "ignore *.=
txt,
+ * ignore all" list which is then reduced to "ignore all",</li>
+ * <li>"do not ignore" rules at the bottom of the intern list are remo=
ved. This
+ * optimization would remove !a from "!a\n/b" as it is in the inversed=
 list at
+ * the bottom.</li>
+ * </ul>
+ */
+class RuleListToObjectConverter {
+	protected Rules createIgnoreRules(Iterator<Rule> ruleIterator) {
+		final List<Rule> rules =3D getNessesaryRulesFromIterator(ruleIterato=
r);
+		removeUnnecessaryDoNotIgnoreRulesAtTheEndOfTheList(rules);
+		removeUnnecessaryIgnoreRulesNearTheEndOfTheList(rules);
+
+		if (rules.size() =3D=3D 1) {
+			final Rule rule =3D rules.get(0);
+			if (rule.getPattern() =3D=3D FilePattern.MATCH_ALWAYS) {
+				if (rule.isIgnoreAtMatch()) {
+					return Rules.IGNORE_ALL;
+				} else {
+					return Rules.IGNORE_NOTHING;
+				}
+			}
+		} else if (rules.isEmpty()) {
+			return Rules.IGNORE_NOTHING;
+		}
+		return new RulesImplementation(rules, this);
+	}
+
+	private List<Rule> getNessesaryRulesFromIterator(Iterator<Rule> ruleI=
terator) {
+		final List<Rule> rules =3D new ArrayList<Rule>();
+		while (ruleIterator.hasNext()) {
+			final Rule subRule =3D ruleIterator.next();
+			if (subRule.getPattern() =3D=3D FilePattern.MATCH_NEVER) {
+				continue;
+			}
+			rules.add(subRule);
+			// There is no need for rules after a rule witch match always,
+			// as such a rule would never be the first rule which matches.
+			if (subRule.getPattern() =3D=3D FilePattern.MATCH_ALWAYS) {
+				break;
+			}
+		}
+		return rules;
+	}
+
+	/**
+	 * Expects that
+	 * {@link #removeUnnecessaryDoNotIgnoreRulesAtTheEndOfTheList(List)} =
has
+	 * been executed first.
+	 *=20
+	 * @param rules
+	 *            rule list to reduce.
+	 */
+	private void removeUnnecessaryIgnoreRulesNearTheEndOfTheList(
+			final List<Rule> rules) {
+		// Why the following optimization makes only sense for the end of th=
e
+		// list:
+		// If there is a "ignore all"- rule,
+		// then it is located at the end of the list
+		// See how the list is filled to prove this statement.
+		if (rules.size() >=3D 2) {
+			final Rule lastRule =3D rules.get(rules.size() - 1);
+			assert lastRule.isIgnoreAtMatch() : "Expected that no 'not ignore'-=
rule is at the end of the list any more";
+			final boolean ignoreAllAtEnd =3D lastRule.getPattern().equals(
+					FilePattern.MATCH_ALWAYS);
+			if (ignoreAllAtEnd) {
+				while (rules.size() >=3D 2) {
+					final int ruleBeforeLastIndex =3D rules.size() - 2;
+					final Rule ruleBeforeLast =3D rules.get(ruleBeforeLastIndex);
+					if (ruleBeforeLast.isIgnoreAtMatch()) {
+						rules.remove(ruleBeforeLastIndex);
+					} else {
+						break;
+					}
+				}
+			}
+		}
+	}
+
+	private void removeUnnecessaryDoNotIgnoreRulesAtTheEndOfTheList(
+			final List<Rule> rules) {
+		// Why it is save to remove "don't ignore rules" at the end of the l=
ist
+		// if there is no "ignore rule" below a "don't ignore rule" then
+		// the path which haven't match jet will never be ignored:
+		// -> if another "don't ignore rule" match then the patch will not b=
e
+		// ignored
+		// -> if no "don't ignore rule" match then the path will not be igno=
red.
+		while (!rules.isEmpty()) {
+			final int indexOfLastRule =3D rules.size() - 1;
+			final Rule lastRule =3D rules.get(indexOfLastRule);
+			if (lastRule.isIgnoreAtMatch()) {
+				break;
+			} else {
+				rules.remove(indexOfLastRule);
+			}
+		}
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/Rules=
Implementation.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/ru=
les/RulesImplementation.java
new file mode 100644
index 0000000..e98a57e
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/RulesImpleme=
ntation.java
@@ -0,0 +1,86 @@
+/*
+ *  Copyright (C) 2008 Florian K=C3=B6berle
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public
+ *  License, version 2, as published by the Free Software Foundation.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public
+ *  License along with this library; if not, write to the Free Softwar=
e
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  021=
10-1301
+ */
+package org.spearce.jgit.treewalk.rules;
+
+import java.util.ArrayList;
+import java.util.Iterator;
+import java.util.List;
+
+class RulesImplementation implements Rules {
+	/**
+	 * Complete list of rules. Note that order is: determining rule first=
=2E
+	 */
+	private final List<Rule> rulesForTree;
+
+	/**
+	 * {@link Rule} objects which return true at a call of
+	 * {@link Rule#canMatchAtThisDirectoryLevel}.
+	 */
+	private final List<Rule> rulesForThisLevel;
+
+	/**
+	 * Factory used to create {@link Rules} for sub directories.
+	 */
+	private RuleListToObjectConverter factory;
+
+	RulesImplementation(List<Rule> rules, RuleListToObjectConverter facto=
ry) {
+		this.rulesForTree =3D rules;
+		this.factory =3D factory;
+		this.rulesForThisLevel =3D new ArrayList<Rule>();
+		for (Rule rule : rules) {
+			if (rule.canMatchAtThisDirectoryLevel()) {
+				this.rulesForThisLevel.add(rule);
+			}
+		}
+	}
+
+	/**
+	 * @see Rules#toIgnore(java.lang.String, boolean)
+	 */
+	public boolean toIgnore(String fileName, boolean fileIsDirectory) {
+		for (Rule rule : rulesForThisLevel) {
+			if (rule.getPattern().match(fileName, fileIsDirectory)) {
+				return rule.isIgnoreAtMatch();
+			}
+		}
+		return false;
+	}
+
+	/**
+	 * @see Rules#getRulesForSubDirectory(java.lang.String)
+	 */
+	public Rules getRulesForSubDirectory(final String directoryName) {
+		final Iterator<Rule> subRuleIterator =3D new Iterator<Rule>() {
+			final Iterator<Rule> ruleIterator =3D rulesForTree.iterator();
+
+			public boolean hasNext() {
+				return ruleIterator.hasNext();
+			}
+
+			public Rule next() {
+				return ruleIterator.next()
+						.getRuleForSubDirectory(directoryName);
+			}
+
+			public void remove() {
+				throw new UnsupportedOperationException();
+			}
+
+		};
+		return factory.createIgnoreRules(subRuleIterator);
+	}
+}
--=20
1.5.4.3
