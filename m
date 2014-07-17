From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v9r2 1/2] add `config_set` API for caching config-like
 files
Date: Thu, 17 Jul 2014 16:36:43 +0530
Message-ID: <53C7AE43.5080402@gmail.com>
References: <1405434571-25459-1-git-send-email-tanayabh@gmail.com>	<1405434571-25459-3-git-send-email-tanayabh@gmail.com>	<xmqqk37ewr5r.fsf@gitster.dls.corp.google.com>	<53C665A0.2060705@gmail.com> <vpqvbqxjzfx.fsf@anie.imag.fr>	<53C66E70.3050507@gmail.com> <vpqha2h9tjw.fsf@anie.imag.fr>	<53C6ABEB.3060205@gmail.com> <vpqzjg9z115.fsf@anie.imag.fr>	<53C6C2BD.3030703@gmail.com> <vpqvbqwpalt.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 17 13:06:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7jWX-0004O7-JM
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 13:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757000AbaGQLGu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2014 07:06:50 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:63154 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756363AbaGQLGt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2014 07:06:49 -0400
Received: by mail-pa0-f46.google.com with SMTP id lj1so3178308pab.33
        for <git@vger.kernel.org>; Thu, 17 Jul 2014 04:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=HLL7AvmIzQc9sttyYsAaUN28656nUClSDV+oUDSYS7E=;
        b=i57lGCWKcL12HuLO0/CTxIj/GdAUx9hTayaT91ejEZ/njoJ9Mn0THoOkz2drRXWrAJ
         QavwUld8lMw9sQn8R1+vP+3ce5c1JpoXAMbgd4vnufi5fioqjSS4OBGru5x1nnuLGtDl
         fhihT9rIYQzHz8AbhsdtH3vr1Hj5j9SIrIk8oli5zd5BYHo3WAELCTH7nd3jnVCSb6Px
         ipS0dxKPKWZVrf9Rrb4nMGAm0d2g4cHlwwB+s7c1Nc8/VMPxSZFzZg3WpN0mflLuSXyf
         ShJ2+g8BAQtEkpBqNmG4mbO9cAf4ni4gE71k/R9A+TZztE/kJbbD+awzMZ2aGY+qXbNq
         iA6Q==
X-Received: by 10.68.134.98 with SMTP id pj2mr36130516pbb.98.1405595208391;
        Thu, 17 Jul 2014 04:06:48 -0700 (PDT)
Received: from [127.0.0.1] ([223.176.227.200])
        by mx.google.com with ESMTPSA id qp12sm2900101pdb.82.2014.07.17.04.06.45
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 17 Jul 2014 04:06:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpqvbqwpalt.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253730>

On 7/17/2014 3:31 PM, Matthieu Moy wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
> 
>> I have a question about renaming git_config() to git_config_raw().
>> I was working on a patch and I am getting stuck here.
>> It fails in t1001, t1020 & t4018. The reason for the last test failure
>> is unknown right now. For the first two, it boils down to this,
>>
>> 		git init --bare bare-ancestor-aliased.git &&
>> 		cd bare-ancestor-aliased.git &&
>> 		echo "[alias] aliasedinit = init" >>config &&
>> 		mkdir plain-nested &&
>> 		cd plain-nested &&
>> 		git aliasedinit
> 
> Git tries to read .git/config relative to the current directory, and
> tries to resolve aliases from it. The problem is: if one tries to do
> this from a subdirectory inside the repo, .git/config is not the right
> path, and the alias lookup fails.
> 
> I'll investigate more later.
>

Hmn, this does the trick,
-- 8< --
diff --git a/cache.h b/cache.h
index c67639d..66b52f1 100644
--- a/cache.h
+++ b/cache.h
@@ -1272,6 +1272,7 @@ extern int git_config_from_buf(config_fn_t fn, const char *name,
 			       const char *buf, size_t len, void *data);
 extern void git_config_push_parameter(const char *text);
 extern int git_config_from_parameters(config_fn_t fn, void *data);
+extern int git_config_raw(config_fn_t fn, void *);
 extern int git_config(config_fn_t fn, void *);
 extern int git_config_with_options(config_fn_t fn, void *,
 				   struct git_config_source *config_source,
diff --git a/config.c b/config.c
index d14f761..9e3f99a 100644
--- a/config.c
+++ b/config.c
@@ -1222,11 +1222,36 @@ int git_config_with_options(config_fn_t fn, void *data,
 	return ret;
 }

-int git_config(config_fn_t fn, void *data)
+extern int git_config_raw(config_fn_t fn, void *data)
 {
 	return git_config_with_options(fn, data, NULL, 1);
 }

+int git_configset_iter(struct config_set *cs, config_fn_t fn, void *data)
+{
+	int i;
+	struct string_list *strptr;
+	struct config_set_element *entry;
+	struct hashmap_iter iter;
+	hashmap_iter_init(&cs->config_hash, &iter);
+	while ((entry = hashmap_iter_next(&iter))) {
+		strptr = &entry->value_list;
+		for (i = 0; i < strptr->nr; i++) {
+			if (fn(entry->key, strptr->items[i].string, data) < 0)
+				die("bad config file");
+		}
+	}
+	return 0;
+}
+
+static void git_config_check_init(void);
+
+int git_config(config_fn_t fn, void *data)
+{
+	git_config_check_init();
+	return git_configset_iter(&the_config_set, fn, data);
+}
+
 static struct config_set_element *configset_find_element(struct config_set *cs, const char *key)
 {
 	struct config_set_element k;
@@ -1409,7 +1434,7 @@ static void git_config_check_init(void)
 	if (the_config_set.hash_initialized)
 		return;
 	git_configset_init(&the_config_set);
-	git_config(config_hash_callback, &the_config_set);
+	git_config_raw(config_hash_callback, &the_config_set);
 }

 void git_config_clear(void)
diff --git a/pager.c b/pager.c
index 8b5cbc5..b4237e6 100644
--- a/pager.c
+++ b/pager.c
@@ -177,7 +177,7 @@ int check_pager_config(const char *cmd)
 	c.cmd = cmd;
 	c.want = -1;
 	c.value = NULL;
-	git_config(pager_command_config, &c);
+	git_config_raw(pager_command_config, &c);
 	if (c.value)
 		pager_program = c.value;
 	return c.want;
-- 8< --

The offending part is in git.c, line number 540:

static void execv_dashed_external(const char **argv)
{
	struct strbuf cmd = STRBUF_INIT;
	const char *tmp;
	int status;

	if (use_pager == -1)
		use_pager = check_pager_config(argv[0]);
----------------------------^^^^^^^^^^^^^^^^^^^^^^^^^^^
	commit_pager_choice();


which cause git_config() to be called before handle_alias
can call it in git.c line no 587,

static int run_argv(int *argcp, const char ***argv)
{
	int done_alias = 0;

	while (1) {
		/* See if it's a builtin */
		handle_builtin(*argcp, *argv);

		/* .. then try the external ones */
		execv_dashed_external(*argv);
/* calls git_config() first, skips the .git/config file*/
		/* It could be an alias -- this works around the insanity
		 * of overriding "git log" with "git show" by having
		 * alias.log = show
		 */
		if (done_alias)
			break;
		save_env();
		if (!handle_alias(argcp, argv))
/* does setup_git_directory_gently() before calling git_config() */
			break;
		done_alias = 1;
	}

	return done_alias;
}

I am searching for a more elegant solution to this problem.
Thanks,
Tanay Abhra.
