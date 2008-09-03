From: Michael Dressel <MichaelTiloDressel@t-online.de>
Subject: [PATCH 1/2] add '%d' pretty format specifier to show decoration
Date: Wed, 3 Sep 2008 20:40:08 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0809032036270.32295@pollux>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org, peff@peff.net
X-From: git-owner@vger.kernel.org Wed Sep 03 20:41:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaxIc-0004H3-Jh
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 20:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753600AbYICSkp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 14:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753723AbYICSko
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 14:40:44 -0400
Received: from mailout10.t-online.de ([194.25.134.21]:54559 "EHLO
	mailout10.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595AbYICSko (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 14:40:44 -0400
Received: from fwd27.aul.t-online.de 
	by mailout10.sul.t-online.de with smtp 
	id 1KaxHV-000698-04; Wed, 03 Sep 2008 20:40:41 +0200
Received: from [192.168.2.100] (VmQoL2Zvwhk6cqpxfKH6Dk7kjkvpJ-tB9GMOS56lWtoVGa+Ob81t79yrhZnv8gjwlS@[84.163.231.184]) by fwd27.t-online.de
	with esmtp id 1KaxGx-1f1I1I0; Wed, 3 Sep 2008 20:40:07 +0200
X-X-Sender: michael@pollux
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
X-ID: VmQoL2Zvwhk6cqpxfKH6Dk7kjkvpJ-tB9GMOS56lWtoVGa+Ob81t79yrhZnv8gjwlS
X-TOI-MSGID: 2345e4d0-6771-4b13-b8a0-5698f82c5197
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94834>


This is a variation of the patch provided by  Jeff King <peff@peff.net>:
allow '%d' pretty format specifier to show decoration

Previously, specifying

   git log --pretty=format:'%H %s' --decorate

would calculate decorations, but not show them. You can now
do:

   git log --pretty=format:'%H (%d) %s'

to see them.

The difference is that you don't need --decorate when %d has been given
because this would be "doppeltgemoppelt" (redundant).

Signed-off-by: Michael Dressel <MichaelTiloDressel@t-online.de>
---
  Documentation/pretty-formats.txt |    1 +
  builtin-log.c                    |   24 +++++++++++++++++++++++-
  pretty.c                         |   15 +++++++++++++++
  3 files changed, 39 insertions(+), 1 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 388d492..2616d63 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -116,6 +116,7 @@ The placeholders are:
  - '%cr': committer date, relative
  - '%ct': committer date, UNIX timestamp
  - '%ci': committer date, ISO 8601 format
+- '%d': decoration
  - '%e': encoding
  - '%s': subject
  - '%b': body
diff --git a/builtin-log.c b/builtin-log.c
index 1d3c5cb..5424012 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -50,11 +50,29 @@ static int add_ref_decoration(const char *refname, const unsigned char *sha1, in
  	return 0;
  }

+static int deco_in_format(int argc, const char **argv)
+{
+	int i;
+	int deco=0;
+	for (i=0;i<argc;i++)
+	{
+		if ((strstr(argv[i], "pretty=format:") ||
+					strstr(argv[i], "pretty=tformat:")) &&
+				strstr(argv[i], "%d"))
+		{
+			deco=1;
+			break;
+		}
+
+	}
+	return deco;
+}
+
  static void cmd_log_init(int argc, const char **argv, const char *prefix,
  		      struct rev_info *rev)
  {
  	int i;
-	int decorate = 0;
+	int decorate = deco_in_format(argc, argv);

  	rev->abbrev = DEFAULT_ABBREV;
  	rev->commit_format = CMIT_FMT_DEFAULT;
@@ -77,6 +95,10 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
  		if (rev->diffopt.nr_paths != 1)
  			usage("git logs can only follow renames on one pathname at a time");
  	}
+	if (decorate)
+	{
+		for_each_ref(add_ref_decoration, NULL);
+	}
  	for (i = 1; i < argc; i++) {
  		const char *arg = argv[i];
  		if (!strcmp(arg, "--decorate")) {
diff --git a/pretty.c b/pretty.c
index a29c290..3430e4d 100644
--- a/pretty.c
+++ b/pretty.c
@@ -520,8 +520,23 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
  			return 3;
  		} else
  			return 0;
+	case 'd':
+		{
+			struct name_decoration *d;
+			const char *prefix = "";
+			d = lookup_decoration(&name_decoration,
+					&commit->object);
+			while (d) {
+				strbuf_addstr(sb, prefix);
+				prefix = ", ";
+				strbuf_addstr(sb, d->name);
+				d = d->next;
+			}
+		}
+		return 1;
  	}

+
  	/* these depend on the commit */
  	if (!commit->object.parsed)
  		parse_object(commit->object.sha1);
-- 
1.6.0.1
