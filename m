From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 1/2] blame: large-scale performance rewrite
Date: Sat, 26 Apr 2014 10:09:00 -0700
Message-ID: <CAJo=hJsrFb+FdBDoHiYOPeB0nEQhD+9dBXTK84bDSj1MgBBdQA@mail.gmail.com>
References: <1398470210-28746-1-git-send-email-dak@gnu.org>
 <CAJo=hJukmej1rJXuVoECwd7AxmSue8Wmv4rBmCHEYcWBWNarSw@mail.gmail.com>
 <87wqec8rb5.fsf@fencepost.gnu.org> <CAJo=hJs=ap=Ct_PzOsO=vHmDVMvUF+nvbB7b67bgnmug+Yrohg@mail.gmail.com>
 <87ha5g8286.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Apr 26 19:09:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1We66R-0001EE-Hw
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 19:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752320AbaDZRJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2014 13:09:23 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:61407 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582AbaDZRJW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2014 13:09:22 -0400
Received: by mail-wg0-f48.google.com with SMTP id l18so4851912wgh.7
        for <git@vger.kernel.org>; Sat, 26 Apr 2014 10:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9HjxJ6XbXSEvixKKpHOV6hzGsU1GPUe6Q7i+y9B0/V8=;
        b=XwH1RP66CMyX8CnJ8KZaFMWIddMzCvivw22ENzeRJ/XFs43GFx3s6TdDKAYnuVb60S
         anMhxsTTzs5WVwePEK2VXxjJbS4xO8KnLQxEObNh2UveWUdrBwNWb/+tLA9FPOyXKZr/
         TujGcynVLej1OJxr/nLjbKRhMv3ntUA6z8Qw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=9HjxJ6XbXSEvixKKpHOV6hzGsU1GPUe6Q7i+y9B0/V8=;
        b=Ux5Io8aZR2OIp5x5aqjehmO+uXLVfr59TxujwnTbiSmZxnxXN1xvihpLWpbTPw+0Cb
         r3h2SQDOdGqwJXJO7w8KsVCs5B5pnnRO5gnKBmuc0OB3ovdsoCjmXfz3koaDHIVyDaVm
         31JASkTveWfiIFpCBG+Y+IK0jEFBp+3Bt3TG4Vevo05Lnke/62L3LURS0O5ZielFr563
         pXHIK2pb8yAs6aY3Ujhd8gxKLx4T6Idj0ZjnKkln1vk38hgKnKujb09BMmhPnjE6mUo0
         LUDpFMZPXKpRv/DaT4404GzXEfSNX7GLTwQD/VUQYUq6gRMDZwCPS6AybmBRNF0XuamA
         j5HA==
X-Gm-Message-State: ALoCoQlruHrUjz0O9S+2ih4ykyON0AGV3qbRbGX58eVNW6k65jxTi19GrM6zTk+hMBOMc0zirCOq
X-Received: by 10.180.101.166 with SMTP id fh6mr8449486wib.2.1398532160689;
 Sat, 26 Apr 2014 10:09:20 -0700 (PDT)
Received: by 10.227.7.131 with HTTP; Sat, 26 Apr 2014 10:09:00 -0700 (PDT)
In-Reply-To: <87ha5g8286.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247161>

On Sat, Apr 26, 2014 at 9:50 AM, David Kastrup <dak@gnu.org> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
>
>> On Sat, Apr 26, 2014 at 12:48 AM, David Kastrup <dak@gnu.org> wrote:
>>> Shawn Pearce <spearce@spearce.org> writes:
>>>>
>>>> And JGit was already usually slower than git-core. Now it will be
>>>> even slower! :-)
>>>
>>> If your statement about JGit is accurate, it should likely have beat
>>> Git for large use cases (where the performance improvements are most
>>> important) as O(n) beats O(n^2) in the long run.
>>
>> Agreed.
>>
>> In a few cases yes, JGit did beat git-core at blame running time.
>> Unfortunately according to my profiling blame performance is still
>> dominated by inflation and scanning of commit and tree objects to
>> identify unmodified blobs and advance to the next scapegoat ancestor.
>
> Oh, the C version is most certainly significantly impacted by that after
> my patch.  One can _significantly_ speed it up by increasing
> core.deltaBaseCacheLimit from its rather silly value of 16M.  If you
> have a comparable control in JGit and if your benchmarking points to the
> unpacking, that's where I'd suggest tweaking first.

Good point, we have that control but I always forget to play with it
during benchmarking.

>>> Apart from the objective measurement of "total time", the more
>>> subjective impression of interactive/incremental response (like in
>>> git gui blame) where the order of results will significantly differ
>>> (current git-blame --incremental focuses on getting blames resolved
>>> in first-lines-first manner, the proposed git-blame rather works on a
>>> newest-commits-first basis which might better match typical use
>>> cases) might be worth reporting.
>>
>> Seeing this fill during execution was the initial motivation I had for
>> writing git gui blame.
>
> It does not look impressively better to me, actually.  Probably because
> "git gui blame" is running "git blame" several times.

IIRC git gui blame runs blame only twice. Once with the simple blame,
and then again with -M -C or something like that. Its a nice display
because you can see who moved code here, and then who originally wrote
it. Unfortunately it has to be done as two passes as the blame
implementation does not know how to compute both in one pass.

The move/copy detection is also computationally more expensive per
revision visited, so it really slows down the simple "who put it here"
if the two passes were somehow run in a single iteration.

>> I don't think anyone cares about the order it displays in. In fact
>> ordering my timestamp may be more what the user wants anyway, as you
>> suggest above.
>
> What the user wants anyway is that "git gui blame" notifies "git blame"
> of the currently displayed window area whenever that changes, and that
> git blame then _first_ deals with all chunks with a visible on-screen
> part.

That is a really good idea. Unfortunately finding that part of the
window in the blame data can still take a while. You may compute other
parts of the file anyway while looking for this part, as you had to
compare two revisions and scapegoat sections to find out that commit
didn't touch the interesting region and keep going back through
history.

You may get lucky and be able to fill in a recent region quickly, but
I somehow suspect giving priority to the visible region in the
priority queue won't really help to reduce latency of the visible
region for the user.

> The really tricky/expensive part was realizing that as opposed to target
> line number ranges, source line number ranges may overlap and/or be
> duplicate when using -M or -C options.  That really messed things up for
> a long time and was hard to debug.  Once I figured out what was going
> wrong, recoding the respective stuff was straightforward.

Right, and JGit blame still is missing the -M and -C options, as I
have not implemented those yet. I got basic blame and reverse blame
working a few years ago and then stopped working on the code for a
while. Now we have interest in improving the latency for $DAY_JOB, so
I've been poking at the code again for the last week or so.

But that -M and -C thing is still not implemented, and I know its
going to be tricky to get right with the way the scapegoating is
passed along.
