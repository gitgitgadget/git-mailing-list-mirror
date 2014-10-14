From: Etienne Buira <etienne.buira@gmail.com>
Subject: Re: [PATCH v4] Handle atexit list internaly for unthreaded builds
Date: Tue, 14 Oct 2014 17:02:27 +0200
Message-ID: <CAMcFKVyMOO4iTq_70fqd0Jjq4WNzz9YrGYNSCZmVx5F28KXicQ@mail.gmail.com>
References: <87bnpg9b99.fsf@igel.home>
	<2724eb56a7219e0ed341e734beb32aa236119998.1413225018.git.etienne.buira@gmail.com>
	<xmqq7g033flb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: pclouds@gmail.com, schwab@linux-m68k.org, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 14 17:02:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xe3cP-0002kF-Gt
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 17:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbaJNPC3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 11:02:29 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:63206 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932145AbaJNPC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 11:02:28 -0400
Received: by mail-qg0-f43.google.com with SMTP id j107so8503118qga.16
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 08:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Cb/RAXm7FDPF/9eCc/0TPNKc1i3K/6Sg79U1Kgt9WIM=;
        b=f0M3z7M0eFAzMP8nTxfMrBGV+lGqfUMSpitHWNS+kBBVqFueW4/YWCNYc00k+I5K3b
         JlYqxk8Ij6xV1J/2D0bfw5Wx3I8DqwK1Fcjv2+lkmxxNrXqNwRJ3FtNxh1FRg9Thq6yg
         D46KpW6ayQYbmxfquAD3lU7OmuKOVURH6Waaaf073JANBTMs4ypvUT5rqFWkYO42C9aF
         4sWzOOB7pCwLpXFACAg5/PIrMEGYgNY5zGaUtUXu4mFb41osREteVr9Q6vUmBvKpo6g2
         2DNa+0Wgk90TQGERBEudlYk+7ph10zOzaHGqxqQb7E5t2e/PNHxdL1+BACKjXl+RJPI5
         chBA==
X-Received: by 10.140.31.10 with SMTP id e10mr9556848qge.4.1413298947069; Tue,
 14 Oct 2014 08:02:27 -0700 (PDT)
Received: by 10.140.35.116 with HTTP; Tue, 14 Oct 2014 08:02:27 -0700 (PDT)
In-Reply-To: <xmqq7g033flb.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 13, 2014 at 10:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Etienne Buira <etienne.buira@gmail.com> writes:
>
>> Wrap atexit()s calls on unthreaded builds to handle callback list
>> internally.
>>
>> This is needed because on unthreaded builds, asyncs inherits parent's
>> atexit() list, that gets run as soon as the async exit()s (and again at
>> the end of the parent process). That led to remove temporary and lock
>> files too early.
>
> ... that does not explain what you did to builtin/clone.c at all.
> Care to enlighten us, please?

Checking current pid against the one that registered the atexit()
routine (what builtin/clone.c currently does) is another way to guard
against the same issue, but it needs to store a pid for each atexit()
call whenever code called after might use async.
From what I've seen, two out of all atexit() calls were guarded like that:
- builtin/clone.c:cmd_clone
- lockfile.c:lock_file (overlooked it at first, would you mind to
s/temporary and lock files/temporary files/ the commit message if no
other round is needed? I'll do it otherwise).

So the changes in builtin/clone.c are just there because the patch
makes this check redundant (still needed in lockfile.c, as it loops
over a list that might refer to parent process's lockfiles).

>> Fixes test 5537 (temporary shallow file vanished before unpack-objects
>> could open it)
>>
>> V4: fix bogus preprocessor directives
>
> Please do not write this "V4:" line in the log message.  People who
> read "git log" output and find this description would not know
> anything about the previous faulty ones.  Putting it _after_ the
> three-dash line below will help the reviewers a lot.
>
>>
>> Thanks-to: Duy Nguyen <pclouds@gmail.com>
>> Thanks-to: Andreas Schwab <schwab@linux-m68k.org>
>
> Usually we spell these "Helped-by: " instead.
>
>> Signed-off-by: Etienne Buira <etienne.buira@gmail.com>
>> ---
>
> Thanks.
>
>>  builtin/clone.c   |  5 -----
>>  git-compat-util.h |  5 +++++
>>  run-command.c     | 40 ++++++++++++++++++++++++++++++++++++++++
>>  shallow.c         |  7 ++-----
>>  4 files changed, 47 insertions(+), 10 deletions(-)
>>
>> diff --git a/builtin/clone.c b/builtin/clone.c
>> index bbd169c..e122f33 100644
>> --- a/builtin/clone.c
>> +++ b/builtin/clone.c
>> @@ -390,7 +390,6 @@ static void clone_local(const char *src_repo, const char *dest_repo)
>>
>>  static const char *junk_work_tree;
>>  static const char *junk_git_dir;
>> -static pid_t junk_pid;
>>  static enum {
>>       JUNK_LEAVE_NONE,
>>       JUNK_LEAVE_REPO,
>> @@ -417,8 +416,6 @@ static void remove_junk(void)
>>               break;
>>       }
>>
>> -     if (getpid() != junk_pid)
>> -             return;
>>       if (junk_git_dir) {
>>               strbuf_addstr(&sb, junk_git_dir);
>>               remove_dir_recursively(&sb, 0);
>> @@ -758,8 +755,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>>       struct refspec *refspec;
>>       const char *fetch_pattern;
>>
>> -     junk_pid = getpid();
>> -
>>       packet_trace_identity("clone");
>>       argc = parse_options(argc, argv, prefix, builtin_clone_options,
>>                            builtin_clone_usage, 0);
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index f587749..6dd63dd 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -577,6 +577,11 @@ int inet_pton(int af, const char *src, void *dst);
>>  const char *inet_ntop(int af, const void *src, char *dst, size_t size);
>>  #endif
>>
>> +#ifdef NO_PTHREADS
>> +#define atexit git_atexit
>> +extern int git_atexit(void (*handler)(void));
>> +#endif
>> +
>>  extern void release_pack_memory(size_t);
>>
>>  typedef void (*try_to_free_t)(size_t);
>> diff --git a/run-command.c b/run-command.c
>> index 35a3ebf..0f9a9b0 100644
>> --- a/run-command.c
>> +++ b/run-command.c
>> @@ -624,6 +624,45 @@ static int async_die_is_recursing(void)
>>       return ret != NULL;
>>  }
>>
>> +#else
>> +
>> +static struct {
>> +     void (**handlers)(void);
>> +     size_t nr;
>> +     size_t alloc;
>> +} git_atexit_hdlrs;
>> +
>> +static int git_atexit_installed;
>> +
>> +static void git_atexit_dispatch()
>> +{
>> +     size_t i;
>> +
>> +     for (i=git_atexit_hdlrs.nr ; i ; i--)
>> +             git_atexit_hdlrs.handlers[i-1]();
>> +}
>> +
>> +static void git_atexit_clear()
>> +{
>> +     free(git_atexit_hdlrs.handlers);
>> +     memset(&git_atexit_hdlrs, 0, sizeof(git_atexit_hdlrs));
>> +     git_atexit_installed = 0;
>> +}
>> +
>> +#undef atexit
>> +int git_atexit(void (*handler)(void))
>> +{
>> +     ALLOC_GROW(git_atexit_hdlrs.handlers, git_atexit_hdlrs.nr + 1, git_atexit_hdlrs.alloc);
>> +     git_atexit_hdlrs.handlers[git_atexit_hdlrs.nr++] = handler;
>> +     if (!git_atexit_installed) {
>> +             if (atexit(&git_atexit_dispatch))
>> +                     return -1;
>> +             git_atexit_installed = 1;
>> +     }
>> +     return 0;
>> +}
>> +#define atexit git_atexit
>> +
>>  #endif
>>
>>  int start_async(struct async *async)
>> @@ -682,6 +721,7 @@ int start_async(struct async *async)
>>                       close(fdin[1]);
>>               if (need_out)
>>                       close(fdout[0]);
>> +             git_atexit_clear();
>>               exit(!!async->proc(proc_in, proc_out, async->data));
>>       }
>>
>> diff --git a/shallow.c b/shallow.c
>> index de07709..f067811 100644
>> --- a/shallow.c
>> +++ b/shallow.c
>> @@ -226,7 +226,6 @@ static void remove_temporary_shallow_on_signal(int signo)
>>
>>  const char *setup_temporary_shallow(const struct sha1_array *extra)
>>  {
>> -     static int installed_handler;
>>       struct strbuf sb = STRBUF_INIT;
>>       int fd;
>>
>> @@ -237,10 +236,8 @@ const char *setup_temporary_shallow(const struct sha1_array *extra)
>>               strbuf_addstr(&temporary_shallow, git_path("shallow_XXXXXX"));
>>               fd = xmkstemp(temporary_shallow.buf);
>>
>> -             if (!installed_handler) {
>> -                     atexit(remove_temporary_shallow);
>> -                     sigchain_push_common(remove_temporary_shallow_on_signal);
>> -             }
>> +             atexit(remove_temporary_shallow);
>> +             sigchain_push_common(remove_temporary_shallow_on_signal);
>>
>>               if (write_in_full(fd, sb.buf, sb.len) != sb.len)
>>                       die_errno("failed to write to %s",
