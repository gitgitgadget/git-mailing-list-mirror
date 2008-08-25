From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-apply - Add --include=PATH
Date: Mon, 25 Aug 2008 01:05:31 -0700
Message-ID: <7vhc99h644.fsf@gitster.siamese.dyndns.org>
References: <1219523869.18365.106.camel@localhost>
 <7viqtrw7up.fsf@gitster.siamese.dyndns.org>
 <1219615063.18365.141.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 10:06:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXX66-0001PW-1y
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 10:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753829AbYHYIFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 04:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753808AbYHYIFk
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 04:05:40 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47329 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720AbYHYIFj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 04:05:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1D91B67D84;
	Mon, 25 Aug 2008 04:05:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 76DA467D83; Mon, 25 Aug 2008 04:05:34 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9A4B0614-727C-11DD-A5E9-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93604>

Joe Perches <joe@perches.com> writes:

>> > @@ -2996,10 +2996,16 @@ static struct excludes {
>> >  	const char *path;
>> >  } *excludes;
>> >  
>> > +static struct includes {
>> > +	struct includes *next;
>> > +	const char *path;
>> > +} *includes;
>> 
>> Now this is ugly.  You can just add a new variable "*includes" that is of
>> exactly the same type as existing "*excludes" without introducing a new
>> type.
>
> Yes, it's slightly ugly, but it was less work and much easier for
> a human to parse.

Another consideration is what should happen when you give contradicting
excludes and includes list.  For example, it is very plausible you might
want to say "apply to all but header files, except that you want the part
to one specific header file to also get applied).  Something like:

    $ git apply --include='specific-one.h' --exclude='*.h' --include='*' <patch

It is easy to declare that all the exclude patterns are processed and used
to reject paths, and then only after that include patterns, if any, are
used to limit the remainder.  But that is describing how the code does it,
and may not match what the users expect.  For example, the users would
expect:

    $ git apply --include='specific-one.h' --exclude='s*' <patch

to apply the part for "specific-one.h" but no other paths that begin with "s".
However, that is not what happens.

It would be much easier to explain to the end users if the rule were that
include and exclude patterns are examined in the order they are specified
on the command line, and the first match determines the each path's fate.

In order to support that, you do not want two separate lists.  Instead,
you would want to keep a single "static struct string_list limit_by_name",
append both excluded and included items to the list as you encounter with
string_list_append(), but in such a way that you can distinguish which one
is which later.  Also remember if you have seen any included item.

Then your use_patch() would:

 * first check and ignore patches about paths outside of the prefix if any
   is specified via --directory;

 * loop over the limit_by_name.items[] array, checking the path with each
   element in it with fnmatch().  If you find a match, then you know if it
   is excluded (return 0) or included (return 1);

 * if no patterns match, return 1 (i.e. modify this path) if you did not
   see any "include" pattern.  If you had any "include" pattern on the
   command line, return 0 (i.e. do not modify this path).

Perhaps something like this, but I did not test it.

 builtin-apply.c |   48 +++++++++++++++++++++++++++++++++---------------
 1 files changed, 33 insertions(+), 15 deletions(-)

diff --git c/builtin-apply.c w/builtin-apply.c
index 2216a0b..967ebec 100644
--- c/builtin-apply.c
+++ w/builtin-apply.c
@@ -2991,29 +2991,45 @@ static int write_out_results(struct patch *list, int skipped_patch)
 
 static struct lock_file lock_file;
 
-static struct excludes {
-	struct excludes *next;
-	const char *path;
-} *excludes;
+static struct string_list limit_by_name;
+static int has_include;
+static void add_name_limit(const char *name, int exclude)
+{
+	struct string_list_item *it;
+
+	it = string_list_append(name, &limit_by_name);
+	it->util = exclude ? NULL : (void *) 1;
+}
 
 static int use_patch(struct patch *p)
 {
 	const char *pathname = p->new_name ? p->new_name : p->old_name;
-	struct excludes *x = excludes;
-	while (x) {
-		if (fnmatch(x->path, pathname, 0) == 0)
-			return 0;
-		x = x->next;
-	}
+	int i;
+
+	/* Paths outside are not touched regardless of "--include" */
 	if (0 < prefix_length) {
 		int pathlen = strlen(pathname);
 		if (pathlen <= prefix_length ||
 		    memcmp(prefix, pathname, prefix_length))
 			return 0;
 	}
-	return 1;
+
+	/* See if it matches any of exclude/include rule */
+	for (i = 0; i < limit_by_name.nr; i++) {
+		struct string_list_item *it = &limit_by_name.items[i];
+		if (!fnmatch(it->string, pathname, 0))
+			return (it->util != NULL);
+	}
+
+	/*
+	 * If we had any include, a path that does not match any rule is
+	 * not used.  Otherwise, we saw bunch of exclude rules (or none)
+	 * and such a path is used.
+	 */
+	return !has_include;
 }
 
+
 static void prefix_one(char **name)
 {
 	char *old_name = *name;
@@ -3154,10 +3170,12 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 			continue;
 		}
 		if (!prefixcmp(arg, "--exclude=")) {
-			struct excludes *x = xmalloc(sizeof(*x));
-			x->path = arg + 10;
-			x->next = excludes;
-			excludes = x;
+			add_name_limit(arg + 10, 1);
+			continue;
+		}
+		if (!prefixcmp(arg, "--include=")) {
+			add_name_limit(arg + 10, 0);
+			has_include = 1;
 			continue;
 		}
 		if (!prefixcmp(arg, "-p")) {
