From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Let deny.currentBranch=updateInstead ignore submodules
Date: Mon, 10 Nov 2014 07:42:01 -0800
Message-ID: <xmqq1tpbawqe.fsf@gitster.dls.corp.google.com>
References: <cover.1415368490.git.johannes.schindelin@gmx.de>
	<84dba8872922da96e99953eea0ccff5f5af9dd4a.1415368490.git.johannes.schindelin@gmx.de>
	<xmqqh9yag6mt.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1411101400050.13845@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 10 16:42:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xnr6Z-0008AB-RG
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 16:42:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883AbaKJPmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 10:42:07 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50422 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750993AbaKJPmF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 10:42:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F1E451A03E;
	Mon, 10 Nov 2014 10:42:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZKUqVf7mGGlDvI5vFn8aGDm6+8I=; b=yMPiqW
	p8CAqF4rIZuDphBV2a+1TpDV98n/sUGQeAQc53PRVv7a59FzOlzgOmeRgzAafOkT
	lhS4kthfWxW9znGqav5tajSn+gBC1eGP9+Qkm1y/8e4feN/ULNYupABG5OFdifFK
	ctcy55M2OZf3cJZ3Tsu2u4mRdw5zvYq25pvIo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ns+r5/6BpsoD8Vf1Evme1DllDbUUDmr+
	5TYvnGspLcJ1ihP3h4Q2Hiza5tcwL+5L+PjoZZz37Sg28mHuqqnikpPyoJbWlTQG
	CviZGoL1TFRwE4K2hlSw8UiMrU/76O2PRkXZjNphD/nYMtOD0SI+PDcI+wDYYslw
	yqsZw04nmjg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E83231A03D;
	Mon, 10 Nov 2014 10:42:03 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 38C2C1A03C;
	Mon, 10 Nov 2014 10:42:03 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1411101400050.13845@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Mon, 10 Nov 2014 14:01:20 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1DFBC320-68F0-11E4-BC63-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> By the way, if the expected use case of updateInstead is what I
>> outlined in the previous message, would it make more sense not to
>> fail with "update-index --refresh" failure (i.e. the working tree
>> files have no changes since the index)?
>> 
>> Thinking about it a bit more, checking with "update-index --refresh"
>> feels doubly wrong.  You not just want the working tree files to be
>> pristine with respect to the index, but also you do not want to see
>> any change between the index and the original HEAD, i.e.
>> 
>> 	$ git reset --hard && echo >>Makefile ; git add Makefile
>>         $ git update-index --refresh ; echo $?
>>         0
>> 
>> this is not a good state from which you would want to update the
>> working tree.
>> 
>> Wouldn't the two-tree form "read-tree -u -m" that is the equivalent
>> to branch switching do a sufficient check?
>
> That is indeed what the patched code calls.

I know that ;-), but I think I wasn't clear enough.

I am not saying you are not using two-tree read-tree.  I am saying
the check with update-index --refresh before read-tree seems
dubious.

There are three "cleanliness" we require in various occasions:

 (1) rebase asks you to have your index and the working tree match
     HEAD exactly, as if just after "reset --hard HEAD".

 (2) merge asks you to have your index match HEAD exactly (i.e. no
     output from "diff --cached HEAD"), and have no changes in the
     working tree at paths that are involved in the operation.  It
     is OK to have local changes in the working tree (but not in the
     index) at paths that are not involved in a mergy operation.

 (3) checkout asks you to have your index and the working tree match
     either HEAD or the commit you are switching to exactly at paths
     that are involved in the operation.  It is OK to have local
     changes in the working tree and in the index at paths that are
     not different between the commits you are moving between, and
     it is also OK to have the contents from the "new" commit in the
     working tree and the index at paths that are different between
     the two.

Dying when "update-index --refresh" signals a difference is an
attempt to mimic #1, but it is in line with the spirit of the reason
why a user would want to use updateInstead, I think.  The situation
is more like the person who pushed into your repository from
sideline did a "checkout -B $current_branch $new_commit" to update
the HEAD, the index and the working tree, to let you pretend as if
you based your work on the commit he pushed to you.

While you still need to error out when your local work does not
satisfy the cleanliness criteria #3 above, I do not think you would
want to stop the operation when "checkout" would not fail, e.g. you
have a local change that does not interfere with the update between
the two commits, with this one:

+	if (run_command(&child))
+		die ("Could not refresh the index");

When refreshed the index successfully, we signal that there were
differences between the index and the working tree with a non-zero
return value, so "Could not refresh" is not quite right, either.

But this one that checks the exit status from two-tree read-tree

+	if (run_command(&child))
+		die ("Could not merge working tree with new HEAD.  Good luck.");

is checking the right condition, i.e. cleanliness #3.  The
disposition should not be "die", but an error return to tell the
caller to abort the push as we discussed earlier.
