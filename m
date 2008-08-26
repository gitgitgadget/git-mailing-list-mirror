From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 properly indented] fix start_command() bug when stdin
 is closed
Date: Tue, 26 Aug 2008 08:33:48 +0200
Message-ID: <48B3A3CC.3060906@viscovery.net>
References: <quack.20080825T0128.lthr68djy70@roar.cs.berkeley.edu> <48B28CF8.2060306@viscovery.net> <48B29C52.8040901@gnu.org> <E1KXawS-0001gg-Ty@fencepost.gnu.org> <48B2AFC2.20901@viscovery.net> <E1KXcH3-0000zJ-0m@fencepost.gnu.org> <7vbpzgb94q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Paolo Bonzini <bonzini@gnu.org>, Karl Chen <quarl@cs.berkeley.edu>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 08:39:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXsCm-00005v-4E
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 08:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbYHZGdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 02:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbYHZGdz
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 02:33:55 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:7507 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbYHZGdz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 02:33:55 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KXs7h-000721-G6; Tue, 26 Aug 2008 08:33:49 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2265B54D; Tue, 26 Aug 2008 08:33:49 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vbpzgb94q.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93714>

Junio C Hamano schrieb:
> Paolo Bonzini <bonzini@gnu.org> writes:
> 
>>  int start_command(struct child_process *cmd)
>>  {
>>  	int need_in, need_out, need_err;
>>  	int fdin[2], fdout[2], fderr[2];
>>  
>>  	/*
>> +	 * Make sure that all file descriptors <= 2 are open, otherwise we
>> +	 * mess them up when dup'ing pipes onto stdin/stdout/stderr.  Since
>> +	 * we are at it, save a file descriptor on /dev/null to use it later.
>> +	 */
>> +	if (devnull_fd == -1) {
>> +		devnull_fd = open("/dev/null", O_RDWR);
>> +		while (devnull_fd >= 0 && devnull_fd <= 2)
>> +			devnull_fd = dup(devnull_fd);
>> +		if (devnull_fd == -1)
>> +			die("opening /dev/null failed (%s)", strerror(errno));
>> +	}
>> +
> 
> I may be misreading the patch but, this logic always opens /dev/null, if
> nobody asked for *any* cmd->no_stdXXX and low 3 fds are occupied, and
> worse, it keeps fd=3 open.
> 
> Making sure low fds 0, 1 and 2 are open is a good thing.  I do not think
> clobbering fd=3 is good.

It is sometimes _unnecessary_, but I don't see why it should hurt. The
effect on performance will be in the noise.

> Also shouldn't this be done only on the side that dup()s fds around,
> i.e. in the child process after fork()?  Why is this done for the parent?

Because it must be done *before* the pipe()s are created so that they
don't occupy fds 0-2.

-- Hannes
