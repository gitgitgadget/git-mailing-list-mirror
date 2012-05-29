From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: "docs: stop using asciidoc no-inline-literal" breaks asciidoc 8.2.5
Date: Tue, 29 May 2012 12:19:56 +0200
Message-ID: <CACBZZX7Y-NTzRP1KYy=eEHTsLHTrzxGms61anXSHVbyCSPgurw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 29 12:20:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZJXM-0004UG-DX
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 12:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488Ab2E2KUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 May 2012 06:20:19 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:44978 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753367Ab2E2KUS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2012 06:20:18 -0400
Received: by obbtb18 with SMTP id tb18so6669069obb.19
        for <git@vger.kernel.org>; Tue, 29 May 2012 03:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=fLlQ2hVf4d0wr3t/QiRh+Oa+wNYFgjxPH/EZUT3DrNU=;
        b=OgwXylziNOmCIU+s0v1TgtpM6+XP7ZcGCWc/Kl2oRdTb7JoxxfK8Y6EnLYVz02jFE4
         krkfNqTjxn5OrMurmc6r1r5Uf6rZic4gIfZP7m7AEZdfXdrAP90Al+HjVSOnYy+HNZij
         TJgb096/oWY8FJmqR+YtcI561fCjhwYAycdHcXL/PACqleFYvgP3CARO/GaANMS3MRd8
         wEx4xS0yUUuUmkhf4LQXhkwTQ1KbDAkdOF1RYc0gVT83+s/7XmDMjtq/wwKK3ugtoq74
         vdvm6Nm4OpJtbxW8uf+3fVh0BrbTHfjKreX3+j3WOMFaydRlmqW7i8QLHACz2m5BxyDZ
         xH5A==
Received: by 10.60.14.68 with SMTP id n4mr10677194oec.24.1338286817713; Tue,
 29 May 2012 03:20:17 -0700 (PDT)
Received: by 10.182.167.65 with HTTP; Tue, 29 May 2012 03:19:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198733>

Jeff King's 6cf378f0cbe7c7f944637892caeb9058c90a185a broke my Git
build on CentOS 5.5. The patch suggests that it only breaks
compatibility with asciidoc 7 but that isn't actually the case.

The problem is that by using literals we seem to be triggering some
old bug in asciidoc related to how it balances XML tags, so e.g. for
this bit in user-manual.txt:

    - the variable `sha1` in the function signature of `get_sha1()` is `unsigned
      char *`, but is actually expected to be a pointer to `unsigned
      char[20]`.  This variable will contain the 160-bit SHA-1 of the given
      commit.  Note that whenever a SHA-1 is passed as `unsigned char *`, it
      is the binary representation, as opposed to the ASCII representation in
      hex characters, which is passed as `char *`.

We'll produce this XML:

    <simpara>
    the variable <literal>sha1</literal> in the function signature of
<literal>get_sha1()</literal> is <literal>unsigned
      char <emphasis role="strong"></literal>, but is actually
expected to be a pointer to <literal>unsigned
      char[20]</literal>.  This variable will contain the 160-bit
SHA-1 of the given
      commit.  Note that whenever a SHA-1 is passed as
<literal>unsigned char </emphasis></literal>, it
      is the binary representation, as opposed to the ASCII representation in
      hex characters, which is passed as <literal>char *</literal>.
    </simpara>

Which results in this error:

    user-manual.xml:3743: parser error : Opening and ending tag
mismatch: emphasis line 3743 and literal
      char <emphasis role="strong"></literal>, but is actually
expected to be a poin
                                             ^
    user-manual.xml:3745: parser error : Opening and ending tag
mismatch: literal line 3745 and emphasis
    mit.  Note that whenever a SHA-1 is passed as <literal>unsigned
char </emphasis>

A patch like this will hack around that:

    diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
    index 1b94207..0fc8829 100644
    --- a/Documentation/user-manual.txt
    +++ b/Documentation/user-manual.txt
    @@ -4270,9 +4270,9 @@ Two things are interesting here:
       negative numbers in case of different errors--and 0 on success.

     - the variable `sha1` in the function signature of `get_sha1()`
is `unsigned
    -  char *`, but is actually expected to be a pointer to `unsigned
    +  char {asterisk}`, but is actually expected t
       char[20]`.  This variable will contain the 160-bit SHA-1 of the given
    -  commit.  Note that whenever a SHA-1 is passed as `unsigned char *`, it
    +  commit.  Note that whenever a SHA-1 is passed as `unsigned char
{asterisk}`, it
       is the binary representation, as opposed to the ASCII representation in
       hex characters, which is passed as `char *`.

So the issue appears to be mostly related to older asciidoc in the 8.*
line incorrectly handling markup that would generate nested XML tags,
here's as far as I got with fixing it:

    $ git --no-pager diff -U0 @{u}..
    diff --git a/Documentation/config.txt b/Documentation/config.txt
    index 915cb5a..fd2f939 100644
    --- a/Documentation/config.txt
    +++ b/Documentation/config.txt
    @@ -904 +904 @@ commit.template::
    -       "`~/`" is expanded to the value of `$HOME` and "`~user/`" to the
    +       "`{tilde}/`" is expanded to the value of `$HOME` and
"`{tilde}user/`" to the
    @@ -1664 +1664 @@ pack.indexVersion::
    -If you have an old git that does not understand the version 2 `*.idx` file,
    +If you have an old git that does not understand the version 2
`{asterisk}.idx` file,
    @@ -1666 +1666 @@ cloning or fetching over a non native protocol
(e.g. "http" and "rsync")
    -that will copy both `*.pack` file and corresponding `*.idx` file from the
    +that will copy both `{asterisk}.pack` file and corresponding
`{asterisk}.idx` file from the
    @@ -1668 +1668 @@ other side may give you a repository that cannot
be accessed with your
    -older version of git. If the `*.pack` file is smaller than 2 GB, however,
    +older version of git. If the `{asterisk}.pack` file is smaller
than 2 GB, however,
    @@ -1670 +1670 @@ you can use linkgit:git-index-pack[1] on the
*.pack file to regenerate
    -the `*.idx` file.
    +the `{asterisk}.idx` file.
    @@ -1694 +1694 @@ pretty.<name>::
    -       running `git config pretty.changelog "format:* %H %s"`
    +       running `git config pretty.changelog "format:{asterisk} %H %s"`
    @@ -1696 +1696 @@ pretty.<name>::
    -       to be equivalent to running `git log "--pretty=format:* %H %s"`.
    +       to be equivalent to running `git log
"--pretty=format:{asterisk} %H %s"`.
    diff --git a/Documentation/git-check-ref-format.txt
b/Documentation/git-check-ref-format.txt
    index 98009d1..3370565 100644
    --- a/Documentation/git-check-ref-format.txt
    +++ b/Documentation/git-check-ref-format.txt
    @@ -95 +95 @@ OPTIONS
    -       enabled, <refname> is allowed to contain a single `*`
    +       enabled, <refname> is allowed to contain a single `{asterisk}`
    @@ -97 +97 @@ OPTIONS
    -       `foo/*/bar` but not `foo/bar*`).
    +       `foo/{asterisk}/bar` but not `foo/bar{asterisk}`).
    diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
    index 3bec036..5ae82f3 100644
    --- a/Documentation/git-grep.txt
    +++ b/Documentation/git-grep.txt
    @@ -252 +252 @@ Examples
    -`git grep 'time_t' -- '*.[ch]'`::
    +`git grep {apostrophe}time_t{apostrophe} \--
{apostrophe}*.[ch]{apostrophe}`::
    diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
    index 1b94207..fe86e53 100644
    --- a/Documentation/user-manual.txt
    +++ b/Documentation/user-manual.txt
    @@ -4273 +4273 @@ Two things are interesting here:
    -  char *`, but is actually expected to be a pointer to `unsigned
    +  char {asterisk}`, but is actually expected to be a pointer to `unsigned
    @@ -4275 +4275 @@ Two things are interesting here:
    -  commit.  Note that whenever a SHA-1 is passed as `unsigned char *`, it
    +  commit.  Note that whenever a SHA-1 is passed as `unsigned char
{asterisk}`, it
    @@ -4277 +4277 @@ Two things are interesting here:
    -  hex characters, which is passed as `char *`.
    +  hex characters, which is passed as `char {asterisk}`.

I suggest just ejecting this patch and trying again, these RedHat
systems are still used in a lot of environments, especially by various
companies.
