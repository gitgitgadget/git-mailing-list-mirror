From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Implement git-branch and git-merge-base as built-ins.
Date: Thu, 08 Jun 2006 11:53:48 -0700
Message-ID: <7vverbsclf.fsf@assigned-by-dhcp.cox.net>
References: <4488633A.5060409@bitplanet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 08 20:53:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoPdh-0006fp-8q
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 20:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbWFHSxu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 8 Jun 2006 14:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964938AbWFHSxu
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 14:53:50 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:19657 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S964934AbWFHSxt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jun 2006 14:53:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060608185348.ZAFS5347.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 8 Jun 2006 14:53:48 -0400
To: Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@bitplanet.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21506>

Kristian H=F8gsberg <krh@bitplanet.net> writes:

> This patch is more or less a straight port of git-branch from shell
> script to C.  Branch deletion uses git-merge-base to check if it is s=
afe
> to delete a branch, so I changed merge-base.c to export this function=
ality
> as a for_each_merge_base() iterator.  As a side effect, git-merge-bas=
e is
> now also a built-in command.

=46irst, some lighter-weight comments:

 (0) Somehow your diff have two copies of everything.  How did
     you prepare this message I wonder...?

 (1) Sign your work, please.

 (2) I would have preferred a patch to do merge-base and another
     patch to do branch.  That way, we could do merge-base
     without doing branch if we wanted to.

But the patch is wrong.  Your for-each-merge-base cannot be
called more than once, but delete-branches does.

The merge-base program as implemented currently is written with
the assumption that it is called only once, and leaves its
working state in parsed commit objects all over the place.  In
order to make the second and subsequent call to work correctly,
you need to clean the flags up.

As a demonstration, with this function appended to your
merge-base.c and making it a built-in "merge-base-bogo":

int cmd_merge_base_bogo(int argc, const char **argv, char **envp)
{
	struct commit *rev1, *rev2;
	unsigned char rev1key[20], rev2key[20];
	int errors =3D 0;

	setup_git_directory();
	git_config(git_default_config);

	while (1 < argc && argv[1][0] =3D=3D '-') {
		const char *arg =3D argv[1];
		if (!strcmp(arg, "-a") || !strcmp(arg, "--all"))
			show_all =3D 1;
		else
			usage(merge_base_usage);
		argc--; argv++;
	}
	for (; 3 <=3D argc; argc -=3D 2, argv +=3D 2) {
		if (get_sha1(argv[1], rev1key) ||
		    !(rev1 =3D lookup_commit_reference(rev1key))) {
			error("Not a valid object name %s", argv[1]);
			errors++;
			continue;
		}
		if (get_sha1(argv[2], rev2key) ||
		    !(rev2 =3D lookup_commit_reference(rev2key))) {
			error("Not a valid object name %s", argv[2]);
			errors++;
			continue;
		}
		for_each_merge_base(rev1, rev2, print_merge_base, NULL);
	}
	if (1 < argc) {
		error("Trailing argument %s not used", argv[1]);
		errors++;
	}
	return !!errors;
}

Here is what happens.

: gitster; ./git merge-base-bogo 66ae0c77 ced9456a
262a6ef76a1dde97ab50d79fa5cd6d3f9f125765
: gitster; ./git merge-base-bogo 89719209 262a6ef7
aa6bf0eb6489d652c5877d65160ed33c857afa74
: gitster; ./git merge-base-bogo 66ae0c77 ced9456a 89719209 262a6ef7
262a6ef76a1dde97ab50d79fa5cd6d3f9f125765
262a6ef76a1dde97ab50d79fa5cd6d3f9f125765

This is because the invocation for the second pair does not
start with a clean slate, and is affected by the leftover states
from the computation for the first pair.  If you swap the
arguments, you sometimes get correct result by accident, like this:

: gitster; ./git merge-base-bogo 89719209 262a6ef7 66ae0c77 ced9456a
aa6bf0eb6489d652c5877d65160ed33c857afa74
262a6ef76a1dde97ab50d79fa5cd6d3f9f125765

Incidentally, this is why I haven't done "A...B" revision syntax
extension to mean "^$(git merge-base A B) B".
