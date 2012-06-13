From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCHv5] rebase [-i --exec | -ix] <CMD>...
Date: Thu, 14 Jun 2012 00:43:06 +0200
Message-ID: <4FD9177A.5030303@in.waw.pl>
References: <1339325076-474-1-git-send-email-Lucien.Kong@ensimag.imag.fr> <1339488312-6349-1-git-send-email-Lucien.Kong@ensimag.imag.fr> <4FD70A8E.7050502@in.waw.pl> <7vk3zc4mgz.fsf@alter.siamese.dyndns.org> <4FD89DD6.1070705@in.waw.pl> <20120613200552.Horde.JHFYfHwdC4BP2NaA39-wrmA@webmail.minatec.grenoble-inp.fr> <7vipevgjhp.fsf@alter.siamese.dyndns.org> <20120613213836.Horde.qI8GQnwdC4BP2Ow8uCTQqgA@webmail.minatec.grenoble-inp.fr> <4FD8FF25.6030908@kdbg.org> <7vr4tig7rg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, konglu@minatec.inpg.fr,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 14 00:44:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SewIB-0006ND-8s
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 00:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253Ab2FMWnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 18:43:18 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:38494 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755098Ab2FMWnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 18:43:16 -0400
Received: from 69-mo7-2.acn.waw.pl ([85.222.93.69] helo=[192.168.0.150])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SewHQ-0001jW-5S; Thu, 14 Jun 2012 00:43:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120329 Icedove/10.0.3
In-Reply-To: <7vr4tig7rg.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199955>

On 06/14/2012 12:35 AM, Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> Not so fast.
>>
>> 	exec cmd1 && cmd2
>> and
>> 	exec cmd1
>> 	exec cmd2
>>
>> are far from equivalent: If cmd1 fails, the first version never runs
>> cmd2, but the second version runs cmd2 upon rebase --continue.
> 
> This reminds me of one thing.
> 
> For "exec" insns that are meant to validate each commit in the
> resulting history, what should happen (I am not asking what the
> current implementation of "rebase -i" does) after "exec cmd1" fails?
> 
> Ideally, the user will at that point fix the problem in the code,
> run "commit --amend" to record the fix, and then want to make sure
> it really fixed it by re-running "exec cmd1", no?
> 
> Shouldn't "rebase --continue" after such a "commit --amend" resume
> execution from "exec cmd1", which failed in the initial run?
> 
> I said in the beginning 'For "exec" insns that are meant to validate',
> as "exec" is not necessarily about validation, and other use cases
> of it may want it run only once in the sequence, whether it succeeds
> or fails.  So perhaps we would need two kinds of "exec", one that
> just runs once and is not re-run even if the initial round fails,
> and another (perhaps spell it "test") that runs upon "--continue"
> until it passes.  The latter of course can be skipped by the user
> with "rebase --skip".
A different proposal would be to add a 'rebase --retry' which would
inoke the last command again. And then the advice after 'exec' could say
"Use --retry to rerun this command, and --continue to proceed with the
next one".

--retry could make sense for 'apply' commands too: if a commit fails to
apply, one could do
  git reset --hard HEAD^
  hack hack adjusting the preimage
  git commit
  git rebase --retry

Using --retry to rerun tests would have the advantage that one normally
doesn't think that the tests will fail, so could get into the habit of
using 'exec', not 'test', for the verification commands.

Just thinking aloud.

Zbyszek
