From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: wishlist bugreport: make limit configurable for
 do_fmt_merge_msg (merge.log)
Date: Fri, 20 Aug 2010 03:16:41 -0500
Message-ID: <20100820081641.GA32127@burratino>
References: <20100820020127.GG22469@onerussian.com>
 <20100820064741.GC12794@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yaroslav Halchenko <debian@onerussian.com>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 10:18:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmMo8-0001GM-JZ
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 10:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426Ab0HTIS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 04:18:26 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49887 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849Ab0HTISY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 04:18:24 -0400
Received: by iwn5 with SMTP id 5so564063iwn.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 01:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=BLFgg/+JojwGM738dLVcHqNPEsHjugk2STivEzj4wRQ=;
        b=V9qT3I7n3SWFO2ILwv9eXHdesxIf3EW83nKU2QthVa940zFlHx9c7pxe2zDojSw+bR
         A3+WRgrkPtLnfu2aZhODzl+xTOiXsJ5VfP/EZyl0fPVObz4E6HxSKvKNPkzT9MjVYvsH
         mcOBzOF0NUIKLFV5UNjvc/mzQxiSc10W2STnE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gaWVgAmMHb0ad1eErar8a34kpumxBM+WZmu+K2tZWs/A43zR5N2BT2wfgdj4EjrYVN
         ow+iExzKIaqF4uWh8pr6uNYoTTUKdQml8S2JyBG2LHfNhcmoDM/yWjIqB+3uWrIHlsGz
         Tof0PkYbd6Ds5+AXseaZP/lUDzSwjkNV38JhY=
Received: by 10.231.146.129 with SMTP id h1mr1095815ibv.181.1282292303740;
        Fri, 20 Aug 2010 01:18:23 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id h8sm2376196ibk.21.2010.08.20.01.18.23
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 01:18:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100820064741.GC12794@kytes>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153984>

Ramkumar Ramachandra wrote:

>     fmt-merge-msg: Make the number of log entries in shortlog configurable
>     
>     Introduce a new configuration option called merge.logLimit to limit
>     the number of log entries displayed in the shortlog of a merge commit
>     configurable. Set the default value to 20.

Neat.  Sign-off?

> +++ b/builtin/fmt-merge-msg.c
> @@ -22,6 +23,8 @@ static int fmt_merge_msg_config(const char *key, const char *value, void *cb)
>  	}
>  	if (!found_merge_log && !strcmp("merge.summary", key))
>  		merge_summary = git_config_bool(key, value);
> +	if (!strcmp("merge.logLimit", key))
> +		log_limit = git_config_int(key, value);

Maybe something like the following would be good on top (or maybe not;
you decide).

-- 8< --
Subject: fmt-merge-msg --log-limit to override merge.loglimit configuration

Yes, one can already use "git -c merge.loglimit=n fmt-merge-msg", but
maybe providing an option name makes it more obvious that this can
be overridden on the command-line.

This also provides --log-limit=0 / "[merge] loglimit = 0" to not limit
the number of commits summarized at all, which I would expect to
be the most interesting case.  So you can use
"git fmt-merge-msg --log-limit=0" in your scripts to get a message
like

	Merge branch 'long-topic'

	 * log-topic:
	   commit 1
	   commit 2
[...]
	   commit 1001
	   commit 1002

and not to limit the number of commits summarized at all.

This patch does not propagate the option from "git merge" yet.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Also untested.  I still haven't figured out the context where this
would be most useful, just thought it sounded like a fun idea.

diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index a585dbe..3066392 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -9,8 +9,8 @@ git-fmt-merge-msg - Produce a merge commit message
 SYNOPSIS
 --------
 [verse]
-'git fmt-merge-msg' [--log | --no-log] <$GIT_DIR/FETCH_HEAD
-'git fmt-merge-msg' [--log | --no-log] -F <file>
+'git fmt-merge-msg' [--log | --no-log] [--log-limit=<n>] <$GIT_DIR/FETCH_HEAD
+'git fmt-merge-msg' [--log | --no-log] [--log-limit=<n>] -F <file>
 
 DESCRIPTION
 -----------
@@ -38,6 +38,11 @@ OPTIONS
 	Synonyms to --log and --no-log; these are deprecated and will be
 	removed in the future.
 
+--log-limit <n>::
+	Truncate --log output after <n> lines, instead of 20.  This
+	overrides the merge.loglimit configuration.  If <n> is 0,
+	do not truncate --log output at all.
+
 -F <file>::
 --file <file>::
 	Take the list of merged objects from <file> instead of
@@ -54,6 +59,11 @@ merge.summary::
 	Synonym to `merge.log`; this is deprecated and will be removed in
 	the future.
 
+merge.loglimit::
+	How many commits (at maximum) to print from each merge
+	parent when the `--log` option is used.  The default is 20.
+	Can be overridden by the `--log-limit` option.
+
 SEE ALSO
 --------
 linkgit:git-merge[1]
diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index a403155..fd861b8 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -10,6 +10,11 @@ merge.log::
 	Whether to include summaries of merged commits in newly created
 	merge commit messages. False by default.
 
+merge.loglimit::
+	How many merged commits to summarize in the merge message if
+	`--log` is used.  The default is 20.  See also
+	linkgit:git-fmt-merge-msg[1].
+
 merge.renameLimit::
 	The number of files to consider when performing rename detection
 	during a merge; if not specified, defaults to the value of
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 2c1d15b..e1aefa7 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -7,7 +7,7 @@
 #include "string-list.h"
 
 static const char * const fmt_merge_msg_usage[] = {
-	"git fmt-merge-msg [--log|--no-log] [--file <file>]",
+	"git fmt-merge-msg [--log|--no-log] [--log-limit=<num>] [--file <file>]",
 	NULL
 };
 
@@ -172,7 +172,7 @@ static void shortlog(const char *name, unsigned char *sha1,
 			continue;
 
 		count++;
-		if (subjects.nr > log_limit)
+		if (log_limit && subjects.nr > log_limit)
 			continue;
 
 		format_commit_message(commit, "%s", &sb, &ctx);
@@ -185,13 +185,13 @@ static void shortlog(const char *name, unsigned char *sha1,
 			string_list_append(&subjects, strbuf_detach(&sb, NULL));
 	}
 
-	if (count > log_limit)
+	if (log_limit && count > log_limit)
 		strbuf_addf(out, "\n* %s: (%d commits)\n", name, count);
 	else
 		strbuf_addf(out, "\n* %s:\n", name);
 
 	for (i = 0; i < subjects.nr; i++)
-		if (i >= log_limit)
+		if (log_limit && i >= log_limit)
 			strbuf_addf(out, "  ...\n");
 		else
 			strbuf_addf(out, "  %s\n", subjects.items[i].string);
@@ -327,6 +327,8 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 		{ OPTION_BOOLEAN, 0, "summary", &merge_summary, NULL,
 		  "alias for --log (deprecated)",
 		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
+		OPT_INTEGER(0, "log-limit", &log_limit,
+			"truncate shortlog after <n> lines (0 for no limit)"),
 		OPT_FILENAME('F', "file", &inpath, "file to read from"),
 		OPT_END()
 	};
-- 
