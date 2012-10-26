From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/7] Move code from builtin to libgit.a
Date: Fri, 26 Oct 2012 22:53:48 +0700
Message-ID: <1351266835-22610-1-git-send-email-pclouds@gmail.com>
References: <20121026120253.GA1455@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 26 17:54:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRmEi-0008Oz-G4
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 17:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877Ab2JZPyD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Oct 2012 11:54:03 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:49515 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964824Ab2JZPyB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 11:54:01 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1361868dak.19
        for <git@vger.kernel.org>; Fri, 26 Oct 2012 08:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=z5qZn8+pZsmBuI3KPjq6iqfd+1RDhMbkmcPwPrRNcic=;
        b=sr/7XreDyfMiwWWWkpyhsMuANDr44M/WvvJm5jjnRJIQQpBDlNAjJUPpyjp23SY4FD
         Tm0J85zxEdfyeKeFSUjsKcnMATBWzadXn26EnI7VoeQUQrzBb7B49bv8blFAPFjpK/i1
         pB6uJ8PiPlSpBZZDSL+ab0QFWZj+NtC5otk/1p3hpl8LDKyxic7UXP+hCDREe7+/YKwk
         6RCPd3OzBZ70ABUSkM5R8rXvG+aPtzL764dsBL6B5Pz3g19M8ROdTi0D10XQPqDf2YaC
         ER7H6gfCkegki3TdFqrxTMIO6EYSim+tRdDcXEj0T0dXIm29Eca1y1fpCbVrl2viAjK1
         DRWQ==
Received: by 10.66.86.228 with SMTP id s4mr52500544paz.15.1351266841097;
        Fri, 26 Oct 2012 08:54:01 -0700 (PDT)
Received: from lanh ([115.74.33.44])
        by mx.google.com with ESMTPS id c7sm1199214pay.10.2012.10.26.08.53.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 26 Oct 2012 08:54:00 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 26 Oct 2012 22:53:56 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <20121026120253.GA1455@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208456>

On Fri, Oct 26, 2012 at 7:02 PM, Jeff King <peff@peff.net> wrote:
>> OK. I checked around for similar issues and found these used by
>> libgit.a but stay in builtin/ instead:
>
> Yeah, we have traditionally been kind of lazy about the distinction,
> because it doesn't really matter for our build system (i.e., libgit.a=
 is
> not _really_ a library, but just a convenience in the build process).=
 So
> one option is just not caring about these.

Yeah. We can fix it up when we encounter new undefined reference
errors (e.g. a new test program that links to libgit.a). Anyway it
does not look too difficult to do. Take it or drop it. Your call.

> I'm also fine with fixing.
>
>> estimate_bisect_steps: bisect.c and builtin/rev-list.c
>> print_commit_list: bisect.c and builtin/rev-list.c
>>
>>  -> move them to bisect.c? another candidate is revision.c.
>
> I'd probably say bisect.c for the first, and commit.c for the latter
> (that is where commit_list functions are defined, and it is really ab=
out
> that).

Makes sense.

>> setup_diff_pager: diff-no-index.c and builtin/diff.c
>>
>>  -> to diff-lib.c?
>
> I'm not sure (to be honest, I am not even sure of the intended
> difference between diff.c and diff-lib.c). That function is really no=
t
> for general diffing, but for diff-like commands. Probably it would be=
 OK
> in diff.c.

Ditto. check_pager_config() is also moved from git.c to pager.c.

>> fetch_pack: transport.c and builtin/fetch-pack.c
>> send_pack: transport.c and builtin/send-pack.c
>>
>>  -> move them to transport.c? or new files fetch-pack.c and
>> send-pack.c? I haven't check how many functions they may pull
>> together.
>
> I think I'd rather have fetch-pack.c and send-pack.c than putting the=
m
> into transport.c (which is getting kind of bloated already).

These two are big code moves, basically all {fetch,send}-pack code.
While I think this is good cleanup (I get surprise every time I look
at transport.c and it leads to buitin/fetch-pack.c), this is probably
not a good idea if we have on flight topics, which may cause lots of
conflicts for you and Junio. Fortunately we don't at the moment.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (7):
  Move try_merge_command and checkout_fast_forward to libgit.a
  Move estimate_bisect_steps to libgit.a
  Move print_commit_list to libgit.a
  Move setup_diff_pager to libgit.a
  send-pack: move core code to libgit.a
  fetch-pack: remove global (static) configuration variable "args"
  fetch-pack: move core code to libgit.a

 Makefile             |   3 +
 bisect.c             |  38 ++
 bisect.h             |   4 -
 builtin.h            |   4 -
 builtin/diff.c       |  16 -
 builtin/fetch-pack.c | 951 +------------------------------------------=
--------
 builtin/merge.c      | 106 +-----
 builtin/rev-list.c   |  49 ---
 builtin/send-pack.c  | 333 ------------------
 cache.h              |  12 +-
 commit.c             |  10 +
 commit.h             |   4 +
 diff.c               |  16 +
 diff.h               |   1 +
 fetch-pack.c         | 951 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
 git.c                |  33 --
 merge-recursive.h    |   5 -
 merge.c              | 112 ++++++
 pager.c              |  34 ++
 send-pack.c          | 344 +++++++++++++++++++
 sequencer.c          |   2 +-
 transport.h          |   5 +
 22 files changed, 1535 insertions(+), 1498 deletions(-)
 create mode 100644 fetch-pack.c
 create mode 100644 merge.c
 create mode 100644 send-pack.c

--=20
1.8.0.rc2.23.g1fb49df
