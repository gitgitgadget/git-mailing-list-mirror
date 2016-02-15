From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 2/3] config: add 'type' to config_source struct that
 identifies config type
Date: Mon, 15 Feb 2016 21:30:29 +0000
Message-ID: <56C24375.4080007@ramsayjones.plus.com>
References: <1455531466-16617-1-git-send-email-larsxschneider@gmail.com>
 <1455531466-16617-3-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, sschuberth@gmail.com, sunshine@sunshineco.com,
	hvoigt@hvoigt.net, sbeller@google.com, Johannes.Schindelin@gmx.de,
	gitster@pobox.com
To: larsxschneider@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 15 22:30:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVQj9-0000XO-Ti
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 22:30:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234AbcBOVag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 16:30:36 -0500
Received: from avasout04.plus.net ([212.159.14.19]:48145 "EHLO
	avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbcBOVaf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 16:30:35 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout04 with smtp
	id JlWW1s0094mu3xa01lWYJg; Mon, 15 Feb 2016 21:30:33 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=K//fZHiI c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=N659UExz7-8A:10
 a=pGLkceISAAAA:8 a=cC5Hlu8QWE12Ejjj-XIA:9 a=pILNOxqGKmIA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <1455531466-16617-3-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286243>



On 15/02/16 10:17, larsxschneider@gmail.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> Use the config type to print more detailed error messages that inform
> the user about the origin of a config error (file, stdin, blob).
> 
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  cache.h                |  6 ++++--
>  config.c               | 36 +++++++++++++++++++++++++-----------
>  submodule-config.c     |  4 ++--
>  t/t1300-repo-config.sh |  8 +++++++-
>  t/t1308-config-set.sh  |  4 ++--
>  5 files changed, 40 insertions(+), 18 deletions(-)
> 
> diff --git a/cache.h b/cache.h
> index c63fcc1..8d86e5c 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1485,8 +1485,8 @@ struct git_config_source {
>  typedef int (*config_fn_t)(const char *, const char *, void *);
>  extern int git_default_config(const char *, const char *, void *);
>  extern int git_config_from_file(config_fn_t fn, const char *, void *);
> -extern int git_config_from_buf(config_fn_t fn, const char *name,
> -			       const char *buf, size_t len, void *data);
> +extern int git_config_from_mem(config_fn_t fn, const char *type,
> +					const char *name, const char *buf, size_t len, void *data);
>  extern void git_config_push_parameter(const char *text);
>  extern int git_config_from_parameters(config_fn_t fn, void *data);
>  extern void git_config(config_fn_t fn, void *);
> @@ -1525,6 +1525,8 @@ extern const char *get_log_output_encoding(void);
>  extern const char *get_commit_output_encoding(void);
>  
>  extern int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
> +extern const char *current_config_type();
> +extern const char *current_config_name();
>  
>  struct config_include_data {
>  	int depth;
> diff --git a/config.c b/config.c
> index 86a5eb2..5cf11b5 100644
> --- a/config.c
> +++ b/config.c
> @@ -24,6 +24,7 @@ struct config_source {
>  			size_t pos;
>  		} buf;
>  	} u;
> +	const char *type;
>  	const char *name;
>  	const char *path;
>  	int die_on_error;
> @@ -471,9 +472,9 @@ static int git_parse_source(config_fn_t fn, void *data)
>  			break;
>  	}
>  	if (cf->die_on_error)
> -		die(_("bad config file line %d in %s"), cf->linenr, cf->name);
> +		die(_("bad config line %d in %s %s"), cf->linenr, cf->type, cf->name);
>  	else
> -		return error(_("bad config file line %d in %s"), cf->linenr, cf->name);
> +		return error(_("bad config line %d in %s %s"), cf->linenr, cf->type, cf->name);
>  }
>  
>  static int parse_unit_factor(const char *end, uintmax_t *val)
> @@ -588,9 +589,9 @@ static void die_bad_number(const char *name, const char *value)
>  	if (!value)
>  		value = "";
>  
> -	if (cf && cf->name)
> -		die(_("bad numeric config value '%s' for '%s' in %s: %s"),
> -		    value, name, cf->name, reason);
> +	if (cf && cf->type && cf->name)
> +		die(_("bad numeric config value '%s' for '%s' in %s %s: %s"),
> +		    value, name, cf->type, cf->name, reason);
>  	die(_("bad numeric config value '%s' for '%s': %s"), value, name, reason);
>  }
>  
> @@ -1061,11 +1062,13 @@ static int do_config_from(struct config_source *top, config_fn_t fn, void *data)
>  }
>  
>  static int do_config_from_file(config_fn_t fn,
> -		const char *name, const char *path, FILE *f, void *data)
> +		const char *type, const char *name, const char *path, FILE *f,
> +		void *data)
>  {
>  	struct config_source top;
>  
>  	top.u.file = f;
> +	top.type = type;
>  	top.name = name;
>  	top.path = path;
>  	top.die_on_error = 1;
> @@ -1078,7 +1081,7 @@ static int do_config_from_file(config_fn_t fn,
>  
>  static int git_config_from_stdin(config_fn_t fn, void *data)
>  {
> -	return do_config_from_file(fn, "<stdin>", NULL, stdin, data);
> +	return do_config_from_file(fn, "stdin", "", NULL, stdin, data);

I think this should be:
	return do_config_from_file(fn, "file", "<stdin>", NULL, stdin, data);

ie. <stdin> is not a separate type, but a file that does not exist in
the filesystem and, thus, has no name. (what you use internally is a
separate issue, but <file,NULL> works for me.)

Also, I'm so used to '<stdin>' as the 'name' (token/handle) of that
file, that it looks very odd spelt otherwise. :-D

>  }
>  
>  int git_config_from_file(config_fn_t fn, const char *filename, void *data)
> @@ -1089,21 +1092,22 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
>  	f = fopen(filename, "r");
>  	if (f) {
>  		flockfile(f);
> -		ret = do_config_from_file(fn, filename, filename, f, data);
> +		ret = do_config_from_file(fn, "file", filename, filename, f, data);
>  		funlockfile(f);
>  		fclose(f);
>  	}
>  	return ret;
>  }
>  
> -int git_config_from_buf(config_fn_t fn, const char *name, const char *buf,
> -			size_t len, void *data)
> +int git_config_from_mem(config_fn_t fn, const char *type, const char *name,
> +			const char *buf, size_t len, void *data)
>  {
>  	struct config_source top;
>  
>  	top.u.buf.buf = buf;
>  	top.u.buf.len = len;
>  	top.u.buf.pos = 0;
> +	top.type = type;
>  	top.name = name;
>  	top.path = NULL;
>  	top.die_on_error = 0;
> @@ -1132,7 +1136,7 @@ static int git_config_from_blob_sha1(config_fn_t fn,
>  		return error("reference '%s' does not point to a blob", name);
>  	}
>  
> -	ret = git_config_from_buf(fn, name, buf, size, data);
> +	ret = git_config_from_mem(fn, "blob", name, buf, size, data);
>  	free(buf);
>  
>  	return ret;
> @@ -2385,3 +2389,13 @@ int parse_config_key(const char *var,
>  
>  	return 0;
>  }
> +
> +const char *current_config_type()
> +{
> +	return cf && cf->type ? cf->type : "cmdline";
> +}
> +
> +const char *current_config_name()
> +{
> +	return cf && cf->name ? cf->name : "";
> +}
> diff --git a/submodule-config.c b/submodule-config.c
> index fe8ceab..92502b5 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -427,8 +427,8 @@ static const struct submodule *config_from(struct submodule_cache *cache,
>  	parameter.commit_sha1 = commit_sha1;
>  	parameter.gitmodules_sha1 = sha1;
>  	parameter.overwrite = 0;
> -	git_config_from_buf(parse_config, rev.buf, config, config_size,
> -			&parameter);
> +	git_config_from_mem(parse_config, "submodule-blob", rev.buf,
> +			config, config_size, &parameter);
>  	free(config);
>  
>  	switch (lookup_type) {
> diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
> index 1782add..42ed5cc 100755
> --- a/t/t1300-repo-config.sh
> +++ b/t/t1300-repo-config.sh
> @@ -700,12 +700,18 @@ test_expect_success 'invalid unit' '
>  	git config aninvalid.unit >actual &&
>  	test_cmp expect actual &&
>  	cat >expect <<-\EOF &&
> -	fatal: bad numeric config value '\''1auto'\'' for '\''aninvalid.unit'\'' in .git/config: invalid unit
> +	fatal: bad numeric config value '\''1auto'\'' for '\''aninvalid.unit'\'' in file .git/config: invalid unit
>  	EOF
>  	test_must_fail git config --int --get aninvalid.unit 2>actual &&
>  	test_i18ncmp expect actual
>  '
>  
> +test_expect_success 'invalid stdin config' '
> +	echo "fatal: bad config line 1 in stdin " >expect &&

So, this looks odd. Using the above would give:
	fatal: bad config line 1 in file <stdin>

> +	echo "[broken" | test_must_fail git config --list --file - >output 2>&1 &&
> +	test_cmp expect output
> +'
> +
>  cat > expect << EOF
>  true
>  false
> diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
> index 91235b7..82f82a1 100755
> --- a/t/t1308-config-set.sh
> +++ b/t/t1308-config-set.sh
> @@ -195,14 +195,14 @@ test_expect_success 'proper error on error in default config files' '
>  	cp .git/config .git/config.old &&
>  	test_when_finished "mv .git/config.old .git/config" &&
>  	echo "[" >>.git/config &&
> -	echo "fatal: bad config file line 34 in .git/config" >expect &&
> +	echo "fatal: bad config line 34 in file .git/config" >expect &&
>  	test_expect_code 128 test-config get_value foo.bar 2>actual &&
>  	test_cmp expect actual
>  '
>  
>  test_expect_success 'proper error on error in custom config files' '
>  	echo "[" >>syntax-error &&
> -	echo "fatal: bad config file line 1 in syntax-error" >expect &&
> +	echo "fatal: bad config line 1 in file syntax-error" >expect &&
>  	test_expect_code 128 test-config configset_get_value foo.bar syntax-error 2>actual &&
>  	test_cmp expect actual
>  '
> 

ATB,
Ramsay Jones
