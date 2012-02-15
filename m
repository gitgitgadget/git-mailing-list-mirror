From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: git status: small difference between stating whole repository and
 small subdirectory
Date: Wed, 15 Feb 2012 09:57:29 +0100
Message-ID: <CAA01Cso_8=159UDMFUHiYz1X=gYtpbqRO4h3TMw7N=4YMV8YNg@mail.gmail.com>
References: <CAA01Csr8FbvQ8uFvxX8_6i-hysin6JuaifVVC-yoLyoT0N5F4Q@mail.gmail.com>
	<CAA01Csp6_9fP2rg4104UWUXwOxZmUVdQNDAaBe6fRou6agBz6g@mail.gmail.com>
	<8762f9k5sg.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Feb 15 09:57:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxagB-000315-Bk
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 09:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757936Ab2BOI5a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Feb 2012 03:57:30 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:46094 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753437Ab2BOI5a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Feb 2012 03:57:30 -0500
Received: by ghrr11 with SMTP id r11so492821ghr.19
        for <git@vger.kernel.org>; Wed, 15 Feb 2012 00:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=TcWnXGbzMwYoboyKBML71b8KcqjA3RMNwBMJelytqKY=;
        b=vP2ZCZKuKx3zC0tz6NgxZp3bPk07vFx1qlmUT7sXf2wx9SchkHJk9teMLSjISLDXcY
         BMZD2iN7r9E9OEtlEhLwMnwnIG9MmS4H9V9JR3lt5mNyPacbxaAd5a3/FspnRKPoOCrH
         L6Myw2VPCVwZ8ug/XILnpp6CPaLn8D9sFa+Co=
Received: by 10.50.179.106 with SMTP id df10mr40456940igc.6.1329296249147;
 Wed, 15 Feb 2012 00:57:29 -0800 (PST)
Received: by 10.50.46.33 with HTTP; Wed, 15 Feb 2012 00:57:29 -0800 (PST)
In-Reply-To: <8762f9k5sg.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190817>

On Tue, Feb 14, 2012 at 12:34 PM, Thomas Rast <trast@inf.ethz.ch> wrote=
:
> Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:
>
>> On Fri, Feb 10, 2012 at 10:42 AM, Piotr Krukowiecki
>> <piotr.krukowiecki@gmail.com> wrote:
>>> I compared stating whole tree vs one small subdirectory, and I
>>> expected that for the subdirectory status will be very very fast.
>>> After all, it has only few files to stat. But it's not fast. Why?
>>>
>>>
>>> With cold cache (echo 3 | sudo tee /proc/sys/vm/drop_caches):
>>>
>>> $ time git status =A0 =A0> /dev/null
>>> real =A0 =A00m41.670s
>>> user =A0 =A00m0.980s
>>> sys =A0 =A0 0m2.908s
>>>
>>> $ time git status -- src/.../somedir =A0 > /dev/null
>>> real =A0 =A00m17.380s
>>> user =A0 =A00m0.748s
>>> sys =A0 =A0 0m0.328s
> [...]
>> I can't reproduce this behavior at the moment. 'status' on the
>> directory takes about 1.5s instead of 17s. status on whole repositor=
y
>> takes 27s.
>> This is my work repository, so it was changed today.
>
> To me these timings smell like a combination of either a network
> filesystem or a slow/busy disk, and non-packed repositories. =A0Next =
time
> this happens look at 'git count-objects', run 'git gc' and redo the
> timings.
>
> If you are indeed on a network filesystem, also look at the
> core.preloadIndex setting.

All is on local disk and system is idle.

Indeed, after gc the times went down:
10s -> 2.3s (subdirectory)
17s -> 9.5s (whole repo)

2 seconds is much better and I'd say acceptable for me. But my question=
s are:
- why is it so slow with not packed repo?
- can it be faster without repacking?
- even with packed repo, the time on small subdirectory is much higher
than I'd expect given time on whole repo and subdirectory size - why?


$ git count-objects -v
count: 5095
size: 37084
in-pack: 755364
packs: 21
size-pack: 2398468
prune-packable: 0
garbage: 0

$ git gc
Counting objects: 760212, done.
Compressing objects: 100% (158651/158651), done.
Writing objects: 100% (760212/760212), done.
Total 760212 (delta 535848), reused 736108 (delta 513257)
Checking connectivity: 760212, done.

$ time git status  -- .
real	0m2.503s
user	0m0.160s
sys	0m0.096s

$ time git status
real	0m9.663s
user	0m0.232s
sys	0m0.556s


--=20
Piotr Krukowiecki
