From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG: "--work-tree blah" does not imply "--git-dir blah/.git" or
 fix misleading error message
Date: Wed, 30 Nov 2011 11:21:29 -0800
Message-ID: <7vaa7dquva.fsf@alter.siamese.dyndns.org>
References: <CAEUMa-cA8qPjJuPBREE1RqhgwmcZG7x1MjBYkxa3i+ZSAnMPOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Twilley <mathuin@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 30 20:21:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVpis-0007xQ-Ov
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 20:21:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551Ab1K3TVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 14:21:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44633 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306Ab1K3TVd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 14:21:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2AAF65D2;
	Wed, 30 Nov 2011 14:21:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uU0MJBzsR+AsG5zUQ18GsiPUSB8=; b=vK8x2i
	4lcbCjM1bxpHPBXR20R7354azKNmh7IWAD6JMB/eoHVlxFwI3FYla9kXI6m6u/mn
	22+Kmi4QfNN+FohWXXxHQJzmXDZ07K/IwBVuV+IZ7X6sk1VqDmmSoHoCAJ+NYaq3
	6tBRdLDoKESW3ewuB794b+QD+UnIfcy53VJMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KNudcoh37OuEI0bFeyxbxVCEoYfQAmwq
	Vz/k1an4FkUk66hGhrXMkTKXp59Ieg8huGRgP4CgTUQjjMY4oHPDAMXuczUG/A3T
	XaOQS3CcWSbgBa83MvtOw1TordikByW1Xit2W4Xjzxcj91k388nF4kX+OnlB8bCV
	OdxmsyqRQeA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8CBE65D1;
	Wed, 30 Nov 2011 14:21:32 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7595E65D0; Wed, 30 Nov 2011
 14:21:30 -0500 (EST)
In-Reply-To: <CAEUMa-cA8qPjJuPBREE1RqhgwmcZG7x1MjBYkxa3i+ZSAnMPOA@mail.gmail.com> (John
 Twilley's message of "Wed, 30 Nov 2011 09:43:08 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 81CB6F12-1B88-11E1-9D4E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186138>

John Twilley <mathuin@gmail.com> writes:

> Today someone asked me if there was a way to run git against a
> directory other than the current directory.  I looked at the output of
> --help and ran this:
>
> $ git --work-tree blah status
>
> I got the following output:
>
> fatal: Not a git repository (or any parent up to mount parent /home)

Yeah, that is a "this a use case that we didn't even intend to support,
and as a consequence we do a random thing" bug.

Originally, when GIT_DIR is set (from the environment, and then later we
added "git --git-dir=..." as another way to do so), Git always used the
current directory as the top of the working tree. There was no mechanism
for the user to say "No, I am not at the top level, but I am in a
subdirectory of the working tree. The top of working tree is there".  That
was the use case GIT_WORK_TREE (from the environment, and then later we
added "git --work-tree=..." as another way to do so) was introduced
for.

So in that sense, it is an unsupported mode of operation and it is not
surprising at all if Git did any random and meaningless things if you used
GIT_WORK_TREE without specifying GIT_DIR at all. In the same sense,
strictly speaking, setting GIT_WORK_TREE to somewhere that is not a parent
directory of the current directory (even if you set GIT_DIR) is also an
unsupported mode of operation.

When GIT_DIR is not set, I think we still run the normal GIT_DIR discovery
starting from the current working directory, and when we do not find one,
we would error out, as you saw. I am sympathetic that your particular case
might have resulted in a more pleasant user experience if the GIT_DIR
discovery started from the directory specified by GIT_WORK_TREE (i.e. the
subdirectory "blah/.git"), but I do not think this is likely to change, as
I suspect that people and scripts are relying on the current behaviour to
be able to do something like this:

    cd /pub/scm/git/git.git ;# this is a bare repository
    mkdir /var/tmp/git
    git --work-tree=/var/tmp/git checkout

to have a temporary checkout, and changing the GIT_DIR discovery logic
will break them, i.e. they now have to do:

    cd /pub/scm/git/git.git ;# this is a bare repository
    mkdir /var/tmp/git
    git --work-tree=/var/tmp/git --git-dir=$(pwd) checkout

or something. Instead, what you wanted to do is already supported by:

    (cd blah && git status)

so nothing is lost.

We could reword this:

> fatal: Not a git repository (or any parent up to mount parent /home)

to "fatal: /home/bar/baz (or any parent ...) is not a git repository" to
mention the current directory /home/bar/baz, but I am having a hard time
convincing myself that such a change is particularly good, because almost
always you know where you are (many people have it in their shell prompt).
Such a change makes the message longer to fit on a line without adding
much value.
