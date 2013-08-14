From: Ben Tebulin <tebulin@googlemail.com>
Subject: Reproducible, corrupt packfile after fresh git-svn checkouts - IDENTIFIED
Date: Wed, 14 Aug 2013 11:29:22 +0200
Message-ID: <520B4DF2.207@gmail.com>
References: <52037F47.5010302@exxcellent.de> <52037F84.9060006@exxcellent.de> <f1d8f80d6fa3678ac043bfdb19bebf6bf4261273@localhost> <877gfw4byx.fsf@linux-k42r.v.cablecom.net> <262a9f8309a3812970f47ac9f4e4b49bb972ca49@localhost> <87fvuk2wl0.fsf@linux-k42r.v.cablecom.net> <9aa1672d5c04994f416dccd84b5983c960c0fdf9@localhost> <vpqli4cfhhe.fsf@anie.imag.fr> <813506281f7a4d3a8af650c5f8ee33dd7224f193@localhost> <vpqfvukfgr5.fsf@anie.imag.fr> <edc9f41b4ffca9ce36dc50e749de7a86e4618a0e@localhost> <87fvuk1cyl.fsf@linux-k42r.v.cablecom.net> <5203B100.30008@gmail.com> <87txj0i4mc.fsf@inf.ethz.ch> <7vsiyk9j6a.fsf@alter.siamese.dyndns.org> <5204E018.4000808@gmail.com> <5204E67D.9090106@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ben Tebulin <tebulin@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Aug 14 11:29:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9XOd-0005E8-At
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 11:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089Ab3HNJ3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 05:29:31 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35810 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430Ab3HNJ31 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 05:29:27 -0400
Received: by mail-wi0-f181.google.com with SMTP id en1so1688332wid.2
        for <git@vger.kernel.org>; Wed, 14 Aug 2013 02:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=FQisIaiBAt1DXpe8cSv6AElMG6fhuKcVCo+9uxc6tgM=;
        b=HHNtu3bjd+8buhSx+WshyyMrn4FXpBRBhfygg7idOTbCdxni7iMQFm6+fq3sWpzwcW
         a7DYrxmmSsLlCfntF3PkwJcQiX++meTBx17knYGTSvf6MAxK6Rn5BJ9mN+gkgtF7UaGi
         YJTuxieaLL4SBRWkSnz3YRqGbukzEn3p41aHv8KPnIKkWgtVffhzMpaAmLmho9s61kRN
         wcW8WF79rrv/uLWdobHxQc+mgjUO0njqp9nq6tECBC79XajmY6sFvLn7AY9TAwoHznnQ
         2r5cccpF+pvZs0gWxrLwSVTuH5HsEGENq6KCn8sbgKa/HAPUkn8rBVmdxlH1Ku/CS253
         X9ug==
X-Received: by 10.180.75.239 with SMTP id f15mr5571599wiw.43.1376472566053;
        Wed, 14 Aug 2013 02:29:26 -0700 (PDT)
Received: from [127.0.0.1] (ulmg-5d845cdb.pool.mediaWays.net. [93.132.92.219])
        by mx.google.com with ESMTPSA id jc18sm200220wic.5.2013.08.14.02.29.23
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 14 Aug 2013 02:29:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <5204E67D.9090106@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232278>

Hello everybody!

I'm the guy having the issue, that in a particular Git repository the
reads of an object fail the SHA1 reproducible on *two independent
machines* .

The issue occurs on a very specific repository starting with Linux
Kernel 3.7.2. Unfortunately my E-Mail to the kernel list dit get no
response.

After a long session of rebooting and bisecting the Linux kernel
(fortunately I had a SSD and ccache!) I was able to pinpoint this to the
following patch related to _memory management_ causing my data
corruption with git:

*"mm: limit mmu_gather batching to fix soft lockups on !CONFIG_PREEMPT"*
  787f7301074ccd07a3e82236ca41eefd245f4e07 linux stable [1]
  53a59fc67f97374758e63a9c785891ec62324c81 upstream commit [2]

The patch speaks about "batching [memory] pages to be freed" so I'm a
bit unsure: Is this a Git or a Linux kernel issue?


Thanks
- Ben


[1] https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/commit/?id=787f7301074ccd07a3e82236ca41eefd245f4e07
[2] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=53a59fc67f97374758e63a9c785891ec62324c81
