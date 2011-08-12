From: Thomas Rast <trast@student.ethz.ch>
Subject: git_checkattr() is inefficient when repeated [Re: [PATCH 00/11] Micro-optimizing lookup_object()]
Date: Fri, 12 Aug 2011 17:59:24 +0200
Message-ID: <201108121759.24884.trast@student.ethz.ch>
References: <1313085196-13249-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 12 17:59:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qru95-0008HN-6P
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 17:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753355Ab1HLP7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 11:59:34 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:36888 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751688Ab1HLP7b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 11:59:31 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.289.1; Fri, 12 Aug
 2011 17:59:26 +0200
Received: from thomas.inf.ethz.ch (80.187.110.12) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.289.1; Fri, 12 Aug
 2011 17:59:27 +0200
User-Agent: KMail/1.13.7 (Linux/3.0.0-39-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <1313085196-13249-1-git-send-email-gitster@pobox.com>
X-Originating-IP: [80.187.110.12]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179233>

Junio C Hamano wrote:
> 4-way cuckoo

Cool stuff!

While looking at the performance of it, I noticed something odd about
packing: stracing the command you gave for your timings

  strace -o pack.trace \
    ./git-pack-objects --count-only --keep-true-parents --honor-pack-keep \
    --non-empty --all --reflog --no-reuse-delta --delta-base-offset \
    --stdout  </dev/null >/dev/null

yields the fairly crazy

  $ grep -c 'open.*attrib' pack.trace 
  4398

including runs such as (with a line of context for clarity)

  munmap(0x7f9cd39f7000, 4096)            = 0
  open("compat/.gitattributes", O_RDONLY) = -1 ENOENT (No such file or directory)
  open("compat/.gitattributes", O_RDONLY) = -1 ENOENT (No such file or directory)
  open("compat/.gitattributes", O_RDONLY) = -1 ENOENT (No such file or directory)
  open("compat/.gitattributes", O_RDONLY) = -1 ENOENT (No such file or directory)
  open("compat/.gitattributes", O_RDONLY) = -1 ENOENT (No such file or directory)
  open("compat/.gitattributes", O_RDONLY) = -1 ENOENT (No such file or directory)
  open("compat/.gitattributes", O_RDONLY) = -1 ENOENT (No such file or directory)
  open("compat/.gitattributes", O_RDONLY) = -1 ENOENT (No such file or directory)
  open("t/.gitattributes", O_RDONLY)      = 3
  fstat(3, {st_mode=S_IFREG|0644, st_size=36, ...}) = 0

So calling git_checkattr in a loop is quite inefficient.  Indeed
there's a good optimization opportunity: compiled for 4-way hashing I
have (best of 3)

  6.76user 0.23system 0:07.02elapsed 99%CPU (0avgtext+0avgdata 479792maxresident)

but making no_try_delta() in pack-objects.c a dummy 'return 0' gives

  6.45user 0.13system 0:06.61elapsed 99%CPU (0avgtext+0avgdata 478256maxresident)

Which would be a 4.5% speedup.  Obviously that won't quite be
attainable since we want the attributes mechanism to work, but we
still shouldn't have to open 4398 .gitattributes files when there are
only 8 .gitattributes plus one .git/info/attributes.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
