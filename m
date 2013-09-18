From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] completion: improve untracked directory filtering for
 filename completion
Date: Wed, 18 Sep 2013 19:06:08 +0200
Message-ID: <1379523968-20668-1-git-send-email-szeder@ira.uka.de>
References: <CADHXV5=ZVif6xppJgOXRKmqG9bBmAF0=A-sS9TUkH1RHSX9k6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Manlio Perillo <manlio.perillo@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Isaac Levy <ilevy@google.com>
X-From: git-owner@vger.kernel.org Wed Sep 18 19:06:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMLCt-0001v0-Rz
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 19:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417Ab3IRRGX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Sep 2013 13:06:23 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:64844 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604Ab3IRRGW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 13:06:22 -0400
Received: from localhost6.localdomain6 (217-197-184-8.pool.digikabel.hu [217.197.184.8])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0MDU2z-1V7lp33sZ3-00GYod; Wed, 18 Sep 2013 19:06:21 +0200
X-Mailer: git-send-email 1.8.4.366.g16e4e67
In-Reply-To: <CADHXV5=ZVif6xppJgOXRKmqG9bBmAF0=A-sS9TUkH1RHSX9k6g@mail.gmail.com>
X-Provags-ID: V02:K0:ADPXM5J5EcQGlE6ZNi8Bguib9wvj9NbL8safwr3TK/+
 M6kONS7GdT3XVvoNqn1Xi4kw05ArjazSGcIuOVOccw+CMGTw/Z
 hKgWggA+XjGSTnHFvFaz25WxxWbnVptAm7BpiFVdLobAsr3Zbw
 t10do37ydSPBV9dFXFZujpWIAjYXpf+MJAMJiivpLt28gtfxzk
 GMPqdkKJBTEcHLtXzKz0YRhcnakqky4r4Gb9n/WYZI9axZ7/UP
 LRjnVSDvlRiqwIfqa1rzls+vrMoUM2lxvY76mbhHA9JhMpP+Dm
 4Q26fXx6Q7yEjmBLrYIXK4zM+F6UzniLcu6tMHfiFJUM8zlWHz
 zOA9Rg0/N/z/VBpZ/KM10w3eUF3OwXvJFVDZ4Bn/DZrlY6kOUs
 hH9zI4dxPThRQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234974>

Similar to Bash's default filename completion, our git-aware filename
completion stops at directory boundaries, i.e. it doesn't offer the
full 'path/to/file' at first, but only 'path/'.  To achieve that the
completion script runs 'git ls-files' with specific command line
options to get the list of relevant paths under the current directory,
and then processes each path to strip all but the base directory or
filename (see __git_index_files()).

To offer only modified and untracked files for 'git add' the
completion script runs 'git ls-files --exclude-standard --others
--modified'.  This command lists all non-ignored files in untracked
directories, which leads to a noticeable delay caused by the
processing mentioned above if there are a lot of such files
(__git_index_files() specifies '--exclude-standard' internally):

  $ mkdir untracked-dir
  $ for i in {1..10000} ; do >untracked-dir/$i ; done
  $ time __git_index_files "--others --modified"
  untracked-dir

  real	0m0.537s
  user	0m0.452s
  sys	0m0.160s

Eliminate this delay by additionally passing the '--directory
--no-empty-directory' options to 'git ls-files' to show only the
directory name of non-empty untracked directories instead their whole
content:

  $ time __git_index_files "--others --modified --directory --no-empty-=
directory"
  untracked-dir

  real	0m0.029s
  user	0m0.020s
  sys	0m0.004s

=46ilename completion for 'git clean' suffers from the same delay, as i=
t
offers untracked files, too.  The fix could be the same, but since it
actually makes sense to 'git clean' empty directories, in this case we
only pass the '--directory' option to 'git ls-files'.

Reported-by: Isaac Levy <ilevy@google.com>
Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index e1b7313072..86f77345fd 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -901,7 +901,7 @@ _git_add ()
 	esac
=20
 	# XXX should we check for --update and --all options ?
-	__git_complete_index_file "--others --modified"
+	__git_complete_index_file "--others --modified --directory --no-empty=
-directory"
 }
=20
 _git_archive ()
@@ -1063,7 +1063,7 @@ _git_clean ()
 	esac
=20
 	# XXX should we check for -x option ?
-	__git_complete_index_file "--others"
+	__git_complete_index_file "--others --directory"
 }
=20
 _git_clone ()
--=20
1.8.4.366.g16e4e67
