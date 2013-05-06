From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 4/4] fast-import: only store commit objects
Date: Mon, 6 May 2013 16:04:57 -0500
Message-ID: <CAMP44s1Nk7YAjNkTq=ShQbzkMasw6bpcEPTXLb8x+2q-vXLRGg@mail.gmail.com>
References: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com>
	<1367555502-4706-5-git-send-email-felipe.contreras@gmail.com>
	<87y5bw3q1s.fsf@hexa.v.cablecom.net>
	<CAMP44s1R9hAMZ=DQoPiTVi3+40NpADjVFU7tYovZA8W-PWEhhg@mail.gmail.com>
	<518785B3.3050606@alum.mit.edu>
	<87ip2wflg0.fsf@linux-k42r.v.cablecom.net>
	<518789D1.4010905@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon May 06 23:05:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZSb0-0003vt-Uh
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 23:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757686Ab3EFVFB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 17:05:01 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:43434 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756527Ab3EFVE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 17:04:59 -0400
Received: by mail-la0-f51.google.com with SMTP id ep20so3652967lab.24
        for <git@vger.kernel.org>; Mon, 06 May 2013 14:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=adHXPz0HAPHF9JkFslkVwm4HSI2bUdxOQAbUE+Ef2Rc=;
        b=SDoYB81NEtTAsYhA3h5gszadv92yunF4tf5TPQRkzchEy+cWIy2/+5a++nzrG2cJ1x
         srbxWl8zKJFDWpu4pxJRQCbyKPBE7H+qC3dXJTjE1ev0zIXnVaKU6W3f6ucvFDmASWvB
         lGgHAnxIMtQ4yGZJPt9PBcqNGzZ513eHvsu2XvubzjpECGQYQVEZST/WENVxPyiaTzGa
         K49Nxyvu2fU7n0Gw/CNyI8tOqHJupWM9FjuUBa+vya/DU0CF2e9j6B9l0OHrWVIWCySY
         aaeGOn0inUtknoBP8C7IOtdcS19P5MMpAyw2VVgZOFLn4fopC9cGiVKEOHcGyb+UO/Yw
         tUJQ==
X-Received: by 10.112.166.101 with SMTP id zf5mr8547417lbb.59.1367874297173;
 Mon, 06 May 2013 14:04:57 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Mon, 6 May 2013 14:04:57 -0700 (PDT)
In-Reply-To: <518789D1.4010905@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223505>

On Mon, May 6, 2013 at 5:45 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 05/06/2013 12:32 PM, Thomas Rast wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>
>>> On 05/03/2013 08:23 PM, Felipe Contreras wrote:
>>>> On Fri, May 3, 2013 at 12:56 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
>>>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>>
>>>>> How do we know that this doesn't break any users of fast-import?  Your
>>>>> comment isn't very reassuring:
>>>>>
>>>>>> the vast majority of them will never be used again
>>>>>
>>>>> So what's with the minority?
>>>>
>>>> Actually I don't think there's any minority. If the client program
>>>> doesn't store blobs, the blob marks are not used anyway. So there's no
>>>> change.
>>>
>>> I haven't been following this conversation in detail, but your proposed
>>> change sounds like something that would break cvs2git [1].  Let me
>>> explain what cvs2git does and why:
>>>
>>> CVS stores all of the revisions of a single file in a single filename,v
>>> file in rcsfile(5) format.  The revisions are stored as deltas ordered
>>> so that a single revision can be reconstructed from a single serial read
>>> of the file.
>>>
>>> cvs2git reads each of these files once, reconstructing *all* of the
>>> revisions for a file in a single go.  It then pours them into a
>>> git-fast-import stream as blobs and sets a mark on each blob.
>>>
>>> Only much later in the conversion does it have enough information to
>>> reconstruct tree-wide commits.  At that time it outputs git-fast-import
>>> data (to a second file) defining the git commits and their ancestry.
>>> The contents are defined by referring to the marks of blobs from the
>>> first git-fast-import stream file.
>>>
>>> This strategy speeds up the conversion *enormously*.
>>>
>>> So if I understand correctly that you are proposing to stop allowing
>>> marks on blob objects to be set and/or referred to later, then I object
>>> vociferously.
>>
>> The proposed patch wants to stop writing marks (in --export-marks) for
>> anything but commits.  Does cvs2git depend on that?  I.e., are you using
>> two separate fast-import processes for the blob and tree/commit phases
>> you describe above?
>
> Yes, it can be handy to start loading the first "blobfile" in parallel
> with the later stages of the conversion, before the second "dumpfile" is
> ready.  In that case the user needs to pass --export-marks to the first
> fast-import process to export marks on blobs so that the marks can be
> passed to the second fast-import via --import-marks.

It can be used that way, but it doesn't have to be.

> So the proposed change would break a documented use of cvs2git.

It's documented as an alternative. How many people actually use this
form over the other? Is there really any advantage? It's possibly that
basically nobody is using this form, and there's no benefits.

> Making the export of blob marks optional would of course be OK, as long
> as the default is to export them.

Nobody benefits from leaving the default as it is.

-- 
Felipe Contreras
