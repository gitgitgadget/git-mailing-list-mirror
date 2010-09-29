From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [RFC PATCH 3/3] grep: add support for grepping in submodules
Date: Wed, 29 Sep 2010 16:02:01 -0700
Message-ID: <4CA3C569.4020309@gmail.com>
References: <1285792134-26339-1-git-send-email-judge.packham@gmail.com> <1285792134-26339-4-git-send-email-judge.packham@gmail.com> <4CA3BBD7.3090006@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Sep 30 01:01:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P15em-0000GD-Bc
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 01:01:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519Ab0I2XBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 19:01:43 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:43449 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674Ab0I2XBm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 19:01:42 -0400
Received: by pxi10 with SMTP id 10so317332pxi.19
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 16:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=nfNr2Ko7D4Aj74qIB1m0rmo36fD1dMaFp64Ovd7bbjw=;
        b=tTstZQDeqEpVmvVm3ov/yfNkYNVqO6ofP7QeFk5PjhrGj0ZohOvKp57gNtVLDhDKxk
         ifBCt71aZAfy8fvjoxhfnkfrI53wSO9WbG53yNSsrrF4MWGP7J+kARFFA0xpvYJG03O0
         CURcsneWOrLupxg3G1Lup+eHOjuR6UfMSnJMA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=VsK/YE54Al51dfziZZaOSMr/s0rOiJGi9FbkSsczDutiyp4He/KWu+QRmceuUCGyPO
         r85CXRG5/5KhulGU/FdoZdIGKV7Tl6aBI9jzD1GzQRI/8PCNPM5ONrcPayK1UMi5wKmC
         e0nbYzQbZFx7y1Aix3b1grMXloh9L5TEAWzbQ=
Received: by 10.114.77.13 with SMTP id z13mr2940093waa.45.1285801301833;
        Wed, 29 Sep 2010 16:01:41 -0700 (PDT)
Received: from laptop.site (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id d38sm15384674wam.20.2010.09.29.16.01.40
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 29 Sep 2010 16:01:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.11) Gecko/20100714 SUSE/3.0.6 Thunderbird/3.0.6
In-Reply-To: <4CA3BBD7.3090006@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157618>

On 29/09/10 15:21, Jens Lehmann wrote:
> Nice start!
> 
> 
> Am 29.09.2010 22:28, schrieb Chris Packham:
>> When the --recurse-submodules option is given git grep will search in
>> submodules as they are encountered.
> 
> As "git clone" already introduced a "--recursive" option for
> submodule recursion IMO "--recursive" should be used here too for
> consistency. (Maybe you took the idea to use "--recurse-submodules"
> from my "git-checkout-recurse-submodules" branch on github? But that
> is only used there because I didn't get around to change it yet like
> I did in the "fetch-submodules-too" branch).

I actually started with --recursive and switched to
--recurse-submodules. One thing with this is the standard grep
--recursive option which may cause some confusion if people expect git
grep to behave like normal grep. I'll switch to using --recursive for
now until someone objects to the potential confusion.

One more thought on this that has been hanging around in my mind. I
sometimes want to do something on all but one submodule, in this case
with grep I'm fairly likely to want to skip a linux repository because I
already know the thing I'm looking for is in userland. Maybe in the
future we can make --recursive take an argument that allows us to
specify/restrict which submodules get included in the command invocation.

> 
>> Signed-off-by: Chris Packham <judge.packham@gmail.com>
>> ---
>>  builtin/grep.c |   72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  grep.h         |    1 +
>>  2 files changed, 73 insertions(+), 0 deletions(-)
>>
>> diff --git a/builtin/grep.c b/builtin/grep.c
>> index 8315ff0..c9befdc 100644
>> --- a/builtin/grep.c
>> +++ b/builtin/grep.c
>> @@ -30,6 +30,9 @@ static char const * const grep_usage[] = {
>>  
>>  static int use_threads = 1;
>>  
>> +static int saved_argc;
>> +static const char **saved_argv;
>> +
>>  #ifndef NO_PTHREADS
>>  #define THREADS 8
>>  static pthread_t threads[THREADS];
>> @@ -585,6 +588,67 @@ static void run_pager(struct grep_opt *opt, const char *prefix)
>>  	free(argv);
>>  }
>>  
>> +static const char **create_sub_grep_argv(struct grep_opt *opt, const char *path)
>> +{
>> +	#define NUM_ARGS 10
>> +	struct strbuf buf = STRBUF_INIT;
>> +	const char **argv;
>> +	int i = 0;
>> +
>> +	argv = xcalloc(NUM_ARGS, sizeof(const char *));
>> +	argv[i++] = "grep";
>> +	strbuf_addf(&buf, "--submodule-prefix=\\\"%s\\\"", path);
>> +	//argv[i++] = buf.buf;
> 
> As C++ comments are not portable they have to be avoided, but I
> assume this one here (and the unused "saved_argc" variable too) is
> a hint that this code is not working as intended yet? ;-)

Yeah this is due to my test problem I mentioned in the cover email. When
run_command gets called it ends up invoking the installed git executable
which doesn't understand my new option.

> It seems you want to use strbuf_detach() here so that this argv[]
> stays valid after the strbuf_release() at the end of this function.
> And if I'm not missing something this would not work correctly in
> the second recursion depth, as the new submodule prefix should
> be the one given to this grep command concatenated with the current
> submodule path.

I'll look into strbuf_detatch. The tricky thing will be keeping track of
what to free at the end of grep_submodule. I guess I can assume that it
will argv[1] is always going to be the dynamically allocated string.

> 
>> +	if (opt->linenum)
>> +		argv[i++] = "-n";
>> +	if (opt->invert)
>> +		argv[i++] = "-v";
>> +	if (opt->ignore_case)
>> +		argv[i++] = "-i";
>> +	if (opt->count)
>> +		argv[i++] = "-c";
>> +	if (opt->name_only)
>> +		argv[i++] = "-l";
>> +
>> +	argv[i++] = saved_argv[0];
>> +	argv[i++] = NULL;
> 
> Hm, at a quick glance it might be much easier to copy argc & argv
> in cmd_grep() before parse_options() starts manipulating it. Then
> you would only have to change/add the "--submodule-prefix" option
> as needed and would not have to deal with all possible grep option
> combinations (and for example you don't pass the recurse option
> yet, which would stop the recursion pretty soon).

Yeah this is the part I was struggling with a little. It would be easy
to save argv before any option processing but I wondered if that would
be frowned upon as an overhead for non-submodule usages.

I was thinking about doing something tricky with max-depth and
recursion. But maybe its better to keep it simple.

>> +
>> +	strbuf_release(&buf);
>> +	return argv;
>> +}
>> +
>> +static int grep_submodule(struct grep_opt *opt, const char *path)
>> +{
>> +	struct strbuf buf = STRBUF_INIT;
>> +	struct child_process cp;	
>> +	const char **argv = create_sub_grep_argv(opt, path);
>> +	const char *git_dir;
>> +	int hit = 0;
>> +
>> +	strbuf_addf(&buf, "%s/.git", path);
>> +	git_dir = read_gitfile_gently(buf.buf);
>> +	if (!git_dir)
>> +		git_dir = buf.buf;
>> +	if (!is_directory(git_dir)) {
>> +		warning("submodule %s has not been initialized\n", path);
> 
> Having a submodule which is not checked out is perfectly fine, so
> I don't think we want to issue a warning here.
> 
OK I'll remove it.

>> +		goto out_free;
>> +	}
>> +
>> +	memset(&cp, 0, sizeof(cp));
>> +	cp.argv = argv;
>> +	cp.env = local_repo_env;
>> +	cp.git_cmd = 1;
>> +	cp.no_stdin = 1;
>> +	cp.dir = path;
>> +	if (run_command(&cp) == 0)
>> +		hit = 1;
>> +out_free:
>> +	free(argv);
>> +	strbuf_release(&buf);
>> +	return hit;
>> +}
>> +
>>  static int grep_cache(struct grep_opt *opt, const char **paths, int cached)
>>  {
>>  	int hit = 0;
>> @@ -593,6 +657,10 @@ static int grep_cache(struct grep_opt *opt, const char **paths, int cached)
>>  
>>  	for (nr = 0; nr < active_nr; nr++) {
>>  		struct cache_entry *ce = active_cache[nr];
>> +		if (S_ISGITLINK(ce->ce_mode) && opt->recurse_submodules) {
>> +			hit |= grep_submodule(opt, ce->name);
>> +			continue;
>> +		}
>>  		if (!S_ISREG(ce->ce_mode))
>>  			continue;
>>  		if (!pathspec_matches(paths, ce->name, opt->max_depth))
>> @@ -929,9 +997,13 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>>  		  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, help_callback },
>>  		OPT_STRING(0, "submodule-prefix", &opt.submodule_prefix, "DIR",
>>  			"prepend this to submodule path output"),
>> +		OPT_BOOLEAN(0, "recurse-submodules", &opt.recurse_submodules,
>> +			"recurse into submodules"),
>>  		OPT_END()
>>  	};
>>  
>> +	saved_argc = argc;
>> +	saved_argv = argv;
>>  	/*
>>  	 * 'git grep -h', unlike 'git grep -h <pattern>', is a request
>>  	 * to show usage information and exit.
>> diff --git a/grep.h b/grep.h
>> index d918da4..e3199c9 100644
>> --- a/grep.h
>> +++ b/grep.h
>> @@ -102,6 +102,7 @@ struct grep_opt {
>>  	unsigned post_context;
>>  	unsigned last_shown;
>>  	int show_hunk_mark;
>> +	int recurse_submodules;
>>  	void *priv;
>>  
>>  	void (*output)(struct grep_opt *opt, const void *data, size_t size);
> 
