From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge: refuse to create too cool a merge by default
Date: Wed, 06 Apr 2016 11:36:45 -0700
Message-ID: <xmqqwpoawpmq.fsf@gitster.mtv.corp.google.com>
References: <xmqqshznpmfe.fsf@gitster.mtv.corp.google.com>
	<CA+55aFz7309BkfHjD5H7tp9WE0yf1VWncxfmB3hgimJ00fbT-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 06 20:36:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ansJz-0002MA-3E
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 20:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491AbcDFSgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 14:36:50 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:51235 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752391AbcDFSgs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 14:36:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 847865251F;
	Wed,  6 Apr 2016 14:36:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1NDKRqr4vAkTsgkAWsInTkFnD1k=; b=x+5yzf
	GOU7DFWLG7r+T9JKGyakaW/RsWdclHllFlt+OFuVJ/22s241V0IYuxk7Cc28Vf7R
	Tzbn53zeYer2YCx6jDbcfBpGCKP7OB00K6Cc1XU2sHH7hvkgNN3bGglTNn352kxL
	KEMl0n0spRyfy5b23un6VsoA/PSBWt9/AT97Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dslKoVVTNo71/u0PWxcHlc/sLvn9xT+C
	ZUPuGWM62mQbO6ILYQhHtF71FLnk/elc8hWI9sI7/K2v3EVloXklnByn0PFPgzsz
	SLAo9Xaj7Z3GyKfBwhVN5K8M7xlaCSVpi5FYPVvJ5PJb8/T7c9KsAKD2XeOp3+Ty
	/RVT00dbFwI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7A9C15251E;
	Wed,  6 Apr 2016 14:36:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E90EC5251D;
	Wed,  6 Apr 2016 14:36:46 -0400 (EDT)
In-Reply-To: <CA+55aFz7309BkfHjD5H7tp9WE0yf1VWncxfmB3hgimJ00fbT-Q@mail.gmail.com>
	(Linus Torvalds's message of "Fri, 18 Mar 2016 13:25:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 84AEE3B6-FC26-11E5-8C0C-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290860>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, Mar 18, 2016 at 1:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> While it makes sense to allow merging unrelated histories of two
>> projects that started independently into one, in the way "gitk" was
>> merged to "git" itself aka "the coolest merge ever", such a merge is
>> still an unusual event.  Worse, if somebody creates an independent
>> history by starting from a tarball of an established project and
>> sends a pull request to the original project, "git merge" however
>> happily creates such a merge without any sign of something unusual
>> is happening.
>>
>> Teach "git merge" to refuse to create such a merge by default,
>> unless the user passes a new "--allow-unrelated-histories" option to
>> tell it that the user is aware that two unrelated projects are
>> merged.
>
> Heh. I had a separate set of patches for you, but hadn't sent them out
> because of the other test failures (which you also worked out).

I was reviewing the topics to merge to 'master', and a thought
crossed my mind.  Both of our series only refuse to create a merge
that does not have any common ancestor, but shouldn't the right
solution refuse to add a new root?  That is, somebody may

 - Create a new root by mistake;
 - Pull from you to update, with --allow-unrelated-histories option;
 - Optionally, build more history on top of it; and then finally
 - Ask you to pull without telling you that there is a new root.

Wouldn't the "git pull" you do in response to this pull request have
a common ancestor (i.e. the tip of what he pulled from you in the
second step) and evade this check?
