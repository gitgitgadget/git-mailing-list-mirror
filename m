From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH] rebase: accept indented comments (fixes regression)
Date: Wed, 30 Sep 2015 11:58:52 +0200 (CEST)
Message-ID: <310795808.1397218.1443607132172.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1443600661-19391-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Sep 30 11:57:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhE8L-0007E0-O2
	for gcvg-git-2@plane.gmane.org; Wed, 30 Sep 2015 11:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756018AbbI3J46 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Sep 2015 05:56:58 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:57415 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755983AbbI3J44 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2015 05:56:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id D00142279;
	Wed, 30 Sep 2015 11:56:51 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9kfLd9WSfrRi; Wed, 30 Sep 2015 11:56:51 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id B870A21F8;
	Wed, 30 Sep 2015 11:56:51 +0200 (CEST)
In-Reply-To: <1443600661-19391-1-git-send-email-Matthieu.Moy@imag.fr>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF41 (Linux)/8.0.9_GA_6191)
Thread-Topic: rebase: accept indented comments (fixes regression)
Thread-Index: vfJpqAM/CQi3sRgUK7NIfkI1tiL6ag==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278843>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:
> With Git <2.0.6, 'git rebase' used to accept lines starting with
> whitespaces followed with '#' as a comment. This was broken by
> 804098b (git rebase -i: add static check for commands and SHA-1,
> 2015-06-29), which introduced additional checks on the TODO-list usin=
g
> "git stripspaces" which only strips comments starting at the first
> column.
>
> Whether it's a good thing to accept indented comments is
> debatable (other commands like "git commit" do not accept them), but =
we
> already accepted them in the past, and some people and scripts rely o=
n
> this behavior. Also, a line starting with space followed by a '#' can=
not
> have any meaning other than being a comment, hence it doesn't harm to
> accept them as comments.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>

Thank you for the patch, and sorry for the introduced regression.

R=C3=A9mi

> ---
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >> I know you alluded to preprocess what is fed to stripspace, but I
> >> wonder if we can remove the misguided call to stripspace in the
> >> first place and do something like the attached instead.
> >>
> >> git-rebase--interactive.sh | 3 +--
> >> 1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.=
sh
> >> index f01637b..a64f77a 100644
> >> --- a/git-rebase--interactive.sh
> >> +++ b/git-rebase--interactive.sh
> >> @@ -886,7 +886,6 @@ check_commit_sha () {
> >> # from the todolist in stdin
> >> check_bad_cmd_and_sha () {
> >> retval=3D0
> >> - git stripspace --strip-comments |
> >> (
> >> while read -r line
> >> do
> >> @@ -896,7 +895,7 @@ check_bad_cmd_and_sha () {
> >> sha1=3D$2
> >>
> >> case $command in
> >> - ''|noop|x|"exec")
> >> + '#'*|''|noop|x|"exec")
> >> # Doesn't expect a SHA-1
> >> ;;
> >> pick|p|drop|d|reword|r|edit|e|squash|s|fixup|f)
> >
> > Nah, that would not work, as I misread the "split only at SP" manua=
l
> > parsing of $line.
>
> OK, let's go for the solution I seem to be able to get right even wit=
h
> low cafeine ;-).
>
> git-rebase--interactive.sh | 3 +++
> t/t3404-rebase-interactive.sh | 10 ++++++++++
> 2 files changed, 13 insertions(+)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index f01637b..55adf78 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -886,6 +886,9 @@ check_commit_sha () {
> # from the todolist in stdin
> check_bad_cmd_and_sha () {
> retval=3D0
> + # git rebase -i accepts comments preceeded by spaces, while
> + # stripspace does not.
> + sed 's/^[[:space:]]*//' |
> git stripspace --strip-comments |
> (
> while read -r line
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interacti=
ve.sh
> index d26e3f5..ac5bac3 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1227,6 +1227,16 @@ test_expect_success 'static check of bad comma=
nd' '
> test C =3D $(git cat-file commit HEAD^ | sed -ne \$p)
> '
>
> +test_expect_success 'indented comments are accepted' '
> + rebase_setup_and_clean indented-comment &&
> + write_script add-indent.sh <<-\EOF &&
> + printf "\n \t # comment\n" >>$1
> + EOF
> + test_set_editor "$(pwd)/add-indent.sh" &&
> + git rebase -i HEAD^ &&
> + test E =3D $(git cat-file commit HEAD | sed -ne \$p)
> +'
> +
> cat >expect <<EOF
> Warning: the SHA-1 is missing or isn't a commit in the following line=
:
> - edit XXXXXXX False commit
> --
> 2.6.0.rc2.24.g231a9a1.dirty
