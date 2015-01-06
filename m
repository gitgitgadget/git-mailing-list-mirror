From: Junio C Hamano <gitster@pobox.com>
Subject: Re: profile-fast is failing in my Git 2.2.1 build from tar in a Git repo
Date: Tue, 06 Jan 2015 15:13:30 -0800
Message-ID: <xmqq1tn7o63p.fsf@gitster.dls.corp.google.com>
References: <1420408723.7095.207.camel@homebase>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: paul@mad-scientist.net
X-From: git-owner@vger.kernel.org Wed Jan 07 00:14:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8dJh-0005rL-HG
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 00:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208AbbAFXNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 18:13:33 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57184 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750987AbbAFXNc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 18:13:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F38902D3F7;
	Tue,  6 Jan 2015 18:13:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Abpk37Ol9MQI/4rhg1AySndusfw=; b=PJNDfi
	VAQsQ7hmh/yyN5/67SlKqytnWSJ30k9MjUqboRlU8Y/cnVvnuNJfx4/jk/DnyQbj
	d1WLVFaCU//hayM3SG2feMoEwd/IEcYpYqYw8XTv/Fx4JHbd/xLkWdQ9eOltmO/G
	BFpSjmjYIwbSAfERRIQuoFF8GwtPWeGxDrf/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LXQ0A/+woUZGP8QQ9KiTQZ/TN5OjPJFy
	g1Va3GkUQse2siWHrrP3uh76a8WTbRFKQ9QpnnuwnZod6lZADxw4camY4i0rTVU2
	VYgTmGjNnrVWh6mqM5CMcXDOzqOvooOY8qgaoY+pl3EyJplAULOmAPxx+1ub0e20
	R/3jL0P8AgE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EAF012D3F6;
	Tue,  6 Jan 2015 18:13:31 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6EEDD2D3F3;
	Tue,  6 Jan 2015 18:13:31 -0500 (EST)
In-Reply-To: <1420408723.7095.207.camel@homebase> (Paul Smith's message of
	"Sun, 04 Jan 2015 16:58:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A15DC598-95F9-11E4-B971-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262110>

Paul Smith <paul@mad-scientist.net> writes:

> Is anyone aware of this?  It seems that profile-fast fails when invoked
> from a downloaded tarball, if you are in a Git repository when you
> unpack it.

Not me (I don't do profile build), but I am not surprised.

> The problem is in the t/perf/perf-lib.sh:test_perf_create_repo_from()
> function, where we see this:
>
>   repo="$1"
>   source="$2"
>   source_git=$source/$(cd "$source" && git rev-parse --git-dir)
>
> The function is invoked as:
>
>   test_perf_create_repo_from '/home/psmith/src/git-2.2.1/t/perf/trash
> directory.p5302-pack-index' /home/psmith/src/git-2.2.1/t/..
>
> but this doesn't work, because "$source" is not a Git repository; it's
> the root of the unpacked tarball.

Yup, that is exactly why I said I am not surprised.

I do not think profile build is prepared to be run without having
our history (after all, it is not test_perf_create_REPO_from, not
test_perf_create_source_directory_of_git_from).  It wants to create
a repository that hosts a reasonably sized but not too big a
project, i.e. us.

The safest and cleanest fix would be to make sure that the said
function checks if $source/.git is a repository, perhaps?
