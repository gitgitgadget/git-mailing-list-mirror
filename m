Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF9EC433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 18:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98E1164E6C
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 18:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbhBYSbh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 13:31:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:51004 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233404AbhBYSaI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 13:30:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4F059AC6F;
        Thu, 25 Feb 2021 18:29:26 +0000 (UTC)
Date:   Thu, 25 Feb 2021 19:29:25 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: Getting an actuallt useful merge base?
Message-ID: <20210225182924.GY6564@kitsune.suse.cz>
References: <20210224175834.GT6564@kitsune.suse.cz>
 <YDcOOwBOR4rO3sGr@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YDcOOwBOR4rO3sGr@camp.crustytoothpaste.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 25, 2021 at 02:40:59AM +0000, brian m. carlson wrote:
> On 2021-02-24 at 17:58:34, Michal Suchánek wrote:
> > Hello,
> > 
> > I find the results of git merge-base A B quite useless.
> > 
> > Suppose you have a repository with file sets
> > 
> > S and T
> > 
> > where S are sources which are developed in mainline and number of stable
> > versions, and feature branches, and T are build tools (such as autoconf
> > tests or whatever) that are largely independent of the source version.
> > 
> > Because of the independence of T from S T are developed in a separate
> > branch t which is merged into all branches developing S as needed.
> > 
> > Fixes to S may affect more than one version, and depending on the
> > situation it might be useful to apply fixes to S to mutiple
> > stable/feature branche at once. For that one would need a merge base of
> > the branches in question.
> > 
> > However, merge-base almost always give a commit on branch t which is the
> > merge base of files in set T and does not contain files in set S at all.
> > In other words it is merge base only for files from set T and not set S.
> > Can I get merge base that is merge base for all files that have common
> > history between two branches?
> 
> The merge base is determined by the history.  In your case, I imagine
> you have a history like this:
> 
>  A -- B -- C -- D -- E -- F -- G (S)
>         _/        _/        _/
>  H -- I -- J -- K -- L -- M -- N (T)
> 
> Here, the merge base of N and G is M, and the merge base of F and M is
> K.  Those are the most recent common ancestors, which are typically
> chosen as the merge base.
> 
> In your case, you probably want to cherry-pick a commit, or maybe rebase
> a small set of commits onto another set.  That would probably work
> better than trying to merge.  It's possible that there's something about
> this case that I'm missing where it wouldn't work properly, but it's
> definitely the approach I would try.

It's like this

T
----o----o----o----o----o----o----o----o----o----o----o----o---(t)---o----o----
     \             \     \                                      \\\
      \             \     \                                      \\\
       \             \     \                                      \\\
        \        o----o----o\̶---o---(s)---o----o----o----o----o----o\̶\̶-(a)
         \      /            \      /                                \\
S+T  o----o----o----o----o----o----o----o----o----o----o----o----o----o\̶--(b)
    /                                       /                           \
---o----o----o----o----o----o----o----o----o----o----o----o----o----o----o---(m)

So (t) is common ancestor for (a) and (b) that merge-base reports but it is
only ancestor for files in set T, and does not have files from set S at all.
The common ancestor I am insterested in is (s) which is merge base for both
sets of files.

Thanks

Michal
