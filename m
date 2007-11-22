From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Replace setenv(GIT_DIR_ENVIRONMENT, ...) with set_git_dir()
Date: Wed, 21 Nov 2007 23:52:05 -0800
Message-ID: <7vsl2y90pm.fsf@gitster.siamese.dyndns.org>
References: <11956768414090-git-send-email-prohaska@zib.de>
	<11956768412804-git-send-email-prohaska@zib.de>
	<11956768413887-git-send-email-prohaska@zib.de>
	<11956768412755-git-send-email-prohaska@zib.de>
	<Pine.LNX.4.64.0711220121560.27959@racer.site>
	<7v63zv9fel.fsf@gitster.siamese.dyndns.org>
	<C50619A0-4A67-4968-8431-D7A685F723B7@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Dmitry Kakurin <Dmitry.Kakurin@gmail.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Nov 22 08:52:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv6rQ-0004g5-VR
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 08:52:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbXKVHwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 02:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbXKVHwO
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 02:52:14 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:34741 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbXKVHwO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 02:52:14 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 9AAC32EF;
	Thu, 22 Nov 2007 02:52:33 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id EEACA968BE;
	Thu, 22 Nov 2007 02:52:28 -0500 (EST)
In-Reply-To: <C50619A0-4A67-4968-8431-D7A685F723B7@zib.de> (Steffen Prohaska's
	message of "Thu, 22 Nov 2007 07:13:50 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65746>

Steffen Prohaska <prohaska@zib.de> writes:

> On Nov 22, 2007, at 3:34 AM, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>> Does this not have a fundamental issue?  When you call other git
>>> programs
>>> with run_command(), you _need_ GIT_DIR to be set, no?
>>
>> It is much worse.  set_git_dir() does not just setenv() but does
>> setup_git_env() as well.
>
> What do your comments mean?
>
> My understanding is that set_git_dir() sets the environment and
> then calls setup_git_env() to cache all pointers.  This call
> updates dangling pointer if they have been cached earlier.

Well, I was agreeing with you.  "Worse" was about what the
current code does _not_ do.

If there are earlier calls that obtain locations relative to the
earlier definition of GIT_DIR, the locations they obtained are
not just stored in memory that is "dangling" (which was what
your proposed log message described) but they are also
inconsistent with the updated definition of GIT_DIR.

I suspect Johannes mistook set_git_dir() was only local
(i.e. per calling process) matter without noticing that it has
its own setenv() when he made that comment, hence my response to
point out that the current code only calls setenv(), but
set_git_dir() does setup_git_env() too, which should hide the
inconsistency problem.

HOWEVER.

I suspect that if there are even earlier callers than these
early parts in the codepaths (handle_options, enter_repo, and
setup_git_directory_gently), maybe these earlier callers are
doing something wrong.  Logically, if you are somewhere very
early in the codepath that you can still change the value of
GIT_DIR, you shouldn't have assumed the unknown value of GIT_DIR
and cached locations relative to that directory, no?  What are
the problematic callers?  What values do they access and why?
