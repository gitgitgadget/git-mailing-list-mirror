From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v4 08/24] Added a Rules interface implementation and a factory for it.
Date: Fri, 13 Jun 2008 20:35:05 +0200
Message-ID: <1213382121-19786-8-git-send-email-florianskarten@web.de>
References: <4852BCCA.4030404@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 20:38:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7EAL-0005zA-To
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 20:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881AbYFMSfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 14:35:45 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754396AbYFMSfl
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 14:35:41 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:41945 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752587AbYFMSf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 14:35:28 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 90CB0DFAF6F6
	for <git@vger.kernel.org>; Fri, 13 Jun 2008 20:35:27 +0200 (CEST)
Received: from [84.150.79.9] (helo=localhost.localdomain)
	by smtp08.web.de with asmtp (WEB.DE 4.109 #226)
	id 1K7E7T-0000eI-00; Fri, 13 Jun 2008 20:35:27 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <4852BCCA.4030404@web.de>
In-Reply-To: <4852BCCA.4030404@web.de>
References: <4852BCCA.4030404@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX19kzY99SiA/fFX7ZZmi1LyLTLeELfAmErQJ1Tk/
	8NyiPVLCtuS9mc4bYt/Z6dcILIdSu//8eNC193sUT6J9hnlBxT
	iW76pwlbjTBM4nMU0CTw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84915>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../treewalk/rules/RuleListToObjectConverter.java  |  151 ++++++++++++=
++++++++
 .../jgit/treewalk/rules/RulesImplementation.java   |   88 ++++++++++++
 2 files changed, 239 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/treewalk/rule=
s/RuleListToObjectConverter.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/treewalk/rule=
s/RulesImplementation.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/RuleL=
istToObjectConverter.java b/org.spearce.jgit/src/org/spearce/jgit/treew=
alk/rules/RuleListToObjectConverter.java
new file mode 100644
index 0000000..96f27bb
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/RuleListToOb=
jectConverter.java
@@ -0,0 +1,151 @@
+/*
+ * Copyright (C) 2008, Florian K=C3=B6berle <florianskarten@web.de>
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
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
index 0000000..cd12701
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/RulesImpleme=
ntation.java
@@ -0,0 +1,88 @@
+/*
+ * Copyright (C) 2008, Florian K=C3=B6berle <florianskarten@web.de>
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.treewalk.rules;
+
+import java.util.Iterator;
+import java.util.List;
+
+class RulesImplementation implements Rules {
+	/**
+	 * Complete list of rules. Note that order is: determining rule first=
=2E
+	 */
+	private final List<Rule> rules;
+
+	/**
+	 * Factory used to create {@link Rules} for sub directories.
+	 */
+	private RuleListToObjectConverter factory;
+
+	RulesImplementation(List<Rule> rules, RuleListToObjectConverter facto=
ry) {
+		this.rules =3D rules;
+		this.factory =3D factory;
+	}
+
+	public boolean shouldIgnore(String fileName, boolean fileIsDirectory)=
 {
+		for (Rule rule : rules) {
+			if (rule.getPattern().match(fileName, fileIsDirectory)) {
+				return rule.isIgnoreAtMatch();
+			}
+		}
+		return false;
+	}
+
+	public Rules getRulesForSubDirectory(final String directoryName) {
+		final Iterator<Rule> subRuleIterator =3D new Iterator<Rule>() {
+			final Iterator<Rule> ruleIterator =3D rules.iterator();
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
