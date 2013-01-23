From: Ivan D Vasin <nisavid@gmail.com>
Subject: =?UTF-8?B?YXV0byBwYWNraW5nIHdpdGggc2ltdWx0YW5lb3VzIHB1c2hlczogImVycm9yOiBDb3VsZA==?=
	=?UTF-8?B?IG5vdCBzdGF0ICdvYmplY3RzL1vigKZdL1vigKZdJyI=?=
Date: Wed, 23 Jan 2013 18:50:38 -0500
Message-ID: <CADcu=0jCkNr6J_-iiKp00aSXHPf=+QV6oFvFHUZ_uc02JTaCbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 24 00:51:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyA6O-00044X-OX
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 00:51:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044Ab3AWXvM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jan 2013 18:51:12 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:44963 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143Ab3AWXvK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jan 2013 18:51:10 -0500
Received: by mail-lb0-f177.google.com with SMTP id go11so2595440lbb.8
        for <git@vger.kernel.org>; Wed, 23 Jan 2013 15:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=nU1ZAkeXfRGH5j5YGK5FiwAe5YvWQMDHcnNZHfBUDP4=;
        b=MaGxRDfKij/qXX2eY0/BecqRQCZOHXG7r80nidI6pkYR4CXfWjTy2RuHFasBe74VaG
         2zEkHR5+pZa0PsvVTr0Qy3RXEi3KFfrj2fYAM3o+65HCZnxbcjmxcIgQ5WnbRiil0GQ0
         eEffh4mTrq21yPsBJd2oga6f2W88cBXHBDDLymEwh+UszEE6OT6bZuLbED7r7omEBK60
         CKXW/E8qIbCVIuT9yeR1ZW9YRGF11dNBlH674ZfkRwXigyLswdN8y3GTCzOOInGxGrAY
         eLbuB4dn/C8N8cAmD9zZ4Yt23ZBebng6xGhGQZ+uKg2kSfcI1JCNpQirQi70bgtJpGPl
         XD3A==
X-Received: by 10.152.105.38 with SMTP id gj6mr2996843lab.25.1358985068294;
 Wed, 23 Jan 2013 15:51:08 -0800 (PST)
Received: by 10.114.63.44 with HTTP; Wed, 23 Jan 2013 15:50:38 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214379>

my coworker and i just pushed some commits seconds apart from each
other.  both of our pushes triggered a server-side auto pack
(presumably as part of ``receive-pack``, as a result of the setting
``receive.autogc =3D true``).  each auto pack produced multiple errors
of the form ``error: Could not stat 'objects/[=E2=80=A6]/[=E2=80=A6]'``=
=2E  there
appears to be no overlap between the two auto packs' lists of failed
object hashes.

my suspicion is that the two auto pack processes each generated a list
of objects to pack, then proceeded to pack them, removing the
corresponding files as they went along.  as each one encountered an
entry in its list that was previously handled by the other process, it
found that it was unable to stat the corresponding file because it had
been removed by the other process.

my suggestion is that an auto pack should lock the repository,
preventing at least other auto packs (and perhaps other operations)
from running until it is finished.  alternatively, the auto pack can
skip over objects that were already packed by another process;
however, i imagine this would be much less efficient if done
correctly.

here is the console output from my push:

$ git push
X11 forwarding request failed on channel 0
Counting objects: 32, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (18/18), done.
Writing objects: 100% (18/18), 2.70 KiB, done.
Total 18 (delta 12), reused 0 (delta 0)
Auto packing the repository for optimum performance.
error: Could not stat 'objects/00/
c706ccf0ef06092134ccb1f9fdf0e7d39a9d5f'
error: Could not stat 'objects/02/7c2932047c9c9c7bacd6e1abdc3810866161b=
c'
error: Could not stat 'objects/13/b2c3f0a55e8de099553cad6901a150f19b83c=
2'
error: Could not stat 'objects/2a/3992fa9c096f7514a62781a3c3923a996a707=
3'
error: Could not stat 'objects/3d/cb6e9055b9b51911aae52f4bb0ca8d8719d64=
5'
error: Could not stat 'objects/50/c2f6d8e0de1eba988256597cc1d6e1a387902=
c'
error: Could not stat 'objects/50/9f494f6b60741957a45cf51f8d097f0578c89=
a'
error: Could not stat 'objects/52/6597c12d730c5903d46f598c6ec438cfabfe0=
f'
error: Could not stat 'objects/52/a6b4ee4bebb043d21858455fd0cd33b4812a4=
2'
error: Could not stat 'objects/53/71c6f99023efecb3a4c16daeeee63f534d63b=
2'
error: Could not stat 'objects/5f/bd49df3c4abdc93c7118f762ac770a0fcd6ce=
4'
error: Could not stat 'objects/67/900e6e598e8e1c7bde5776fd220f7daf147cd=
e'
error: Could not stat 'objects/72/42ecd310d0286da6c3967985c6446cf105b0b=
d'
error: Could not stat 'objects/79/4afecb2d348dde5ad4d24cf62c8fcd4db3b63=
a'
error: Could not stat 'objects/7e/4c612c51c5d76f03f12c04241d3b3c5aa212e=
4'
error: Could not stat 'objects/84/fd1e038d4345bac1fa2b33edb73fd73813ac4=
f'
error: Could not stat 'objects/89/c32fdbf3400c797d01659f9ee644aa8a71357=
4'
error: Could not stat 'objects/8b/cbe10b0d09325b49876416341d6cf4bccc9e3=
5'
error: Could not stat 'objects/8d/6dcc95d6bea57cfafe8a08fed7947561682b6=
8'
error: Could not stat 'objects/b9/67af0f23deb87f1708689d159ee6444503462=
a'
error: Could not stat 'objects/bb/9d6fafe3ba2189582ac48088ee6f732755ddd=
b'
error: Could not stat 'objects/e0/549c20e56d6ec270ec3ffee6c93a6d6cb8f6b=
5'
error: Could not stat 'objects/f2/737f0d8635265a56d57c27a3ddf155da48b07=
a'
error: Could not stat 'objects/fc/8b2f0837aefa21d86de65f6230c86f64addb8=
d'
error: Could not stat 'objects/fc/ac21d190770fdee23e5e69cdba36eefd6e001=
a'
error: Could not stat 'objects/fd/ae521d6a3404ceabff223385d7b5b5c783f0f=
e'
To git@code.adverplex.com:syseng
   fb49a86..e161cf5  HEAD -> uber_release_alpha

here is the console output from my coworker's push:

$ git push
Counting objects: 181, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (154/154), done.
Writing objects: 100% (159/159), 1.81 MiB, done.
Total 159 (delta 74), reused 0 (delta 0)
Auto packing the repository for optimum performance.
error: Could not stat 'objects/06/b2aee0b4adca015d072be4ef6a655c118b6af=
3'
error: Could not stat 'objects/0d/66f41003c9112b8093dfee5fd56e8db25a142=
b'
error: Could not stat 'objects/0d/6c3e296fb7b83998677d207f9df6a69e14416=
8'
error: Could not stat 'objects/14/64e2bd863a15e08be7aa2f33b8df5b5f69560=
8'
error: Could not stat 'objects/14/19cad4e2a38720186eb36b3c756d05e196387=
7'
error: Could not stat 'objects/16/1b9e65004a9120ea250ef8ef8292d5416ed98=
4'
error: Could not stat 'objects/23/b6bc50c16fe3740393c8a08cf57cc07a56c77=
8'
error: Could not stat 'objects/60/1d7c562cafaf6c71c57dbbd0bab55c3698d0c=
7'
error: Could not stat 'objects/6c/c5c7ededba86ce291b531def840e757ce3ecc=
c'
error: Could not stat 'objects/74/8d6bece2b4ccec41584d22152d0fd903e0190=
8'
error: Could not stat 'objects/9a/6c21779e7c063b87bbf055e4c6b6baecc8a3e=
1'
error: Could not stat 'objects/9a/6519e7bb625f681ead373e9a9226f862ee155=
0'
error: Could not stat 'objects/9b/7027422cbce1f5f2c5929ae1313ecee2cd353=
7'
error: Could not stat 'objects/a4/7e0b5906c2b552158a1e5943063e983532988=
f'
error: Could not stat 'objects/a4/6db00ea7b7d2e618731d7b4f1e59b5f0276af=
f'
error: Could not stat 'objects/ab/b3a8fd9585af5a7f6dbd609e6b4ed8c4359ca=
6'
error: Could not stat 'objects/ad/0c98f2674807beee093cead1179d95756c178=
8'
error: Could not stat 'objects/bf/4fd1b9cc617d3fc832350783064418e0d7fdf=
d'
error: Could not stat 'objects/bf/c65d6bc705dfc5018c3d25228a4469d069f3b=
8'
error: Could not stat 'objects/c0/adb5b39efd31698789ee8aefcedf91913fc7f=
1'
error: Could not stat 'objects/ca/f4ee60f223039d2ec6185adbb4c28ab7df461=
e'
error: Could not stat 'objects/ca/e3b7c60b4b3a34bba4b4a5738edf0f7786a78=
4'
error: Could not stat 'objects/cb/4a470752088b708290713b0a513e22bb0dcb1=
5'
error: Could not stat 'objects/d3/d44ba75332e3e7e21a89eafe724e682cf124d=
d'
error: Could not stat 'objects/d3/8a635a420af938f680ab30c6252fdddd448a5=
d'
error: Could not stat 'objects/d8/f102045fc608b65cb1d75ad8de11a673ebd65=
6'
error: Could not stat 'objects/da/97ac29d9024f589b4aec46bc0ea1f597b0080=
2'
error: Could not stat 'objects/e5/3e9d05c4e9a3e336453af3b43fe06dfa5c6d5=
7'
error: Could not stat 'objects/ea/b586bcc6925bcb34cdeede1562a851d5b58d9=
0'
error: Could not stat 'objects/ec/f2cf1dd8d6045242676cd22320902c085ecbb=
3'
error: Could not stat 'objects/f3/819de13ed535bdd92580e2f2b01580714188e=
1'
To git@code.adverplex.com:syseng
   fb49a86..a39c897  master -> master

``git fsck`` is successful on both of our repos and on the bare repo
to which we pushed.
