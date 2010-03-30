From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git cvsimport and case-insensitive config
Date: Tue, 30 Mar 2010 10:29:07 -0700
Message-ID: <7vy6h9vhuk.fsf@alter.siamese.dyndns.org>
References: <hoscv7$hmn$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 30 19:29:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwfFj-0006Ar-0K
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 19:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755552Ab0C3R3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 13:29:17 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57935 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755443Ab0C3R3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 13:29:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B476A6B47;
	Tue, 30 Mar 2010 13:29:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KothyjsHkNG4VTpRYk2ETR29TX4=; b=gK0CXM
	cns3pCA69Mdq+Tk/TaZZuAf/RTKMkghmKi0RujoCnJgrLLoo3kZIaavtu9HJ6iPH
	QNUuSqf7hoF2ddewj1l2VrajpPxYMSZo3YrcN+GTPvTbb7BmMtJhSzW6iyL0Jozp
	T588A1nEKJyQEb3hlQIpso9SMPkCAEO14NMyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LYlsNH+ad3dGcw85txRrtbimfuBfE73m
	EiQDgu9D8xjnyUcVz6QTpXgyS+EV4Si3CFNw0WDolXI0itLsfE6NTtdpK78MY06y
	PZ5Tlh3rGsO+wr9LdWBNc5rQpeQdwQdUaovZOD9ELVHKo3YQI9FhLL65GJyRDtcb
	zcnzmRYf0Gc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 67ED7A6B45;
	Tue, 30 Mar 2010 13:29:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9A470A6B3B; Tue, 30 Mar
 2010 13:29:08 -0400 (EDT)
In-Reply-To: <hoscv7$hmn$1@dough.gmane.org> (Giuseppe Bilotta's message of
 "Tue\, 30 Mar 2010 10\:32\:37 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C0FF423C-3C21-11DF-BBCD-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143582>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> git cvsimport looks for cvsimport.* single-letter keys that match the 
> command-line option (e.g. cvsimport.r for -r). However, since there are some 
> single-letter options which only differ by case (a vs A, r vs R) if you set 
> either you get annoying messages (and potentially also odd results, although 
> I haven't come across these yet).

Ouch.

The only sensible solution in the longer term is to eventually rename them
to spell them out e.g. cvsimport.remote vs cvsimport.userevisionmap.

The transition cost would be the same for either approach.

 (1) Introduce long options for cvsimport; the code already uses
     Getopt::Long, so this shouldn't be too bad.

 (2) Add case-sensitive variant of "git config -l" that shows the config
     variable names in the original case.

 (3) Upon startup, use "git config -l -f $GIT_DIR/config" to check for
     historical short name (e.g. "cvsimport.a" or "cvsimport.A").  If
     there are, map them to longer name, remove the short keys and write
     the conversion back to the configuration file.  You might want to do
     the same for "$HOME/.gitconfig" as well.

 (4) Then the rest of the code can stay the same.

Step (2) may look like this.  Note that I made this "list with case"
hidden and inaccessible on purpose, as this is primarily to write a tool
to recover from mistakes like this.

 builtin/config.c |   10 +++++++++-
 cache.h          |    1 +
 config.c         |   12 +++++++++---
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 4bc46b1..3684c3a 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -41,6 +41,7 @@ static int end_null;
 #define ACTION_SET_ALL (1<<12)
 #define ACTION_GET_COLOR (1<<13)
 #define ACTION_GET_COLORBOOL (1<<14)
+#define ACTION_LIST_KEYS_WITH_CASE (1<<15)
 
 #define TYPE_BOOL (1<<0)
 #define TYPE_INT (1<<1)
@@ -73,6 +74,11 @@ static struct option builtin_config_options[] = {
 	OPT_BIT(0, "path", &types, "value is a path (file or directory name)", TYPE_PATH),
 	OPT_GROUP("Other"),
 	OPT_BOOLEAN('z', "null", &end_null, "terminate values with NUL byte"),
+	{
+		OPTION_BIT, 0, "list-keys-with-case", &actions,
+		NULL, "list for conversion", PARSE_OPT_NOARG|PARSE_OPT_HIDDEN,
+		NULL, ACTION_LIST_KEYS_WITH_CASE,
+	},
 	OPT_END(),
 };
 
@@ -397,7 +403,9 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 			usage_with_options(builtin_config_usage, builtin_config_options);
 		}
 
-	if (actions == ACTION_LIST) {
+	if (actions == ACTION_LIST || actions == ACTION_LIST_KEYS_WITH_CASE) {
+		if (actions == ACTION_LIST_KEYS_WITH_CASE)
+			config_return_keys_with_case = 1;
 		check_argc(argc, 0, 0);
 		if (git_config(show_all_config, NULL) < 0) {
 			if (config_exclusive_filename)
diff --git a/cache.h b/cache.h
index 6dcb100..4320288 100644
--- a/cache.h
+++ b/cache.h
@@ -953,6 +953,7 @@ extern int git_config_system(void);
 extern int git_config_global(void);
 extern int config_error_nonbool(const char *);
 extern const char *config_exclusive_filename;
+extern int config_return_keys_with_case;
 
 #define MAX_GITNAME (1000)
 extern char git_default_email[MAX_GITNAME];
diff --git a/config.c b/config.c
index 6963fbe..c548cec 100644
--- a/config.c
+++ b/config.c
@@ -17,6 +17,11 @@ static int config_file_eof;
 static int zlib_compression_seen;
 
 const char *config_exclusive_filename = NULL;
+/*
+ * only used for config --list-case-sensitive-keys for recovering
+ * from mistakes.
+ */
+int config_return_keys_with_case;
 
 static int get_next_char(void)
 {
@@ -123,7 +128,7 @@ static int get_value(config_fn_t fn, void *data, char *name, unsigned int len)
 			break;
 		if (!iskeychar(c))
 			break;
-		name[len++] = tolower(c);
+		name[len++] = config_return_keys_with_case ? c : tolower(c);
 		if (len >= MAXNAME)
 			return -1;
 	}
@@ -193,7 +198,8 @@ static int get_base_var(char *name)
 			return -1;
 		if (baselen > MAXNAME / 2)
 			return -1;
-		name[baselen++] = tolower(c);
+		name[baselen++] = config_return_keys_with_case
+			? c : tolower(c);
 	}
 }
 
@@ -246,7 +252,7 @@ static int git_parse_file(config_fn_t fn, void *data)
 		}
 		if (!isalpha(c))
 			break;
-		var[baselen] = tolower(c);
+		var[baselen] = config_return_keys_with_case ? c : tolower(c);
 		if (get_value(fn, data, var, baselen+1) < 0)
 			break;
 	}
