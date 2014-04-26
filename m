From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 1/2] blame: large-scale performance rewrite
Date: Sat, 26 Apr 2014 18:50:01 +0200
Message-ID: <87ha5g8286.fsf@fencepost.gnu.org>
References: <1398470210-28746-1-git-send-email-dak@gnu.org>
	<CAJo=hJukmej1rJXuVoECwd7AxmSue8Wmv4rBmCHEYcWBWNarSw@mail.gmail.com>
	<87wqec8rb5.fsf@fencepost.gnu.org>
	<CAJo=hJs=ap=Ct_PzOsO=vHmDVMvUF+nvbB7b67bgnmug+Yrohg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Apr 26 18:50:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1We5o6-0006JJ-9Y
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 18:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbaDZQuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2014 12:50:24 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:45031 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbaDZQuX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2014 12:50:23 -0400
Received: from localhost ([127.0.0.1]:44073 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1We5ny-0004CO-BX; Sat, 26 Apr 2014 12:50:22 -0400
Received: by lola (Postfix, from userid 1000)
	id 7F178E05FE; Sat, 26 Apr 2014 18:50:01 +0200 (CEST)
In-Reply-To: <CAJo=hJs=ap=Ct_PzOsO=vHmDVMvUF+nvbB7b67bgnmug+Yrohg@mail.gmail.com>
	(Shawn Pearce's message of "Sat, 26 Apr 2014 09:01:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247159>

Shawn Pearce <spearce@spearce.org> writes:

> On Sat, Apr 26, 2014 at 12:48 AM, David Kastrup <dak@gnu.org> wrote:
>> Shawn Pearce <spearce@spearce.org> writes:
>>>
>>> And JGit was already usually slower than git-core. Now it will be
>>> even slower! :-)
>>
>> If your statement about JGit is accurate, it should likely have beat
>> Git for large use cases (where the performance improvements are most
>> important) as O(n) beats O(n^2) in the long run.
>
> Agreed.
>
> In a few cases yes, JGit did beat git-core at blame running time.
> Unfortunately according to my profiling blame performance is still
> dominated by inflation and scanning of commit and tree objects to
> identify unmodified blobs and advance to the next scapegoat ancestor.

Oh, the C version is most certainly significantly impacted by that after
my patch.  One can _significantly_ speed it up by increasing
core.deltaBaseCacheLimit from its rather silly value of 16M.  If you
have a comparable control in JGit and if your benchmarking points to the
unpacking, that's where I'd suggest tweaking first.

>> Apart from the objective measurement of "total time", the more
>> subjective impression of interactive/incremental response (like in
>> git gui blame) where the order of results will significantly differ
>> (current git-blame --incremental focuses on getting blames resolved
>> in first-lines-first manner, the proposed git-blame rather works on a
>> newest-commits-first basis which might better match typical use
>> cases) might be worth reporting.
>
> Seeing this fill during execution was the initial motivation I had for
> writing git gui blame.

It does not look impressively better to me, actually.  Probably because
"git gui blame" is running "git blame" several times.

> I don't think anyone cares about the order it displays in. In fact
> ordering my timestamp may be more what the user wants anyway, as you
> suggest above.

What the user wants anyway is that "git gui blame" notifies "git blame"
of the currently displayed window area whenever that changes, and that
git blame then _first_ deals with all chunks with a visible on-screen
part.

> Thanks for doing this. Unfortunately I can't read the patch itself as
> I am also trying to improve JGit's blame code for $DAY_JOB, and JGit
> is BSD licensed.

Shrug.  The patch is functionally equivalent to the previous behavior,
the arrangement of linear lists on underlying data structures is hardly
copyrightable, and Java implements linear lists differently anyhow.
Merging two sorted linear lists is a straightforward operation,
splitting a linear list into several others also is.

The really tricky/expensive part was realizing that as opposed to target
line number ranges, source line number ranges may overlap and/or be
duplicate when using -M or -C options.  That really messed things up for
a long time and was hard to debug.  Once I figured out what was going
wrong, recoding the respective stuff was straightforward.

I doubt that there is much copyrightable material to transfer as I seem
to remember that Java does not have anything like a pointer.  So the
main stuff, juggling with linear lists, would not likely transfer in a
reasonably recognizable manner.

-- 
David Kastrup
