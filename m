From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Add Makefile target glossary.html
Date: Thu, 18 Aug 2005 17:28:57 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508181727560.31642@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Aug 18 17:31:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5mKF-000706-RH
	for gcvg-git@gmane.org; Thu, 18 Aug 2005 17:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbVHRP27 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 11:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbVHRP27
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 11:28:59 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:57000 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932254AbVHRP26 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2005 11:28:58 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C48F1EA239; Thu, 18 Aug 2005 17:28:57 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A81A7B0971; Thu, 18 Aug 2005 17:28:57 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8B289B096C; Thu, 18 Aug 2005 17:28:57 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7C1DFEA239; Thu, 18 Aug 2005 17:28:57 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This also includes a script which does the sorting, and introduces
hyperlinks for every described term.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

 Documentation/Makefile         |    7 +++-
 Documentation/sort_glossary.pl |   70 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/sort_glossary.pl

a080898e91dce96c5bac6f0527236e37aeedd156
diff --git a/Documentation/Makefile b/Documentation/Makefile
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -1,7 +1,7 @@
 MAN1_TXT=$(wildcard git-*.txt)
 MAN7_TXT=git.txt
 
-DOC_HTML=$(patsubst %.txt,%.html,$(MAN1_TXT) $(MAN7_TXT))
+DOC_HTML=$(patsubst %.txt,%.html,$(MAN1_TXT) $(MAN7_TXT)) glossary.html
 
 DOC_MAN1=$(patsubst %.txt,%.1,$(MAN1_TXT))
 DOC_MAN7=$(patsubst %.txt,%.7,$(MAN7_TXT))
@@ -54,3 +54,8 @@ clean:
 %.xml : %.txt
 	asciidoc -b docbook -d manpage $<
 
+glossary.html : glossary.txt sort_glossary.pl
+	cat $< | \
+	perl sort_glossary.pl | \
+	asciidoc -b xhtml11 - > glossary.html
+
diff --git a/Documentation/sort_glossary.pl b/Documentation/sort_glossary.pl
new file mode 100644
--- /dev/null
+++ b/Documentation/sort_glossary.pl
@@ -0,0 +1,70 @@
+#!/usr/bin/perl
+
+%terms=();
+
+while(<>) {
+	if(/^(\S.*)::$/) {
+		my $term=$1;
+		if(defined($terms{$term})) {
+			die "$1 defined twice\n";
+		}
+		$terms{$term}="";
+		LOOP: while(<>) {
+			if(/^$/) {
+				last LOOP;
+			}
+			if(/^	\S/) {
+				$terms{$term}.=$_;
+			} else {
+				die "Error 1: $_";
+			}
+		}
+	}
+}
+
+sub format_tab_80 ($) {
+	my $text=$_[0];
+	my $result="";
+	$text=~s/\s+/ /g;
+	$text=~s/^\s+//;
+	while($text=~/^(.{1,72})(|\s+(\S.*)?)$/) {
+		$result.="	".$1."\n";
+		$text=$3;
+	}
+	return $result;
+}
+
+sub no_spaces ($) {
+	my $result=$_[0];
+	$result=~tr/ /_/;
+	return $result;
+}
+
+print 'GIT Glossary
+============
+Aug 2005
+
+This list is sorted alphabetically:
+
+';
+
+@keys=sort {uc($a) cmp uc($b)} keys %terms;
+$pattern='(\b'.join('\b|\b',reverse @keys).'\b)';
+foreach $key (@keys) {
+	$terms{$key}=~s/$pattern/sprintf "<<ref_".no_spaces($1).",$1>>";/eg;
+	print '[[ref_'.no_spaces($key).']]'.$key."::\n"
+		.format_tab_80($terms{$key})."\n";
+}
+
+print '
+
+Author
+------
+Written by Johannes Schindelin <Johannes.Schindelin@gmx.de> and
+the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the link:git.html[git] suite
+';
+
