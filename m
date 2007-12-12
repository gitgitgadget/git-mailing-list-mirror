From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (amend)] diff: Make numstat machine friendly also for renames (and copies)
Date: Tue, 11 Dec 2007 23:46:30 -0800
Message-ID: <7vabog9wyx.fsf@gitster.siamese.dyndns.org>
References: <200712102332.53114.jnareb@gmail.com>
	<200712110226.35343.jnareb@gmail.com>
	<7vprxehrlv.fsf@gitster.siamese.dyndns.org>
	<200712120009.36560.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 08:47:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2MJS-0005x4-6N
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 08:47:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754374AbXLLHrE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 02:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754364AbXLLHrD
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 02:47:03 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55409 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678AbXLLHrA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 02:47:00 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F2C45EA1;
	Wed, 12 Dec 2007 02:46:54 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D8B495C78;
	Wed, 12 Dec 2007 02:46:31 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68004>

Jakub Narebski <jnareb@gmail.com> writes:

> The previous patch is a fix (usability fix) for numstat output in the
> presence of rename detection, making it truly machine friendly. Moreover
> it should not break any scripts which parsed numstat output not
> expecting to deal with renames (for example if repository has
> diff.renames config option set), and might even fix them.
>
> The proposed - and implemented in patch below - change could break some
> scripts not expecting to deal with new numstat output.

I do not quite follow.  If a script wanted -M and/or -C output in the
older "common/{a => b}/common" format, either change would break it
equally badly, either with or without -z.  And I do not think adding
status letter is necessary for --numstat; if the caller wants that
information, it can ask for it explicitly with both options.

So I do not think there is anything more to solve, than the patch you
just sent.

The patch looks good.  Thanks.

> P.S. The numstat output format for renames should be probably described
> in documentation, and not only in commit message, but I was not sure
> where to put it (and even how it should be written).

I started writing this, and then reviewed the result of squashing your
two patches.

Although everybody complains that most of git is run-once-and-exit, I
wrote the original diff part fairly conservatively to make it leak-free,
because of a single command, "diff-tree --stdin", that can be told to
run millions of diffs inside a single process.

But the diffstat part is horribly leaky, especially after your patch,
and it has ugly workarounds such as refusing to show both diffstat and
shortstat at the same time, not because it does not make much sense
(admittedly it doesn't), but because show_stats() discards necessary
information when it is done, making it impossible for shortstat to run.

So I ended up restructuring the name allocation/free code a bit while at
it.

-- >8 --
diff --numstat -z: make it machine readable

The "-z" format is all about machine parsability, but showing renamed
paths as "common/{a => b}/suffix" makes it impossible.  The scripts would
never have successfully parsed "--numstat -z -M" in the old format.

This fixes the output format in a (hopefully minimally) backward
incompatible way.

 * The output without -z is not changed.  This has given a good way for
   humans to view added and deleted lines separately, and showing the
   path in combined, shorter way would preserve readability.

 * The output with -z is unchanged for paths that do not involve renames.
   Existing scripts that do not pass -M/-C are not affected at all.

 * The output with -z for a renamed path is shown in a format that can
   easily be distinguished from an unrenamed path.

This is based on Jakub Narebski's patch.  Bugs and documentation typos
are mine.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/diff-format.txt |   61 +++++++++++++++++++++++++
 diff.c                        |  100 ++++++++++++++++++++++++++++-------------
 2 files changed, 129 insertions(+), 32 deletions(-)

diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
index 2c3a4c4..400cbb3 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -84,3 +84,64 @@ all parents.
 
 
 include::diff-generate-patch.txt[]
+
+
+other diff formats
+------------------
+
+The `--summary` option describes newly added, deleted, renamed and
+copied files.  The `--stat` option adds diffstat(1) graph to the
+output.  These options can be combined with other options, such as
+`-p`, and are meant for human consumption.
+
+When showing a change that involves a rename or a copy, `--stat` output
+formats the pathnames compactly by combining common prefix and suffix of
+the pathnames.  For example, a change that moves `arch/i386/Makefile` to
+`arch/x86/Makefile` while modifying 4 lines will be shown like this:
+
+------------------------------------
+arch/{i386 => x86}/Makefile    |   4 +--
+------------------------------------
+
+The `--numstat` option gives the diffstat(1) information but is designed
+for easier machine consumption.  An entry in `--numstat` output looks
+like this:
+
+----------------------------------------
+1	2	README
+3	1	arch/{i386 => x86}/Makefile
+----------------------------------------
+
+That is, from left to right:
+
+. the number of added lines;
+. a tab;
+. the number of deleted lines;
+. a tab;
+. pathname (possibly with rename/copy information);
+. a newline.
+
+When `-z` output option is in effect, the output is formatted this way:
+
+----------------------------------------
+1	2	README NUL
+3	1	NUL arch/i386/Makefile NUL arch/x86/Makefile NUL
+----------------------------------------
+
+That is:
+
+. the number of added lines;
+. a tab;
+. the number of deleted lines;
+. a tab;
+. a NUL (only exists if renamed/copied);
+. pathname in preimage;
+. a NUL (only exists if renamed/copied);
+. pathname in postimage (only exists if renamed/copied);
+. a NUL.
+
+The extra `NUL` before the preimage path in renamed case is to allow
+scripts that read the output to tell if the current record being read is
+a single-path record or a rename/copy record without reading ahead.
+After reading added and deleted lines, reading up to `NUL` would yield
+the pathname, but if that is `NUL`, the record will show two paths.
diff --git a/diff.c b/diff.c
index f780e3e..fc51506 100644
--- a/diff.c
+++ b/diff.c
@@ -734,7 +734,9 @@ struct diffstat_t {
 	int nr;
 	int alloc;
 	struct diffstat_file {
+		char *from_name;
 		char *name;
+		char *print_name;
 		unsigned is_unmerged:1;
 		unsigned is_binary:1;
 		unsigned is_renamed:1;
@@ -755,11 +757,14 @@ static struct diffstat_file *diffstat_add(struct diffstat_t *diffstat,
 	}
 	diffstat->files[diffstat->nr++] = x;
 	if (name_b) {
-		x->name = pprint_rename(name_a, name_b);
+		x->from_name = xstrdup(name_a);
+		x->name = xstrdup(name_b);
 		x->is_renamed = 1;
 	}
-	else
+	else {
+		x->from_name = NULL;
 		x->name = xstrdup(name_a);
+	}
 	return x;
 }
 
@@ -803,6 +808,28 @@ static void show_graph(char ch, int cnt, const char *set, const char *reset)
 	printf("%s", reset);
 }
 
+static void fill_print_name(struct diffstat_file *file)
+{
+	char *pname;
+
+	if (file->print_name)
+		return;
+
+	if (!file->is_renamed) {
+		struct strbuf buf;
+		strbuf_init(&buf, 0);
+		if (quote_c_style(file->name, &buf, NULL, 0)) {
+			pname = strbuf_detach(&buf, NULL);
+		} else {
+			pname = file->name;
+			strbuf_release(&buf);
+		}
+	} else {
+		pname = pprint_rename(file->from_name, file->name);
+	}
+	file->print_name = pname;
+}
+
 static void show_stats(struct diffstat_t* data, struct diff_options *options)
 {
 	int i, len, add, del, total, adds = 0, dels = 0;
@@ -836,19 +863,8 @@ static void show_stats(struct diffstat_t* data, struct diff_options *options)
 	for (i = 0; i < data->nr; i++) {
 		struct diffstat_file *file = data->files[i];
 		int change = file->added + file->deleted;
-
-		if (!file->is_renamed) {  /* renames are already quoted by pprint_rename */
-			struct strbuf buf;
-			strbuf_init(&buf, 0);
-			if (quote_c_style(file->name, &buf, NULL, 0)) {
-				free(file->name);
-				file->name = strbuf_detach(&buf, NULL);
-			} else {
-				strbuf_release(&buf);
-			}
-		}
-
-		len = strlen(file->name);
+		fill_print_name(file);
+		len = strlen(file->print_name);
 		if (max_len < len)
 			max_len = len;
 
@@ -873,7 +889,7 @@ static void show_stats(struct diffstat_t* data, struct diff_options *options)
 
 	for (i = 0; i < data->nr; i++) {
 		const char *prefix = "";
-		char *name = data->files[i]->name;
+		char *name = data->files[i]->print_name;
 		int added = data->files[i]->added;
 		int deleted = data->files[i]->deleted;
 		int name_len;
@@ -901,17 +917,17 @@ static void show_stats(struct diffstat_t* data, struct diff_options *options)
 			printf("%s%d%s", add_c, added, reset);
 			printf(" bytes");
 			printf("\n");
-			goto free_diffstat_file;
+			continue;
 		}
 		else if (data->files[i]->is_unmerged) {
 			show_name(prefix, name, len, reset, set);
 			printf("  Unmerged\n");
-			goto free_diffstat_file;
+			continue;
 		}
 		else if (!data->files[i]->is_renamed &&
 			 (added + deleted == 0)) {
 			total_files--;
-			goto free_diffstat_file;
+			continue;
 		}
 
 		/*
@@ -933,11 +949,7 @@ static void show_stats(struct diffstat_t* data, struct diff_options *options)
 		show_graph('+', add, add_c, reset);
 		show_graph('-', del, del_c, reset);
 		putchar('\n');
-	free_diffstat_file:
-		free(data->files[i]->name);
-		free(data->files[i]);
 	}
-	free(data->files);
 	printf("%s %d files changed, %d insertions(+), %d deletions(-)%s\n",
 	       set, total_files, adds, dels, reset);
 }
@@ -962,11 +974,7 @@ static void show_shortstats(struct diffstat_t* data)
 				dels += deleted;
 			}
 		}
-		free(data->files[i]->name);
-		free(data->files[i]);
 	}
-	free(data->files);
-
 	printf(" %d files changed, %d insertions(+), %d deletions(-)\n",
 	       total_files, adds, dels);
 }
@@ -975,6 +983,9 @@ static void show_numstat(struct diffstat_t* data, struct diff_options *options)
 {
 	int i;
 
+	if (data->nr == 0)
+		return;
+
 	for (i = 0; i < data->nr; i++) {
 		struct diffstat_file *file = data->files[i];
 
@@ -982,15 +993,39 @@ static void show_numstat(struct diffstat_t* data, struct diff_options *options)
 			printf("-\t-\t");
 		else
 			printf("%d\t%d\t", file->added, file->deleted);
-		if (!file->is_renamed) {
-			write_name_quoted(file->name, stdout, options->line_termination);
+		if (options->line_termination) {
+			fill_print_name(file);
+			if (!file->is_renamed)
+				write_name_quoted(file->name, stdout,
+						  options->line_termination);
+			else {
+				fputs(file->print_name, stdout);
+				putchar(options->line_termination);
+			}
 		} else {
-			fputs(file->name, stdout);
-			putchar(options->line_termination);
+			if (file->is_renamed) {
+				putchar('\0');
+				write_name_quoted(file->from_name, stdout, '\0');
+			}
+			write_name_quoted(file->name, stdout, '\0');
 		}
 	}
 }
 
+static void free_diffstat_info(struct diffstat_t *diffstat)
+{
+	int i;
+	for (i = 0; i < diffstat->nr; i++) {
+		struct diffstat_file *f = diffstat->files[i];
+		if (f->name != f->print_name)
+			free(f->print_name);
+		free(f->name);
+		free(f->from_name);
+		free(f);
+	}
+	free(diffstat->files);
+}
+
 struct checkdiff_t {
 	struct xdiff_emit_state xm;
 	const char *filename;
@@ -2943,8 +2978,9 @@ void diff_flush(struct diff_options *options)
 			show_numstat(&diffstat, options);
 		if (output_format & DIFF_FORMAT_DIFFSTAT)
 			show_stats(&diffstat, options);
-		else if (output_format & DIFF_FORMAT_SHORTSTAT)
+		if (output_format & DIFF_FORMAT_SHORTSTAT)
 			show_shortstats(&diffstat);
+		free_diffstat_info(&diffstat);
 		separator++;
 	}
 
