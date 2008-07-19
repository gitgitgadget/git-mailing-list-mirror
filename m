From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Windows: set gitexecdir = $(bindir)
Date: Sat, 19 Jul 2008 10:28:05 -0700
Message-ID: <7vmykd238a.fsf@gitster.siamese.dyndns.org>
References: <1216366485-12201-1-git-send-email-johannes.sixt@telecom.at>
 <1216366485-12201-5-git-send-email-johannes.sixt@telecom.at>
 <7vej5q67dq.fsf@gitster.siamese.dyndns.org>
 <200807191052.20057.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sat Jul 19 19:29:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKGF8-0001Ht-4a
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 19:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754627AbYGSR2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 13:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754346AbYGSR2O
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 13:28:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48270 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754360AbYGSR2N (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 13:28:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AA7A935074;
	Sat, 19 Jul 2008 13:28:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D877F35073; Sat, 19 Jul 2008 13:28:07 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 104D79E6-55B8-11DD-AD8E-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89115>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> On Samstag, 19. Juli 2008, Junio C Hamano wrote:
>> Sorry, I am not sure if I understand what you are trying to solve.  If you
>> have ../libexec/git-core/ in GIT_EXEC_PATH (or have builtin_exec_path()
>> use it), then your installation would look like this:
>>
>> 	[[some random place]]
>>         	bin/git
>>                 libexec/git-core/git-add
>>                 libexec/git-core/git-del
>>                 libexec/git-core/git-dir
>>                 ...
>>
>> and if "git" can figure out it is "[[some random place]]/bin/git",
>> it can find its subcommands from neighbouring directory, that is still
>> inside the random place the user told the installer to use, can't it?
>
> Yes, but...
>
> Take as an example 'git pull'.
>
> - The first call to git will derive the exec-path 
> $prefix/bin/../libexec/git-core and prepend it to $PATH.
>
> - Calls to builtin git commands from inside 'git pull' will then derive the 
> exec-path $prefix/bin/../libexec/git-core/../libexec/git-core, that is 
> $prefix/libexec/libexec/git-core, and prepend it to $PATH as well. That 
> directory does not exist - usually - and it does not hurt. But it feels dirty 
> and potentially dangerous.

You run "git" with an argument "pull".  It needs to figure out where
"git-pull" is, it checks where it came from and adds ../libexec/git-core/.
Then it runs "git-pull" script.

Then the script may have a call to "git ls-files -u" or "git-merge".

 - The former case, "git" again needs to find out where "git-ls-files"
   is.

   If "git" is found as bin/git and not as libexec/git-core/git, this
   should be perfectly fine, isn't it?  Perhaps we install a duplicate
   copy there by mistake, which is what we need to fix?

 - The latter case (our scripts source git-sh-setup so they have libexec
   one in the PATH when they are started) would find "git-merge" directly
   and runs it.

In either case, the programs "git-ls-files" and "git-merge" do not need to
do the same discovery -- are we giving them enough clues when we run them
to let them avoid that?
