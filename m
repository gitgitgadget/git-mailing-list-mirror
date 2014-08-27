From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC] improving advice message from "git commit" during a merge
Date: Wed, 27 Aug 2014 11:23:08 -0700
Message-ID: <xmqq4mwxeqr7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 27 20:23:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMhsS-0005je-2N
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 20:23:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935615AbaH0SXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 14:23:20 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59154 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932413AbaH0SXT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 14:23:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B281A33F45;
	Wed, 27 Aug 2014 14:23:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=2
	TU+khEIl0od8GqWQLe/EjFgZIE=; b=QF2wkWIwHi8JoxBFAO342XO7WwNsKooyI
	Y9GV+nHA8wD5M9CBfc20ep3mIash3S/5M8RJ2Obj//u7+2M0ROPnEE+RAimfcTn6
	6+AyYfP1xFbgyLLk+o4AmdcFzte1X5mwB2zqUrnbSkhixvbbo1BcoNMYEHa7FztZ
	+fPCySrt+8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=UY1
	qsIO9flKBp/76oZVIDRXfoAN+gl3E8AAZa/iURCLYawD2FBkM4Gywh4TMwkS9xW/
	lk7UTOuxgh7ghm/oBTA7YarAVWmApODGkmermZZSnkeLVoxe9u9ZrmjNNhy3L4mC
	wPVz0LTpFg3trPr4XYfQ2SW5LneHIZ2IJNSzZhck=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A8DBF33F43;
	Wed, 27 Aug 2014 14:23:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A4AB733F3B;
	Wed, 27 Aug 2014 14:23:10 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 333F35D2-2E17-11E4-BAFE-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256020>

When there are unmerged paths, you would often get something like
this:

    [git.git (pu|MERGING]$ git commit
    U       copy.c
    U       wrapper.c
    error: commit is not possible because you have unmerged files.
    hint: Fix them up in the work tree, and then use 'git add/rm <file>'
    hint: as appropriate to mark resolution and make a commit, or use
    hint: 'git commit -a'.
    fatal: Exiting because of an unresolved conflict.

which is all good and correct, but I am wondering if we can be a bit
more helpful by customizing the message in various ways.

 - When all the unmerged paths have their conflicts resolved in the
   working tree, we do not have to say "Fix them up in the work
   tree,".  We can instead say "You seem to have fixed them up in
   the work tree already," or something.

 - When some of the unmerged paths have their conflicts still in the
   working tree, we can name them separately from the ones that have
   already been dealt with.

    U       copy.c
    U       wrapper.c (conflicts already resolved in the working tree)

 - Hasty-and-careless new users will be incorrectly enticed to type
   the command given by "or use 'git commit -a'" at the end of this
   advice message without thinking.  Perhaps it is safer to stop the
   sentence at "... and make a commit." and drop that last bit while
   there are conflicts still in the working tree files.  We should
   use the current end-of-message only when all the conflicts have
   been resolved in the working tree.

 - The "/rm" in "use 'git add/rm <file>'" is often useless, as it is
   much rarer to remove a path than adding one.  Perhaps show that
   part only when there is a conflicted path with stage #2 but not
   stage #3 (i.e. they kept what we removed) or vice versa.  "add"
   needs to stay there no matter what, as that is how we tell the
   index "this is the final content".

I am not doing this myself soon, though.  Hint, hint...
