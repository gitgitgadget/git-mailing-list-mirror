From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git Submodule Problem - Bug?
Date: Tue, 29 Nov 2011 11:21:48 -0800
Message-ID: <7vobvuspir.fsf@alter.siamese.dyndns.org>
References: <38AE3033-6902-48AA-819B-DB4083F1F8EF@gmail.com>
 <201111291024.01230.trast@student.ethz.ch> <20111129101546.GB2829@kolya>
 <201111291125.41943.trast@student.ethz.ch> <20111129104105.GA10839@kolya>
 <4ED5196B.5030200@web.de> <839E634E-76C0-40ED-8CCC-43E52F782079@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Fredrik Gustafsson <iveqy@iveqy.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Manuel Koller <koller.manuel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 29 20:21:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVTFd-0006cK-5C
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 20:21:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755286Ab1K2TVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Nov 2011 14:21:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34221 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753626Ab1K2TVv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2011 14:21:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7835A5D4E;
	Tue, 29 Nov 2011 14:21:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RS5wf2iDAWxp9ae2n+tKwNJFmAE=; b=vJGY8t
	yNK6c4nAxTij7pvfxsNH611Of4UUmJV3BNl0pyQNr+/ctK+wIg0k/WUIy7oEQUXG
	mL+B6briZyAx0Js7BkuSuEwPKyObGeZtheMdcQ5I+/aT4PTaqr5ljZY6dvqNInTn
	92zC/jL0ct6XFtCdK936K+/cD/GF65Y4yYmEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VWo3TVFVDbSXvQ2Okdr/dO16mZ+wJgIK
	F2ATchCoI8RZ3Q7clLIWzcdBY0Z0sckhTxCU5WNb4b3o2BEqGnp8yd1xh9jw+K8D
	i4hdv1zY5dtBhI+kIlNL2uKhyU4XyK/T7fWuXyTIJCM4ap+8zAuhj9p4NlkxHBg5
	3xedmA6xnBw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 701B05D4D;
	Tue, 29 Nov 2011 14:21:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CFEDA5D4B; Tue, 29 Nov 2011
 14:21:49 -0500 (EST)
In-Reply-To: <839E634E-76C0-40ED-8CCC-43E52F782079@gmail.com> (Manuel
 Koller's message of "Tue, 29 Nov 2011 19:15:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 62F22F28-1ABF-11E1-AED0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186073>

Manuel Koller <koller.manuel@gmail.com> writes:

> In have wrote a workaround for the problem i posted that goes into this
> direction. I just check whether the url has changed and remove the
> submodule by hand if it did.

... which might be wrong, depending on how you implement it, so be careful
(see below).

> ...
> What is the purpose of having two different submodules in the same path?
> Identifying the submodule by url however would probably make things
> considerably faster...

There are three primary things involved when talking about a submodule in
a superproject. Its name, its path in the superproject hierarchy, and its
URL (if it is foreign). The canonical example used when discussing the
design of Git submodule support is to imagine your superproject that is
about a small router that has a kernel component as a submodule that lives
in kernel/ hierarchy (your userland may live elsewhere in the tree, either
as a submodule bound at src/ hierarchy or contained in the superproject
itself and it does not make a difference).

You may had two major versions of your product. v1.0 line used to use BSD
kernels, and v2.0 line with linux-2.6 kernels. Even though a checkout of
any version of your superproject has a submodule bound at its kernel/
directory, the logical identity of the submodule used in your v1.0 line of
product and v2.0 line are different. You can differenciate them by giving
them different names, say 'kernel' and 'linux-kernel' [*1*]. When you
checkout the v1.0 tag, kernel/ directory should be populated by the
submodule that house the BSD kernel. When you checkout the v2.0 tag, it
should house the Linux 2.6 kernel.

Now, your v3.0 line will still use linux-2.6 (and now linux-3.0)
kernel. Logically, the kernel project is the same thing. linux-3.0 is just
a continuation of linux-2.6 series and maintained in the *logically* same
upstream repository. However, the repository location has recently changed
and now lives in

    http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

even though it used to be linux-2.6.git in the same hierarchy [*2*]. The
name of the submodule ('linux-kernel') does not have to change, as the
repository in the new location has all the history for linux-2.6 kernel as
well. The URL mapping recorded in .gitmodules in-tree from the submodule
name to the location however needs to change [*3*]. Ideally (I do not
think the current "git submodule" implementation does this), there should
be a more automated way to optionally allow switching the upstream URL of
the 'linux-kernel' subproject bound at kernel/ directory when you switch
between commits in the v2.0 series and in the v3.0 series of the
superproject [*3*], so that the user can say "Yes, I know linux.git URL
contains everything needed from linux-2.6.git URL, so just update the
submodule's upstream URL to linux.git one, and keep it like so; there is
no need to use the older URL even when I check out v2.0 from the
superproject" or "Notice when the URL recorded in .gitmodules for this
project changes when I check out a different version of the superproject,
and use the old URL to update the submodule when I check out the old
version of the superproject".

Even though it is an ancient design discussion, this thread is worth a
read before discussing anything about submodules:

  http://thread.gmane.org/gmane.comp.version-control.git/47466/focus=47498

not because the ideas that were discussed but not implemented in the
current "git submodule" are all good things that should be added, but
because the discussion shows what kind of considerations need to go into
the design.


[Footnotes]

*1* In the ideal world, you would have called it 'bsd' back in your v1.0
days with a foresight that someday you would switch to 'linux', but it is
likely you would not have been perfect.

*2* You can still access it as linux-2.6.git because k.org is trying to be
nice to its users, but that is besides the point.

*3* It becomes relevant if you imagine a case where the old linux-2.6.git
repository at k.org were left frozen at the last version of the 2.6 series
and the new history is only available in linux.git repository.
