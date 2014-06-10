From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v14 24/40] receive-pack.c: use a reference transaction
 for updating the refs
Date: Tue, 10 Jun 2014 16:18:41 -0700
Message-ID: <20140610231841.GC8557@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
 <1402093758-3162-25-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 01:18:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuVJZ-0003pv-7a
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 01:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753259AbaFJXSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 19:18:45 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:61711 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937AbaFJXSo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 19:18:44 -0400
Received: by mail-pa0-f48.google.com with SMTP id bj1so1196800pad.7
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 16:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=X9AZFKNrBuOm312y7PvZwwNDcS1Kx/TqdgL3IqwK17k=;
        b=fJdEhfj6tOMRQJL2QdSOFgZfLlHe0Bysqp6Wx6tcgyW0WnRi78wBhQtjVox7ZknSjM
         rsg3+6m5T5/HED4akcbpl5Sh1C6tScUYzlz0W4NUASLa6vG8vsf/D9lJpQEJYqxs/vF2
         EOrlmIZjVngatWzI/LK0B/5NzxdM96owzi/UmVLbEvMTU3pAq12q8AtataErBvcoG2A2
         P/wkp8jhcHjg1rigSFK9iYtFJNJtYoZTS1nOQSMTg0W/t4uI+EZo4EevaBadI0wOIz0f
         5O0nkt6bldcsj5wPg+ShktdCKPvIkkyM+QcHicOhycSlV7RLH/AO46aklogx3IP1vRr5
         N7xg==
X-Received: by 10.68.174.33 with SMTP id bp1mr325570pbc.74.1402442324108;
        Tue, 10 Jun 2014 16:18:44 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id hb10sm71413670pbd.75.2014.06.10.16.18.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 10 Jun 2014 16:18:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1402093758-3162-25-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251321>

Ronnie Sahlberg wrote:

> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -46,6 +46,7 @@ static void *head_name_to_free;
>  static int sent_capabilities;
>  static int shallow_update;
>  static const char *alt_shallow_file;
> +static struct string_list error_strings = STRING_LIST_INIT_DUP;
[...]
> @@ -576,19 +576,31 @@ static const char *update(struct command *cmd, struct shallow_info *si)
[...]
> +		transaction = ref_transaction_begin(&err);
> +		if (!transaction ||
> +		    ref_transaction_update(transaction, namespaced_name,
> +					   new_sha1, old_sha1, 0, 1, &err) ||
> +		    ref_transaction_commit(transaction, "push", &err)) {
> +
> +			const char *str;
> +			string_list_append(&error_strings, err.buf);
> +			str = error_strings.items[error_strings.nr - 1].string;
[...]
> +			return str;
[...]
> @@ -1215,5 +1227,6 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
>  		packet_flush(1);
>  	sha1_array_clear(&shallow);
>  	sha1_array_clear(&ref);
> +	string_list_clear(&error_strings, 0);
>  	return 0;

I think it's okay to let error strings accumulate like this because
there will not be too many of them.  Still I wonder, would it work to
change the convention to transfer ownership of the string to the caller?

Ultimately 'commands' is leaked so we could even avoid the strdups but
I'd rather leave it possible to clean up.

Something like this:

diff --git i/builtin/receive-pack.c w/builtin/receive-pack.c
index 13f4a63..d8ab7b2 100644
--- i/builtin/receive-pack.c
+++ w/builtin/receive-pack.c
@@ -46,7 +46,6 @@ static void *head_name_to_free;
 static int sent_capabilities;
 static int shallow_update;
 static const char *alt_shallow_file;
-static struct string_list error_strings = STRING_LIST_INIT_DUP;
 
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
@@ -195,7 +194,7 @@ static void write_head_info(void)
 
 struct command {
 	struct command *next;
-	const char *error_string;
+	char *error_string;
 	unsigned int skip_update:1,
 		     did_not_exist:1;
 	int index;
@@ -469,7 +468,7 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 	return 0;
 }
 
-static const char *update(struct command *cmd, struct shallow_info *si)
+static char *update(struct command *cmd, struct shallow_info *si)
 {
 	const char *name = cmd->ref_name;
 	struct strbuf namespaced_name_buf = STRBUF_INIT;
@@ -589,12 +588,9 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 					   new_sha1, old_sha1, 0, 1, &err) ||
 		    ref_transaction_commit(transaction, "push", &err)) {
 
-			const char *str;
-			string_list_append(&error_strings, err.buf);
-			str = error_strings.items[error_strings.nr - 1].string;
-			strbuf_release(&err);
-
+			char *str = strbuf_detach(&err, NULL);
 			ref_transaction_free(transaction);
+
 			rp_error("%s", str);
 			return str;
 		}
@@ -659,6 +655,9 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
 	char cmd_oldh[41], cmd_newh[41], dst_oldh[41], dst_newh[41];
 	int flag;
 
+	if (cmd->error_string)
+		die("BUG: check_alised_update called with failed cmd");
+
 	strbuf_addf(&buf, "%s%s", get_git_namespace(), cmd->ref_name);
 	dst_name = resolve_ref_unsafe(buf.buf, sha1, 0, &flag);
 	strbuf_release(&buf);
@@ -670,7 +669,7 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
 	if (!dst_name) {
 		rp_error("refusing update to broken symref '%s'", cmd->ref_name);
 		cmd->skip_update = 1;
-		cmd->error_string = "broken symref";
+		cmd->error_string = xstrdup("broken symref");
 		return;
 	}
 
@@ -696,8 +695,9 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
 		 cmd->ref_name, cmd_oldh, cmd_newh,
 		 dst_cmd->ref_name, dst_oldh, dst_newh);
 
-	cmd->error_string = dst_cmd->error_string =
-		"inconsistent aliased update";
+	cmd->error_string = xstrdup("inconsistent aliased update");
+	free(dst_cmd->error_string);
+	dst_cmd->error_string = xstrdup("inconsistent aliased update");
 }
 
 static void check_aliased_updates(struct command *commands)
@@ -745,7 +745,9 @@ static void set_connectivity_errors(struct command *commands,
 		if (!check_everything_connected(command_singleton_iterator,
 						0, &singleton))
 			continue;
-		cmd->error_string = "missing necessary objects";
+		if (cmd->error_string)	/* can't happen */
+			continue;
+		cmd->error_string = xstrdup("missing necessary objects");
 	}
 }
 
@@ -782,9 +784,9 @@ static void reject_updates_to_hidden(struct command *commands)
 		if (cmd->error_string || !ref_is_hidden(cmd->ref_name))
 			continue;
 		if (is_null_sha1(cmd->new_sha1))
-			cmd->error_string = "deny deleting a hidden ref";
+			cmd->error_string = xstrdup("deny deleting a hidden ref");
 		else
-			cmd->error_string = "deny updating a hidden ref";
+			cmd->error_string = xstrdup("deny updating a hidden ref");
 	}
 }
 
@@ -798,8 +800,11 @@ static void execute_commands(struct command *commands,
 	struct iterate_data data;
 
 	if (unpacker_error) {
-		for (cmd = commands; cmd; cmd = cmd->next)
-			cmd->error_string = "unpacker error";
+		for (cmd = commands; cmd; cmd = cmd->next) {
+			if (cmd->error_string)	/* can't happen */
+				continue;
+			cmd->error_string = xstrdup("unpacker error");
+		}
 		return;
 	}
 
@@ -812,8 +817,9 @@ static void execute_commands(struct command *commands,
 
 	if (run_receive_hook(commands, "pre-receive", 0)) {
 		for (cmd = commands; cmd; cmd = cmd->next) {
-			if (!cmd->error_string)
-				cmd->error_string = "pre-receive hook declined";
+			if (cmd->error_string)
+				continue;
+			cmd->error_string = xstrdup("pre-receive hook declined");
 		}
 		return;
 	}
@@ -1091,7 +1097,8 @@ static void update_shallow_info(struct command *commands,
 		if (is_null_sha1(cmd->new_sha1))
 			continue;
 		if (ref_status[cmd->index]) {
-			cmd->error_string = "shallow update not allowed";
+			free(cmd->error_string);
+			cmd->error_string = xstrdup("shallow update not allowed");
 			cmd->skip_update = 1;
 		}
 	}
@@ -1227,6 +1234,5 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		packet_flush(1);
 	sha1_array_clear(&shallow);
 	sha1_array_clear(&ref);
-	string_list_clear(&error_strings, 0);
 	return 0;
 }
