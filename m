From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Poor performance of git describe in big repos
Date: Thu, 30 May 2013 18:21:55 +0200
Message-ID: <87ip20bfq4.fsf@linux-k42r.v.cablecom.net>
References: <CAJ-05NPQLVFhtb9KMLNLc5MqguBYM1=gKEVrrtT3kSMiZKma_g@mail.gmail.com>
	<CALkWK0ndKMZRuWgdg6djqPUGxbDAqZPcv2q0qPrv_2b=1NEM5g@mail.gmail.com>
	<CAJ-05NNAeLUfyk8+NU8PmjKqfTcZ1NT_NPAk3M1QROtzsQKJ8g@mail.gmail.com>
	<87ehcoeb3t.fsf@linux-k42r.v.cablecom.net>
	<CAJ-05NOjVhb+3Cab7uQE8K3VE0Q2GhqR3FE=WzJZvSn8Djt6tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Thu May 30 18:22:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui5c3-00013A-Lz
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 18:22:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934790Ab3E3QV7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 May 2013 12:21:59 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:59825 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934256Ab3E3QV5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 May 2013 12:21:57 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 30 May
 2013 18:21:54 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS22.d.ethz.ch (172.31.51.112) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 30 May 2013 18:21:55 +0200
In-Reply-To: <CAJ-05NOjVhb+3Cab7uQE8K3VE0Q2GhqR3FE=WzJZvSn8Djt6tw@mail.gmail.com>
	("Alex \=\?utf-8\?Q\?Benn\=C3\=A9e\=22's\?\= message of "Thu, 30 May 2013 17:01:58
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226018>

Alex Benn=C3=A9e <kernel-hacker@bennee.com> writes:

> On 30 May 2013 16:33, Thomas Rast <trast@inf.ethz.ch> wrote:
>> Alex Benn=C3=A9e <kernel-hacker@bennee.com> writes:
>>
>>>  41.58%   git  libcrypto.so.1.0.0  [.] sha1_block_data_order_ssse3
>>>  33.62%   git  libz.so.1.2.3.4     [.] inflate_fast
>>>  10.39%   git  libz.so.1.2.3.4     [.] adler32
>>>   2.03%   git  [kernel.kallsyms]   [k] clear_page_c
>>
>> Do you have any large blobs in the repo that are referenced directly=
 by
>> a tag?
>
> Most probably. I've certainly done a bunch of releases (which are tag=
ged) were
> the last thing that was updated was an FPGA image.
[...]
>> git-describe should probably be fixed to avoid loading blobs, though=
 I'm
>> not sure off hand if we have any infrastructure to infer the type of=
 a
>> loose object without inflating it.  (This could probably be added by
>> inflating only the first block.)  We do have this for packed objects=
, so
>> at least for packed repos there's a speedup to be had.
>
> Will it be loading the blob for every commit it traverses or just one=
s that hit
> a tag? Why does it need to load the blob at all? Surely the commit
> tree state doesn't
> need to be walked down?

No, my theory is that you tagged *the blobs*.  Git supports this.

git-describe needs to look at the commit (if any) obtained by peeling
each tag (i.e. dereferencing tags until it reaches a non-tag).  So to d=
o
that, it resolves the tag's referent and loads it.  Usually this will b=
e
a commit, in which case it is marked as reached by the tag.

As my example shows, it also resolves tags' referents if they refer to
non-commits, in particular, it will decompress large blobs that are
(directly) referenced by a tag.

Note that while annotated tags provide the type information themselves,
e.g.

  $ git cat-file tag junio-gpg-pub
  object fe113d3f96636710600c6b02d5fd421fa7e87dd6
  type blob
  tag junio-gpg-pub
  [...]

unannotated tags are simply refs, so it is not enough to just look at
the tag objects' referent type.

I had a brief look around sha1_file.c, in particular sha1_object_info,
and it turns out we lack the "deflate only early part" logic as I
suspected.  So that'll have to be fixed first.  After that I *think* it
should automatically carry over into the tag readers.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
