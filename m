From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git init shared=group with a subdir
Date: Wed, 14 Nov 2012 12:29:45 -0800
Message-ID: <7vr4nw9bd2.fsf@alter.siamese.dyndns.org>
References: <alpine.OSX.2.00.1211141107180.737@nikto-air>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: petesea@bigfoot.com
X-From: git-owner@vger.kernel.org Wed Nov 14 21:31:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYjb3-0000sI-O4
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 21:30:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423398Ab2KNU3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 15:29:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48634 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423232Ab2KNU3v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 15:29:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F7A9A76A;
	Wed, 14 Nov 2012 15:29:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jl2j9VdxpTMZy3P0Z//gnTQA0OM=; b=JlFx2J
	yXYE57L3/mP1YxjqpNdrG8nXcnSUI0F1u2ekQ9QhIVgdGzV1MOpN2dRt5fClGBYt
	SQWjX9PqNrI1FO3bj2dqnv8SbFynZiLO4KHVJpkRc9fmslpvojZZQXY4G/eAosXS
	kbvHA4gxleJYJvO4K8CDSayaM+Q+tKhGftcK0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dupwXDEKeKp8rjxvnrdfbyxCcHpp6MMc
	neDRtsDW/iN+K80WX6aRlh6dhgi34jsHfQ1ZIl847Y8UKHfEm3yyx15sRhbHFbMS
	oaXEgL7RLftXJA10GY7ye+4rEr+tZ+JDzvOz+CFHjB6ftEabd8pLTE4wEZtSlO24
	Uzl1fVoj9so=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BE4BA769;
	Wed, 14 Nov 2012 15:29:50 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C3E8DA767; Wed, 14 Nov 2012
 15:29:49 -0500 (EST)
In-Reply-To: <alpine.OSX.2.00.1211141107180.737@nikto-air>
 (petesea@bigfoot.com's message of "Wed, 14 Nov 2012 12:00:03 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 09C239BC-2E9A-11E2-BCAD-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209752>

petesea@bigfoot.com writes:

>   $ ls -ld subdir
>   ls: cannot access subdir: No such file or directory
>   $ git init --bare --shared=group subdir/test.git
>   Initialized empty shared Git repository in /tmp/subdir/test.git/
>   $ ls -ld subdir subdir/test.git
>   drwxr-xr-x 3 pete users 4096 2012-11-14 11:16 subdir
>   drwxrwsr-x 7 pete users 4096 2012-11-14 11:16 subdir/test.git
>
> Assuming the "subdir" directory doesn't already exist and is created
> by the "git init" command AND the --shared=group option is used, then
> shouldn't the "subdir" directory also have 2775 permissions?

People who access this "test.git" does not need to be able to write
into subdir/foobar, so the lack of w bit for the group is perfectly
fine, no?  Depending on to whom you would want to expose things
other than "test.git" in "subdir", the desirable set of the
permission bits on "subdir" itself would be different, but the "git
init" command line does not give us enough information to infer what
exact mode is needed.

At least we should give r-x to the parent directories for the
classes of users to whom we give rwx to the repository itself.  In
your example, since we give rwx to user=pete and group=users on
"test.git", "subdir" should have r-x (or better) for user=pete and
group=users, so that result happens to be correct.

But I do not think we did the right thing by design but it turned
out to be correct by accident.  If your umask were 077 or something
tight, I suspect that we end up creating "subdir" with "rwx------",
and group members wouldn't be able to access "test.git".  We may
want to loosen it down to "rwxr-x---" in such a case, but doing so
unconditionally risks exposing things inside "subdir" other than
"test.git" to your group members, and worse yet, we would be doing
so without telling the user.  If your umask is set to a tight value,
it is likely that you did so on purpose, and it is debatable if it
is a good thing to do.  It is safer to create these leading
directories like "subdir" honoring the umask, give the user a chance
to make sure that other things in "subdir" can be exposed to people
who have access to "test.git", and let the user handle the
permission (perhaps running "chmod g+rx subdir" as necessary).  And
that is the behaviour you are observing, I think.
