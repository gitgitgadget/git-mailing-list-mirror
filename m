From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [RFC/PATCHv2 5/5] grep: add support for grepping in submodules
Date: Sun, 17 Oct 2010 19:01:51 -0700
Message-ID: <4CBBAA8F.2040805@gmail.com>
References: <1287185204-843-1-git-send-email-judge.packham@gmail.com> <1287185204-843-6-git-send-email-judge.packham@gmail.com> <AANLkTikSukNCkcx4RYRuzzKU8T64mT0boMDqoNBrWW73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, gitster@pobox.com
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 04:01:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7f2i-0007zw-Gm
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 04:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633Ab0JRCB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Oct 2010 22:01:28 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53166 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945Ab0JRCBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Oct 2010 22:01:25 -0400
Received: by gyg13 with SMTP id 13so128190gyg.19
        for <git@vger.kernel.org>; Sun, 17 Oct 2010 19:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=gYeKE2XL3C82xtYPstk0SBEv7Cxss8S0I5V5+f+YKuk=;
        b=DI3j4QJEakvnfXWugCy3IO1xlnzlYjN2DHnAkVhv3TbiUfjyD/px1W3lyvjroHZUw8
         fkp4qo36ptucY+eE/1mGxqcXXgmb2m7c9fIYAPHgFCCM8Hf8CYaGVIQHp6N8oFhxQz0d
         Z2UyP2XtNmBCY1NbC7uqakAIT92D/2tsaRvM0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=ISUZiktFhlpVJOPH7h/VDtNKkcGS49OwIAqrse0nSOAKzMmUYRaF99H0voDNYO6cKD
         F6Ug43K4q9/qZZBJxcy0gdMFPUJtsZbm8rWEVqfN2uIOKILq/rQE3qazqF3BqV3GVR41
         C1cf+tRpSnIN8onyQvvwa/VfMQd9HAQUUW39c=
Received: by 10.100.142.2 with SMTP id p2mr2266623and.67.1287367284709;
        Sun, 17 Oct 2010 19:01:24 -0700 (PDT)
Received: from laptop.site (m130436d0.tmodns.net [208.54.4.19])
        by mx.google.com with ESMTPS id b22sm21051261anb.35.2010.10.17.19.01.22
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 17 Oct 2010 19:01:23 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.12) Gecko/20100914 SUSE/3.0.8 Thunderbird/3.0.8
In-Reply-To: <AANLkTikSukNCkcx4RYRuzzKU8T64mT0boMDqoNBrWW73@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159225>

On 17/10/10 03:28, Nguyen Thai Ngoc Duy wrote:
> On Sat, Oct 16, 2010 at 6:26 AM, Chris Packham <judge.packham@gmail.com> wrote:
>> +static int grep_submodule(struct grep_opt *opt, const char *path,
>> +                         const char *sha1, const char *tree_name)
>> +{
>> +       struct strbuf buf = STRBUF_INIT;
>> +       struct strbuf pre_buf = STRBUF_INIT;
>> +       struct child_process cp;
>> +       const char **argv = create_sub_grep_argv(opt, path, sha1, tree_name);
> 
> Can we just save sha1 in a env variable and drop this argv rewrite?
> 
The tree_name is a hangover from when I was passing it as a command line
arg, I'll remove it. For now we still need to rewrite argv to modify the
pathspec and max-depth, eventually I'd like to ditch that approach in
favour of using fork() and modifying opts.

>> +       const char *git_dir;
>> +       int hit = 0;
>> +       memset(&cp, 0, sizeof(cp));
>> +
>> +       strbuf_addf(&buf, "%s/.git", path);
>> +       git_dir = read_gitfile_gently(buf.buf);
>> +       if (!git_dir)
>> +               git_dir = buf.buf;
>> +       if (!is_directory(git_dir))
>> +               goto out_free;
>> +
>> +       setenv("GIT_SUPER_REFNAME", tree_name, 1);
>> +       setenv(GIT_DIR_ENVIRONMENT, git_dir, 1);
>> +       setenv(GIT_WORK_TREE_ENVIRONMENT, path, 1);
> 
> cp.env can be used to set these variables
> 
I was struggling a little with how to do this. The run_command
invocation in submodules.c uses local_repo_env which is protected
against modification. I also don't understand how the actual values are
passed. If someone could point me in the right direction it'd be
appreciated.

>> +       cp.argv = argv;
>> +       cp.git_cmd = 1;
>> +       cp.no_stdin = 1;
> 
> I think you stll need "cp.dir = path;" here because the setup routines
> won't do that for you. But I need to check/test that.
> 
Originally I did set cp.dir but that is used by run_command (via
start_command) to chdir. Which foils the cwd to worktree detection (at
least in V1 of that patch).

>> +       if (run_command(&cp) == 0)
>> +               hit = 1;
>> +out_free:
>> +       unsetenv("GIT_SUPER_REFNAME");
>> +       unsetenv(GIT_DIR_ENVIRONMENT);
>> +       unsetenv(GIT_WORK_TREE_ENVIRONMENT);
>> +       free(argv);
>> +       strbuf_release(&buf);
>> +       strbuf_release(&pre_buf);
>> +       return hit;
>> +}
>> +
>>  static int grep_cache(struct grep_opt *opt, const char **paths, int cached)
>>  {
>>        int hit = 0;
>> @@ -597,6 +682,10 @@ static int grep_cache(struct grep_opt *opt, const char **paths, int cached)
>>                struct cache_entry *ce = active_cache[nr];
>>                if (!pathspec_matches(paths, ce->name, opt->max_depth))
>>                        continue;
>> +               if (S_ISGITLINK(ce->ce_mode) && opt->recurse_submodules) {
>> +                       hit |= grep_submodule(opt, ce->name, NULL, NULL);
>> +                       continue;
>> +               }
>>                if (!S_ISREG(ce->ce_mode))
>>                        continue;
>>                /*
>> @@ -634,11 +723,16 @@ static int grep_tree(struct grep_opt *opt, const char **paths,
>>        char *down;
>>        int tn_len = strlen(tree_name);
>>        struct strbuf pathbuf;
>> +       const char *refname = getenv("GIT_SUPER_REFNAME");
>> +       int rn_len = refname ? strlen(refname) : 0;
>>
>> -       strbuf_init(&pathbuf, PATH_MAX + tn_len);
>> +       strbuf_init(&pathbuf, PATH_MAX + MAX(tn_len, rn_len));
>>
>>        if (tn_len) {
>> -               strbuf_add(&pathbuf, tree_name, tn_len);
>> +               if (refname)
>> +                       strbuf_add(&pathbuf, refname, rn_len);
>> +               else
>> +                       strbuf_add(&pathbuf, tree_name, tn_len);
>>                strbuf_addch(&pathbuf, ':');
>>                tn_len = pathbuf.len;
>>        }
>> @@ -664,6 +758,9 @@ static int grep_tree(struct grep_opt *opt, const char **paths,
>>                        ;
>>                else if (S_ISREG(entry.mode))
>>                        hit |= grep_sha1(opt, entry.sha1, pathbuf.buf, tn_len);
>> +               else if (S_ISGITLINK(entry.mode) && opt->recurse_submodules)
>> +                       hit |= grep_submodule(opt, entry.path,
>> +                               sha1_to_hex(entry.sha1), tree_name);
>>                else if (S_ISDIR(entry.mode)) {
>>                        enum object_type type;
>>                        struct tree_desc sub;
>> @@ -931,6 +1028,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>>                            "allow calling of grep(1) (ignored by this build)"),
>>                { OPTION_CALLBACK, 0, "help-all", &options, NULL, "show usage",
>>                  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, help_callback },
>> +               OPT_BOOLEAN(0, "recursive", &opt.recurse_submodules,
>> +                       "recurse into submodules"),
>>                OPT_END()
>>        };
>>
>> diff --git a/grep.h b/grep.h
>> index 06621fe..d5e2e11 100644
>> --- a/grep.h
>> +++ b/grep.h
>> @@ -101,6 +101,7 @@ struct grep_opt {
>>        unsigned post_context;
>>        unsigned last_shown;
>>        int show_hunk_mark;
>> +       int recurse_submodules;
>>        void *priv;
>>
>>        void (*output)(struct grep_opt *opt, const void *data, size_t size);
>> --
>> 1.7.3.1
>>
>>
> 
> 
> 
