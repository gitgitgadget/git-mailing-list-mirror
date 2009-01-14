From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] git-am: add --directory=<dir> option
Date: Thu, 15 Jan 2009 00:46:02 +0100
Message-ID: <20090114234602.GD32313@leksak.fem-net>
References: <7vbpudjanf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>,
	Simon 'corecode' Schubert <corecode@fs.ei.tum.de>,
	Kevin Ballard <kevin@sb.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 00:47:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNFSY-0004mD-AM
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 00:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756825AbZANXqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 18:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756633AbZANXqS
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 18:46:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:50970 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755662AbZANXqR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 18:46:17 -0500
Received: (qmail invoked by alias); 14 Jan 2009 23:46:16 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp033) with SMTP; 15 Jan 2009 00:46:16 +0100
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19Yx9oqx8dY68jdR1vusAwlLWgfX8gsBmheBIYWno
	TQOB0Hh+xQVIBC
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1LNFQw-0000kL-Ud; Thu, 15 Jan 2009 00:46:02 +0100
Content-Disposition: inline
In-Reply-To: <7vbpudjanf.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105731>

Hi Junio,

Junio C Hamano wrote:
>
>  git-am.sh             |   17 +++++++++++++----
>  t/t4252-am-options.sh |    8 ++++++++
>  2 files changed, 21 insertions(+), 4 deletions(-)

I think this is missing some

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index b9c6fac..64c8178 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -66,6 +66,7 @@ default.   You could use `--no-utf8` to override this.
 
 -C<n>::
 -p<n>::
+--directory=<root>::
 	These flags are passed to the 'git-apply' (see linkgit:git-apply[1])
 	program that applies
 	the patch.

or even

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index b9c6fac..327bc3d 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -59,13 +59,10 @@ default.   You could use `--no-utf8` to override this.
 	it is supposed to apply to, and we have those blobs
 	available locally.
 
---whitespace=<option>::
-	This flag is passed to the 'git-apply' (see linkgit:git-apply[1])
-	program that applies
-	the patch.
-
 -C<n>::
 -p<n>::
+--directory=<root>::
+--whitespace=<option>::
 	These flags are passed to the 'git-apply' (see linkgit:git-apply[1])
 	program that applies
 	the patch.

> diff --git c/git-am.sh w/git-am.sh
> index 4b157fe..7e6329b 100755
> --- c/git-am.sh
> +++ w/git-am.sh
[...]
> @@ -33,6 +34,14 @@ cd_to_toplevel
>  git var GIT_COMMITTER_IDENT >/dev/null ||
>  	die "You need to set your committer info first"
>  
> +sq () {
> +	for sqarg
> +	do
> +		printf "%s" "$sqarg" |
> +		sed -e 's/'\''/'\''\'\'''\''/g' -e 's/.*/ '\''&'\''/'
                                  ^^^

	$ echo "/fo'ba" | sed -e 's/'\''/'\''\'\'''\''/g' -e 's/.*/ '\''&'\''/'
	 '/fo'''ba'


Do I have a thinko or should it be this:

+		sed -e 's/'\''/'\''\\\'\'''\''/g' -e 's/.*/ '\''&'\''/'
		                   ^^
			(added for escaping ' outside single quotes)

leading to:

	$ echo "/fo'ba" | sed -e 's/'\''/'\''\\\'\'''\''/g' -e 's/.*/ '\''&'\''/'
	 '/fo'\''ba'


Well, I was unsure, so I've tested...


Without this change:

	$ ./git-am.sh --directory="fo'ba" /tmp/test/*
	Applying: abcdefg
	./git-am.sh: eval: line 471: unexpected EOF while looking for matching
	`''
	./git-am.sh: eval: line 472: syntax error: unexpected end of file
	Patch failed at 0001.
	When you have resolved this problem run "git am --resolved".
	If you would prefer to skip this patch, instead run "git am --skip".
	To restore the original branch and stop patching run "git am --abort".

And with this change:

	$ ./git-am.sh --directory="fo'ba" /tmp/test/*
	Applying: abcdefg
	Applying: asdgasfh

> diff --git c/t/t4252-am-options.sh w/t/t4252-am-options.sh
> index 3ab9e8e..e91a6da 100755
> --- c/t/t4252-am-options.sh
> +++ w/t/t4252-am-options.sh
> @@ -50,4 +50,12 @@ test_expect_success 'interrupted am -C1 -p2' '
>  	grep "^Three$" file-2
>  '
>  
> +test_expect_success 'interrupted am --directory="frotz nitfol"' '
> +	rm -rf .git/rebase-apply &&
> +	git reset --hard initial &&
> +	test_must_fail git am --directory="frotz nitfol" "$tm"/am-test-5-? &&

Have you forgotten to add the files prefixed with "am-test-5-" or is this
patch based on another one?

$ git ls-files t/t4252
t/t4252/am-test-1-1
t/t4252/am-test-1-2
t/t4252/am-test-2-1
t/t4252/am-test-2-2
t/t4252/am-test-3-1
t/t4252/am-test-3-2
t/t4252/am-test-4-1
t/t4252/am-test-4-2
t/t4252/file-1-0
t/t4252/file-2-0


Thanks and regards,
  Stephan

--------------- proposed interdiff without am-test-5* ---------------
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index b9c6fac..327bc3d 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -59,13 +59,10 @@ default.   You could use `--no-utf8` to override this.
 	it is supposed to apply to, and we have those blobs
 	available locally.
 
---whitespace=<option>::
-	This flag is passed to the 'git-apply' (see linkgit:git-apply[1])
-	program that applies
-	the patch.
-
 -C<n>::
 -p<n>::
+--directory=<root>::
+--whitespace=<option>::
 	These flags are passed to the 'git-apply' (see linkgit:git-apply[1])
 	program that applies
 	the patch.
diff --git a/git-am.sh b/git-am.sh
index 7e6329b..ca3dbcd 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -38,7 +38,7 @@ sq () {
 	for sqarg
 	do
 		printf "%s" "$sqarg" |
-		sed -e 's/'\''/'\''\'\'''\''/g' -e 's/.*/ '\''&'\''/'
+		sed -e 's/'\''/'\''\\\'\'''\''/g' -e 's/.*/ '\''&'\''/'
 	done
 }
 
-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
