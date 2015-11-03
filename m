From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/5] Use watchman to reduce index refresh time
Date: Tue, 3 Nov 2015 10:21:36 +0100
Message-ID: <CACsJy8Dz17gRSHch9e=iB2Kq2t4FbssatW84DF8pHTuFMgEgjQ@mail.gmail.com>
References: <1446386146-10438-1-git-send-email-pclouds@gmail.com>
 <CAHVLzcn3j8eLi9VrNoZjyOZ2UzE7=NYF1bqB9UyKmghUoUw1Zg@mail.gmail.com> <CACsJy8DzSEVJYc85-3vSAZ8wB1pR9TLz0RrKyKFfHth9Tq+xyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 10:22:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtXnf-0002fv-Tu
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 10:22:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbbKCJWM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Nov 2015 04:22:12 -0500
Received: from mail-lf0-f42.google.com ([209.85.215.42]:33410 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbbKCJWI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2015 04:22:08 -0500
Received: by lfbf136 with SMTP id f136so10528519lfb.0
        for <git@vger.kernel.org>; Tue, 03 Nov 2015 01:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ew9Nivfy+/N1xxWVQ8rDfB0C+K1H8rvZSDKq6eQRezk=;
        b=OlldvMl4WzFjNK8mV+HrDH4n+hok4/QMmfxMlHjz2MbKTxhVoRdjcnJzE9YCXsbA2a
         RMLwZSXgZREhJIGDrpYKDoNojMdN2o7X+luh7PVgI6ZM0SVdU/4whKir9/wVDvlv3Wz1
         4EDt6faG0mfljnazYendhlzIRdNFbRc3ywam6MglS+ZXszFSC9nhx0757KqySL24Ghiw
         k8a+i7nMwZdf5CZwyagX+0yWlTbrhYfqb7F9aEO3iuk6p/dFkJX9M+CIEKopwmkjlQz5
         Oe4EL3+cuPiQQlIYBWVoRMszK5jrmvZ77FGhWicYlpqdytvqBn8OKU2rkA9LoAiXm8K5
         DNFg==
X-Received: by 10.25.40.197 with SMTP id o188mr5115116lfo.115.1446542526041;
 Tue, 03 Nov 2015 01:22:06 -0800 (PST)
Received: by 10.112.255.229 with HTTP; Tue, 3 Nov 2015 01:21:36 -0800 (PST)
In-Reply-To: <CACsJy8DzSEVJYc85-3vSAZ8wB1pR9TLz0RrKyKFfHth9Tq+xyg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280787>

On Mon, Nov 2, 2015 at 8:23 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Nov 2, 2015 at 3:54 PM, Paolo Ciarrocchi
> <paolo.ciarrocchi@gmail.com> wrote:
>> On Sun, Nov 1, 2015 at 2:55 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>>
>> Hi Duy,
>>
>>> This series builds on top of the index-helper series I just sent an=
d
>>> uses watchman to keep track of file changes in order to avoid lstat=
()
>>> at refresh time. The series can also be found at [1]
>>>
>>> When I started this work, watchman did not support Windows yet. It
>>> does now, even if still experimental [2]. So Windows people, please
>>> try it out if you have time.
>>>
>>> To put all pieces so far together, we have split-index to reduce in=
dex
>>> write time, untracked cache to reduce I/O as well as computation fo=
r
>>> .gitignore, index-helper for index read time and this series for
>>> lstat() at refresh time. The remaining piece is killing lstat() fro=
m
>>> untracked cache, but right now it's just some idea and incomplete
>>> code.
>>
>> Did you manage to measure the speedup introduced by this series?
>
> It was from last year. I may have measured it but because I didn't
> save it in the commit message, it was lost anyway. Installing watchma=
n
> and measuring with webkit.git soon..

Test repo: webkit.git with 104665 tracked files, 5615 untracked,
3517 dirs. Best numbers out of a few tries. This is best case
scenario. Normal usage could have worse numbers.

There is something strange about the "-uno" measurements. I don't
think watchman+untracked cache can beat -uno..  Maybe I did something
wrong.

0m0.383s   index v2
0m0.351s   index v4
0m0.352s   v2 split-index
0m0.309s   v2 split index-helper
0m0.159s   v2 split helper untracked-cache
0m0.123s   v2 split helper "status -uno"
0m0.098s   v2 split helper untracked watchman
0m0.071s   v2 split helper watchman "status -uno"

Note, the watchman series needs
s/free_watchman_shm/release_watchman_shm/ (I didn't do a good job
of testing after rebase). And there's a small bug in index-helper
--detach code writing incorrect PID..
--=20
Duy
