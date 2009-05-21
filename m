From: Michal Marek <mmarek@suse.cz>
Subject: Re: [PATCH] apply: handle filenames with double slashes better
Date: Thu, 21 May 2009 21:12:04 +0200
Message-ID: <20090521191204.GA29362@sepie.suse.cz>
References: <20090521122511.GA31614@sepie.suse.cz> <7vd4a2bj3p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 21 21:12:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7Dge-0004Nh-Ob
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 21:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754096AbZEUTMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2009 15:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753662AbZEUTMG
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 15:12:06 -0400
Received: from cantor.suse.de ([195.135.220.2]:58891 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753362AbZEUTMF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 15:12:05 -0400
Received: from relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 90928749C2;
	Thu, 21 May 2009 21:12:05 +0200 (CEST)
Received: by sepie.suse.cz (Postfix, from userid 10020)
	id 10D7176646; Thu, 21 May 2009 21:12:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vd4a2bj3p.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119702>

On Thu, May 21, 2009 at 07:56:10AM -0700, Junio C Hamano wrote:
> Michal Marek <mmarek@suse.cz> writes:
> 
> > Collapse double slashes to make patches like this work with --index or
> > --cached:
> >
> > git apply --index <<-EOF
> > 	--- a/perl//Git.pm
> > 	+++ b/perl//Git.pm
> > 	@@ -1358,3 +1358,4 @@
> >
> >
> > 	 1; # Famous last words
> > 	+# test
> > EOF
> >
> > Signed-off-by: Michal Marek <mmarek@suse.cz>
> 
> Hmm, I do not know if this is a good change.
> 
> For duplicate slashes in paths, I do not think there is any other sensible
> way to handle them other than squashing them together, but naming the
> function to do so "canon_name()" would tempt people to add other
> not-so-clearly-sensible "canonicalization" such as turning "./a" to "a"
> (which we shouldn't --- we should treat "./" as one level so that we keep
> behaving in a similar way as "patch -p1" does) or "a/../b" to "b".

OK, renamed to squash_slash().


> Also calling this in find_name() loses information too early in the
> processing; how bad would it look if you move the callsite of this
> duplicate slash squashing down the callchain where the names are actually
> used?

I tried this, but I'm not sure it's better now (and there might be some
inconsistencies left). IMHO removing the double slashes is an operation
similar to the unquoting done in find_name(), i.e. converting the text
in the patch to something that can be passed to lstat() or
cache_name_lookup(). Anyway, new patch attached.

Michal

diff --git a/builtin-apply.c b/builtin-apply.c
index 8a3771e..5a35d9f 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -320,6 +320,22 @@ static int name_terminate(const char *name, int namelen, int c, int terminate)
 	return 1;
 }
 
+/* remove double slashes to make --index work with such filenames */
+static char *squash_slash(char *name)
+{
+	int i = 0, j = 0;
+
+	if (!name)
+		return name;
+	while (name[i]) {
+		if ((name[j++] = name[i++]) == '/')
+			while (name[i] == '/')
+				i++;
+	}
+	name[j] = '\0';
+	return name;
+}
+
 static char *find_name(const char *line, char *def, int p_value, int terminate)
 {
 	int len;
@@ -423,6 +439,7 @@ static int guess_p_value(const char *nameline)
 	name = find_name(nameline, NULL, 0, TERM_SPACE | TERM_TAB);
 	if (!name)
 		return -1;
+	name = squash_slash(name);
 	cp = strchr(name, '/');
 	if (!cp)
 		val = 0;
@@ -2416,7 +2433,7 @@ static int verify_index_match(struct cache_entry *ce, struct stat *st)
 
 static int check_preimage(struct patch *patch, struct cache_entry **ce, struct stat *st)
 {
-	const char *old_name = patch->old_name;
+	const char *old_name = squash_slash(patch->old_name);
 	struct patch *tpatch = NULL;
 	int stat_ret = 0;
 	unsigned st_mode = 0;
@@ -2503,8 +2520,8 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
 static int check_patch(struct patch *patch)
 {
 	struct stat st;
-	const char *old_name = patch->old_name;
-	const char *new_name = patch->new_name;
+	const char *old_name = squash_slash(patch->old_name);
+	const char *new_name = squash_slash(patch->new_name);
 	const char *name = old_name ? old_name : new_name;
 	struct cache_entry *ce = NULL;
 	struct patch *tpatch;
-- 
1.6.3
