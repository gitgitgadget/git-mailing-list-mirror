From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: tr/xdiff-fast-hash generates warnings and breaks tests
Date: Thu, 17 May 2012 01:31:54 +0200
Message-ID: <CAA787r=WCJXeDipiVL37oMgji=ncoPyXXVOcCyYbSC6iCcTi1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 17 01:32:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUnhK-0005nK-6J
	for gcvg-git-2@plane.gmane.org; Thu, 17 May 2012 01:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932977Ab2EPXb4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 May 2012 19:31:56 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37089 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932144Ab2EPXby convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 May 2012 19:31:54 -0400
Received: by pbbrp8 with SMTP id rp8so1742665pbb.19
        for <git@vger.kernel.org>; Wed, 16 May 2012 16:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=a01EI86RSPJPhWRyyz7M+dJovnm1tbdXGpYnyHpfCVM=;
        b=0qkPbiqS1WSrHBOADGWeA1ep7fYQSMpMdyEbgKbfkk1voqxGCf5XCcm6togYCLkq5D
         PbxmeiQVyjPYvzIQggd5A6qD1+75KEHmKrw/Ew2IWwN5QjS/44A6eE4gnTC6Gf7Cwzv4
         MJ9/75JKsC+593wRh/4d9aeq7q5B5DKamkAN3nPwmKMkLf/qQuPbW85nP6/L0ep5V5jw
         5AiFn4Nq+wtSOnSqgwcYs9rfFx1e2NaMRFAeWBTdsz7nHA2f1/l06K+gfFbeUWMOlDaH
         bth5k3TTm/GwfzKTWSjUzFB0h9wqOn3bd8/hbvzSEKHtdVz7Ymz+T1XLEJuH1+crd8NT
         wuvA==
Received: by 10.68.203.40 with SMTP id kn8mr20980676pbc.162.1337211114037;
 Wed, 16 May 2012 16:31:54 -0700 (PDT)
Received: by 10.68.26.98 with HTTP; Wed, 16 May 2012 16:31:54 -0700 (PDT)
X-Google-Sender-Auth: 5kxbVELwl6hhIwTZe2vGqdo6kDo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197906>

On Debian GNU/Linux 6.0.5 (squeeze), the two commits on the
tr/xdiff-fast-hash branch introduces compiler warnings and breaks
t/t0020-crlf.sh and maybe later tests:

6942efc (xdiff: load full words in the inner loop of xdl_hash_record)
  Introduces these compiler warnings (formatted for readability):

  [...]
      CC xdiff/xprepare.o
      CC xdiff/xutils.o
  xdiff/xutils.c: In function `has_zero':
  xdiff/xutils.c:290: warning: integer constant is too large for
                      `unsigned long' type
  xdiff/xutils.c:290: warning: integer constant is too large for
                      `unsigned long' type
  xdiff/xutils.c: In function `xdl_hash_record':
  xdiff/xutils.c:345: warning: integer constant is too large for
                      `unsigned long' type
  xdiff/xutils.c:361: warning: integer constant is too large for
                      `unsigned long' type
      CC xdiff/xemit.o
      CC xdiff/xmerge.o
  [...]

6f1af02 (xdiff: choose XDL_FAST_HASH code on sizeof(long) instead of
        __WORDSIZE)

  Breaks these tests in t/t0020-crlf.sh :

  not ok - 12 apply patch (autocrlf=3Dinput)
  not ok - 13 apply patch --cached (autocrlf=3Dinput)
  not ok - 14 apply patch --index (autocrlf=3Dinput)
  not ok - 15 apply patch (autocrlf=3Dtrue)
  not ok - 16 apply patch --cached (autocrlf=3Dtrue)
  not ok - 17 apply patch --index (autocrlf=3Dtrue)
  # failed 6 among 34 test(s)

Some later tests might also fail, haven't tested that.

Reverting those two commits on current master (6a4a482) fixes both
problems. Tried building on two other systems (Ubuntu 10.04.4 LTS and
Ubuntu 10.10), and these problems don't appear there. Some info:

  $ lsb_release -a
    No LSB modules are available.
    Distributor ID: Debian
    Description:    Debian GNU/Linux 6.0.5 (squeeze)
    Release:        6.0.5
    Codename:       squeeze

  $ gcc --version
    gcc (Debian 4.4.5-8) 4.4.5

  $ ldd --version
    ldd (Debian EGLIBC 2.11.3-3) 2.11.3

  $ uname -a
    Linux shell 2.6.32-5-amd64 #1 SMP Mon Jan 16 17:15:00 UTC 2012
    x86_64 GNU/Linux

  First part of /proc/cpuinfo:
    processor       : 0
    vendor_id       : GenuineIntel
    cpu family      : 6
    model           : 23
    model name      : Intel(R) Xeon(R) CPU           X3350  @ 2.66GHz
    stepping        : 7
    cpu MHz         : 2666.649
    cache size      : 6144 KB
    physical id     : 0
    siblings        : 4
    core id         : 0
    cpu cores       : 4
    apicid          : 0
    initial apicid  : 0
    fpu             : yes
    fpu_exception   : yes
    cpuid level     : 10
    wp              : yes
    flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
                      pge mca cmov pat pse36 clflush dts acpi mmx fxsr
                      sse sse2 ss ht tm pbe syscall nx lm constant_tsc
                      arch_perfmon pebs bts rep_good aperfmperf pni
                      dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16
                      xtpr pdcm sse4_1 lahf_lm tpr_shadow vnmi
                      flexpriority
    bogomips        : 5333.29
    clflush size    : 64
    cache_alignment : 64
    address sizes   : 36 bits physical, 48 bits virtual
    power management:

Cheers,
=C3=98yvind
