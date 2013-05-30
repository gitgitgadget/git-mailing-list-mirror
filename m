From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 1/4] commit: reload cache properly
Date: Thu, 30 May 2013 14:58:49 +0200
Message-ID: <8761y0k4ja.fsf@linux-k42r.v.cablecom.net>
References: <1369915136-4248-1-git-send-email-felipe.contreras@gmail.com>
	<1369915136-4248-2-git-send-email-felipe.contreras@gmail.com>
	<87ehcok6gl.fsf@linux-k42r.v.cablecom.net>
	<CAMP44s1O=VTu8EZi+yOfGMccCpS+pozvZJuDW1mK95U8-YEquA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Adam Spiers <git@adamspiers.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Stephen Boyd" <sboyd@codeaurora.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 14:58:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui2RU-0003ir-CC
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 14:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754664Ab3E3M6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 08:58:53 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:41506 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752877Ab3E3M6w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 08:58:52 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 30 May
 2013 14:58:49 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS11.d.ethz.ch (172.31.38.211) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 30 May 2013 14:58:49 +0200
In-Reply-To: <CAMP44s1O=VTu8EZi+yOfGMccCpS+pozvZJuDW1mK95U8-YEquA@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 30 May 2013 07:35:53 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225980>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, May 30, 2013 at 7:17 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> We are supposedly adding files, to to which cache if 'the_index' is
>>> discarded?
>> [...]
>>>       if (!current_head) {
>>>               discard_cache();
>>> +             if (read_cache() < 0)
>>> +                     die(_("cannot read the index"));
>>>               return;
>>>       }
>>
>> It is not obvious to me that this is a correct change.  discard_cache()
>> without subsequent reloading could also legitimately be used to empty
>> the index.  So if you are fixing a bug, please justify the change and
>> provide a testcase to guard against it in the future.
>
> So istate->initialized is false, yet somebody can still add entries to
> the cache? What happens when somebody else tries to initialize this
> cache? All the entries there will be lost, even though nobody
> discarded it afterwards.

And yet it works, and your patch breaks it.

diff --git i/t/t7501-commit.sh w/t/t7501-commit.sh
index 195e747..1608254 100755
--- i/t/t7501-commit.sh
+++ w/t/t7501-commit.sh
@@ -524,4 +524,16 @@ test_expect_success 'commit a file whose name is a dash' '
 	test_i18ngrep " changed, 5 insertions" output
 '
 
+test_expect_success '--only works on to-be-born branch' '
+	git checkout --orphan orphan &&
+	echo foo >newfile &&
+	git add newfile &&
+	git commit --only newfile -m"--only on unborn branch" &&
+	cat >expected <<EOF &&
+100644 blob 257cc5642cb1a054f08cc83f2d943e56fd3ebe99	newfile
+EOF
+	git ls-tree -r HEAD >actual &&
+	test_cmp expected actual
+'
+
 test_done


-- 
Thomas Rast
trast@{inf,student}.ethz.ch
