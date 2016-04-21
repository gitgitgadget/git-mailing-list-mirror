From: XZS <d.f.fischer@web.de>
Subject: [PATCH/RFC/GSoC 0/2] add a add.patch config variable
Date: Thu, 21 Apr 2016 11:15:20 +0200
Message-ID: <cover.1459946531.git.d.f.fischer@web.de>
References: <xmqqio0b5ash.fsf@gitster.mtv.corp.google.com> <CAP8UFD0KZk1nTgR8gdbedsAuw2ztWZDWri6EkeEkf8FhwS9yag@mail.gmail.com>
Cc: XZS <d.f.fischer@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 11:15:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atAiK-0006aU-BA
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 11:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321AbcDUJPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 05:15:39 -0400
Received: from mout.web.de ([212.227.15.3]:58116 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752121AbcDUJPf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 05:15:35 -0400
Received: from storm.fritz.box ([95.116.240.233]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0M09eO-1binQV3qGq-00uKkU; Thu, 21 Apr 2016 11:15:32
 +0200
X-Mailer: git-send-email 2.8.0
In-Reply-To: <xmqqio0b5ash.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:bjDqjaQD6vtLjWQGdHDBzeQcChlX9i4hxEm+T2aynSryDwr/WSQ
 +2MN+VGvA118HhdRqZILuaQISqlx8Y7Zm8RyDzmuma/bXyieUscazQZEN0fl9Nn0OV4iY89
 zMBZKKhVwr7bD8v39YAZOfCKGIBN+ExC6oF8si7OZT4Uuq+TtTqF8yaW9PWYp8lcyc84KVP
 bjVBymKyo56cNfvwdEEfQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:U3Z1eNMpWbc=:VqeyswfmUAl0/VsYplAw0b
 o2NcmSLam1VRWpuTOBQhQcpMMWChPD8LNr210Q4OlZhmloTri30u8/fB/3lJEZ8xrElDUskYo
 d8qkKpUoCujR921UlULNCjW7n0Ve1cHQk/KHAG1awR61P3jIo2IME2lkQYwo6fwwy/iI173u+
 dpQRKuADHjBr4W7L3OKd4Iqe9nGyT6KfMoQ1UAThAfnsyx8P/Oe5FyVx5MefPnK/rdbjSkv9k
 aYUUsvkhd3wnwebYgopAxlu3HzY4DB6/sQzZ1NJJ8/q7MnUjT8nkc4erotQfBjRO1zpRndCVm
 e1svFWnciQe6/k8/ko7ssKyapjP+qgX8cb9iQ+BIqQKXDXn7ag2b7HiRlRv6P4UBc5ak2aPkM
 f7Wrs68S3OOtEx1gq2maPD8q8I4DXaSbUNc6Q1XyI3UJ3GRBzaZUFWolO41Xba3lzLMub2139
 A12MgRpEYxtZKJeaYDbdwatXe9O3QFXdzMX7Xfx2fKJJ4+Hu95pbtPFeZGoX1tztnKy/1XYpE
 AlnEN3jBiIDlOj8C3E9gs/XK7cIpiep8xNmuPOubNVTCc3K50L8sQc91yxw8Vva4Lq9ve3twL
 zWq8SJx65XXOZzfhdEHAPifpwyUDpzlSUeoNYhCdGKa4VBYroxOu1OSyECrlOXJpFiSHk3clO
 7meQaq+oaMhbxLj5sgUb8QU+xNAE6GcThg5X6wsV9VEyRifqxcBj7eXZIj81fUA77pY67yWOS
 yMaMeqKQBOoMBG+9jLoZ7b4bQ9AwUOZqjC6gpHVqX6KAxvmkY8PdgTYo/Aw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292102>

The following patches try to provide an add.patch configuration variable
while keeping out of the way of other commands. To do so, an environment
variable counts how often git was recursively invoked. The variable is
then only considered in the first recursion.

To ensure other commands work as expected also when add.patch is set, I
added a test exemplifying the case with mergetool. To confirm the same
for other commands, I also reran all tests with an activated add.patch,
all direct invocations of git-add in the tests augmented with
--no-patch. You can reproduce this by running the following commands
from the root of the git source code repository.

sed -i '/add\.patch/,/}/ {
  # pretend add.patch to always be active
  s/\(patch_interactive = \).*;/\11;/
}' builtin/add.c
find t -type f -exec sed -i ' # in all tests
  /(use\|forget\|hint/! { # exclude help texts
    # replace git add invocations, also when options are passed to git,
    # but not subcommands named add.
    s/git\( -[^ ]\+ [^ ]\+\| --[^ ]\+=[^ ]\+\)* add/& --no-patch/g
  }
  /patch mode can be activated per option/ {
    # find add.patched test now invalid and deactivate
    s/\(test_expect_\)success/\1failure/
  }
' '{}' + 

I am unsure whether I placed all the code into the correct locations, so
comments are much appreciated, as well as opinions about the concept of
a recursion counter in general.

Regards,
XZS.

XZS (2):
  count recursion depth
  add a add.patch config variable

 Documentation/config.txt               |  6 ++++++
 Documentation/git-add.txt              |  3 +++
 builtin/add.c                          |  3 +++
 cache.h                                |  1 +
 contrib/completion/git-completion.bash |  1 +
 git.c                                  | 18 ++++++++++++++++++
 t/t0001-init.sh                        |  1 +
 t/t0120-recursion-depth.sh             | 17 +++++++++++++++++
 t/t3701-add-interactive.sh             | 27 +++++++++++++++++++++++++++
 9 files changed, 77 insertions(+)
 create mode 100755 t/t0120-recursion-depth.sh

-- 
2.8.0
