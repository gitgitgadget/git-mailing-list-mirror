From: in-gitvger@baka.org
Subject: Re: Project- vs. Package-Level Branching in Git
Date: Fri, 28 Jan 2011 11:39:35 -0500
Message-ID: <201101281639.p0SGdZe1006900@no.baka.org>
References: <14F4737F-E8E4-4E4E-A625-16CA63CF9EFF@shaggyfrog.com> <AANLkTinTRgzv0s9MTyM4TaOwVOmhwRckDqMfxrbsKVfm@mail.gmail.com>
        <15B7CA2E-C584-4563-B9E3-D80861CD9565@shaggyfrog.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Thomas Hauk <tom@shaggyfrog.com>
X-From: git-owner@vger.kernel.org Fri Jan 28 17:39:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PirMS-0002bh-K9
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 17:39:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754805Ab1A1Qjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jan 2011 11:39:43 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from tsutomu.baka.org ([66.114.72.182]:55166 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752793Ab1A1Qjm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jan 2011 11:39:42 -0500
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id p0SGdaWL030312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 28 Jan 2011 11:39:36 -0500
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id p0SGdZe1006900;
	Fri, 28 Jan 2011 11:39:35 -0500
In-reply-to: <15B7CA2E-C584-4563-B9E3-D80861CD9565@shaggyfrog.com>
Comments: In reply to a message from "Thomas Hauk <tom@shaggyfrog.com>" dated "Thu, 27 Jan 2011 15:22:09 -0800."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165625>


In message <15B7CA2E-C584-4563-B9E3-D80861CD9565@shaggyfrog.com>, Thoma=
s Hauk w
rites:

    On Jan 27, 2011, at 12:53 PM, =C6var Arnfj=F6r=F0 Bjarmason wrote:
    > You'll be much better off if you have project-specific repositori=
es.

    But how often do you have a project that has no external or
    internal dependencies on any other packages or libraries? Any
    project I've ever done, big or small, has relied on some existing
    codebase. Imagine a project that uses liba and libb, which both
    reference libc. To use Git, I'd have to have copies of libc
    existing in three repositories, and copies of liba and lib in two
    repositories each. What a nightmare... and that's only a trivial
    hypothetical example.

Including libs in the superproject is the subtree merge method.  It
certainly works and provides inband commit exploration (since one repo
can see all commits), but it inconvenient to update and even harder to
export changes back to share with other liba users.  It may also cause
the repo to be inconveniently large.  Arranging for the correct
commits to be on the differently named branches (between the
subproject and the superproject) is also not convenient.

git-submodule is the normal approach for the problem you have.  There
is a strong binding from each commit in the superproject to commits in
the subprojects.  What is inconvenient is managing what branch you
need to check out on the subproject in order to get or make the right
changes in the right place.  It is also annoying if you are performing
active development on the subprojects since you continually have to
update the superproject and then recheckout the correct branches on
the subproject.

Another solution is gitslave (http://gitslave.sf.net).  This provides
a loose binding from the superproject to the subprojects which is very
convenient if you are doing active development on all of the
subprojects.  Specifically there is only a strong binding when you tag
(since you tag the superproject and all subprojects at the same time).
Generally, however, you check out the same branch/tag on all branches
at the same time, which obviously does not match your preferred usage,
except it gave me an idea.  Specifically, you could have your own
local master bare repositories for those packages and an orthogonal
naming scheme for branches and tags.  So the project foo would might
have branch foo-2.0 and liba libb and libc would all have those
branches as well.  When you want to update libb, a repo with the true
master upstream and the local master upstream would fetch the true
master and merge the changes from the correct branch into foo-2.0
and then push to the local upstream master.  Everyone else would then j=
ust
`gits pull` and would get the changes.

Of course this concept for a local master would work for submodules as
well, depending on whether you want the tight binding and
update/change annoyance or the loose binding and easier
update/changes.

					-Seth Robertson
