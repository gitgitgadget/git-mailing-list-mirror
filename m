From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: GSoC - Designing a faster index format
Date: Fri, 23 Mar 2012 18:24:28 +0700
Message-ID: <CACsJy8CU_q+3ROO9z5nHe8NZDjTD4mvnEUP7C0+T3u3bRD11rQ@mail.gmail.com>
References: <CAKTdtZm3qfG1rcoashDoMoqtD34JJDUDtDruGqGn9bSMzQTcFA@mail.gmail.com>
 <87aa3aw5z8.fsf@thomas.inf.ethz.ch> <CAKTdtZkGP3KbMGf88yW7zcCjemUyEy_4CVNkLD0SV=Lm7=Kveg@mail.gmail.com>
 <CAKTdtZmYc=xz4zCPQiuSTUvdmbLRKXNWNL3N6_4Bj0gujYmRvw@mail.gmail.com>
 <CACsJy8AYs5bzRnhRj_R33qTt-2gPh-rJaO0=1iTva9n14wHB4w@mail.gmail.com> <CAKTdtZk4FJD9qXEybpN01+S=5fOm=4AbOp8trFr5c6Uxbfykkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>
To: elton sky <eltonsky9404@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 23 12:25:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB2cI-0003Jb-B3
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 12:25:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194Ab2CWLZD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Mar 2012 07:25:03 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:57399 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752836Ab2CWLZB convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 07:25:01 -0400
Received: by lahj13 with SMTP id j13so2408167lah.19
        for <git@vger.kernel.org>; Fri, 23 Mar 2012 04:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=B9f2segy7kV6l+7tlC3pogYCK+klSt4AehWq7UeL2mE=;
        b=QUSfeq6SNqOCXmuSH0M4QZOZI0JsY1LZxonlpZ6J54B8UJMFEQKsprMt5Gg5FvbfuC
         wwQoitvkWZp52ytCR2hNG9IsY81niarF6MmDhmZezyjqJNZsabbcSEe240gNO9oDwUx5
         nbcMcm9Pml/lGTAU3LMc4ST/x7CBWSikzdL+eLaxm7hHvj0zKczQu/DOxk7/gva2L4sP
         1ZYeXXT/kRZmI3IEzrtrMf6/6YC3r3i59Dv7M69+bxO1i8BRwnCqZVjauEs4zi/QgHVx
         hKgbYS3si7kg3pjTanl1xHcqxxuA7hC5LQXDG0Pup30jaoneYfEjIGoPVBjlRzZpZl6q
         3BVA==
Received: by 10.112.42.35 with SMTP id k3mr4649484lbl.98.1332501898561; Fri,
 23 Mar 2012 04:24:58 -0700 (PDT)
Received: by 10.112.42.197 with HTTP; Fri, 23 Mar 2012 04:24:28 -0700 (PDT)
In-Reply-To: <CAKTdtZk4FJD9qXEybpN01+S=5fOm=4AbOp8trFr5c6Uxbfykkg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193755>

On Fri, Mar 23, 2012 at 5:27 PM, elton sky <eltonsky9404@gmail.com> wro=
te:
> On Fri, Mar 23, 2012 at 12:30 PM, Nguyen Thai Ngoc Duy
> <pclouds@gmail.com> wrote:
>> On Fri, Mar 23, 2012 at 3:32 AM, elton sky <eltonsky9404@gmail.com> =
wrote:
>>> 3. how does git track updated files? Does it compare the ts between
>>> working dir and index ? Or they are recorded somewhere?
>>
>> Check out refresh_cache_ent. At the beginning of most commands, they
>> call refresh_index() or refresh_cache(), which checks a file's mtime
>> against one stored in index (different means updated). In the worst
>> scenario, refresh_cache_ent may call ce_compare_data(), which comput=
es
>> SHA-1 of the specified file and compare it with one stored in index.
>>
>
> This means working dir will compare each entry in index on mtime
> field, to find out =C2=A0if it's updated. The complexity for this ope=
ration
> is O(nlogn). I assume the way of this checking is: it loops through
> entries in the index, for each entry, it searches in working dir and
> compare the mtime.
>
> Because current index is a single steam of file, when it writes back
> it has to write back everything sequentially. So we have to do
> checksum for every entry. And I suppose this process is more time
> consuming than previous step.

The previous step is pretty fast on Linux in hot cache case. I don't
think we need to care about that. Some commands only care a
subdirectory (for example "git diff -- path/to/here") and only refresh
entries within that subdirectory, which further reduces refresh cost.

Which reminds me, we cannot abandon current index format. Users should
be allowed to choose which format to use. It may be hard to keep the
code support two formats while still taking advantage of the new one.
Maybe you could internally convert old format to new one in memory so
that git code only has to deal with one format, but that adds more
cost on using old format. I don't know..

> If we use a tree format, still, when looking for updated files, time
> complexity is O(nlogn), i.e. we traverse the index entries and for
> each entry we refer back to working dir. However, when we write index
> back, we only need to recompute and write updated file nodes, but not
> all entries. Total processing time benefit from here.

Yes. And if you compute checksum per-entry, not as a whole file, then
when you read an entry, you only need to verify checksum of that entry
(and index header of course). That reduces reading cost. But that
increases space (20-byte per entry if you stick with SHA-1). Maybe we
could do checksum per group (or tree) instead as a trade off between
space/time.
--=20
Duy
