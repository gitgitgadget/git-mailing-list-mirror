From: Alex Kuleshov <kuleshovmail@gmail.com>
Subject: Re: Re*: [PATCH] change contract between system_path and it's callers
Date: Tue, 25 Nov 2014 01:53:35 +0600
Message-ID: <87ppcc4b2g.fsf@gmail.com>
References: <87mw7gae8k.fsf@gmail.com> <1416838063-16797-1-git-send-email-kuleshovmail@gmail.com> <xmqqoarwwfz1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 24 21:07:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xszv0-00045x-75
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 21:07:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754389AbaKXUH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 15:07:26 -0500
Received: from mail-lb0-f169.google.com ([209.85.217.169]:50088 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313AbaKXUHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 15:07:25 -0500
Received: by mail-lb0-f169.google.com with SMTP id p9so7014543lbv.14
        for <git@vger.kernel.org>; Mon, 24 Nov 2014 12:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=references:from:to:cc:subject:date:in-reply-to:message-id
         :mime-version:content-type;
        bh=VebzpPCr3TsLjiGuN3r5ZBN5N0Z+DKV7ixey6UgFQdI=;
        b=CQ/G9RJ2W4XNRd65+KkKVeIBKOv2Jx/Ic+BZBlvsYkOMwkETLwJgQBVnfsDXKQMPwi
         eHTtUHFnl/1zDKmEodK7kWUnA+qwoIS70IebxK8culmVts1cVTfiqLgSrkHgpaU2rmjl
         gF5bSwia4H0kBlFwIAVZj1z7KcZ+a8h91Z2KGNC6t/URGTbJ0OevrQi5gRdzgCkezmHx
         7RE+UG8Q4t74xtEZRix/DHBIM6sehVQ/mVzRxjJmyUrZHh+PkxC8xiLG/4RymG/I3oTK
         V5nYbOHG40Rt+PeD1jXrzmIjazlLJ6JPFEuczZsw0A1Vl+cZDhKXhMeeygjz4rMmKMCh
         oZPQ==
X-Received: by 10.112.168.97 with SMTP id zv1mr22675606lbb.6.1416859644239;
        Mon, 24 Nov 2014 12:07:24 -0800 (PST)
Received: from alex-desktop ([92.46.67.170])
        by mx.google.com with ESMTPSA id ei11sm2670574lad.18.2014.11.24.12.07.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Nov 2014 12:07:23 -0800 (PST)
In-reply-to: <xmqqoarwwfz1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260142>


Junio C Hamano <gitster@pobox.com> @ 2014-11-25 01:33 ALMT:

>> -static const char *git_etc_gitattributes(void)
>> +static char *git_etc_gitattributes(void)
>
> Hmph, I think this should keep returning "const char *", as the
> caller is not expected to free the pointer or write into the memory
> held by the returned string.  The same applies to the change of the
> type in "struct git_config_source".
>
> The change in the semantics of system_path() made the "get once and
> keep returning it" this function does safer and correct, but this
> function itself did not change any behaviour from its caller's point
> of view.

Understand, will fix it.

>
>>  {
>> -	static const char *system_wide;
>> +	static char *system_wide;
>>  	if (!system_wide)
>>  		system_wide = system_path(ETC_GITATTRIBUTES);
>>  	return system_wide;
>
>
>> @@ -489,7 +489,9 @@ static void bootstrap_attr_stack(void)
>>  	attr_stack = elem;
>>
>>  	if (git_attr_system()) {
>> -		elem = read_attr_from_file(git_etc_gitattributes(), 1);
>> +		char *etc_attributes = git_etc_gitattributes();
>> +		elem = read_attr_from_file(etc_attributes, 1);
>> +		free(etc_attributes);
>
> And freeing here is actively wrong, I think.  You are freeing the
> piece of memory still pointed by "static char *system_wide" in the
> function git_etc_gitattributes(); when it is called again, the
> caller will get a pointer into the memory you have freed here.

Why? If i understand correctly we don't use etc_attributes anymore in
this function and if we'll call this function again
git_etc_gitattributes will create new pointer and system_path alloc
memory for it or i'm wrong with it?

>
>> diff --git a/builtin/config.c b/builtin/config.c
>> index 15a7bea..266d42b 100644
>> --- a/builtin/config.c
>> +++ b/builtin/config.c
>> @@ -575,8 +575,14 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>>  		if (given_config_source.blob)
>>  			die("editing blobs is not supported");
>>  		git_config(git_default_config, NULL);
>> -		config_file = xstrdup(given_config_source.file ?
>> -				      given_config_source.file : git_path("config"));
>> +
>> +		if (use_system_config)
>> +			config_file = given_config_source.file ?
>> +							given_config_source.file : git_path("config");
>> +		else
>> +			config_file = xstrdup(given_config_source.file ?
>> +								  given_config_source.file : git_path("config"));
>> +
>
> Sorry, but I do not understand this change.
>
> Why do you need "if use-system-config, do not allocate" here and
> then later everywhere "if use-system-config, free it"?  I would
> understand if the change were "earlier we had mixture of borrowed
> and owned strings, but we make sure we always own the string by
> running xstrdup() in the caller when we used to let this function
> borrow, so that we can always free() before returning from here",
> or something.
>
> For example, in the original code, use_local_config codepath uses
> git_pathdup(), which is an allocated piece of memory, to initialize
> given_config_source.file.  Doesn't it need to be freed?
>
> Even if it is not in the use_system_config mode, if
> given_config_source.file is not an absolute path, we store a copy of
> prefix-filename result to given_config_source.file.  Doesn't it need
> to be freed?
>
> I think the implementation strategy you took makes the result
> unnecessarily messy and error prone.  Let's step back a bit.
>
> When you have code that sometimes borrows memory and sometimes owns
> memory, writing the clean-up part like this is error prone:
>
> 	char *var;
>
> 	if (A)
> 		var = borrowed memory;
> 	else if (B)
> 		var = borrowed memory;
> 	else if (C)
> 		var = xstrdup(borrowed memory);
> 	else
> 		var = borrowed memory;
>
> 	use var; /* a loong piece of code in reality */
>
> 	if (C)
>         	free(var);
>
> because the set-up part can and will change over time as the code
> evolves.  If written this way:
>
> 	char *var, *to_free = NULL;
>
> 	if (A)
> 		var = borrowed memory;
> 	else if (B)
> 		var = borrowed memory;
> 	else if (C)
> 		to_free = var = xstrdup(borrowed memory);
> 	else
> 		var = borrowed memory;
>
> 	use var; /* a loong piece of code in reality */
>
> 	free(to_free);
>
> the clean-up part would not have to worry how the set-up part
> decided when to borrow memory and when to own memory.  Another way
> to do so would obviously be:
>
> 	char *var;
>
> 	if (A)
> 		var = xstrdup(borrowed memory);
> 	else if (B)
> 		var = xstrdup(borrowed memory);
> 	else if (C)
> 		var = xstrdup(borrowed memory);
> 	else
> 		var = xstrdup(borrowed memory);
>
> 	use var; /* a loong piece of code in reality */
>
>        	free(var);
>
> to always own the memory, but depending on the original code, it may
> make the result more inefficient and the patch more noisy.
>
> This is especially true when the clean-up part is spread all over
> the place like your patch does, i.e. the "use var" part of the code
> looks like
>
> 	if (X) {
>         	... a looong piece of code to use var ...
> 	        if (C)
>                 	free(var);
> 	} else if (Y) {
>         	... a looong piece of code to use var ...
> 	        if (C)
>                 	free(var);
>         } else {
>         	... a looong piece of code to use var ...
> 	        if (C)
>                 	free(var);
> 	}
>
> which is simply unmaintainable.  Better to make "use var" and the
> clean-up part structured more like this, using the to_free trick:
>
> 	if (X) {
>         	... a looong piece of code to use var ...
> 		goto cleanup;
> 	} else if (Y) {
>         	... a looong piece of code to use var ...
> 		goto cleanup;
>         } else {
>         	... a looong piece of code to use var ...
> 		goto cleanup;
> 	}
>
> 	cleanup:
> 		free(to_free);
>

Will look again on it tomorrow and hope send new patch (sorry deep night
today here), anyway thanks for great explanation.

>> diff --git a/builtin/help.c b/builtin/help.c
>> index b3c818e..20ffbb1 100644
>> --- a/builtin/help.c
>> +++ b/builtin/help.c
>> @@ -326,7 +326,8 @@ static void setup_man_path(void)
>>  	 * old_path, the ':' at the end will let 'man' to try
>>  	 * system-wide paths after ours to find the manual page. If
>>  	 * there is old_path, we need ':' as delimiter. */
>> -	strbuf_addstr(&new_path, system_path(GIT_MAN_PATH));
>> +	char *git_man_path = system_path(GIT_MAN_PATH);
>
> Defile variable in the definition block above to avoid future
> decl-after-stmt, i.e.
>
> 	 const char *old_path = getenv("MANPATH");
> 	+char *git_man_path = system_path(GIT_MAN_PATH);
>
> 	 /* We should always put ...
>
>> +	strbuf_addstr(&new_path, git_man_path);
>
> And better free it immediately after you are done, instead of at the
> end of the function.

Will fix it.

>
>>  	strbuf_addch(&new_path, ':');
>>  	if (old_path)
>>  		strbuf_addstr(&new_path, old_path);
>> @@ -334,6 +335,7 @@ static void setup_man_path(void)
>>  	setenv("MANPATH", new_path.buf, 1);
>>
>>  	strbuf_release(&new_path);
>> +	free(git_man_path);
>>  }
>
>> -static void get_html_page_path(struct strbuf *page_path, const char *page)
>> +static void get_html_page_path(struct strbuf *page_path, const char *page, char *html_path)
>>  {
>>  	struct stat st;
>> -	if (!html_path)
>> -		html_path = system_path(GIT_HTML_PATH);
>>
>>  	/* Check that we have a git documentation directory. */
>>  	if (!strstr(html_path, "://")) {
>>  		if (stat(mkpath("%s/git.html", html_path), &st)
>> -		    || !S_ISREG(st.st_mode))
>> -			die("'%s': not a documentation directory.", html_path);
>> +				|| !S_ISREG(st.st_mode)){
>> +			printf("'%s': not a documentation directory.\n", html_path);
>> +			free(html_path);
>> +			exit(1);
>
> This is an unnecessary churn, and an unwarranted change to the
> externally visible behaviour.  die() gives its message to the
> standard error stream (not to the standard output stream), and exits
> with 128 (not with 1).
>
> We are exiting immediately after; it is not worth changing the API
> to the caller or external behaviour, only to free(html_path)
> conditionally.

So how can i free html_path here if when i'll return die instead exit? I
can't use free(html_path) before/after die call.

>
>> diff --git a/builtin/init-db.c b/builtin/init-db.c
>> index 2619ca5..6f36f3f 100644
>> --- a/builtin/init-db.c
>> +++ b/builtin/init-db.c
>> @@ -126,11 +126,17 @@ static void copy_templates(const char *template_dir)
>>  		template_dir = init_db_template_dir;
>>  	if (!template_dir)
>>  		template_dir = system_path(DEFAULT_GIT_TEMPLATE_DIR);
>> -	if (!template_dir[0])
>> +	if (!template_dir[0]){
>
> A SP between ) and {
>
>> +		if (!template_dir)
>> +			free((char*)template_dir);
>
> No need for "call free only if it is not NULL"; free(NULL) works
> just fine.

Will fix it.

>
>>  		return;
>> +	}
>>  	template_len = strlen(template_dir);
>> -	if (PATH_MAX <= (template_len+strlen("/config")))
>> +	if (PATH_MAX <= (template_len+strlen("/config"))){
>> +		if (!template_dir)
>> +			free((char*)template_dir);
>>  		die(_("insanely long template path %s"), template_dir);
>
> You are freeing and then using it in the message, and it cannot be
> NULL anyway so "if (!template_dir)" is doubly unnecessary.
>
> I wouldn't bother freeing immediately before dying, exiting, or
> execing.
>
> Here is my quick attempt, starting solely from the output of "git
> grep system_path".  How does it look?

It looks fantastic :)

>
> One thing to note is that this illustration does not consider memory
> pointed at by the "system_wide" variable here (from attr.c)
>
>         static const char *git_etc_gitattributes(void)
>         {
>                 static const char *system_wide;
>                 if (!system_wide)
>                         system_wide = system_path(ETC_GITATTRIBUTES);
>                 return system_wide;
>         }
>
> at the point of process exit as a "leak".

But why? We allocated memory to "system_wide" with system_path, next git
will exit somewhere with die, but system_wide didn't free... Or i'm
wrong here too?

Anyway many thanks for so great feedback, tomorrow I'll reread it and
will try to do all things in correct way.

Thanky you.
