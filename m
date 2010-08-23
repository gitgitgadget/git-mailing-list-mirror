From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 1/5] fmt_merge_msg: Change fmt_merge_msg API to
 accept shortlog_len
Date: Mon, 23 Aug 2010 17:00:31 -0500
Message-ID: <20100823220031.GA1308@burratino>
References: <1282494398-20542-1-git-send-email-artagnon@gmail.com>
 <1282494398-20542-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 00:02:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Onf6C-0005sE-IG
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 00:02:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754781Ab0HWWCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 18:02:23 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39721 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754240Ab0HWWCV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 18:02:21 -0400
Received: by bwz11 with SMTP id 11so4342104bwz.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 15:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=owBGEVsdXpxYCZNlEm4ZEZb0lG4rzE4v5cKseYniW+I=;
        b=Cdbn+oa8kUjEvRRMxh0Iz9cS1tiFf3lesA2JZ1DA9Gzg+KhfQPum/6Q7PYmGPbZs5G
         lOj4QcqBFpsX1GTnbDZOEYLAfqRu3I3Uuqtlm8FWjO/2ysBAe3HwXXZiozMgOPdXKkdc
         7Pf4Lpk/vgENYMIK5ht4PXQBSLB/2A23Zr1ak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Mqki0uHwQ829v1ABSfpy/UhOhkZoHTS0WBErREPlu+9DfJUTih6LKvm0OlYelX792K
         jHRHWP3EXPfgfojAMZQytz07/81KLMU+Auwjm25BiCU1xWZWxWxw2XWXsayhzL/JJDCQ
         /eqYrmeCWxaZCW3WyeloSNb8L/DU9tqpcRRj0=
Received: by 10.213.64.76 with SMTP id d12mr3559163ebi.8.1282600939590;
        Mon, 23 Aug 2010 15:02:19 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id a48sm11560991eei.0.2010.08.23.15.02.16
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 23 Aug 2010 15:02:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1282494398-20542-2-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154263>

Ramkumar Ramachandra wrote:

> Update the API of the fmt_merge_msg function to replace the the
> merge_summary argument with a new shortlog_len argument.

Even more, actually:

> +++ b/builtin.h
> @@ -14,9 +14,8 @@ extern const char git_more_info_string[];
>  extern void list_common_cmds_help(void);
>  extern const char *help_unknown_cmd(const char *cmd);
>  extern void prune_packed_objects(int);
> -extern int fmt_merge_msg(int merge_summary, struct strbuf *in,
> -	struct strbuf *out);
> -extern int fmt_merge_msg_shortlog(struct strbuf *in, struct strbuf *out);
> +extern int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
> +			 int merge_title, int shortlog_len);

This combines the public functions.  Nice, but probably worth a
mention in the log message.

The API does not make the sense of the merge_title argument clear:
should it be 1 when the caller provides a title or when fmt_merge_msg
should provide one?  There is not much I can see to do about that;
I'd just suggest making it clear in the commit message (so it can
be mentioned in the API docs, once they're written :)).

> @@ -357,9 +354,10 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
>  		die_errno("could not read input file");
>  	if (message) {
>  		strbuf_addstr(&output, message);
> -		ret = fmt_merge_msg_shortlog(&input, &output);
> +		ret = fmt_merge_msg(&input, &output, 0, 20);
>  	} else {
> -		ret = fmt_merge_msg(merge_summary, &input, &output);
> +		ret = fmt_merge_msg(&input, &output, 1,
> +				    merge_summary ? 20 : 0);

Could be further simplified:

	if (message)
		strbuf_addstr(&output, message);
	ret = fmt_merge_msg(&input, &output,
				message ? 0 : 1,
				merge_summary ? 20 : 0);

Not sure if that helps or not.

A part of me wishes that the constant 20 wouldn't be duplicated so much.
Would something like

	#define DEFAULT_MERGE_SHORTLOG_LEN 20

make sense?

> +++ b/builtin/merge.c
> @@ -1014,9 +1014,10 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  			merge_name(argv[i], &merge_names);
>  
>  		if (have_message && option_log)
> -			fmt_merge_msg_shortlog(&merge_names, &merge_msg);
> +			fmt_merge_msg(&merge_names, &merge_msg, 0, 20);
>  		else if (!have_message)
> -			fmt_merge_msg(option_log, &merge_names, &merge_msg);
> +			fmt_merge_msg(&merge_names, &merge_msg, 1,
> +				      option_log ? 20: 0);

Likewise.

The rest looks good.  So except for the commit message,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

Here are the cleanups I mentioned.  Except for the #define, they
probably don't belong in this patch.
---
diff --git a/builtin.h b/builtin.h
index 7d18106..09b94ea 100644
--- a/builtin.h
+++ b/builtin.h
@@ -7,6 +7,8 @@
 #include "commit.h"
 #include "notes.h"
 
+#define DEFAULT_MERGE_LOG_LEN 20
+
 extern const char git_version_string[];
 extern const char git_usage_string[];
 extern const char git_more_info_string[];
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 4ed728a..7f06b95 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -352,13 +352,13 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 
 	if (strbuf_read(&input, fileno(in), 0) < 0)
 		die_errno("could not read input file");
-	if (message) {
+
+	if (message)
 		strbuf_addstr(&output, message);
-		ret = fmt_merge_msg(&input, &output, 0, 20);
-	} else {
-		ret = fmt_merge_msg(&input, &output, 1,
-				    merge_summary ? 20 : 0);
-	}
+	ret = fmt_merge_msg(&input, &output,
+			    message ? 0 : 1,
+			    merge_summary ? DEFAULT_MERGE_LOG_LEN : 0);
+
 	if (ret)
 		return ret;
 	write_in_full(STDOUT_FILENO, output.buf, output.len);
diff --git a/builtin/merge.c b/builtin/merge.c
index 70ee412..d797853 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1000,15 +1000,12 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		for (i = 0; i < argc; i++)
 			merge_name(argv[i], &merge_names);
 
-		if (have_message && option_log)
-			fmt_merge_msg(&merge_names, &merge_msg, 0, 20);
-		else if (!have_message)
-			fmt_merge_msg(&merge_names, &merge_msg, 1,
-				      option_log ? 20: 0);
-
-
-		if (!(have_message && !option_log) && merge_msg.len)
-			strbuf_setlen(&merge_msg, merge_msg.len-1);
+		if (!have_message || option_log) {
+			fmt_merge_msg(&merge_names, &merge_msg, !have_message,
+				      option_log ? DEFAULT_MERGE_LOG_LEN : 0);
+			if (merge_msg.len)
+				strbuf_setlen(&merge_msg, merge_msg.len - 1);
+		}
 	}
 
 	if (head_invalid || !argc)
-- 
