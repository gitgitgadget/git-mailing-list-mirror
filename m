From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] difftool: avoid symlinks when reusing worktree files
Date: Thu, 29 Oct 2015 10:59:58 -0700
Message-ID: <xmqq8u6lsggx.fsf@gitster.mtv.corp.google.com>
References: <1445981088-6285-1-git-send-email-davvid@gmail.com>
	<xmqq1tcgne4u.fsf@gitster.mtv.corp.google.com>
	<20151029015539.GA12513@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ismail Badawi <ismail@badawi.io>,
	John Keeping <john@keeping.me.uk>,
	Tim Henigan <tim.henigan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 19:00:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrrUh-0007Qj-Li
	for gcvg-git-2@plane.gmane.org; Thu, 29 Oct 2015 19:00:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757517AbbJ2SAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2015 14:00:05 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65341 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756914AbbJ2SAE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2015 14:00:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4522227098;
	Thu, 29 Oct 2015 14:00:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B9qToJ4KHen1ih+XWfpaN3jMI+Y=; b=Vk927o
	yPXtYGVBZJiQoaR/l4zMDaOQ0s9bPxJCGkBUUR+S1+naNSqVPFaOjcTK/eryNMoh
	BoFRltsSfP3xSCRYxgs1S3kuNr8ilqCrTWfmOmsiR+Ag1jl1mTWE887E8CNYKX+t
	X2Qot53oTj2OOIRC6zkzsdpBoPUzxoSHCHdKY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YASrecvrLoMW9RnMHR1jU/YXcX8PlG56
	KodbRxVTDEWiWi9c4G2guJzLEJxUIS1Su3Hkqmzo4kbltBIKFflB/KzSDDIPk9WZ
	NhC9nFsApu3ABpu5M2hg3cJgShVd1Jk3kmQoGcAuvhcL0zlPeyhgEGYloNsyF8LL
	m2wG38ewXXE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EBA9D27094;
	Thu, 29 Oct 2015 14:00:00 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0E04A27085;
	Thu, 29 Oct 2015 14:00:00 -0400 (EDT)
In-Reply-To: <20151029015539.GA12513@gmail.com> (David Aguilar's message of
	"Wed, 28 Oct 2015 18:55:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DF376936-7E66-11E5-9016-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280452>

David Aguilar <davvid@gmail.com> writes:

> Right.  At first I thought I could revise the commit message to
> make it clearer that we simply want to skip all symlinks, since
> it never makes sense to reuse a worktree symlinks, but looking
> at the tests and implementation makes me realize that it's not
> that simple.
>
> This is going to take a bit more time to get right.  John, I was
> hoping you'd be able to take a look -- I'm playing catch-up too.
> When it was first reported I let it sit for a while in hopes
> that the original author would pickup the issue, but months
> passed and I figured I'd take a stab at helping the user out.
>
> Anyways, it'll take me a bit more time to understand the code
> and work out a sensible solution.  My gut feeling is that we
> should adjust the dir-diff feature so that it ignores all
> symlinks.  That seems like a simple answer since we're deciding
> to skip that chunk of complexity.

What dir-diff wants to do is to prepare two directory hierarchies on
the filesystem and run "diff -r" (or an equivalent command of user's
choice) on them, e.g. "diff -r left/ right/".  "left/" tree is
typically what you want to compare your working tree files agaist
(e.g. a clean checkout of "the other version"), and "right/" tree is
populated with either copies of the working tree or symbolic links.
The copying to "right/" feels wasteful, but your working tree may be
littered with build artifacts, and making a clean copy with only
tracked files is one way to make sure that "diff -r" with a clean
checout of "the other version" will not show them.

In the loop that walks the @rawdiff array, there are a lot of "if we
see a symbolic link on the left, do this" before the last one that
says "if the working tree side is not $null (i.e. not missing), ask
ut_wt_file()".  That code remembers which path on either side had
symbolic links.

Later in the same function, there is this comment "Symbolic links
require special treatment."  The intent of the code here is that any
path that involves a symbolic link should be tweaked there.  The
loop over %symlink expects left/ and right/ to be populated normally
by the loop over @working_tree, and then for any path that is a
symbolic link is replaced with a phony regular file (not a symbolic
link) that says "Here is a symbolic link".

So I think it is fine to return $use=0 for any symbolic link from
use_wt_file.  Anything you do there will be replaced by the loop
over %symlink that appears later in the caller.  The caller discards
$wt_sha1 when $use=0 is returned, so the second return value does
not matter.
