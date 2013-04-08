From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v2 6/7] remote-bzr: add utf-8 support for fetching
Date: Mon, 08 Apr 2013 21:39:30 +0200
Message-ID: <51631CF2.5090503@web.de>
References: <1365442036-25732-1-git-send-email-felipe.contreras@gmail.com> <1365442036-25732-7-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Christophe Simonis <christophe@kn.gl>,
	=?UTF-8?B?InRibyA+PiBUb3JzdGVuIELDtmdlcnNoYXVzZW4i?= 
	<tboegi@web.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 21:39:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPHup-0005hW-5t
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 21:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935776Ab3DHTji convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Apr 2013 15:39:38 -0400
Received: from mout.web.de ([212.227.17.12]:57166 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935627Ab3DHTji (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 15:39:38 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0LoYFm-1V4eGz0K9S-00gWCN; Mon, 08 Apr 2013 21:39:36
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <1365442036-25732-7-git-send-email-felipe.contreras@gmail.com>
X-Provags-ID: V02:K0:QWav7orpLP6gebXVMj/T6PT6N3uUTo05a0G1EUBAMZU
 5hvxiKo89klhX+izi4stfe17PHlgRUt3kaDrlp7cjsrXoN0FK7
 ibWAI8NZBb5iRr+ubZ9A55nVREooKuKk/LOfSirelSMTiqz07+
 v2j9GsT4svyVwztP0CIQMS6iEaFates1hogPHsxKw0Fb5NVE04
 TlsyqjdIdImPkeas/gfkw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220502>

On 08.04.13 19:27, Felipe Contreras wrote:
> From: Christophe Simonis <christophe@kn.gl>
>=20
> Initial patch by Timotheus Pokorra.
>=20
> [fc: added tests]
>=20
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/remote-helpers/git-remote-bzr | 15 +++++++++------
>  contrib/remote-helpers/test-bzr.sh    | 32 +++++++++++++++++++++++++=
+++++++
>  2 files changed, 41 insertions(+), 6 deletions(-)
>=20
> +
> +  export LC_ALL=3Den_US.UTF-8
> +
> +  (
> +  bzr init bzrrepo &&
> +  cd bzrrepo &&
> +
> +  echo test >> "=C3=A1=C3=A9=C3=AD=C3=B3=C3=BA" &&
> +  bzr add "=C3=A1=C3=A9=C3=AD=C3=B3=C3=BA" &&

Just a whish from my side:
bzr under MacOS is not able to handle some unicode characters correctly=
=2E
(Those we can decompose)
https://bugs.launchpad.net/bzr/+bug/172383

I just added a fix on the test-bzr script we have on git.git/next,
and the short version is to avoid all code points like =C3=A1=C3=A9=C3=AD=
=C3=B3=C3=BA.
The greek stuff is probably OK, but the accents are not.
I choose a danish/norwegian "=C3=A6", which is not decomposable.
(And the non-portable echo -e could be avoided by using printf)
/Torsten
=20

git diff git.git/next
diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helper=
s/test-bzr.sh
index f4c7768..2150e7c 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -175,8 +175,8 @@ test_expect_success 'fetch utf-8 filenames' '
   bzr init bzrrepo &&
   cd bzrrepo &&
=20
-  echo test >> "=C3=A1=C3=A9=C3=AD=C3=B3=C3=BA" &&
-  bzr add "=C3=A1=C3=A9=C3=AD=C3=B3=C3=BA" &&
+  echo test >> "=C3=A6" &&
+  bzr add "=C3=A6" &&
   bzr commit -m utf-8
   ) &&
=20
@@ -185,8 +185,7 @@ test_expect_success 'fetch utf-8 filenames' '
   cd gitrepo &&
   git ls-files > ../actual
   ) &&
-  echo "\"\\303\\241\\303\\251\\303\\255\\303\\263\\303\\272\"" > expe=
cted &&
+  echo "\"\\303\\246\"" > expected &&
   test_cmp expected actual
 '
=20
@@ -209,15 +208,15 @@ test_expect_success 'push utf-8 filenames' '
   git clone "bzr::$PWD/bzrrepo" gitrepo &&
   cd gitrepo &&
=20
-  echo test >> "=C3=A1=C3=A9=C3=AD=C3=B3=C3=BA" &&
-  git add "=C3=A1=C3=A9=C3=AD=C3=B3=C3=BA" &&
+  echo test >> "=C3=A6" &&
+  git add "=C3=A6" &&
   git commit -m utf-8 &&
=20
   git push
   ) &&
=20
   (cd bzrrepo && bzr ls > ../actual) &&
-  echo -e "content\n=C3=A1=C3=A9=C3=AD=C3=B3=C3=BA" > expected &&
+  printf "content\n\303\246\n" > expected &&
   test_cmp expected actual
 '
=20
