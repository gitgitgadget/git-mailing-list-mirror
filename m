From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Poor performance of git describe in big repos
Date: Thu, 30 May 2013 17:33:26 +0200
Message-ID: <87ehcoeb3t.fsf@linux-k42r.v.cablecom.net>
References: <CAJ-05NPQLVFhtb9KMLNLc5MqguBYM1=gKEVrrtT3kSMiZKma_g@mail.gmail.com>
	<CALkWK0ndKMZRuWgdg6djqPUGxbDAqZPcv2q0qPrv_2b=1NEM5g@mail.gmail.com>
	<CAJ-05NNAeLUfyk8+NU8PmjKqfTcZ1NT_NPAk3M1QROtzsQKJ8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, <git@vger.kernel.org>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Thu May 30 17:33:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui4r8-0004oZ-Dr
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 17:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933663Ab3E3Pdb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 May 2013 11:33:31 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:54527 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932445Ab3E3Pd3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 May 2013 11:33:29 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 30 May
 2013 17:33:25 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS22.d.ethz.ch (172.31.51.112) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 30 May 2013 17:33:26 +0200
In-Reply-To: <CAJ-05NNAeLUfyk8+NU8PmjKqfTcZ1NT_NPAk3M1QROtzsQKJ8g@mail.gmail.com>
	("Alex \=\?utf-8\?Q\?Benn\=C3\=A9e\=22's\?\= message of "Thu, 30 May 2013 14:09:42
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226014>

Alex Benn=C3=A9e <kernel-hacker@bennee.com> writes:

>  41.58%   git  libcrypto.so.1.0.0  [.] sha1_block_data_order_ssse3
>  33.62%   git  libz.so.1.2.3.4     [.] inflate_fast
>  10.39%   git  libz.so.1.2.3.4     [.] adler32
>   2.03%   git  [kernel.kallsyms]   [k] clear_page_c

Do you have any large blobs in the repo that are referenced directly by
a tag?

Because this just so happens to exactly reproduce your symptoms:

  # in a random git.git
  $ time git describe --debug
  [...]
  real    0m0.390s
  user    0m0.037s
  sys     0m0.011s
  $ git tag big1 $(dd if=3D/dev/urandom bs=3D1M count=3D512 | git hash-=
object -w --stdin)
  512+0 records in
  512+0 records out
  536870912 bytes (537 MB) copied, 45.5088 s, 11.8 MB/s
  $ time git describe --debug
  [...]
  real    0m1.875s
  user    0m1.738s
  sys     0m0.129s
  $ git tag big2 $(dd if=3D/dev/urandom bs=3D1M count=3D512 | git hash-=
object -w --stdin)
  512+0 records in
  512+0 records out
  536870912 bytes (537 MB) copied, 44.972 s, 11.9 MB/s
  $ time git describe --debugsuche zur Beschreibung von HEAD
  [...]
  real    0m3.620s
  user    0m3.357s
  sys     0m0.248s

(I actually ran the git-describe invocations more than once to ensure
that they are again cache-hot.)

git-describe should probably be fixed to avoid loading blobs, though I'=
m
not sure off hand if we have any infrastructure to infer the type of a
loose object without inflating it.  (This could probably be added by
inflating only the first block.)  We do have this for packed objects, s=
o
at least for packed repos there's a speedup to be had.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
