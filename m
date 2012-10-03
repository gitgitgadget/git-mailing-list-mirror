From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: upload-pack is slow with lots of refs
Date: Thu, 4 Oct 2012 01:54:47 +0200
Message-ID: <CACBZZX5Sm++Wjyoue-qk7TjwxUM3QihXfWGtEHhOq=VtkgvNbQ@mail.gmail.com>
References: <CACBZZX70NTic2WtrXooTg+yBbiFFDAEX_Y-b=W=rAkcYKJ3T2g@mail.gmail.com>
 <20121003180324.GB27446@sigill.intra.peff.net> <CACBZZX4Grya=FbL9XEh_EK6KVsFZYWCuHveV2QevcBwr+iYTMQ@mail.gmail.com>
 <20121003212007.GC4484@sigill.intra.peff.net> <CACBZZX6yMfeOx6x4iy8beq5niy9HvPq0c8ND5jZkoiJWAgVjfw@mail.gmail.com>
 <20121003231529.GA11618@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:05:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtM6-0001DP-H2
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932942Ab2JCXzJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Oct 2012 19:55:09 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:55156 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932788Ab2JCXzI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Oct 2012 19:55:08 -0400
Received: by obbuo13 with SMTP id uo13so7920680obb.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 16:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=x+kpLbjxwJzTUz3xhFqmfe9G2kMaqygdLhGIqrmbgdI=;
        b=W3PdsJp9wI2wYATpmC8952GfWnBsRFKctZJUXiOe0PtUd0xd4eptObKnKeE24IA/Vl
         2a1qSImA+kktF03yNJQnc21Wbq2+lemIYTw0og2gZAiTdUJ+wmzbyxG4BLMpRpxTHocu
         2w09c6p3RcTQSBIGFXYwhRDz1X9drNZ8lD74iC5lVQh3eCZiYxTBaq7SEesBJzLw2iBb
         D/cukBE1C61vfK6PoRAX3tv1HAGzUdNt5qoMmslemCUY4MlruvkKYR9/8p3vx7rOytF2
         LpjHMbaTN0sIweCgrJn6T884k3bZCPvirOz+0r8L9ssJIQF3u5vVVSzRg8srh7jGk0dx
         3ydQ==
Received: by 10.182.182.71 with SMTP id ec7mr2941445obc.22.1349308507509; Wed,
 03 Oct 2012 16:55:07 -0700 (PDT)
Received: by 10.60.94.225 with HTTP; Wed, 3 Oct 2012 16:54:47 -0700 (PDT)
In-Reply-To: <20121003231529.GA11618@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206961>

On Thu, Oct 4, 2012 at 1:15 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Oct 04, 2012 at 12:15:47AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>
>> I think he was wrong, I tested this on git.git by first creating a l=
ot
>> of tags:
>>
>>      parallel --eta "git tag -a -m"{}" test-again-{}" ::: $(git rev-=
list HEAD)
>>
>> Then doing:
>>
>>     git pack-refs --all
>>     git repack -A -d
>>
>> And compiled with -g -O3 I get around 1.55 runs/s of git-upload-pack
>> on 1.7.8 and 2.59/s on the master branch.
>
> Thanks for the update, that's more like what I expected.
>
>> FWIW here are my results on the above pathological git.git
>>
>>     $ uname -r; perf --version; echo 0000 | perf record
>> ./git-upload-pack .>/dev/null; perf report | grep -v ^# | head
>>     3.2.0-2-amd64
>>     perf version 3.2.17
>>     [ perf record: Woken up 1 times to write data ]
>>     [ perf record: Captured and wrote 0.026 MB perf.data (~1131 samp=
les) ]
>>         29.08%  git-upload-pack  libz.so.1.2.7       [.] inflate
>>         17.99%  git-upload-pack  libz.so.1.2.7       [.] 0xaec1
>>          6.21%  git-upload-pack  libc-2.13.so        [.] 0x117503
>>          5.69%  git-upload-pack  libcrypto.so.1.0.0  [.] 0x82c3d
>>          4.87%  git-upload-pack  git-upload-pack     [.] find_pack_e=
ntry_one
>>          3.18%  git-upload-pack  ld-2.13.so          [.] 0x886e
>>          2.96%  git-upload-pack  libc-2.13.so        [.] vfprintf
>>          2.83%  git-upload-pack  git-upload-pack     [.] search_for_=
subdir
>>          1.56%  git-upload-pack  [kernel.kallsyms]   [k] do_raw_spin=
_lock
>>          1.36%  git-upload-pack  libc-2.13.so        [.] vsnprintf
>>
>> I wonder why your report doesn't note any time in libz. This is on
>> Debian testing, maybe your OS uses different strip settings so it
>> doesn't show up?
>
> Mine was on Debian unstable. The difference is probably that I have 4=
00K
> refs, but only 12K unique ones (this is the master alternates repo
> containing every ref from every fork of rails/rails on GitHub). So I
> spend proportionally more time fiddling with refs and outputting than
> I do actually inflating tag objects.

An updated profile with your patch:

    $ uname -r; perf --version; echo 0000 | perf record
=2E/git-upload-pack .>/dev/null; perf report | grep -v ^# | head
    3.2.0-2-amd64
    perf version 3.2.17
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 0.015 MB perf.data (~662 samples)=
 ]
        14.45%  git-upload-pack  libc-2.13.so        [.] 0x78140
        12.13%  git-upload-pack  [kernel.kallsyms]   [k] walk_component
        11.01%  git-upload-pack  libc-2.13.so        [.] _IO_getline_in=
fo
        10.74%  git-upload-pack  git-upload-pack     [.] find_pack_entr=
y_one
         8.96%  git-upload-pack  [kernel.kallsyms]   [k] __mmdrop
         8.64%  git-upload-pack  git-upload-pack     [.] sha1_to_hex
         6.73%  git-upload-pack  libc-2.13.so        [.] vfprintf
         4.07%  git-upload-pack  libc-2.13.so        [.] strchrnul
         4.00%  git-upload-pack  libc-2.13.so        [.] getenv
         3.37%  git-upload-pack  git-upload-pack     [.] packet_write

> Hmm. It seems like we should not need to open the tags at all. The ma=
in
> reason is to produce the "peeled" advertisement just after it. But fo=
r a
> packed ref with a modern version of git that supports the "peeled"
> extension, we should already have that information.

B.t.w. do you plan to submit this as a non-hack, I'd like to have it
in git.git, so if you're not going to I could pick it up and clean it
up a bit. But I think it would be better coming from you.
