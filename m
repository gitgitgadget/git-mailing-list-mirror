From: elton sky <eltonsky9404@gmail.com>
Subject: Re: GSoC - Designing a faster index format
Date: Fri, 23 Mar 2012 21:27:32 +1100
Message-ID: <CAKTdtZk4FJD9qXEybpN01+S=5fOm=4AbOp8trFr5c6Uxbfykkg@mail.gmail.com>
References: <CAKTdtZm3qfG1rcoashDoMoqtD34JJDUDtDruGqGn9bSMzQTcFA@mail.gmail.com>
	<87aa3aw5z8.fsf@thomas.inf.ethz.ch>
	<CAKTdtZkGP3KbMGf88yW7zcCjemUyEy_4CVNkLD0SV=Lm7=Kveg@mail.gmail.com>
	<CAKTdtZmYc=xz4zCPQiuSTUvdmbLRKXNWNL3N6_4Bj0gujYmRvw@mail.gmail.com>
	<CACsJy8AYs5bzRnhRj_R33qTt-2gPh-rJaO0=1iTva9n14wHB4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 23 11:27:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB1ic-00079w-Sg
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 11:27:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758003Ab2CWK1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 06:27:34 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:42609 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757136Ab2CWK1d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 06:27:33 -0400
Received: by vcqp1 with SMTP id p1so2681680vcq.19
        for <git@vger.kernel.org>; Fri, 23 Mar 2012 03:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7TWZexYZQP3mFXq2WpISAxB+GO0xkvIuNACVT9lONVc=;
        b=FBKo5k4FYI/QcnJ7nYCyzu5hCgMKFOdz7yfMvtu1Po+KtF1v0xN4ebb0WOUZyQFW4J
         5dCBQqwMxKZdq7VYzd2WBdG7YhVgEDdlpxvhk/bX4oCXtW6UmOIK7kj3pRbOMIy/2EiS
         GcgjYpXncjvTchSPkA8CcVVTmxMHzsosaNQ4XWGvWu/ZCp9pbbTrYCDllnFS0Fel/d0B
         +kh/WEU/6ZpnYGfInrxtY/e/9I9o2R90Lh755SBujiV82yvpo2j1OKjt8WJa601OVR4d
         4G+3KKKB9qC4GuX+qI04A4TkRQA2o/EcAr9n5S0eZxTEGWBhhBIkd+AbPSzkQ22iljRm
         h4Ig==
Received: by 10.52.174.162 with SMTP id bt2mr4384083vdc.56.1332498452828; Fri,
 23 Mar 2012 03:27:32 -0700 (PDT)
Received: by 10.52.182.233 with HTTP; Fri, 23 Mar 2012 03:27:32 -0700 (PDT)
In-Reply-To: <CACsJy8AYs5bzRnhRj_R33qTt-2gPh-rJaO0=1iTva9n14wHB4w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193752>

Hi Nguyen, Jakub

Thank you for your explanations.

Just clarify question about track updated files:

On Fri, Mar 23, 2012 at 12:30 PM, Nguyen Thai Ngoc Duy
<pclouds@gmail.com> wrote:
> On Fri, Mar 23, 2012 at 3:32 AM, elton sky <eltonsky9404@gmail.com> wrote:
>> Got a few questions:
>>
>> 1. index is used for building next commit, so it should only include
>> files created/modified/deleted. But I see it has all entries for
>> current working dir. why?
>
> Jakub has answered this question.
>
>> 2. From read_index_from() I see the whole index is read into mem, and
>> write one by one (entry/ext) back to disk. This makes sense. But why
>> we have to compute Sha1 for all entries, especially unchanged entries?
>
> To catch disk corruption. If a bit is flipped anywhere in the index
> and we do not detect it, we may end up creating broken commits.
>
>> 3. how does git track updated files? Does it compare the ts between
>> working dir and index ? Or they are recorded somewhere?
>
> Check out refresh_cache_ent. At the beginning of most commands, they
> call refresh_index() or refresh_cache(), which checks a file's mtime
> against one stored in index (different means updated). In the worst
> scenario, refresh_cache_ent may call ce_compare_data(), which computes
> SHA-1 of the specified file and compare it with one stored in index.
>

This means working dir will compare each entry in index on mtime
field, to find out  if it's updated. The complexity for this operation
is O(nlogn). I assume the way of this checking is: it loops through
entries in the index, for each entry, it searches in working dir and
compare the mtime.

Because current index is a single steam of file, when it writes back
it has to write back everything sequentially. So we have to do
checksum for every entry. And I suppose this process is more time
consuming than previous step.

If we use a tree format, still, when looking for updated files, time
complexity is O(nlogn), i.e. we traverse the index entries and for
each entry we refer back to working dir. However, when we write index
back, we only need to recompute and write updated file nodes, but not
all entries. Total processing time benefit from here.

Please correct me if I am wrong.

-Elton


>> 4. When does git insert to cache tree? and when it retrieve from it?
>
> cache-tree is built from scratch in some cases, when we know HEAD (or
> some tree) matches index exactly (e.g. reset --hard). Usually it's
> only built up at commit time (update_main_cache_tree in
> builtin/commit.c).
> --
> Duy
