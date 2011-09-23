From: Alexander Pepper <pepper@inf.fu-berlin.de>
Subject: Re: Bug: git log --numstat counts wrong
Date: Fri, 23 Sep 2011 12:30:13 +0200
Message-ID: <8AEDF5F8-19B5-4502-BB53-EC6CEE0E5CB2@inf.fu-berlin.de>
References: <D3CF0A47-64DA-4EBB-9DCD-D2D714596C50@inf.fu-berlin.de> <7vr53a2icn.fsf@alter.siamese.dyndns.org> <3BF8BA51-4CAA-40A2-8B45-D39AAEE58E6F@inf.fu-berlin.de> <7vobyd1vmo.fsf@alter.siamese.dyndns.org> <7vobycxy71.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 12:30:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R731V-0006UG-5W
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 12:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753054Ab1IWKaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 06:30:20 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:55481 "EHLO
	outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753036Ab1IWKaT convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 06:30:19 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost1.zedat.fu-berlin.de (Exim 4.69)
          with esmtp
          (envelope-from <pepper@inf.fu-berlin.de>)
          id <1R731M-0003MZ-1o>; Fri, 23 Sep 2011 12:30:16 +0200
Received: from 91-66-162-110-dynip.superkabel.de ([91.66.162.110] helo=[10.1.19.172])
          by inpost2.zedat.fu-berlin.de (Exim 4.69)
          with esmtpsa
          (envelope-from <pepper@inf.fu-berlin.de>)
          id <1R731L-0007rq-Qn>; Fri, 23 Sep 2011 12:30:16 +0200
In-Reply-To: <7vobycxy71.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1084)
X-Originating-IP: 91.66.162.110
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181957>

Am 22.09.2011 um 19:51 schrieb Junio C Hamano:
> So perhaps a good sanity-check for you to try (note: not checking your
> sanity, but checking the sanity of the above analysis) would be to do:
> 
>  $ git show 48a07e7e53 -- $that_path | diffstat
>  $ git show -U0 48a07e7e53 -- $that_path | diffstat
>  $ git show --numstat 48a07e7e53 -- $that_path
>  $ git show --stat 48a07e7e53 -- $that_path
[...]
> Applying the following patch should make the last two use the default
> context or -U$num given from the command line to be consistent with the
> codepath where we generate textual patches.
> 
> diff.c |    2 ++
> 1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/diff.c b/diff.c
> index 9038f19..302ef33 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2251,6 +2251,8 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
> 		memset(&xpp, 0, sizeof(xpp));
> 		memset(&xecfg, 0, sizeof(xecfg));
> 		xpp.flags = o->xdl_opts;
> +		xecfg.ctxlen = o->context;
> +		xecfg.interhunkctxlen = o->interhunkcontext;
> 		xdi_diff_outf(&mf1, &mf2, diffstat_consume, diffstat,
> 			      &xpp, &xecfg);
> 	}

First of all: thank you for your extended feedback, your respectful e-mails and your patch!

I did some benachmarking. I compared git version 1.7.6.3 with 1.7.7.rc2 and 1.7.7.rc2 with the above patch.

My test setup:
git version 1.7.6.3: 740a8fc2
git version 1.7.7.rc2: 167a5800
git version 1.7.7.rc2': 167a5800 with the above patch applied. 
Tuple (15,07) shows 15 lines added and 7 lines removed

$ git show $rev -- $that_path | diffstat
$ git show -U0 $rev -- $that_path | diffstat
$ git log --numstat -n1 --oneline $rev
$ git show --stat --oneline -n1 $rev -- $that_path

Test 1:
repo='https://github.com/voldemort/voldemort.git'
rev='48a07e7e'
that_path='src/java/voldemort/server/storage/StorageService.java'
Results:
1.7.6.3	1.7.7.rc2	1.7.7.rc2'
(10,09)	(10,09)	(10,09)
(11,10)	(10,09)	(10,09)
(11,10)	(10,09)	(10,09)
(11,10)	(10,09)	(10,09)

Test 2:
repo='https://github.com/voldemort/voldemort.git'
rev='c21ad764'
that_path='contrib/hadoop-store-builder/src/java/voldemort/store/readonly/mr/HadoopStoreBuilderReducer.java'
Results:
1.7.6.3	1.7.7.rc2	1.7.7.rc2'
(30,27)	(25,22)	(25,22)
(25,22)	(25,22)	(25,22)
(25,22)	(25,22)	(25,22)
(25,22)	(25,22)	(25,22)

Test 3:
repo='private repo'
rev='bd61f26e'
that_path='[...]JmeterTest/loadtests/JMeterLoadTest.jmx'
Results:
1.7.6.3	1.7.7.rc2	1.7.7.rc2'
(450,3544)	(450,3544)	(450,3544)
(401,3495)	(401,3495)	(401,3495)
(401,3495)	(401,3495)	(450,3544)
(401,3495)	(401,3495)	(450,3544)

In Test 1 the patch seems to be different formatted from 1.7.7.rc2, so the context doesn't matter with the newer version.
In Test 2 the patch seems to be different formatted from 1.7.7.rc2, so the context doesn't matter with the newer version.
In Test 3 (which is a private repo) where a lot of different lines where changes, some single lines, some multiple lines long makes the biggest difference. With the different contexts different output is observed. I'm sorry that I can not find an open source example for that, but your patch seems to fix this.

So it seems that the patch output in general changed between 1.7.6.3 and 1.7.7.rc2. If I had the right to vote for your patch, I would give it a +1 :-)

Greetings from Berlin
Alex

PS: Will this patch be in the final version of 1.7.7?