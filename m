From: elton sky <eltonsky9404@gmail.com>
Subject: Re: GSoC - Designing a faster index format
Date: Fri, 23 Mar 2012 07:32:08 +1100
Message-ID: <CAKTdtZmYc=xz4zCPQiuSTUvdmbLRKXNWNL3N6_4Bj0gujYmRvw@mail.gmail.com>
References: <CAKTdtZm3qfG1rcoashDoMoqtD34JJDUDtDruGqGn9bSMzQTcFA@mail.gmail.com>
	<87aa3aw5z8.fsf@thomas.inf.ethz.ch>
	<CAKTdtZkGP3KbMGf88yW7zcCjemUyEy_4CVNkLD0SV=Lm7=Kveg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 22 21:32:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAogB-0003yM-Va
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 21:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757271Ab2CVUcL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Mar 2012 16:32:11 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:51373 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229Ab2CVUcK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Mar 2012 16:32:10 -0400
Received: by vcqp1 with SMTP id p1so2353097vcq.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 13:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=p172wgbghzCqZ9AsVO3bFbQd2Wak0q2BLSfp/2vtITw=;
        b=A8F0eG2f37dCGVreNHRISbJNvACPc1JzEC0HXn8EWQ9sln49rhlw/+2X91IEwrQ3xk
         dPLm5wXltUR3IRv/fPU0gFna3esLX8CKCIpImN8n2SU9XDfp+UTNIWl8z1ZjpK221DVU
         n4wJuO4WvLmzzUJyl5WfI+FW4iRyx0YSbQbS+gfELVr625PgQdibJE7O8wfupgIjSRwn
         6sAGZ4TZhNEUYGNDk/gfM/4Kze2aEETf7KFuPGF6Bh1rf4qFpsHK3XejtKSFUpjI5tbe
         vnWu4yZMR/YeTorOlqShtFlzoLbFut4s5H8aWm5C+c4iZltszbmZ1r69zY2VN2tSei2W
         eSKg==
Received: by 10.52.29.244 with SMTP id n20mr3670841vdh.22.1332448328638; Thu,
 22 Mar 2012 13:32:08 -0700 (PDT)
Received: by 10.52.182.233 with HTTP; Thu, 22 Mar 2012 13:32:08 -0700 (PDT)
In-Reply-To: <CAKTdtZkGP3KbMGf88yW7zcCjemUyEy_4CVNkLD0SV=Lm7=Kveg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193711>

Got a few questions:

1. index is used for building next commit, so it should only include
files created/modified/deleted. But I see it has all entries for
current working dir. why?

2. From read_index_from() I see the whole index is read into mem, and
write one by one (entry/ext) back to disk. This makes sense. But why
we have to compute Sha1 for all entries, especially unchanged entries?

3. how does git track updated files? Does it compare the ts between
working dir and index ? Or they are recorded somewhere?

4. When does git insert to cache tree? and when it retrieve from it?


Some early thoughts for the tree format:

We can use B tree like format. Keep the header in the beginning of the
file as is, but add file length (4bytes) and the pointer to extensions
(8bytes) into header.
Entry list follows the header. The entry starts with number of
children offsets (1 byte) followed by list of offsets (4 bytes each).
We can limit the number for balance. Other fields leave as is.
Extensions can locate in between entries.

Use Sha1 , rather than the path, as the key for each entry node. This
beats the case like 1000 files in a dir which breaks the balance of
the tree, as Thomas mentioned. If a file is updated, the old Sha1 can
be found in object dir. This also gives flexibility. We may use splay
tree, in order to move updated nodes close to the root. The downside
is full path has to be stored in entry.

Regards,
Elton

On Wed, Mar 21, 2012 at 11:01 PM, elton sky <eltonsky9404@gmail.com> wr=
ote:
> Hi Nguyen, Thomas
>
> Thanks for the points &clues. Processing them...
>
> -Elton
>
> On Wed, Mar 21, 2012 at 10:25 PM, Thomas Rast <trast@student.ethz.ch>=
 wrote:
>> elton sky <eltonsky9404@gmail.com> writes:
>>
>>> I got questions like: how each operations affect index? how cache t=
ree
>>> data and index is stored?
>>> Maybe you can point me how I should catch up quickly. I went throug=
h
>>> the article "git-for-computer-scientists", that quite makes sense.
>>
>> In addition to what Nguyen Thai Ngoc Duy said, check out the
>> (sub)threads
>>
>> =A0http://thread.gmane.org/gmane.comp.version-control.git/190016/foc=
us=3D190132
>> =A0[origins of the GSoC project idea]
>>
>> =A0http://thread.gmane.org/gmane.comp.version-control.git/192014/foc=
us=3D192025
>> =A0[perspectives of core developers in reply to the idea]
>>
>> =A0http://thread.gmane.org/gmane.comp.version-control.git/186244/foc=
us=3D186282
>> =A0http://thread.gmane.org/gmane.comp.version-control.git/186357
>> =A0[the last few discussions about cache-tree]
>>
>> --
>> Thomas Rast
>> trast@{inf,student}.ethz.ch
