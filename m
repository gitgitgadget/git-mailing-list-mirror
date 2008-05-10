From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH 15/22] Added a Rules interface implementation and a factory for it.
Date: Sat, 10 May 2008 15:00:33 +0200
Message-ID: <1210424440-13886-16-git-send-email-florianskarten@web.de>
References: <1210424440-13886-1-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 10 15:03:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Juoji-0008FZ-UY
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 15:03:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755535AbYEJNB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 09:01:26 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755508AbYEJNBX
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 09:01:23 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:49449 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755547AbYEJNAt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 09:00:49 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id EAD84DA50157
	for <git@vger.kernel.org>; Sat, 10 May 2008 15:00:48 +0200 (CEST)
Received: from [84.150.90.150] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1Juogy-000860-00; Sat, 10 May 2008 15:00:48 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1210424440-13886-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX1+o+8W92PZ4DUIdJWwNrXNJEiyU5di4HaghF5DX
	jrjsK9M7KDsZSERbKGuYsgZ0YvdqPRIJK20kmPrUJKDcY4qLWw
	T0Y7I8HVtMzQrIsM3TjQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81686>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../fileiteration/RuleListToObjectConverter.java   |  113 ++++++++++++=
++++++++
 .../lib/fileiteration/RulesImplementation.java     |   87 ++++++++++++=
+++
 2 files changed, 200 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/fileitera=
tion/RuleListToObjectConverter.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/fileitera=
tion/RulesImplementation.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/fileiteration/Ru=
leListToObjectConverter.java b/org.spearce.jgit/src/org/spearce/jgit/li=
b/fileiteration/RuleListToObjectConverter.java
new file mode 100644
index 0000000..533a35b
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/fileiteration/RuleListT=
oObjectConverter.java
@@ -0,0 +1,113 @@
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
+package org.spearce.jgit.lib.fileiteration;
+
+import java.util.ArrayList;
+import java.util.Iterator;
+import java.util.List;
+
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
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/fileiteration/Ru=
lesImplementation.java b/org.spearce.jgit/src/org/spearce/jgit/lib/file=
iteration/RulesImplementation.java
new file mode 100644
index 0000000..b7bf963
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/fileiteration/RulesImpl=
ementation.java
@@ -0,0 +1,87 @@
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
+package org.spearce.jgit.lib.fileiteration;
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
+	 * @see org.spearce.jgit.lib.fileiteration.Rules#toIgnore(java.lang.S=
tring,
+	 *      boolean)
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
+	 * @see org.spearce.jgit.lib.fileiteration.Rules#getRulesForSubDirect=
ory(java.lang.String)
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
1.5.2.5
