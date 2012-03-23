From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: GSoC - Designing a faster index format
Date: Fri, 23 Mar 2012 08:30:16 +0700
Message-ID: <CACsJy8AYs5bzRnhRj_R33qTt-2gPh-rJaO0=1iTva9n14wHB4w@mail.gmail.com>
References: <CAKTdtZm3qfG1rcoashDoMoqtD34JJDUDtDruGqGn9bSMzQTcFA@mail.gmail.com>
 <87aa3aw5z8.fsf@thomas.inf.ethz.ch> <CAKTdtZkGP3KbMGf88yW7zcCjemUyEy_4CVNkLD0SV=Lm7=Kveg@mail.gmail.com>
 <CAKTdtZmYc=xz4zCPQiuSTUvdmbLRKXNWNL3N6_4Bj0gujYmRvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>
To: elton sky <eltonsky9404@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 23 02:30:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAtLB-0001zf-3F
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 02:30:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253Ab2CWBat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 21:30:49 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:56074 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810Ab2CWBas (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 21:30:48 -0400
Received: by wgbds11 with SMTP id ds11so743561wgb.1
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 18:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0spUHqusD942sqWATOYxgIzxMGUo5bCUEaOyXnXsNB4=;
        b=Ae0CkxVOV2+OFTCidjQj5ArAFbONf52E1T7W7IRFSDTB1OcVFoJXDngJL9OVg5zFQu
         uPc2qrYvOoRMWaqoclKeSBxsY6olpMLxMrCN9dyiavvB3xa43vv8uVcTfG/oh9bCRNZh
         8IK94FdKzBc/ops7wZ/c57Qv5U+USGKJ84xNJol2hup3UJBdZXZvjHIVk4yEq6GkWRR3
         yMiVD3q4v69R4VswaYC19pvacTBQOcJBSrE56cbOZcuSGgF/jMR+y3K07WpAOGb0czyd
         W/8dm2vnXJb/uzKkCQ1yi8gEHMm64+k1zfxFBReNQiOt+zJgYxBtzc2XM7ifT95GSJtS
         TWrA==
Received: by 10.180.100.196 with SMTP id fa4mr2634220wib.0.1332466247099; Thu,
 22 Mar 2012 18:30:47 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Thu, 22 Mar 2012 18:30:16 -0700 (PDT)
In-Reply-To: <CAKTdtZmYc=xz4zCPQiuSTUvdmbLRKXNWNL3N6_4Bj0gujYmRvw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193742>

On Fri, Mar 23, 2012 at 3:32 AM, elton sky <eltonsky9404@gmail.com> wrote:
> Got a few questions:
>
> 1. index is used for building next commit, so it should only include
> files created/modified/deleted. But I see it has all entries for
> current working dir. why?

Jakub has answered this question.

> 2. From read_index_from() I see the whole index is read into mem, and
> write one by one (entry/ext) back to disk. This makes sense. But why
> we have to compute Sha1 for all entries, especially unchanged entries?

To catch disk corruption. If a bit is flipped anywhere in the index
and we do not detect it, we may end up creating broken commits.

> 3. how does git track updated files? Does it compare the ts between
> working dir and index ? Or they are recorded somewhere?

Check out refresh_cache_ent. At the beginning of most commands, they
call refresh_index() or refresh_cache(), which checks a file's mtime
against one stored in index (different means updated). In the worst
scenario, refresh_cache_ent may call ce_compare_data(), which computes
SHA-1 of the specified file and compare it with one stored in index.

> 4. When does git insert to cache tree? and when it retrieve from it?

cache-tree is built from scratch in some cases, when we know HEAD (or
some tree) matches index exactly (e.g. reset --hard). Usually it's
only built up at commit time (update_main_cache_tree in
builtin/commit.c).
-- 
Duy
