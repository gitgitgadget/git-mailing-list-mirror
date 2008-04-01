From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] aliases not working outside of a working copy
Date: Mon, 31 Mar 2008 21:39:48 -0700
Message-ID: <7v1w5qkx2j.fsf@gitster.siamese.dyndns.org>
References: <8aa486160803310819r3a905bbeg5f993a55aaf6efbf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 06:41:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgYJ4-0002PS-DJ
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 06:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbYDAEkI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Apr 2008 00:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbYDAEkI
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 00:40:08 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33042 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbYDAEkG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Apr 2008 00:40:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 75062206F;
	Tue,  1 Apr 2008 00:40:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 577E7206D; Tue,  1 Apr 2008 00:39:57 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78626>

"Santi B=C3=A9jar" <sbejar@gmail.com> writes:

>   I use the following alias:
>
> [alias]
>         wdiff =3D diff --color-words
>
> and it no longer works outside of a working copy since:
>
> af05d67 (Always set *nongit_ok in setup_git_directory_gently())
>
> The problem is with the alias system that detects if you are in a
> working copy, not with the command, as the
> command just works fine.

I was wondering if anybody was using git alias outside git repository, =
as
I thought such a use would be somewhat unorthodox.  The easter egg took=
 6
days to get discovered.

I'll commit this on 'master'.  Thanks for satisfying my curiosity ;-)

-- >8 --
[PATCH] Accept git aliases outside a git repository

af05d67 (Always set *nongit_ok in setup_git_directory_gently(),
2008-03-25) had a change from the patch originally submitted that resul=
ted
in disabling aliases outside a git repository.

It turns out that some people used "alias.fubar =3D diff --color-words"=
 in
$HOME/.gitconfig to use non-git command outside git repositories, and t=
his
change broke such a usage, so this resurrects the support.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index b7729d7..c4e4644 100644
--- a/git.c
+++ b/git.c
@@ -148,8 +148,9 @@ static int handle_alias(int *argcp, const char ***a=
rgv)
 	const char** new_argv;
 	const char *alias_command;
 	char *alias_string;
+	int unused_nongit;
=20
-	subdir =3D setup_git_directory_gently(NULL);
+	subdir =3D setup_git_directory_gently(&unused_nongit);
=20
 	alias_command =3D (*argv)[0];
 	alias_string =3D alias_lookup(alias_command);
--=20
1.5.5.rc2.155.gb0a67
