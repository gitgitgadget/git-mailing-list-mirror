From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC] rewrite `git_default_config()` using config-set API functions
Date: Mon, 21 Jul 2014 15:43:44 +0200
Message-ID: <vpqha2addyn.fsf@anie.imag.fr>
References: <1405941145-12120-1-git-send-email-tanayabh@gmail.com>
	<53CCFD02.6010704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 15:43:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9Dsg-00030S-8o
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 15:43:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbaGUNnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 09:43:50 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39281 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932205AbaGUNnu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 09:43:50 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6LDhgks007531
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Jul 2014 15:43:42 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6LDhi6s025313;
	Mon, 21 Jul 2014 15:43:44 +0200
In-Reply-To: <53CCFD02.6010704@gmail.com> (Tanay Abhra's message of "Mon, 21
	Jul 2014 17:14:02 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 21 Jul 2014 15:43:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6LDhgks007531
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406555026.2786@Im1cx7qn/ZYXgpMbxDg5BQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253963>

Tanay Abhra <tanayabh@gmail.com> writes:

> Consider this as a proof of concept as the others callers have to be rewritten
> as well.
> I think that it is not so buggy as it passes all the tests.

Before and after your patch, git_default_config() is called once per
config key. Before the patch, it made sense, but after the patch, it
doesn't anymore, as it loads the whole config file in one call.

I think it's OK to have this as an intermediate patch, but it should be
clear to reviewers.

At the end of your series, git_default_config should become an
argumentless function.

Actually, I'm wondering whether it makes sense to keep
git_default_config as-is, and introduce a new function like
git_load_default_config(void), initially empty. Then, move and change
code from git_default_config(...) to git_load_default_config(), and
finally remove git_default_config(...) once it's empty.

You have several decl-after-statements in your patch. You should have
something like this in config.mak to catch them:

CFLAGS += -Wdeclaration-after-statement -Wall -Werror

There are several (long unsigned int*) casts that seem useless to me.
Useless casts distract the reader, and prevent usefull warnings from the
compiler.

Actually, I'm wondering whether these casts are safe (they cast from
size_t * to ulong *). On Windows 64 bits for example, sizeof(size_t) ==
8 and sizeof(unsigned long) == 4 if google informed me correctly. On a
big-endian machine, this would be totally broken.

It is probably safer to add a new git_config_get_size_t analog to
git_config_get_ulong.

> +	if > +	git_config_get_string("core.notesref", (const char**)&notes_ref_name);

This cast is needed only because notes_ref_name is declared as
non-const, but a better fix would be to make the variable const, and
remove the cast.

The following patch solves these issues (modulo the question above on
cast safety).

diff --git a/cache.h b/cache.h
index e667d92..1271904 100644
--- a/cache.h
+++ b/cache.h
@@ -674,7 +674,7 @@ enum object_creation_mode {
 
 extern enum object_creation_mode object_creation_mode;
 
-extern char *notes_ref_name;
+extern const char *notes_ref_name;
 
 extern int grafts_replace_parents;
 
diff --git a/config.c b/config.c
index 72196a9..c2664c3 100644
--- a/config.c
+++ b/config.c
@@ -669,6 +669,9 @@ int git_config_pathname(const char **dest, const char *var, const char *value)
 static void git_default_core_config(void)
 {
        const char *value = NULL;
+       int abbrev;
+       int level;
+       const char *comment;
        /* This needs a better name */
        git_config_get_bool("core.filemode", &trust_executable_bit);
        git_config_get_bool("core.trustctime", &trust_ctime);
@@ -690,13 +693,11 @@ static void git_default_core_config(void)
        git_config_get_bool("core.logallrefupdates", &log_all_ref_updates);
        git_config_get_bool("core.warnambiguousrefs", &warn_ambiguous_refs);
 
-       int abbrev;
        if (!git_config_get_int("core.abbrev", &abbrev)) {
                if (abbrev >= minimum_abbrev && abbrev <= 40)
                        default_abbrev = abbrev;
        }
 
-       int level;
        if (!git_config_get_int("core.loosecompression", &level)) {
                if (level == -1)
                        level = Z_DEFAULT_COMPRESSION;
@@ -717,7 +718,7 @@ static void git_default_core_config(void)
                        zlib_compression_level = level;
        }
 
-       if (!git_config_get_ulong("core.packedgitwindowsize", (long unsigned int*)&packed_git_window_size)) {
+       if (!git_config_get_ulong("core.packedgitwindowsize", &packed_git_window_size)) {
                int pgsz_x2 = getpagesize() * 2;
 
                /* This value must be multiple of (pagesize * 2) */
@@ -728,8 +729,8 @@ static void git_default_core_config(void)
        }
 
        git_config_get_ulong("core.bigfilethreshold", &big_file_threshold);
-       git_config_get_ulong("core.packedgitlimit", (long unsigned int*)&packed_git_limit);
-       git_config_get_ulong("core.deltabasecachelimit", (long unsigned int*)&delta_base_cache_limit);
+       git_config_get_ulong("core.packedgitlimit", &packed_git_limit);
+       git_config_get_ulong("core.deltabasecachelimit", &delta_base_cache_limit);
 
        if (!git_config_get_value("core.autocrlf", &value)) {
                if (value && !strcasecmp(value, "input")) {
@@ -760,11 +761,10 @@ static void git_default_core_config(void)
                        die("core.autocrlf=input conflicts with core.eol=crlf");
        }
 
-       git_config_get_string("core.notesref", (const char**)&notes_ref_name);
+       git_config_get_string("core.notesref", &notes_ref_name);
        git_config_get_string("core.pager", &pager_program);
        git_config_get_string("core.editor", &editor_program);
 
-       const char *comment;
        if (!git_config_get_string("core.commentchar", &comment)) {
                if (!strcasecmp(comment, "auto"))
                        auto_comment_line_char = 1;
diff --git a/environment.c b/environment.c
index 565f652..21d4dbb 100644
--- a/environment.c
+++ b/environment.c
@@ -56,7 +56,7 @@ enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
 #define OBJECT_CREATION_MODE OBJECT_CREATION_USES_HARDLINKS
 #endif
 enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
-char *notes_ref_name;
+const char *notes_ref_name;
 int grafts_replace_parents = 1;
 int core_apply_sparse_checkout;
 int merge_log_config = -1;

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
