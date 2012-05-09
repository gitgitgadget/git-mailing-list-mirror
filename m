From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/19] completion: respect $GIT_DIR
Date: Wed, 09 May 2012 11:54:42 -0700
Message-ID: <7vmx5hrxql.fsf@alter.siamese.dyndns.org>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
 <1336524290-30023-5-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed May 09 20:54:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSC2E-0003qZ-GZ
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 20:54:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760045Ab2EISyq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 May 2012 14:54:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34845 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755968Ab2EISyp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2012 14:54:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CC707E91;
	Wed,  9 May 2012 14:54:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=SMf6mUgcSNJy
	8kwqNJ/lGfJ5QvU=; b=ASeZ4OmS/p7Epj9Lns1lAsng8qJq5brdTrdeYObPeDpY
	Bp829QyNj0fFEGU/ImLxDd69FwmBSTTEZhkOI0nskd8SIFEx4NbwgOvp3s7bQkLv
	6Z1WqhIT7SjYSpmeO+biInfWLnpi4dB/5XY8f/xCogoHAIjsq9awPCM8DQFcEVc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=REBbNd
	cnHGFbQ801cbB2nTyU4t8KBKTBSfdviv6Xj8rqKGeujYmYIPUdJ31u0MFGJHcnvB
	qYoQMih8rKwMwkZ5JMgA6fqSib6cBApI8UPkrYWAzf50/rfvYawWAzY7uJpLrl/V
	KnOn+RsjUwbAhDIMl0paVpITOBf9UdtFDwQFU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 950967E90;
	Wed,  9 May 2012 14:54:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 27C6A7E8F; Wed,  9 May 2012
 14:54:44 -0400 (EDT)
In-Reply-To: <1336524290-30023-5-git-send-email-szeder@ira.uka.de> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?= message of "Wed, 9 May 2012 02:44:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 70DC500A-9A08-11E1-AA6E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197491>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> The __gitdir() helper function finds out the path of the git
> repository by running 'git rev-parse --git-dir'.  However, it has a
> shortcut first to avoid the overhead of running a git command in a
> subshell when the current directory is at the top of the work tree,
> i.e. when it contains a '.git' subdirectory.
>
> If the 'GIT_DIR' environment variable is set then it specifies the
> path to the git repository, and the autodetection of the '.git'
> directory is not necessary.  However, $GIT_DIR is only taken into
> acocunt by 'git rev-parse --git-dir', and the check for the '.git'
> subdirectory is performed first, so it wins over the path given in
> $GIT_DIR.

Strictly speaking, you have to be a bit careful here, though.  If GIT_D=
IR
is set as a shell variable without being exported, it will not affect
where the "git" process you will spawn from your interactive shell sess=
ion
will find the repository.  Only when it is exported it does.

It is a different matter if the distinction matters in the real life, i=
n
other words, GIT_DIR set but not exported is a use case that is worth
worrying about.  But note that our own git-sh-setup script is one such =
use
case, so I wouldn't be surprised if somebody uses it for a strange
workflow (I suspect that might involve a working tree that has its .git
dir in a totally unrelated place, and the user runs "GIT_DIR=3D$GIT_DIR=
 git
subcmd", using the set but not exported GIT_DIR as a typesaver).

> diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
> index a6c9ce94..96468ceb 100755
> --- a/t/t9903-bash-prompt.sh
> +++ b/t/t9903-bash-prompt.sh
> @@ -85,7 +85,7 @@ test_expect_success 'gitdir - parent is a .git dire=
ctory' '
>  	test_cmp expected "$actual"
>  '
> =20
> -test_expect_failure 'gitdir - $GIT_DIR set while .git directory in c=
wd' '
> +test_expect_success 'gitdir - $GIT_DIR set while .git directory in c=
wd' '
>  	echo "$TRASH_DIRECTORY/otherrepo/.git" > expected &&
>  	(
>  		GIT_DIR=3D"$TRASH_DIRECTORY/otherrepo/.git" &&

And it is a good thing that the next line that comes after the above
context is "export GIT_DIR".  If we were to declare "set but not export=
ed"
an uninteresting use case whose outcome is undefined (and that might be
fine), this still tests the defined behaviour of having the GIT_DIR in =
the
environment.
