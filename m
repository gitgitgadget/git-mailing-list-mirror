From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 0/3] Fix code issues spotted by clang
Date: Sun, 6 Nov 2011 13:33:47 +0100
Message-ID: <CACBZZX7bzFy_NCr4RTpYXXVmieaV7GrBfJgwdtCT1SwoXV_cGA@mail.gmail.com>
References: <1320581184-4557-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jim Meyering <jim@meyering.net>,
	Fredrik Gustafsson <iveqy@iveqy.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Martin Waitz <tali@admingilde.org>,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 06 13:34:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RN1vT-0008SN-Kl
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 13:34:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890Ab1KFMeL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Nov 2011 07:34:11 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56504 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525Ab1KFMeJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Nov 2011 07:34:09 -0500
Received: by bke11 with SMTP id 11so3008176bke.19
        for <git@vger.kernel.org>; Sun, 06 Nov 2011 04:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ZKcI5x0TCk/N24DHVGHe75KtrOGF0+zeDavc8pptLlY=;
        b=fo4B9nqlU/FmCZwon2d87dIO59I6MGy+xCszw9UGoTR++VFsQ+mq1/yWkiix7jh+Op
         TdkSSMg1ybnRk/eDpJc+vVe2Ewen2vKkM5wi/clXlL8ykXc5M8EPVtQiOOjAGitHRAfM
         G7tk5h2ZwBbdvWvRHCVxnLb9Zz1u62h/5ORQw=
Received: by 10.205.122.144 with SMTP id gg16mr338010bkc.97.1320582848162;
 Sun, 06 Nov 2011 04:34:08 -0800 (PST)
Received: by 10.204.118.67 with HTTP; Sun, 6 Nov 2011 04:33:47 -0800 (PST)
In-Reply-To: <1320581184-4557-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184912>

On Sun, Nov 6, 2011 at 13:06, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
> This series fixes some of the code issues raised by clang.

Out of curiosity I also compiled git on "Sun Studio 12 Update 1" on
ee6dfb2d83ba1b057943e705f707fa27e34e47f9 with this patch series
applied and it emits the following warnings, quoted below along with
my comments:

    "pack-write.c", line 76: warning: name redefined by pragma
redefine_extname declared static: tmpfile

Presumably this means that we've imported the function tmpfile() and
Sun's CC doesn't like that we're creating a variable with that name.

    "read-cache.c", line 761: warning: statement not reached

SunCC's brain is melting on this particularly clever piece of code:

    	goto inside;
    	for (;;) {
    		if (!c)
    			return 1;
    		if (is_dir_sep(c)) {
    inside:

    "sha1_file.c", line 2453: warning: name redefined by pragma
redefine_extname declared static: tmpfile

same tempfile issue.

    "compat/../git-compat-util.h", line 4: warning: macro redefined:
_FILE_OFFSET_BITS
    "compat/../git-compat-util.h", line 4: warning: macro redefined:
_FILE_OFFSET_BITS

Seems we're clashing with this:

    $ grep -r '#define.*_FILE_OFFSET_BITS' /usr/include/
    /usr/include/sys/feature_tests.h:#define   _FILE_OFFSET_BITS   64
    /usr/include/sys/feature_tests.h:#define   _FILE_OFFSET_BITS   32

    "xdiff/xutils.c", line 194: warning: statement not reached

This was added in b97e911643341cb31e6b97029b9ffd96fc675b1d as a
workaround on systems using glibc, should this even be run on Sun
libc? Martin?

Another clever bit of code blowing SunCC's brain:

	if (flags & XDF_IGNORE_WHITESPACE) {
		goto skip_ws;
		while (i1 < s1 && i2 < s2) {
			if (l1[i1++] !=3D l2[i2++])
				return 0;
		skip_ws:
			while (i1 < s1 && XDL_ISSPACE(l1[i1]))
				i1++;
			while (i2 < s2 && XDL_ISSPACE(l2[i2]))
				i2++;
		}
	}

    "fast-import.c", line 858: warning: name redefined by pragma
redefine_extname declared static: tmpfile

ditto tempfile issue.

    "builtin/fast-export.c", line 54: warning: enum type mismatch: op "=
=3D"

This seems to me to be a legitimate issue we introduced in
2d8ad46919213ebbd7bb72eb5b56cca8cc3ae07f, Elijah?

We're defining an enum like this:

    static enum { ABORT, VERBATIM, WARN, STRIP } signed_tag_mode =3D AB=
ORT;
    static enum { ERROR, DROP, REWRITE } tag_of_filtered_mode =3D ABORT=
;

And then doing:

	if (unset || !strcmp(arg, "abort"))
		tag_of_filtered_mode =3D ABORT; <-- Line 54
	else if (!strcmp(arg, "drop"))
		tag_of_filtered_mode =3D DROP;
	else if (!strcmp(arg, "rewrite"))
		tag_of_filtered_mode =3D REWRITE;

Presumably that assignment should be "=3D ERROR".

    "builtin/index-pack.c", line 175: warning: name redefined by
pragma redefine_extname declared static: tmpfile

ditto tempfile.

    "vcs-svn/string_pool.c", line 11: warning: initializer will be
sign-extended: -1
    "vcs-svn/string_pool.c", line 81: warning: initializer will be
sign-extended: -1
    "vcs-svn/repo_tree.c", line 112: warning: initializer will be
sign-extended: -1
    "vcs-svn/repo_tree.c", line 112: warning: initializer will be
sign-extended: -1
    "test-treap.c", line 34: warning: initializer will be sign-extended=
: -1

All of these come down to assigning ~0 to an uint32_t variable, e.g.:

	uint32_t token =3D ~0;
