From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: [PATCH di/fast-import-deltified-tree] Windows: define S_ISUID properly
Date: Wed, 21 Sep 2011 19:44:55 +0600
Message-ID: <CA+gfSn8VaTLcrLqb3HGJpjL5WJMHZz4kPPUtyeHPCsdmO5iU8g@mail.gmail.com>
References: <4E798538.7070106@viscovery.net>
	<loom.20110921T092135-714@post.gmane.org>
	<7vfwjq2hoo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 21 15:45:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6N6j-0007M0-V9
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 15:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789Ab1IUNo5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Sep 2011 09:44:57 -0400
Received: from mail-qw0-f42.google.com ([209.85.216.42]:42971 "EHLO
	mail-qw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711Ab1IUNo4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2011 09:44:56 -0400
Received: by qwm42 with SMTP id 42so2527974qwm.1
        for <git@vger.kernel.org>; Wed, 21 Sep 2011 06:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=4wgGkyJ55KTmN5wLCjxbDuR4mTDjt7Lrcvx2tms1PRA=;
        b=ndSylqz4bvD1cPoyFaJehc1iSRxaoTDU5H0jZiKsqfO8+jfaSI8geRq/tanFN8MeIb
         rwVZ38BLrOhXfuh3vtMoQUXPbY+YgcmMrOkOE3McW2GKTREyYewwogD9U8TmRurHsPZE
         vYO8Tm2R+cTwV+02MLuh9rgyjXcxrda7K1CaE=
Received: by 10.229.69.206 with SMTP id a14mr560003qcj.54.1316612695681; Wed,
 21 Sep 2011 06:44:55 -0700 (PDT)
Received: by 10.229.224.17 with HTTP; Wed, 21 Sep 2011 06:44:55 -0700 (PDT)
In-Reply-To: <7vfwjq2hoo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181846>

On Wed, Sep 21, 2011 at 6:08 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Dmitry Ivankov <divanorama@gmail.com> writes:
>
>> Johannes Sixt <j.sixt <at> viscovery.net> writes:
>>>
>>> From: Johannes Sixt <j6t <at> kdbg.org>
>>>
>>> 8fb3ad76 (fast-import: prevent producing bad delta) introduced the =
first
>>> use of S_ISUID. Since before this commit the value was irrelevant, =
we had
>>> only a dummy definition in mingw.h. But beginning with this commit =
the
>>> macro must expand to a reasonable value. Make it so.
>>> =A0#define S_ISVTX 0
>>> ...
>> Ow, it's awkward that the issue was discussed in [1] but slipped and=
 nobody
>> noticed, especially me being a patch sender.
>>
>> If we choose patch from [1] I'd also change a comment to smth like
>> /*
>> =A0* We abuse the 04000 bit on directories to mean "do not delta".
>> =A0* It is a S_ISUID bit on setuid platforms and an unused bit on
>> =A0* non-setuid platforms supported in git. In either case git ignor=
es
>> =A0* the bit, so it's safe to abuse it locally.
>> =A0*/
>>
>> [1] http://thread.gmane.org/gmane.comp.version-control.git/179223/fo=
cus=3D179762
>
> I think that the fix from Jonathan to stop abusing S_ISUID is much mo=
re
> preferrable; the Windows platform shouldn't have to worry about this.
>
> And it would be even better to use a value that does not overlap with=
 the
> usual bits for do-not-delta bit if possible.

Depends on what is a usual bit. I'll use linux defines for mode bits.

There are S_ISVTX, S_ISUID completely unused in git, S_ISGID is used so=
mehow.
9 lower rwx bits are used as well as S_IFREG and S_IFDIR. Remaining are=
 S_IFIFO
(used somehow), S_IFCHR (part of GITLNK).

S_ISUID in fast-import input stream isn't accepted, so the only danger
is it may come
from a tree object (but not yet, git-fsck doesn't allow it). Or if
there appears a platform
with different S_I{F,S}* definitions, which will break more git parts
than just fast-import.

I remember there was a thread concerning platform vs git-core mode
bits. I'd just use
hard-coded 04000 bit in fast-import as a hot-fix and leave the rest
for the bits topic.
With S_ISUID in a comment near 04000 it'll be a grep-able hard-coded
constant, so
it should be ok.
