From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 2/2] perf-lib: add test_perf_cleanup target
Date: Thu, 19 Sep 2013 13:42:23 +0200
Message-ID: <87fvt1ghr4.fsf@gmail.com>
References: <1379419842-32627-1-git-send-email-t.gummerer@gmail.com> <1379419842-32627-2-git-send-email-t.gummerer@gmail.com> <xmqq7gefz6m0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, trast@inf.ethz.ch
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 19 13:42:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMcd0-0003fX-LQ
	for gcvg-git-2@plane.gmane.org; Thu, 19 Sep 2013 13:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753834Ab3ISLma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 07:42:30 -0400
Received: from mail-bk0-f42.google.com ([209.85.214.42]:55759 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823Ab3ISLm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 07:42:28 -0400
Received: by mail-bk0-f42.google.com with SMTP id my10so3415161bkb.29
        for <git@vger.kernel.org>; Thu, 19 Sep 2013 04:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=r58KrOr9QiBkEd9cxgr8kh6yqeIS0ZgummcCOx2XwyQ=;
        b=oft+EplRQCttGKsBPXH9zg7QNfTJ8zjHdFDxsqjA9U9y2xHMeaKnBuTDsKymXQRLOs
         mdeXfrGiSwONFvMrAF90a+gxGDoMyKEIVSViaiN1Cr29wivnzA211LGizQiY+b4IiDdu
         UCF8D2ksUSvdpxisxJ/lkiC6wej2w8lOh7tSSb4szCf1nHwSMewwPQTc8j6YA4mzrCPF
         dl+Pv7sNm+PBMEEIGstF/Jqi6RQ5lmyfR8S2K8aJ/PPb+EjdkpwWjfUU033ezkzZYbxK
         J+hUA3ZAOcqRk1tDclvO6gPWMODgsfTWrSFv90KeK3QD8xz2z2cVeYIvRI6ihDBNy7p8
         esIg==
X-Received: by 10.205.86.199 with SMTP id at7mr770925bkc.9.1379590946910;
        Thu, 19 Sep 2013 04:42:26 -0700 (PDT)
Received: from localhost ([2001:5c0:1400:a::bef])
        by mx.google.com with ESMTPSA id nv4sm2776538bkb.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 19 Sep 2013 04:42:26 -0700 (PDT)
In-Reply-To: <xmqq7gefz6m0.fsf@gitster.dls.corp.google.com>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235013>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
>> +For performance tests that need cleaning up after them that should not
>> +be timed, use
>> +
>> +	test_perf_cleanup 'descriptive string' '
>> +		command1 &&
>> +		command2
>> +	' '
>> +		cleanupcommand1 &&
>> +		cleanupcommand2
>> +	'
>> +
>
> Hmm, if "not timing the clean-up actions" is the primary goal, is it
> an option to reuse test_when_finished for this (you may have to make
> sure that the commands run inside it are not timed; I didn't check).

Maybe I wasn't clear enough.  The goal is to allow tests to have
everything cleaned up after every run.  This can then be used for
commands that change the index (or other things) and get back to the
original state after that.  For example something like this:

file=$(git ls-files | tail -n 30 | head -1)

test_expect_success "change a file" "
	echo 'something' >>$file
"

test_perf_cleanup "v5 update-index file" "
	git update-index $file
" "
	git reset
"

test_when_finished on the other hand only cleans up when the whole test
is finished.

> One thing I felt uneasy about the above construct is that it makes
> cleanupcommand2 responsible for handling cases where not just
> command2 but also command1 might have failed.
>
> Compared to that, test-when-finished allows you to control what
> clean-up to do depending on what have already been done, i.e.
>
>         test_when_finished 'undo what command1 would have done' &&
> 	command1 &&
>         test_when_finished 'undo what command2 would have done' &&
> 	command2 &&
>         ...
>
> The second "undo command2" must be prepared for the case where
> command2 may have failed in the middle, but it can at least rely on
> command1 having succeeded when it is run.

When one performance test fails, the testing is aborted and the cleanup
commands are not executed anymore, leaving the trash directory in the
failed state.  This consistent with the normal tests with the immediate
flag passed to them.  (All performance tests have the --immediate flag
on implicitly).
