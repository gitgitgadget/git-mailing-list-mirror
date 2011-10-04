From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: pack-object poor performance (with large number of objects?)
Date: Tue, 4 Oct 2011 15:21:24 +0200
Message-ID: <CAA01Csp2rouKk4jvCH0Wu+0gc3+cvyH__d-yw8EHEkeZhRpX1Q@mail.gmail.com>
References: <CAA01CspZijOO_xbR=OcaRaesTeSy=6RM4DR01-07qimVzxvJZA@mail.gmail.com>
	<CAJo=hJtw+sYrP09zrDbZJNGHDYOeguQLkOe88FBYQDZrnaqsAw@mail.gmail.com>
	<CAA01CsppPf_6Zp5UPYBsxa1JEwLGF-FqacRa7kBJ45Ges2ujrw@mail.gmail.com>
	<7v62k5g988.fsf@alter.siamese.dyndns.org>
	<CAA01CsoSTsBLNcbv5o6Jx6YrjG4g8T=yodX811ymBLXg7sjDJQ@mail.gmail.com>
	<20111004110702.GA18599@sigill.intra.peff.net>
	<CAA01CsodyUQJOnj5vV0LdVEWpkvwSW2TAONzyY9J82o9VwC6Ag@mail.gmail.com>
	<20111004124502.GB30162@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 04 15:21:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RB4w7-0005Y7-9l
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 15:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757043Ab1JDNVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 09:21:25 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:47366 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756778Ab1JDNVY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 09:21:24 -0400
Received: by ggnv2 with SMTP id v2so190798ggn.19
        for <git@vger.kernel.org>; Tue, 04 Oct 2011 06:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gj8JwFZx0nAdxmN6gIdO8NtKSA7nMhbws3wNbPLH9fA=;
        b=B+ffHdEieSCQaX6TlfCUUBaiGE6DXVDYuP7YQogQTAbYNvMSl1FCmfktrqfe7Ionvc
         X3Tz00ge2qY8+7pc0Vas05mh37gd8YbWJ6Pbf9YQCo8HqUR1LqMM6GLDepzJgeM3l+IX
         5jcta4kKjH9TVPLd7xQGffqjmx5Gs9soLRm1c=
Received: by 10.150.160.13 with SMTP id i13mr1165136ybe.2.1317734484425; Tue,
 04 Oct 2011 06:21:24 -0700 (PDT)
Received: by 10.150.196.1 with HTTP; Tue, 4 Oct 2011 06:21:24 -0700 (PDT)
In-Reply-To: <20111004124502.GB30162@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182769>

On Tue, Oct 4, 2011 at 2:45 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Oct 04, 2011 at 02:22:55PM +0200, Piotr Krukowiecki wrote:
>
>> > So my guess is that it is simply taking an enormous amount of disk
>> > space, and git is mostly waiting on the disk to read in files. What does
>> > "du -sh .git/objects" say?
>>
>> It isn't that big - it's 11G.
>> .git/objects/pack/ is 666MB currently.
>
> But you have 4G of RAM, no? So depending on the access patterns, you are
> thrashing your disk cache and always pulling each object straight from
> disk.

I have 4GB ram + 4GB swap. Is it possible the RAM is the problem if I
always have free RAM left and my swap is almost not used?
For example at the moment repack finished counting objects ("Counting
objects: 1742200, done."):

$ free -m
             total       used       free     shared    buffers     cached
Mem:          3960       3814        146          0        441        215
-/+ buffers/cache:       3157        803
Swap:         6143        694       5449

$ ps auxwwww | grep git
pkruk    13541  0.0  0.0  15704   716 pts/2    S+   13:19   0:00 git
repack -a -d -f
pkruk    13542  0.0  0.0   4220   540 pts/2    S+   13:19   0:00
/bin/sh /usr/local/stow/git-master/libexec/git-core/git-repack -a -d
-f
pkruk    13556  3.9  9.8 1143628 401232 pts/2  DN+  13:19   4:25 git
pack-objects --keep-true-parents --honor-pack-keep --non-empty --all
--reflog --no-reuse-delta --delta-base-offset
/home/pkruk/dv/devel1_git_repos/.git/objects/pack/.tmp-13542-pack


I have updated to 1.7.7 btw.

-- 
Piotr Krukowiecki
