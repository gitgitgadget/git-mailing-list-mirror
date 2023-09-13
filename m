Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C184DCA5531
	for <git@archiver.kernel.org>; Wed, 13 Sep 2023 09:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239351AbjIMJs1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Sep 2023 05:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjIMJsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2023 05:48:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1814C198C
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 02:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694598457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=elKJLDkXMI5E8ILLz7FNkcMLR9cyInO6bsiytSzMENg=;
        b=dWO0X1ws15coqNoXMcR6A74Tf2NYeR2h/yFC5k64USiNimCNQvKs1fo4q77dGmU/ttT8Uv
        beaRFyQjxB50dU0CPosXEM1Nu6Q5zUDaG4tOHbsvil/5YkzL57rYXm/PE8fmRiYIfYO3PJ
        nrxTpLUkzaEwMhPl6N2qE1dmYNWekXQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-41-aHRmMl2eMm6v8TPc1ysKkA-1; Wed, 13 Sep 2023 05:47:33 -0400
X-MC-Unique: aHRmMl2eMm6v8TPc1ysKkA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 46383801FA9;
        Wed, 13 Sep 2023 09:47:33 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.76])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0D23521B2413;
        Wed, 13 Sep 2023 09:47:31 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 13 Sep 2023 11:46:40 +0200 (CEST)
Date:   Wed, 13 Sep 2023 11:46:39 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        git@vger.kernel.org, Alexey Gladkov <legion@kernel.org>
Subject: Re: [PATCH 1/1] git-grep: improve the --show-function behaviour
Message-ID: <20230913094638.GA535@redhat.com>
References: <20230911121126.GA17383@redhat.com>
 <20230911121211.GA17401@redhat.com>
 <xmqq34zktk4h.fsf@gitster.g>
 <20230911231756.GA2840@redhat.com>
 <20230912130429.GA9982@redhat.com>
 <20230912135124.GA11315@redhat.com>
 <df05f761-c498-6930-bfd8-265f7e23d8ee@web.de>
 <xmqq1qf2lxrm.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1qf2lxrm.fsf@gitster.g>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think I should trim CC to not spam the people who are not
interested in this discussion...

On 09/12, Junio C Hamano wrote:
>
> Documentation may not match the behaviour, but do we know what the
> behaviour we want is?  To me, the last example that shows the same
> line twice (one as a real hit, the other because of "-p") looks a
> bit counter-intuitive for the purpose of "help me locate where the
> grep hits are".  I dunno.

I have another opinion. To me the 2nd "=..." marker does help to
understand the hit location. But this doesn't matter.

Let me repeat: scripts.

I tried to explain this in 0/1 and in my other replies, but lets
start from the very beginning once again.

I've never used git-grep with -p/-n and most probably never will.
But 3 days ago my text editor (vi clone) started to use "grep -pn".

	$ cat -n TEST.c

	     1	void func1(struct pid *);
	     2	
	     3	void func2(struct pid *pid)
	     4	{
	     5		use1(pid);
	     6	}
	     7	
	     8	void func3(struct pid *pid)
	     9	{
	    10		use2(pid);
	    11	}


when I do

	:git-grep --untracked -pn pid TEST.c

in my editor it calls the script which parses the output from git-grep
and puts this

	<pre>
	<a href="TEST.c?1">TEST.c                  </a>    1 <b>                        </b> void func1(struct <i>pid</i> *);
	<a href="TEST.c?3">TEST.c                  </a>    3 <b>                        </b> void func2(struct <i>pid</i> *<i>pid</i>)
	<a href="TEST.c?5">TEST.c                  </a>    5 <b>func2                   </b> use1(<i>pid</i>);
	<a href="TEST.c?8">TEST.c                  </a>    8 <b>                        </b> void func3(struct <i>pid</i> *<i>pid</i>)
	<a href="TEST.c?10">TEST.c                  </a>   10 <b>func3                   </b> use2(<i>pid</i>);
	</pre>

html to the text buffer which is nicely displayed as

	TEST.c                      1                          void func1(struct pid *);
	TEST.c                      3                          void func2(struct pid *pid)
	TEST.c                      5 func2                    use1(pid);
	TEST.c                      8                          void func3(struct pid *pid)
	TEST.c                     10 func3                    use2(pid);

and I can use Ctrl-] to jump to the file/function/location.

And this script is very simple, it parses the output line-by-line. When
it sees the "=" marker it does some minimal post-processing, records the
function name to display it in the 3rd column later, and goes to the next
line.

But without my patch, in this case I get

	TEST.c                      1                          void func1(struct pid *);
	TEST.c                      3                          void func2(struct pid *pid)
	TEST.c                      5                          use1(pid);
	TEST.c                      8                          void func3(struct pid *pid)
	TEST.c                     10                          use2(pid);

because the output from git-grep

	$ git grep --untracked -pn pid TEST.c
	TEST.c:1:void func1(struct pid *);
	TEST.c:3:void func2(struct pid *pid)
	TEST.c:5:       use1(pid);
	TEST.c:8:void func3(struct pid *pid)
	TEST.c:10:      use2(pid);

doesn't have the "=..." markers at all.

But TEST.c is just the trivial/artificial example. From 0/1,

When I do

	:git-grep -pw pid kernel/sys.c

in my editor without this patch, I get

	kernel/sys.c              224 sys_setpriority          struct pid *pgrp;
	kernel/sys.c              294 sys_getpriority          struct pid *pgrp;
	kernel/sys.c              952                          * Note, despite the name, this returns the tgid not the pid.  The tgid and
	kernel/sys.c              953                          * the pid are identical unless CLONE_THREAD was specified on clone() in
	kernel/sys.c              963                          /* Thread ID - the internal kernel "pid" */
	kernel/sys.c              977 sys_getppid              int pid;
	kernel/sys.c              980 sys_getppid              pid = task_tgid_vnr(rcu_dereference(current->real_parent));
	kernel/sys.c              983 sys_getppid              return pid;
	kernel/sys.c             1073                          SYSCALL_DEFINE2(setpgid, pid_t, pid, pid_t, pgid)
	kernel/sys.c             1077 sys_times                struct pid *pgrp;
	kernel/sys.c             1080 sys_times                if (!pid)
	kernel/sys.c             1081 sys_times                pid = task_pid_vnr(group_leader);
	kernel/sys.c             1083 sys_times                pgid = pid;
	kernel/sys.c             1094 sys_times                p = find_task_by_vpid(pid);
	kernel/sys.c             1120 sys_times                if (pgid != pid) {
	kernel/sys.c             1144                          static int do_getpgid(pid_t pid)
	kernel/sys.c             1147 sys_times                struct pid *grp;
	kernel/sys.c             1151 sys_times                if (!pid)
	kernel/sys.c             1155 sys_times                p = find_task_by_vpid(pid);
	kernel/sys.c             1172                          SYSCALL_DEFINE1(getpgid, pid_t, pid)
	kernel/sys.c             1174 sys_times                return do_getpgid(pid);
	kernel/sys.c             1186                          SYSCALL_DEFINE1(getsid, pid_t, pid)
	kernel/sys.c             1189 sys_getpgrp              struct pid *sid;
	kernel/sys.c             1193 sys_getpgrp              if (!pid)
	kernel/sys.c             1197 sys_getpgrp              p = find_task_by_vpid(pid);
	kernel/sys.c             1214                          static void set_special_pids(struct pid *pid)
	kernel/sys.c             1218 sys_getpgrp              if (task_session(curr) != pid)
	kernel/sys.c             1219 sys_getpgrp              change_pid(curr, PIDTYPE_SID, pid);
	kernel/sys.c             1221 sys_getpgrp              if (task_pgrp(curr) != pid)
	kernel/sys.c             1222 sys_getpgrp              change_pid(curr, PIDTYPE_PGID, pid);
	kernel/sys.c             1228 ksys_setsid              struct pid *sid = task_pid(group_leader);
	kernel/sys.c             1684                          SYSCALL_DEFINE4(prlimit64, pid_t, pid, unsigned int, resource,
	kernel/sys.c             1705 check_prlimit_permission tsk = pid ? find_task_by_vpid(pid) : current;

And only the first 5 funcnames are correct.

And note that this case is very simple too (I mostly use :git-grep to scan
the whole linux kernel tree), but even in this simple case I don't think it
makes sense to use "git-grep -pn" directly, the output is hardly readable
(at least to me) with or without my patch.

Oleg.

