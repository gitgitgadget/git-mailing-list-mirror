From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Build in shortlog
Date: Sun, 22 Oct 2006 13:23:31 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610221322370.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
X-From: git-owner@vger.kernel.org Sun Oct 22 13:24:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbbQq-0004NF-Iq
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 13:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWJVLXf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 07:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbWJVLXe
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 07:23:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:61146 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751774AbWJVLXd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Oct 2006 07:23:33 -0400
Received: (qmail invoked by alias); 22 Oct 2006 11:23:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 22 Oct 2006 13:23:31 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29716>


Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 Documentation/git-shortlog.txt |    1 +
 Makefile                       |    5 +-
 builtin-shortlog.c             |  302 ++++++++++++++++++++++++++++++++++++++++
 builtin.h                      |    1 +
 git-shortlog.perl              |  234 -------------------------------
 git.c                          |    1 +
 path-list.c                    |    2 +-
 7 files changed, 309 insertions(+), 237 deletions(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index d54fc3e..95fa901 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -8,6 +8,7 @@ git-shortlog - Summarize 'git log' outpu
 SYNOPSIS
 --------
 git-log --pretty=short | 'git-shortlog' [-h] [-n] [-s]
+git-shortlog [-n|--number] [-s|--summary] [<committish>...]
 
 DESCRIPTION
 -----------
diff --git a/Makefile b/Makefile
index 018dad2..0beda57 100644
--- a/Makefile
+++ b/Makefile
@@ -106,7 +106,7 @@ uname_P := $(shell sh -c 'uname -p 2>/de
 
 # CFLAGS and LDFLAGS are for the users to override from the command line.
 
-CFLAGS = -g -O2 -Wall
+CFLAGS = -g -O0 -Wall
 LDFLAGS =
 ALL_CFLAGS = $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
@@ -178,7 +178,7 @@ SCRIPT_SH = \
 
 SCRIPT_PERL = \
 	git-archimport.perl git-cvsimport.perl git-relink.perl \
-	git-shortlog.perl git-rerere.perl \
+	git-rerere.perl \
 	git-cvsserver.perl \
 	git-svnimport.perl git-cvsexportcommit.perl \
 	git-send-email.perl git-svn.perl
@@ -306,6 +306,7 @@ BUILTIN_OBJS = \
 	builtin-rev-parse.o \
 	builtin-rm.o \
 	builtin-runstatus.o \
+	builtin-shortlog.o \
 	builtin-show-branch.o \
 	builtin-stripspace.o \
 	builtin-symbolic-ref.o \
diff --git a/builtin-shortlog.c b/builtin-shortlog.c
new file mode 100644
index 0000000..df60bd2
--- /dev/null
+++ b/builtin-shortlog.c
@@ -0,0 +1,302 @@
+#include "builtin.h"
+#include "cache.h"
+#include "commit.h"
+#include "diff.h"
+#include "path-list.h"
+#include "revision.h"
+#include <string.h>
+
+static const char shortlog_usage[] =
+"git-shortlog [-n] [-s] [<commit-id>... ]\n";
+
+static int compare_by_number(const void *a1, const void *a2)
+{
+	const struct path_list_item *i1 = a1, *i2 = a2;
+	const struct path_list *l1 = i1->util, *l2 = i2->util;
+
+	if (l1->nr < l2->nr)
+		return -1;
+	else if (l1->nr == l2->nr)
+		return 0;
+	else
+		return +1;
+}
+
+static struct path_list_item mailmap_list[] = {
+	{ "R.Marek@sh.cvut.cz", (void*)"Rudolf Marek" },
+	{ "Ralf.Wildenhues@gmx.de", (void*)"Ralf Wildenhues" },
+	{ "aherrman@de.ibm.com", (void*)"Andreas Herrmann" },
+	{ "akpm@osdl.org", (void*)"Andrew Morton" },
+	{ "andrew.vasquez@qlogic.com", (void*)"Andrew Vasquez" },
+	{ "aquynh@gmail.com", (void*)"Nguyen Anh Quynh" },
+	{ "axboe@suse.de", (void*)"Jens Axboe" },
+	{ "blaisorblade@yahoo.it", (void*)"Paolo 'Blaisorblade' Giarrusso" },
+	{ "bunk@stusta.de", (void*)"Adrian Bunk" },
+	{ "domen@coderock.org", (void*)"Domen Puncer" },
+	{ "dougg@torque.net", (void*)"Douglas Gilbert" },
+	{ "dwmw2@shinybook.infradead.org", (void*)"David Woodhouse" },
+	{ "ecashin@coraid.com", (void*)"Ed L Cashin" },
+	{ "felix@derklecks.de", (void*)"Felix Moeller" },
+	{ "fzago@systemfabricworks.com", (void*)"Frank Zago" },
+	{ "gregkh@suse.de", (void*)"Greg Kroah-Hartman" },
+	{ "hch@lst.de", (void*)"Christoph Hellwig" },
+	{ "htejun@gmail.com", (void*)"Tejun Heo" },
+	{ "jejb@mulgrave.(none)", (void*)"James Bottomley" },
+	{ "jejb@titanic.il.steeleye.com", (void*)"James Bottomley" },
+	{ "jgarzik@pretzel.yyz.us", (void*)"Jeff Garzik" },
+	{ "johnpol@2ka.mipt.ru", (void*)"Evgeniy Polyakov" },
+	{ "kay.sievers@vrfy.org", (void*)"Kay Sievers" },
+	{ "minyard@acm.org", (void*)"Corey Minyard" },
+	{ "mshah@teja.com", (void*)"Mitesh shah" },
+	{ "pj@ludd.ltu.se", (void*)"Peter A Jonsson" },
+	{ "rmps@joel.ist.utl.pt", (void*)"Rui Saraiva" },
+	{ "santtu.hyrkko@gmail.com", (void*)"Santtu Hyrkk,Av(B" },
+	{ "simon@thekelleys.org.uk", (void*)"Simon Kelley" },
+	{ "ssant@in.ibm.com", (void*)"Sachin P Sant" },
+	{ "terra@gnome.org", (void*)"Morten Welinder" },
+	{ "tony.luck@intel.com", (void*)"Tony Luck" },
+	{ "welinder@anemone.rentec.com", (void*)"Morten Welinder" },
+	{ "welinder@darter.rentec.com", (void*)"Morten Welinder" },
+	{ "welinder@troll.com", (void*)"Morten Welinder" }
+};
+
+static struct path_list mailmap = {
+	mailmap_list,
+	sizeof(mailmap_list) / sizeof(struct path_list_item), 0, 0
+};
+
+static int map_email(char *email, char *name, int maxlen)
+{
+	char *p;
+	struct path_list_item *item;
+
+	/* autocomplete common developers */
+	p = strchr(email, '>');
+	if (!p)
+		return 0;
+
+	*p = '\0';
+	item = path_list_lookup(email, &mailmap);
+	if (item != NULL) {
+		const char *realname = (const char *)item->util;
+		strncpy(name, realname, maxlen);
+		return 1;
+	}
+	return 0;
+}
+
+static void insert_author_oneline(struct path_list *list,
+		const char *author, int authorlen,
+		const char *oneline, int onelinelen)
+{
+	const char *dot3 = "/pub/scm/linux/kernel/git/";
+	char *buffer, *p;
+	struct path_list_item *item;
+	struct path_list *onelines;
+
+	while (authorlen > 0 && isspace(author[authorlen - 1]))
+		authorlen--;
+
+	buffer = xmalloc(authorlen + 1);
+	memcpy(buffer, author, authorlen);
+	buffer[authorlen] = '\0';
+
+	item = path_list_insert(buffer, list);
+	if (item->util == NULL)
+		item->util = xcalloc(1, sizeof(struct path_list));
+	else
+		free(buffer);
+
+	if (!strncmp(oneline, "[PATCH", 6)) {
+		char *eob = strchr(buffer, ']');
+
+		while (isspace(eob[1]) && eob[1] != '\n')
+			eob++;
+		if (eob - oneline < onelinelen) {
+			onelinelen -= eob - oneline;
+			oneline = eob;
+		}
+	}
+
+	while (onelinelen > 0 && isspace(oneline[0])) {
+		oneline++;
+		onelinelen--;
+	}
+
+	while (onelinelen > 0 && isspace(oneline[onelinelen - 1]))
+		onelinelen--;
+
+	buffer = xmalloc(onelinelen + 1);
+	memcpy(buffer, oneline, onelinelen);
+	buffer[onelinelen] = '\0';
+
+	while ((p = strstr(buffer, dot3)) != NULL) {
+		memcpy(p, "...", 3);
+		strcpy(p + 2, p + sizeof(dot3) - 1);
+	}
+
+
+	onelines = item->util;
+	if (onelines->nr >= onelines->alloc) {
+		onelines->alloc = alloc_nr(onelines->nr);
+		onelines->items = xrealloc(onelines->items,
+				onelines->alloc
+				* sizeof(struct path_list_item));
+	}
+
+	onelines->items[onelines->nr].util = NULL;
+	onelines->items[onelines->nr++].path = buffer;
+}
+
+static void read_from_stdin(struct path_list *list)
+{
+	char buffer[1024];
+
+	while (fgets(buffer, sizeof(buffer), stdin) != NULL) {
+		char *bob;
+		if ((buffer[0] == 'A' || buffer[0] == 'a') &&
+				!strncmp(buffer + 1, "uthor: ", 7) &&
+				(bob = strchr(buffer + 7, '<')) != NULL) {
+			char buffer2[1024], offset = 0;
+
+			if (map_email(bob + 1, buffer, sizeof(buffer)))
+				bob = buffer + strlen(buffer);
+			else {
+				offset = 8;
+				while (isspace(bob[-1]))
+					bob--;
+			}
+
+			while (fgets(buffer2, sizeof(buffer2), stdin) &&
+					buffer2[0] != '\n')
+				; /* chomp input */
+			if (fgets(buffer2, sizeof(buffer2), stdin))
+				insert_author_oneline(list,
+						buffer + offset,
+						bob - buffer - offset,
+						buffer2, strlen(buffer2));
+		}
+	}
+}
+
+static void get_from_rev(struct rev_info *rev, struct path_list *list)
+{
+	char scratch[1024];
+	struct commit *commit;
+
+	prepare_revision_walk(rev);
+	while ((commit = get_revision(rev)) != NULL) {
+		char *author = NULL, *oneline, *buffer;
+		int authorlen, onelinelen;
+
+		/* get author and oneline */
+		for (buffer = commit->buffer; buffer && *buffer != '\0' &&
+				*buffer != '\n'; ) {
+			char *eol = strchr(buffer, '\n');
+
+			if (eol == NULL)
+				eol = buffer + strlen(buffer);
+			else
+				eol++;
+
+			if (!strncmp(buffer, "author ", 7)) {
+				char *bracket = strchr(buffer, '<');
+
+				if (bracket == NULL || bracket > eol)
+					die("Invalid commit buffer: %s",
+					    sha1_to_hex(commit->object.sha1));
+
+				if (map_email(bracket + 1, scratch,
+							sizeof(scratch))) {
+					author = scratch;
+					authorlen = strlen(scratch);
+				} else {
+					while (bracket[-1] == ' ')
+						bracket--;
+
+					author = buffer + 7;
+					authorlen = bracket - buffer - 7;
+				}
+			}
+			buffer = eol;
+		}
+
+		if (author == NULL)
+			die ("Missing author: %s",
+					sha1_to_hex(commit->object.sha1));
+
+		if (buffer == NULL || *buffer == '\0') {
+			oneline = "<none>";
+			onelinelen = sizeof(oneline) + 1;
+		} else {
+			char *eol;
+
+			oneline = buffer + 1;
+			eol = strchr(oneline, '\n');
+			if (eol == NULL)
+				onelinelen = strlen(oneline);
+			else
+				onelinelen = eol - oneline;
+		}
+
+		insert_author_oneline(list,
+				author, authorlen, oneline, onelinelen);
+	}
+
+}
+
+int cmd_shortlog(int argc, const char **argv, const char *prefix)
+{
+	struct rev_info rev;
+	struct path_list list = { NULL, 0, 0, 1 };
+	int i, j, sort_by_number = 0, summary = 0;
+
+	init_revisions(&rev, prefix);
+	argc = setup_revisions(argc, argv, &rev, NULL);
+	while (argc > 1) {
+		if (!strcmp(argv[1], "-n") || !strcmp(argv[1], "--numbered"))
+			sort_by_number = 1;
+		else if (!strcmp(argv[1], "-s") ||
+				!strcmp(argv[1], "--summary"))
+			summary = 1;
+		else if (!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help"))
+			usage(shortlog_usage);
+		else
+			die ("unrecognized argument: %s", argv[1]);
+		argv++;
+		argc--;
+	}
+
+	if (rev.pending.nr == 1)
+		die ("Need a range!");
+	else if (rev.pending.nr == 0)
+		read_from_stdin(&list);
+	else
+		get_from_rev(&rev, &list);
+
+	if (sort_by_number)
+		qsort(list.items, sizeof(struct path_list_item), list.nr,
+			compare_by_number);
+
+	for (i = 0; i < list.nr; i++) {
+		struct path_list *onelines = list.items[i].util;
+
+		printf("%s (%d):\n", list.items[i].path, onelines->nr);
+		if (!summary) {
+			for (j = onelines->nr - 1; j >= 0; j--)
+				printf("      %s\n", onelines->items[j].path);
+			printf("\n");
+		}
+
+		onelines->strdup_paths = 1;
+		path_list_clear(onelines, 1);
+		free(onelines);
+		list.items[i].util = NULL;
+	}
+
+	list.strdup_paths = 1;
+	path_list_clear(&list, 1);
+
+	return 0;
+}
+
diff --git a/builtin.h b/builtin.h
index 9683a7c..0ce8f8b 100644
--- a/builtin.h
+++ b/builtin.h
@@ -51,6 +51,7 @@ extern int cmd_rev_list(int argc, const 
 extern int cmd_rev_parse(int argc, const char **argv, const char *prefix);
 extern int cmd_rm(int argc, const char **argv, const char *prefix);
 extern int cmd_runstatus(int argc, const char **argv, const char *prefix);
+extern int cmd_shortlog(int argc, const char **argv, const char *prefix);
 extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
 extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
diff --git a/git-shortlog.perl b/git-shortlog.perl
deleted file mode 100755
index 334fec7..0000000
--- a/git-shortlog.perl
+++ /dev/null
@@ -1,234 +0,0 @@
-#!/usr/bin/perl -w
-
-use strict;
-use Getopt::Std;
-use File::Basename qw(basename dirname);
-
-our ($opt_h, $opt_n, $opt_s);
-getopts('hns');
-
-$opt_h && usage();
-
-sub usage {
-	print STDERR "Usage: ${\basename $0} [-h] [-n] [-s] < <log_data>\n";
-        exit(1);
-}
-
-my (%mailmap);
-my (%email);
-my (%map);
-my $pstate = 1;
-my $n_records = 0;
-my $n_output = 0;
-
-sub shortlog_entry($$) {
-	my ($name, $desc) = @_;
-	my $key = $name;
-
-	$desc =~ s#/pub/scm/linux/kernel/git/#/.../#g;
-	$desc =~ s#\[PATCH\] ##g;
-
-	# store description in array, in email->{desc list} map
-	if (exists $map{$key}) {
-		# grab ref
-		my $obj = $map{$key};
-
-		# add desc to array
-		push(@$obj, $desc);
-	} else {
-		# create new array, containing 1 item
-		my @arr = ($desc);
-
-		# store ref to array
-		$map{$key} = \@arr;
-	}
-}
-
-# sort comparison function
-sub by_name($$) {
-	my ($a, $b) = @_;
-
-	uc($a) cmp uc($b);
-}
-sub by_nbentries($$) {
-	my ($a, $b) = @_;
-	my $a_entries = $map{$a};
-	my $b_entries = $map{$b};
-
-	@$b_entries - @$a_entries || by_name $a, $b;
-}
-
-my $sort_method = $opt_n ? \&by_nbentries : \&by_name;
-
-sub summary_output {
-	my ($obj, $num, $key);
-
-	foreach $key (sort $sort_method keys %map) {
-		$obj = $map{$key};
-		$num = @$obj;
-		printf "%s: %u\n", $key, $num;
-		$n_output += $num;
-	}
-}
-
-sub shortlog_output {
-	my ($obj, $num, $key, $desc);
-
-	foreach $key (sort $sort_method keys %map) {
-		$obj = $map{$key};
-		$num = @$obj;
-
-		# output author
-		printf "%s (%u):\n", $key, $num;
-
-		# output author's 1-line summaries
-		foreach $desc (reverse @$obj) {
-			print "  $desc\n";
-			$n_output++;
-		}
-
-		# blank line separating author from next author
-		print "\n";
-	}
-}
-
-sub changelog_input {
-	my ($author, $desc);
-
-	while (<>) {
-		# get author and email
-		if ($pstate == 1) {
-			my ($email);
-
-			next unless /^[Aa]uthor:?\s*(.*?)\s*<(.*)>/;
-
-			$n_records++;
-
-			$author = $1;
-			$email = $2;
-			$desc = undef;
-
-			# cset author fixups
-			if (exists $mailmap{$email}) {
-				$author = $mailmap{$email};
-			} elsif (exists $mailmap{$author}) {
-				$author = $mailmap{$author};
-			} elsif (!$author) {
-				$author = $email;
-			}
-			$email{$author}{$email}++;
-			$pstate++;
-		}
-
-		# skip to blank line
-		elsif ($pstate == 2) {
-			next unless /^\s*$/;
-			$pstate++;
-		}
-
-		# skip to non-blank line
-		elsif ($pstate == 3) {
-			next unless /^\s*?(.*)/;
-
-			# skip lines that are obviously not
-			# a 1-line cset description
-			next if /^\s*From: /;
-
-			chomp;
-			$desc = $1;
-
-			&shortlog_entry($author, $desc);
-
-			$pstate = 1;
-		}
-	
-		else {
-			die "invalid parse state $pstate";
-		}
-	}
-}
-
-sub read_mailmap {
-	my ($fh, $mailmap) = @_;
-	while (<$fh>) {
-		chomp;
-		if (/^([^#].*?)\s*<(.*)>/) {
-			$mailmap->{$2} = $1;
-		}
-	}
-}
-
-sub setup_mailmap {
-	read_mailmap(\*DATA, \%mailmap);
-	if (-f '.mailmap') {
-		my $fh = undef;
-		open $fh, '<', '.mailmap';
-		read_mailmap($fh, \%mailmap);
-		close $fh;
-	}
-}
-
-sub finalize {
-	#print "\n$n_records records parsed.\n";
-
-	if ($n_records != $n_output) {
-		die "parse error: input records != output records\n";
-	}
-	if (0) {
-		for my $author (sort keys %email) {
-			my $e = $email{$author};
-			for my $email (sort keys %$e) {
-				print STDERR "$author <$email>\n";
-			}
-		}
-	}
-}
-
-&setup_mailmap;
-&changelog_input;
-$opt_s ? &summary_output : &shortlog_output;
-&finalize;
-exit(0);
-
-
-__DATA__
-#
-# Even with git, we don't always have name translations.
-# So have an email->real name table to translate the
-# (hopefully few) missing names
-#
-Adrian Bunk <bunk@stusta.de>
-Andreas Herrmann <aherrman@de.ibm.com>
-Andrew Morton <akpm@osdl.org>
-Andrew Vasquez <andrew.vasquez@qlogic.com>
-Christoph Hellwig <hch@lst.de>
-Corey Minyard <minyard@acm.org>
-David Woodhouse <dwmw2@shinybook.infradead.org>
-Domen Puncer <domen@coderock.org>
-Douglas Gilbert <dougg@torque.net>
-Ed L Cashin <ecashin@coraid.com>
-Evgeniy Polyakov <johnpol@2ka.mipt.ru>
-Felix Moeller <felix@derklecks.de>
-Frank Zago <fzago@systemfabricworks.com>
-Greg Kroah-Hartman <gregkh@suse.de>
-James Bottomley <jejb@mulgrave.(none)>
-James Bottomley <jejb@titanic.il.steeleye.com>
-Jeff Garzik <jgarzik@pretzel.yyz.us>
-Jens Axboe <axboe@suse.de>
-Kay Sievers <kay.sievers@vrfy.org>
-Mitesh shah <mshah@teja.com>
-Morten Welinder <terra@gnome.org>
-Morten Welinder <welinder@anemone.rentec.com>
-Morten Welinder <welinder@darter.rentec.com>
-Morten Welinder <welinder@troll.com>
-Nguyen Anh Quynh <aquynh@gmail.com>
-Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
-Peter A Jonsson <pj@ludd.ltu.se>
-Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
-Rudolf Marek <R.Marek@sh.cvut.cz>
-Rui Saraiva <rmps@joel.ist.utl.pt>
-Sachin P Sant <ssant@in.ibm.com>
-Santtu Hyrkk,Av(B <santtu.hyrkko@gmail.com>
-Simon Kelley <simon@thekelleys.org.uk>
-Tejun Heo <htejun@gmail.com>
-Tony Luck <tony.luck@intel.com>
diff --git a/git.c b/git.c
index 8044667..771e8ee 100644
--- a/git.c
+++ b/git.c
@@ -262,6 +262,7 @@ static void handle_internal_command(int 
 		{ "rev-parse", cmd_rev_parse, RUN_SETUP },
 		{ "rm", cmd_rm, RUN_SETUP },
 		{ "runstatus", cmd_runstatus, RUN_SETUP },
+		{ "shortlog", cmd_shortlog, RUN_SETUP },
 		{ "show-branch", cmd_show_branch, RUN_SETUP },
 		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
 		{ "stripspace", cmd_stripspace },
diff --git a/path-list.c b/path-list.c
index 0c332dc..f8800f8 100644
--- a/path-list.c
+++ b/path-list.c
@@ -57,7 +57,7 @@ struct path_list_item *path_list_insert(
 	int index = add_entry(list, path);
 
 	if (index < 0)
-		index = 1 - index;
+		index = -1 - index;
 
 	return list->items + index;
 }
-- 
1.4.3.1.ge8ca-dirty
