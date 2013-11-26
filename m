From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 07/28] shallow.c: add remove_reachable_shallow_points()
Date: Tue, 26 Nov 2013 19:56:04 +0700
Message-ID: <CACsJy8D+8DFL298_mqUDbp=Hk8b=oiDnWgpw=xf3V02=S0mdYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 26 13:56:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlIBz-00018m-LP
	for gcvg-git-2@plane.gmane.org; Tue, 26 Nov 2013 13:56:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191Ab3KZM4f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Nov 2013 07:56:35 -0500
Received: from mail-qe0-f50.google.com ([209.85.128.50]:42093 "EHLO
	mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981Ab3KZM4f convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Nov 2013 07:56:35 -0500
Received: by mail-qe0-f50.google.com with SMTP id 1so3552901qec.9
        for <git@vger.kernel.org>; Tue, 26 Nov 2013 04:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=9FIaOn3kOYtiMqIE3k1eZ+L8m2ru31czqPDRa1LTTdM=;
        b=nQS6bDWIbUa0V9FGx0C/vpp45cr23rMunXX3AY9ikz829J2ki7UteB8u22QDfH28xJ
         TX1xiiCUhMZqiJkF6gV+7Z08T6yVE9pzWQ6d/6K5ttSmLTGnMpRlMAy90jqtHwmWVYjm
         YHsd8ZRo2+qjRntkfZaZ5mzjO6IyAYr5m26Q1xbFIpS3wlqN3Yqwb5QbEvEoHdywrfH/
         qm4sOdan/reRt2oImqGEHP7SfadOGtAMG9JF2cZFk6+UUHUF27w8hCQdx5Pqm58R3Q4P
         lXcGxW+NGWUx2b1VPIbW+wMrsO16/LV7qEXDbPk44433VLCrgA2Fz8YbyKzddXL0ZIhF
         5L7A==
X-Received: by 10.224.114.81 with SMTP id d17mr55321069qaq.18.1385470594435;
 Tue, 26 Nov 2013 04:56:34 -0800 (PST)
Received: by 10.96.134.68 with HTTP; Tue, 26 Nov 2013 04:56:04 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238383>

On Tue, Nov 26, 2013 at 4:53 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> When we receive a pack and the shallow points from another repositor=
y,
>> we may want to add more shallow points to current repo to make sure =
no
>> commits point to nowhere. However we do not want to add unnecessary
>> shallow points and cut our history short because the other end is a
>> shallow version of this repo. The output shallow points may or may n=
ot
>> be added to .git/shallow, depending on whether they are actually
>> reachable in the new pack.
>>
>> This function filters such shallow points out, leaving ones that mig=
ht
>> potentially be added. A simple has_sha1_file won't do because we may
>> have incomplete object islands (i.e. not connected to any refs) and
>> the shallow points are on these islands. In that case we want to kee=
p
>> the shallow points as candidates until we figure out if the new pack
>> connects to such object islands.
>>
>> Typical cases that use remove_reachable_shallow_points() are:
>>
>>  - fetch from a repo that has longer history: in this case all remot=
e
>>    shallow roots do not exist in the client repo, this function will
>>    be cheap as it just does a few lookup_commit_graft and
>>    has_sha1_file.
>
> It is unclear why.  If you fetched from a repository more complete
> than you, you may deepen your history which may allow you to unplug
> the shallow points you originally had, and remote "shallow root" (by
> the way, lets find a single good phrase to represent this thing and
> stick to it) may want to replace them, no?

Except that deepen/shorten history is a different mode that this
function is not used at all. I should have made that clear. This and
the next patch are about "stick to our base and add something on top"

Any suggestions about a good phase? I've been swinging between
"shallow points" (from 4 months ago) and "shallow roots" (recently).

>>  - fetch from a repo that has exactly the same shallow root set
>>    (e.g. a clone from a shallow repo): this case may trigger
>>    in_merge_bases_many all the way to roots. An exception is made to
>>    avoid such costly path with a faith that .git/shallow does not
>>    usually points to unreachable commit islands.
>
> ... and when the faith is broken, you will end up with a broken
> repository???

Not really broken because the new ref will be cut at the troublesome
shallow root before it goes out of bound, so the user may be surprised
that he got a history shorter than he wanted. It's when the root is
removed that we have a problem. But commits in .git/shallow are only
removed by

1) deepening history
2) the prune patch 28/28

#1 should send the missing objects and insert a new commit to
=2Egit/shallow to plug the hole, so we're good. #2 only removes commits
from .git/shallow if they are not reachable from any refs, which is no
longer true.

>> +static int add_ref(const char *refname,
>> +                const unsigned char *sha1, int flags, void *cb_data=
)
>> +{
>> +     struct commit_array *ca =3D cb_data;
>> +     ALLOC_GROW(ca->commits, ca->nr + 1, ca->alloc);
>> +     ca->commits[ca->nr++] =3D lookup_commit(sha1);
>> +     return 0;
>> +}
>
> Can't a ref point at a non-commit-ish?  Is the code prepared to deal
> with such an entry (possibly a NULL pointer) in the commit_array
> struct?

Eck, yes a ref can. No the code is not :P Thanks for pointing this
out. We don't care about non-commit refs, so we just need to filter
them out.
--=20
Duy
