From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH v3 11/19] dir.c: use a single struct exclude_list per
 source of excludes
Date: Sun, 6 Jan 2013 22:53:11 +0000
Message-ID: <20130106225311.GB6552@pacific.linksys.moosehall>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
 <1356575558-2674-12-git-send-email-git@adamspiers.org>
 <7v1ue0veww.fsf@alter.siamese.dyndns.org>
 <20130106152039.GA2396@pacific.linksys.moosehall>
 <7v7gnqnjn7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 06 23:53:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trz5x-0004CN-Mx
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 23:53:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268Ab3AFWxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 17:53:15 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:46024 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753258Ab3AFWxN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 17:53:13 -0500
Received: from localhost (f.4.d.7.f.d.e.f.f.f.3.7.3.0.a.1.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:1a03:73ff:fedf:7d4f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id CC3552E5D3
	for <git@vger.kernel.org>; Sun,  6 Jan 2013 22:53:11 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7v7gnqnjn7.fsf@alter.siamese.dyndns.org>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212852>

On Sun, Jan 06, 2013 at 12:25:48PM -0800, Junio C Hamano wrote:
> Adam Spiers <git@adamspiers.org> writes:
> 
> > On Fri, Jan 04, 2013 at 01:03:59PM -0800, Junio C Hamano wrote:
> >> Adam Spiers <git@adamspiers.org> writes:
> >> 
> >> > diff --git a/builtin/clean.c b/builtin/clean.c
> >> > index 0c7b3d0..bd18b88 100644
> >> > --- a/builtin/clean.c
> >> > +++ b/builtin/clean.c
> >> > @@ -97,9 +97,10 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
> >> >  	if (!ignored)
> >> >  		setup_standard_excludes(&dir);
> >> >  
> >> > +	add_exclude_list(&dir, EXC_CMDL);
> >> >  	for (i = 0; i < exclude_list.nr; i++)
> >> >  		add_exclude(exclude_list.items[i].string, "", 0,
> >> > -			    &dir.exclude_list[EXC_CMDL]);
> >> > +			    &dir.exclude_list_groups[EXC_CMDL].ary[0]);
> >> 
> >> This looks somewhat ugly for two reasons.
> >> 
> >>  * The abstraction add_exclude() offers to its callers is just to
> >>    let them add one pattern to the list of patterns for the kind
> >>    (here, EXC_CMDL); why should they care about .ary[0] part?
> >
> > Because the caller has to decide which exclude list the new exclude
> > should be added to; that is how it has been for a long time, and I am
> > not proposing we change that.
> 
> Unless I was mistaken, I never objected to the EXC_CMDL, etc
> appearing in the text of the calling site of add_exclude().
> 
> The objection was about the .ary[0] bit.  From the point of view of
> a caller of the API, it:
> 
>     - calls add_exclude_list() to declare "I now start adding new
>       patterns that come from a new source of patterns"; then
> 
>     - calls add_exclude() repeatedly to add the patterns that come
>       from that source.
> 
> no?

Correct.

> Why does the latter has to keep repeating "Here is the new
> pattern for the EXC_CMDL group; it comes from the latest source I
> earlier declared, by the way", instead of just "Here is the new
> pattern for the EXC_CMDL group"?

Mainly because there is no guarantee that such a group exists.

unpack_trees() has:

	if (add_excludes_from_file_to_list(git_path("info/sparse-checkout"), "", 0, &el, 0) < 0)

so if you change the signature of add_exclude() to require an
exclude_list_group, then there is no way to implement
add_excludes_from_file_to_list().

Even if you could, you still haven't reduced the number of parameters
add_exclude() requires, so I'm dubious of the benefits of this
"simplification".

> >>    Are
> >>    there cases any sane caller (not the implementation of the
> >>    exclude_list_group machinery e.g. add_excludes_from_... function)
> >>    may want to call it with .ary[1]?
> >
> > Effectively yes, although it is not written like ".ary[1]".  For
> > example prep_exclude() calls add_excludes_from_file_to_list() for each
> > new .gitignore file
> 
> That is part of the "implementation of the machinery".  If the API
> for the outside callers are to call add_exclude_list() to declare
> that patterns added by subsequent calls to add_exclude() are from
> one new source of the patterns (e.g. .gitignore file in a new
> directory level), and then call add_exclude() to add each pattern,
> then the callers to add_exclude() shouldn't have to care about the
> implementation detail that individual sources in exclude_list_group
> is implemented as an array in that sructure, and the latest ones
> should go to its ->array[0].

That's a valid point.  However, the ary[0] part which assumes external
knowledge of the internal implementation can trivially be avoided by
squashing this patch onto the commit we are discussing:

diff --git a/builtin/clean.c b/builtin/clean.c
index dd89737..6e21ca6 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -45,6 +45,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	static const char **pathspec;
 	struct strbuf buf = STRBUF_INIT;
 	struct string_list exclude_list = STRING_LIST_INIT_NODUP;
+	struct exclude_list *el;
 	const char *qname;
 	char *seen = NULL;
 	struct option options[] = {
@@ -97,10 +98,9 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	if (!ignored)
 		setup_standard_excludes(&dir);
 
-	add_exclude_list(&dir, EXC_CMDL);
+	el = add_exclude_list(&dir, EXC_CMDL);
 	for (i = 0; i < exclude_list.nr; i++)
-		add_exclude(exclude_list.items[i].string, "", 0,
-			    &dir.exclude_list_group[EXC_CMDL].el[0]);
+		add_exclude(exclude_list.items[i].string, "", 0, el);
 
 	pathspec = get_pathspec(prefix, argv);


and by adopting the same approach for ls-files.c:

 
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 0ca9d8e..0406adc 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -420,10 +420,11 @@ static int option_parse_z(const struct option *opt,
 static int option_parse_exclude(const struct option *opt,
 				const char *arg, int unset)
 {
-	struct exclude_list_group *group = opt->value;
+	struct string_list *exclude_list = opt->value;
 
 	exc_given = 1;
-	add_exclude(arg, "", 0, &group->el[0]);
+	string_list_append(exclude_list, arg);
+	fprintf(stderr, "append %s\n", arg);
 
 	return 0;
 }
@@ -452,9 +453,11 @@ static int option_parse_exclude_standard(const struct option *opt,
 
 int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 {
-	int require_work_tree = 0, show_tag = 0;
+	int require_work_tree = 0, show_tag = 0, i;
 	const char *max_prefix;
 	struct dir_struct dir;
+	struct exclude_list *el;
+	struct string_list exclude_list = STRING_LIST_INIT_NODUP;
 	struct option builtin_ls_files_options[] = {
 		{ OPTION_CALLBACK, 'z', NULL, NULL, NULL,
 			"paths are separated with NUL character",
@@ -489,7 +492,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		OPT_BOOLEAN(0, "resolve-undo", &show_resolve_undo,
 			    "show resolve-undo information"),
 		{ OPTION_CALLBACK, 'x', "exclude",
-			&dir.exclude_list_group[EXC_CMDL], "pattern",
+			&exclude_list, "pattern",
 			"skip files matching pattern",
 			0, option_parse_exclude },
 		{ OPTION_CALLBACK, 'X', "exclude-from", &dir, "file",
@@ -524,9 +527,13 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	if (read_cache() < 0)
 		die("index file corrupt");
 
-	add_exclude_list(&dir, EXC_CMDL);
 	argc = parse_options(argc, argv, prefix, builtin_ls_files_options,
 			ls_files_usage, 0);
+	el = add_exclude_list(&dir, EXC_CMDL);
+	for (i = 0; i < exclude_list.nr; i++) {
+		fprintf(stderr, "adding exclude: %s\n", exclude_list.items[i].string);
+		add_exclude(exclude_list.items[i].string, "", 0, el);
+	}
 	if (show_tag || show_valid_bit) {
 		tag_cached = "H ";
 		tag_unmerged = "M ";

> The implementation of the machinery may find it more convenient if
> they can add one or more "sources" to an exclude_list_group before
> starting to add patterns to ->array[0] or ->array[1] or ->array[2],
> and a finer grained internal API that lets the caller pass an
> instance of "struct exclude_list" regardless of where in an
> exclude_list_group's ary[] that instance sits may be necessary to do
> so.
> 
> But that does not mean other existing callers has to be aware of
> such inner detail.  If the implementation of the machinery needs a
> helper function that adds an element to any struct exclude_list, not
> necessarily the one at the tip of an exclude_list_group, we can
> still do that by having the bulk of the logic in the internal, finer
> grained helper, say, add_pattern_to_exclude_list(), and keep the
> external API simpler by making it a thin wrapper around it, perhaps
> like:
> 
>    static void add_pattern_to_exclude_list(const char *pattern,
>    		    const char *base, int baselen,
>                     struct exclude_list *el);
> 
>    void add_exclude(const char *pattern,
>    		    const char *base, int baselen,
>                     struct exclude_list_group *group) {
> 	add_pattern_to_exclude_list(pattern, base, baselen, &group->ary[0]);

Presumably you mean

	add_pattern_to_exclude_list(pattern, base, baselen,
				    &group->ary[group->nr - 1]);

(although at your request, I already renamed 'ary' to 'el').

I have made a genuine attempt to implement your suggestion, but due to
the unpack_trees() case stated above, I don't see how it can be done.
