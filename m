From: Junio C Hamano <gitster@pobox.com>
Subject: Re: `git log relative_path_to_object` does not respect the --work-tree path
Date: Mon, 29 Sep 2014 11:06:22 -0700
Message-ID: <xmqqy4t2ti75.fsf@gitster.dls.corp.google.com>
References: <CABj5xzc0bVfyzR5PD5K3STSvdvWEOYeMkayB=GTfKbfij+G5Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Roberto Eduardo Decurnex Gorosito <decurnex.roberto@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 29 20:06:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYfLD-0001lK-NO
	for gcvg-git-2@plane.gmane.org; Mon, 29 Sep 2014 20:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754319AbaI2SG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2014 14:06:27 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50663 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754199AbaI2SGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2014 14:06:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B0CBD3D640;
	Mon, 29 Sep 2014 14:06:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MeKSZEiwoLIFy60ozTzcNZ/LDBE=; b=eDZ0hP
	esqaD/EJhT67Z7HKWnEWEnObZ4WQsuk7FiKRtxtGUjuYim6vV2tvdwTQT6ogy1t8
	SZCDGw9vXmgbJ+mbXCYSsFglMpwLagRy50V/qiTNfCtHYY2sVuvrE7qvJMEjBcB0
	0oJlqADIkhgrD79pAIDglGz2K8dtY5mGMveDg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BBKkIhwrv5/ZWG3W7M0sIg6OSS8aHBHP
	V8dm+u7qO38fDhBbshzNnarZq8wJdA4jx0fiTGYpXERfvm5C0Ql0uwzOmgYrDNZ9
	s0ULhCCZX2NVETcgrMxfMwmIvQcWgqSVYsq+VAFmWoxV9VTa95zveWT1HJ2rK9wa
	KMawvCEYKgo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A6F223D63F;
	Mon, 29 Sep 2014 14:06:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2ED5D3D63A;
	Mon, 29 Sep 2014 14:06:24 -0400 (EDT)
In-Reply-To: <CABj5xzc0bVfyzR5PD5K3STSvdvWEOYeMkayB=GTfKbfij+G5Zw@mail.gmail.com>
	(Roberto Eduardo Decurnex Gorosito's message of "Mon, 29 Sep 2014
	13:40:06 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 52F7D78E-4803-11E4-9AED-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257634>

Roberto Eduardo Decurnex Gorosito <decurnex.roberto@gmail.com>
writes:

> ~/path$ git --work-tree=~/path/to_repo log README.md

This does not seem to specify GIT_DIR explicitly (either with the
$GIT_DIR environment variable or the --git-dir option), so I would
assume that you are sitting in a directory that has ".git/"
subdirectory or a subdirectory of such a directory, but that ".git/"
is not a real repository that controls the working tree you have at
the ~/path/to_repo directory.

The --work-tree option and $GIT_WORK_TREE environment were primarily
invented to solve this problem:

    When a user gives $GIT_DIR or --git-dir to disable the
    repository discovery (i.e. trying to see if the current
    directory has ".git/" that looks like a repository, and if not
    try the parent directory until we find one), traditionally we
    assumed that the current directory is the top-level of the
    corresponding working tree.  This makes it cumbersome to work
    inside a subdirectory, and by allowing $GIT_WORK_TREE or
    --work-tree to specify the top-level of the working tree,
    working from a subdirectory of a working tree becomes usable
    again.

That is why it does not mix very well with repository discovery
(i.e.  letting Git crawl upward from the current directory to find a
directory with ".git/").  It is unclear if the auto-discovered
".git" is the one to be be consulted for the "log" operation you
asked, or the other repository you have at ~/path/to_repo/.git (or
one of its parent directories, e.g. ~/path/.git).  I _think_ the
current implementation randomly chose to use the auto-discovered
one, but it may have been better to forbid and always require both
--git-dir and --work-tree to be given to avoid confusion.
