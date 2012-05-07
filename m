From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git commit path vs rebase path
Date: Mon, 07 May 2012 10:27:42 -0700
Message-ID: <7vaa1j7vg1.fsf@alter.siamese.dyndns.org>
References: <CAAXzdLU6bQ7ta4_-WfGJVaJgt1R5tX=4PW2sq3SdjAB+F72w+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Penny <svnpenn@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 19:27:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRRix-000106-1O
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 19:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092Ab2EGR1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 13:27:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34795 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757467Ab2EGR1p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 13:27:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 93A226154;
	Mon,  7 May 2012 13:27:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nqnJS19ouAFS9vxoPAHpuOYnOak=; b=Vxf1rf
	z6HXpqy/yKejsEcQM7GV8bAlD54/MqnGjl1/EbSaa1GF4K6Z4YrfrKqPZKImrytD
	ymHTH5OP0vlx3mDOBX5qQTW/fBJejfJYtxxCN5ZCbRhe0YiFKJhc7CN3KvCSUE+R
	JN4gEBkBXb1sr95SN0vAjP+SvkeFhl3BtEySs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GGJ/0Re2rAT6zyAbPGoknBqKijGehXd1
	jO8yExGdxusr1WMcvc7jYCPj2Ed81W710k1Bo5++8M8TY261HWPLFLwxaqOM0JYw
	Upnxg8iNH0e9pNMVJvFZuZvSHd7HICXw2x9bGN8yhhgp7GIzZIlcZyuTYaBg94T3
	IBqe3aywsXU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A6D66153;
	Mon,  7 May 2012 13:27:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D99BC6152; Mon,  7 May 2012
 13:27:43 -0400 (EDT)
In-Reply-To: <CAAXzdLU6bQ7ta4_-WfGJVaJgt1R5tX=4PW2sq3SdjAB+F72w+Q@mail.gmail.com> (Steven
 Penny's message of "Sat, 5 May 2012 23:24:16 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F4829CA2-9869-11E1-9EAF-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197285>

Steven Penny <svnpenn@gmail.com> writes:

> I have noticed
>
> git commit uses this path
>
> .git/COMMIT_EDITMSG
>
> git rebase uses this path
>
> /home/Steven/jquery/.git/rebase-merge/git-rebase-todo
>
> So git commit is using a relative path while git rebase is using absolute path.
>
> This causes problem in Windows if your editor does not understand linux paths,
> e.g. notepad, Notepad2, Notepad++, etc.

Hrm, this is not limited to rebase, though.  All shell scripted Porcelain
command use git-sh-setup that gives GIT_DIR as the full path, primarily so
that the implementation of the Porcelain can safely chdir around without
having to worry about relative paths in GIT_DIR.

Most of the time, the commands that use git-sh-setup do cd_to_toplevel
very early.  For these commands, unless you are using GIT_DIR from your
own environment (i.e. where people set the environment point to a place
totally unrelated to the working tree and/or the current directory), it
might look nicer if GIT_DIR given were .git/rebase-merge/git-rebase-todo,
but that will not be the real solution, as sometimes your editor _must_
deal with the full path anyway.  So the issue is _not_ that the path is
absolute, it is that the path is given as a wrong kind of absolute path.

Which suggests that "$(cd "$GIT_DIR" && pwd)" must give a full path that
is suitable for the platform, and your platform wants it to be something
like "c:\home\steven\jquery\..."?  I do not have any Windows environment
to further my speculation, so I'll leave the rest to Windows experts who
may be lurking on this list.

The relevant code snippet in git-sh-setup.sh is this part.

# Make sure we are in a valid repository of a vintage we understand,
# if we require to be in a git repository.
if test -z "$NONGIT_OK"
then
	GIT_DIR=$(git rev-parse --git-dir) || exit
	if [ -z "$SUBDIRECTORY_OK" ]
	then
		test -z "$(git rev-parse --show-cdup)" || {
			exit=$?
			echo >&2 "You need to run this command from the toplevel of the working tree."
			exit $exit
		}
	fi
	test -n "$GIT_DIR" && GIT_DIR=$(cd "$GIT_DIR" && pwd) || {
		echo >&2 "Unable to determine absolute path of git directory"
		exit 1
	}
	: ${GIT_OBJECT_DIRECTORY="$GIT_DIR/objects"}
fi
