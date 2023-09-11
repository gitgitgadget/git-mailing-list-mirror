Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FF1CA0EC3
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 23:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348824AbjIKVbN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237186AbjIKMNT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 08:13:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E29B8E40
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 05:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694434346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=OBkxYyVqm1CoiAMTXD7B+rv7ymLMzwotlJqbt7hrFlo=;
        b=RpgX7MQoMH1kUcM0KcnMwPfnWO5LfAXBFJpFrFMU5ssOWYUqZ0NMdKBxB/iXWxLdKFZxPc
        OFAe4B4v/Ux51OiiLdSHxHgkYrns4nohEnjbhGAH4WsnSnfClu1xTUiiWa5aCWmXkYDQV+
        LQsLHOdL+Nc06olGISiMZz3Hl9ojAu4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-679-iebKdoVJPpi0owLAx2Mv5A-1; Mon, 11 Sep 2023 08:12:23 -0400
X-MC-Unique: iebKdoVJPpi0owLAx2Mv5A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 72CE53C02550;
        Mon, 11 Sep 2023 12:12:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.151])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0625340C2064;
        Mon, 11 Sep 2023 12:12:19 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 11 Sep 2023 14:11:30 +0200 (CEST)
Date:   Mon, 11 Sep 2023 14:11:26 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Carlo Marcelo Arenas =?iso-8859-1?Q?Bel=F3n?= 
        <carenas@gmail.com>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathias Krause <minipli@grsecurity.net>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: [PATCH 0/1] git-grep: improve the --show-function behaviour
Message-ID: <20230911121126.GA17383@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I have never looked into the git sources before, so I am spamming
a lot of people found in git-log grep.c

Yesterday I tried to teach my text editor to use "git grep -p" and
I noticed that it doesn't work as I'd expect. The changelog has a
simple test-case, but let me also provide "real life" example.

When I do

	:git-grep -pw pid kernel/sys.c

in my editor before this patch, I get

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

After this patch I get

	kernel/sys.c              224 sys_setpriority          struct pid *pgrp;
	kernel/sys.c              294 sys_getpriority          struct pid *pgrp;
	kernel/sys.c              952                          * Note, despite the name, this returns the tgid not the pid.  The tgid and
	kernel/sys.c              953                          * the pid are identical unless CLONE_THREAD was specified on clone() in
	kernel/sys.c              963                          /* Thread ID - the internal kernel "pid" */
	kernel/sys.c              977 sys_getppid              int pid;
	kernel/sys.c              980 sys_getppid              pid = task_tgid_vnr(rcu_dereference(current->real_parent));
	kernel/sys.c              983 sys_getppid              return pid;
	kernel/sys.c             1073                          SYSCALL_DEFINE2(setpgid, pid_t, pid, pid_t, pgid)
	kernel/sys.c             1077 sys_setpgid              struct pid *pgrp;
	kernel/sys.c             1080 sys_setpgid              if (!pid)
	kernel/sys.c             1081 sys_setpgid              pid = task_pid_vnr(group_leader);
	kernel/sys.c             1083 sys_setpgid              pgid = pid;
	kernel/sys.c             1094 sys_setpgid              p = find_task_by_vpid(pid);
	kernel/sys.c             1120 sys_setpgid              if (pgid != pid) {
	kernel/sys.c             1144                          static int do_getpgid(pid_t pid)
	kernel/sys.c             1147 do_getpgid               struct pid *grp;
	kernel/sys.c             1151 do_getpgid               if (!pid)
	kernel/sys.c             1155 do_getpgid               p = find_task_by_vpid(pid);
	kernel/sys.c             1172                          SYSCALL_DEFINE1(getpgid, pid_t, pid)
	kernel/sys.c             1174 sys_getpgid              return do_getpgid(pid);
	kernel/sys.c             1186                          SYSCALL_DEFINE1(getsid, pid_t, pid)
	kernel/sys.c             1189 sys_getsid               struct pid *sid;
	kernel/sys.c             1193 sys_getsid               if (!pid)
	kernel/sys.c             1197 sys_getsid               p = find_task_by_vpid(pid);
	kernel/sys.c             1214                          static void set_special_pids(struct pid *pid)
	kernel/sys.c             1218 set_special_pids         if (task_session(curr) != pid)
	kernel/sys.c             1219 set_special_pids         change_pid(curr, PIDTYPE_SID, pid);
	kernel/sys.c             1221 set_special_pids         if (task_pgrp(curr) != pid)
	kernel/sys.c             1222 set_special_pids         change_pid(curr, PIDTYPE_PGID, pid);
	kernel/sys.c             1228 ksys_setsid              struct pid *sid = task_pid(group_leader);
	kernel/sys.c             1684                          SYSCALL_DEFINE4(prlimit64, pid_t, pid, unsigned int, resource,
	kernel/sys.c             1705 sys_prlimit64            tsk = pid ? find_task_by_vpid(pid) : current;

and everythig looks correct.

Oleg.

