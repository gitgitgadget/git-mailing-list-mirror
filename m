From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Submodules always use a relative path to gitdir
Date: Thu, 05 Jan 2012 16:11:30 -0800
Message-ID: <7vlipllmfh.fsf@alter.siamese.dyndns.org>
References: <1325192426-10103-1-git-send-email-antony.male@gmail.com>
 <7vsjk3vw67.fsf@alter.siamese.dyndns.org> <4F007492.8010909@web.de>
 <7vsjjwvdyl.fsf@alter.siamese.dyndns.org> <4F037CBF.9010005@web.de>
 <7vhb0csa6w.fsf@alter.siamese.dyndns.org> <4F0629C6.9010908@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antony Male <antony.male@gmail.com>, git@vger.kernel.org,
	iveqy@iveqy.com
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Jan 06 01:11:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RixPH-0004AW-BZ
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 01:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933018Ab2AFALe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jan 2012 19:11:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36443 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932235Ab2AFALd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jan 2012 19:11:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 970AB750C;
	Thu,  5 Jan 2012 19:11:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p1cetRtFwN/yu5a9RuL2xLzvdtQ=; b=VeIw8r
	HvJtu8/03arE3pKJiXj8k47ShGk14DPV2jr6LPzSWykeha9XeNbBNLGoa4KCV6fX
	paYlzbS8gr5qJPYSh+umrbveJ16mLf6tfu0ROeaQpK+iys//r7jWLkwDbXyXiXzr
	GlL9XQ+LpLzZcJohrKKMlyUV5AjTejWG8v9Zo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l5V/7lc004tKxt2gGe5Ek0TktKXwf8gL
	gAtp3Ogk6vDVvqxhO2pN/oINfx0Nowkv/doFZ9p6v9jaZZYdgCgoTNWQCmLR1gri
	KtgOexeA+7nic57khX1AdQQOprtFeYl8El0j1q4b07d3a+44gmjDqXTNsBBUdOD6
	SLuqhhnWIjs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DF90750B;
	Thu,  5 Jan 2012 19:11:32 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B5D47507; Thu,  5 Jan 2012
 19:11:32 -0500 (EST)
In-Reply-To: <4F0629C6.9010908@web.de> (Jens Lehmann's message of "Thu, 05
 Jan 2012 23:52:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FCD8C72A-37FA-11E1-B146-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188008>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> So in the long run I suspect we might have to change core git anyways
> to make moving submodules easy for the user (surely "git mv" and maybe
> also the setup and gitfile code). Does that make more sense?

If you need to change "git mv" anyway to help moving submodule checkout,
then how gitfile points into .git/modules/ hierarchy of the superproject
becomes an implementation detail the end users should not have to care
about.

What does "if we reached thru a gitfile, then the working tree is where
you found that gitfile" really solve? The way you found that gitfile is by
traversing the directory hierarchy upwards from a subdirectory of a
working tree of a submodule, and you already know where the top of that
working tree is, no?

And the heuristics would not work if somebody goes into the $GIT_DIR/ that
governs the submodule as going upwards from there will not hit gitfile, so
we would need help from core.worktree anyway. A non-submodule setting that
uses gitfile would need to worry about core.worktree, too, so I'd rather
avoid loading more heuristics to gitfile handling unless there is a clear
advantage for doing so, which I am not really seeing here.

That is not really a "If not" below (i.e. I am not saying it is _not_ OK.
I am saying I don't know what the advantage of that approach is), but ...

> If not I'm fine with just setting core.worktree to a relative path in
> the git-submodule.sh script (like I did for the gitfile). And I'll look
> into teaching "git mv" about submodules right after that.

... teaching "git mv" may be a good move, I would think. I do think keeping
core.worktree pointing at the right directory is necessary, but I do not
see much point in making it a relative path, though.
