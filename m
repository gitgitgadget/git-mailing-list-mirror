From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] for-each-repo: new command used for multi-repo
 operations
Date: Sun, 27 Jan 2013 11:45:23 -0800
Message-ID: <7v4ni2wgto.fsf@alter.siamese.dyndns.org>
References: <1359290777-5483-1-git-send-email-hjemli@gmail.com>
 <1359290777-5483-2-git-send-email-hjemli@gmail.com>
 <7vk3qywiqf.fsf@alter.siamese.dyndns.org>
 <20130127194223.GR7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jan 27 20:45:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzYAn-0006zy-J2
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 20:45:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755796Ab3A0Tp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 14:45:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39486 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755745Ab3A0Tp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 14:45:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25400B405;
	Sun, 27 Jan 2013 14:45:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vpy0CD2Y+T0QLsMDUmJrQssgCNg=; b=OA3E0M
	Ix5s8xHKrM0LApKUhb5EdkRTy75UU6CDwmnEbFBV+EQd5745AtVu5+Zy6GnihNcW
	mfB4TgITq7/vKieq8PtfRdi9//iCwpPuwkE4mB7mEH3fV1sKLxFQoCWcK9BI41Fz
	TXfgLi0Oi0tuRnueKWtRr7QgHtR46wUFKe874=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yiyxOHMm6eZvMcBBbkvXeM/oY4JLbBDT
	Ua9Hbj5BaFSmJJEZ3tTP1wng/MpbbibX00LblR7fHdaCEmvlWeQES34bkZmtwT9e
	TkKiuTKflAbpN2HI7iri05BABi4rAcSDyEntM08jEuyYM72hGJlzQneiGILsqs7i
	ZI1DGKEIDfM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A84DB402;
	Sun, 27 Jan 2013 14:45:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 42F0FB3FF; Sun, 27 Jan 2013
 14:45:25 -0500 (EST)
In-Reply-To: <20130127194223.GR7498@serenity.lan> (John Keeping's message of
 "Sun, 27 Jan 2013 19:42:23 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 18250048-68BA-11E2-AE8B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214719>

John Keeping <john@keeping.me.uk> writes:

> On Sun, Jan 27, 2013 at 11:04:08AM -0800, Junio C Hamano wrote:
>> One more thing that nobody brought up during the previous reviews is
>> if we want to support subset of repositories by allowing the
>> standard pathspec match mechanism.  For example,
>> 
>> 	git for-each-repo -d git diff --name-only -- foo/ bar/b\*z
>> 
>> might be a way to ask "please find repositories match the given
>> pathspecs (i.e. foo/ bar/b\*z) and run the command in the ones that
>> are dirty".  We would need to think about how to mark the end of the
>> command though---we could borrow \; from find(1), even though find
>> is not the best example of the UI design.  I.e.
>> 
>> 	git for-each-repo -d git diff --name-only \; [--] foo/ bar/b\*z
>> 
>> with or without "--".
>
> Would it be better to make this a (multi-valued) option?
>
>     git for-each-repo -d --filter=foo/ --filter=bar/b\*z git diff --name-only

The standard way to use filtering based on paths we have is to use
the pathspec parameters at the end of the commmand line.

I see no reason for such an inconsistency with an option like --filter.

>> Oh, that reminds me of another thing.  Perhaps we would want to
>> export the (relative) path to the found repository in some way to
>> allow the commands to do this kind of thing in the first place?
>> "submodule foreach" does this with $path, I think.
>
> I think $path is the only variable exported by "submodule foreach" which
> is applicable here, but it doesn't work on Windows, where environment
> variables are case-insensitive.
>
> Commit 64394e3 (git-submodule.sh: Don't use $path variable in
> eval_gettext string) changed "submodule foreach" to use $sm_path
> internally although I notice that the documentation still uses $path.
>
> Perhaps $repo_path in this case?

I do not care too deeply about the name, as long as the names used
by both mechanisms are the same.
