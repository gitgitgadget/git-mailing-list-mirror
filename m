Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F769C43466
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 16:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52BC220708
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 16:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgIUQNl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 12:13:41 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:50376 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbgIUQNk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 12:13:40 -0400
Received: by mail-pj1-f68.google.com with SMTP id fa1so48342pjb.0
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 09:13:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3usx+ELxtsq50CdAcuxgxJMgRVZBnnmXMQb0jUTJZOY=;
        b=aZU6ZaCB43iXoTvv73Af5rjs/N1rdt/WiAetc6nbdrbsSCPj6qiprxeC3V8Kv4C0tu
         z6iKYCcqzIAwEIQmbdBiAlML5Lh4OzKPkQY8WxhodtaxQBvWsAb76VYIEsuWucu0aoxp
         LYgrtRAMFKC7uaSabdabSW+xIQ2Yfo0dRz4VUuWrQqiQBxs6pmr28Iti7AP3Abvllh5k
         HscYytLZieZT6eM5o4z1r+JyrNyXK+gxbW0vIvZNFJVu6lT5VSALol0cyG6UIfiC99uZ
         A7TeQ67tHhXBCG753BdC7R+IiyVTlBAFTVSItBkvB60zUpTSZiuhfInTrheraSjcFUlK
         nfXA==
X-Gm-Message-State: AOAM530uyzHjnjlKYJEeGGr/7P5z70gHxEXEzZL3eRIEHvI+n7lZaWbi
        QbD31Gy6InFlLMiYXCiHzCfKbijWXKeoaQ==
X-Google-Smtp-Source: ABdhPJwzktolwrI3jlRuNe8kWtTZhPqkZ+CTrdh8wVMsm18qTvbqxvvfldvr5nxroq2bow368bxtGA==
X-Received: by 2002:a17:90b:3717:: with SMTP id mg23mr151362pjb.42.1600704819835;
        Mon, 21 Sep 2020 09:13:39 -0700 (PDT)
Received: from localhost.localdomain (50-125-94-129.hllk.wa.frontiernet.net. [50.125.94.129])
        by smtp.gmail.com with ESMTPSA id g1sm35937pjl.21.2020.09.21.09.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 09:13:39 -0700 (PDT)
From:   Sean Barag <sean@barag.org>
To:     sean@barag.org, gitster@pobox.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com,
        johannes.schindelin@gmx.de
Subject: Re: [PATCH 3/4] clone: validate --origin option before use
Date:   Mon, 21 Sep 2020 09:13:23 -0700
Message-Id: <20200921161323.2381099-1-sean@barag.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200916171151.1890682-1-sean@barag.org>
References: <20200916171151.1890682-1-sean@barag.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 16 Sep 2020 at 10:11:51 -0700, Sean Barag writes:
> > > validation for the provided `--origin` option, but notably
> > > _doesn't_ include a multi-level check (e.g. "foo/bar") that was
> > > present in the original `git-clone.sh`.  It seems `git remote`
> > > allows multi-level remote names, so applying that same validation
> > > in `git clone` seems reasonable.
> >
> > Even though I suspect "git remote" is being overly loose and
> > careless here, I am not sure if it is a good idea to tighten it
> > retroactively.  But if this is meant as a bugfix for misconversion
> > made in 8434c2f1, we should be as strict as the original.  I dunno.
>
>
> To be honest, I'm struggling to decide which route to go.  It seems
> like multilevel fetch and push refspecs are allowed as far back as
> 46220ca100 (remote.c: Fix overtight refspec validation, 2008-03-20) or
> ef00d150e4 (Tighten refspec processing, 2008-03-17), so perhaps
> removing the multilevel check in 8434c2f1 (Build in clone, 2008-04-27)
> was intentional?  If removing that check in 8434c2f1 was a mistake and
> we reintroduce it, that's probably a breaking change for some users.
> What sort of accommodations would I need to include in this patchset
> to ease that pain for users?

Thinking about this more, I'd be very surprised as a `git` user if
introducing a new config option broke backwards compatibility.  Other
`git` UIs have mixed support for slashes in remote names:

* GitHub Desktop has an open issue regarding remote names that contain
  slashes: https://github.com/desktop/desktop/issues/3618
* Sublime Merge (as-of build 2032) renders remote names with slashes as
  a tree of remotes, e.g.:

      $ git remote -v
      foo/bar     /tmp/example_repo
      foo/baz     /tmp/example_repo2

  is rendered with as a collapsible tree, roughly:

      REMOTES (2)
      v foo
        bar
        baz

* `tig` (2.4.1) renders remote names with slashes identically to those
  without slashes

Retroactively tightening those rules would cause more harm than good
(both for end-users and for downstream projects), especially with no
safe way to fix existing /-containing remote names.  I'm going to keep
the multilevel check out of this patchset (thus continuing to allowing
multilevel remote names), but if anyone feels strongly either way please
let me know! :)

Sean
