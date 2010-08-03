From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [RFC/PATCH] git-compat-util.h: Don't define NORETURN under __clang__
Date: Tue,  3 Aug 2010 13:08:03 +0000
Message-ID: <1280840883-24540-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 03 15:08:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgHEM-00075d-Hz
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 15:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755904Ab0HCNIY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Aug 2010 09:08:24 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47294 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755817Ab0HCNIX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 09:08:23 -0400
Received: by wwj40 with SMTP id 40so5107526wwj.1
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 06:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=HXES/YzGWHrB5EEUsnI1g9eEO/snA7QBUSW10qkcdFM=;
        b=pFm3zTalR3JwoATRgnEciqdEoRwWOK3f3OwvhHNT88MxKUlSfk3kI3kejLnFkaLm1q
         u1h3YiuJYKDIL+q4YQZfLdQ5ZNaV3pLMwpf8ightsTkoMpXa27hyyqFMqoKRmqKjYtyX
         XccyzA9BLIY+rhi6ZdjopjCMOtRSGU7RxD8hk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=LP83QdY52eu7fyRy/kooIZJV237mTB38LTtKNys03/0gr6LBKCkhuAvu3RWjYMoarG
         VjNSrQbADN7BRt2if36F0BEMCo7CClt9YFDLLkXPDH6Gk8B2hPnp7INkTvlGLa77oW9+
         xGwlgO9yn4N1Wrka76BFcC+De39wFTgltq+Qk=
Received: by 10.227.148.18 with SMTP id n18mr6122848wbv.207.1280840901966;
        Tue, 03 Aug 2010 06:08:21 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id l55sm3527802weq.41.2010.08.03.06.08.20
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Aug 2010 06:08:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152511>

clang version 1.0 on Debian testing x86_64 defines __GNUC__, but barfs
on `void __attribute__((__noreturn__))'. E.g.:

    usage.c:56:1: error: function declared 'noreturn' should not return=
 [-Winvalid-noreturn]
    }
    ^
    1 diagnostic generated.
    make: *** [usage.o] Error 1

There it's dying on `void __attribute__((__noreturn__)) usagef(const
char *err, ...)' in usage.c, which doesn't return.

Change the header to define NORETURN to nothing under clang. This was
the default behavior for non-GNU and non-MSC compilers already. Having
NORETURN_PTR defined to the GNU C value has no effect on clang
however.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

I have no experience with Clang so this may not be sane, but on my
system clang compiles with it and passes all tests. It still spews a
lot of warnings though:
   =20
    GITGUI_VERSION =3D 0.12.0.64.g89d61
        * new build flags or prefix
    config.c:297:1: warning: control may reach end of non-void function=
 [-Wreturn-type]
    }
    ^
    1 diagnostic generated.
    connect.c:151:1: warning: control may reach end of non-void functio=
n [-Wreturn-type]
    }
    ^
    1 diagnostic generated.
    date.c:678:1: warning: control may reach end of non-void function [=
-Wreturn-type]
    }
    ^
    1 diagnostic generated.
    diff.c:429:1: warning: control may reach end of non-void function [=
-Wreturn-type]
    }
    ^
    1 diagnostic generated.

These are valid, as control may not return the advertised type if we
call die() inside them.

    log-tree.c:297:21: warning: field width should have type 'int', but=
 argument has type 'unsigned int' [-Wformat]
                             "Subject: [%s %0*d/%d] ",
                                             ^
    1 diagnostic generated.
    notes.c:632:25: warning: field precision should have type 'int', bu=
t argument has type 'unsigned int' [-Wformat]
            strbuf_addf(buf, "%o %.*s%c", mode, path_len, path, '\0');
                                   ^            ~~~~~~~~
    1 diagnostic generated.

Should these (and some below) just cast to (int) ?

    object.c:44:1: warning: control may reach end of non-void function =
[-Wreturn-type]
    }
    ^
    1 diagnostic generated.
    parse-options.c:155:1: warning: control may reach end of non-void f=
unction [-Wreturn-type]
    }
    ^
    1 diagnostic generated.
    read-cache.c:1361:1: warning: control may reach end of non-void fun=
ction [-Wreturn-type]
    }
    ^
    1 diagnostic generated.
    remote.c:658:1: warning: control may reach end of non-void function=
 [-Wreturn-type]
    }
    ^
    1 diagnostic generated.
    revision.c:253:1: warning: control may reach end of non-void functi=
on [-Wreturn-type]
    }
    ^
    1 diagnostic generated.
    setup.c:79:1: warning: control may reach end of non-void function [=
-Wreturn-type]
    }
    ^
    1 diagnostic generated.
    sideband.c:97:25: warning: field precision should have type 'int', =
but argument has type 'unsigned int' [-Wformat]
                                            fprintf(stderr, "%.*s", brk=
 + sf, b);
                                                               ^    ~~~=
~~~~~
    1 diagnostic generated.
    transport.c:1133:1: warning: control may reach end of non-void func=
tion [-Wreturn-type]
    }
    ^
    1 diagnostic generated.
    imap-send.c:548:27: warning: more data arguments than '%' conversio=
ns [-Wformat-extra-args]
                               cmd->tag, cmd->cmd, cmd->cb.dlen);
                                                   ^
    1 diagnostic generated.
    Writing perl.mak for Git
    GIT_VERSION =3D 1.7.2.1.7.gb44c1
    builtin/blame.c:1984:1: warning: control may reach end of non-void =
function [-Wreturn-type]
    }
    ^
    1 diagnostic generated.
    builtin/bundle.c:67:1: warning: control may reach end of non-void f=
unction [-Wreturn-type]
    }
    ^
    1 diagnostic generated.
    builtin/commit.c:832:1: warning: control may reach end of non-void =
function [-Wreturn-type]
    }
    ^
    1 diagnostic generated.
    builtin/fetch-pack.c:209:1: warning: control may reach end of non-v=
oid function [-Wreturn-type]
    }
    ^
    1 diagnostic generated.
    builtin/grep.c:704:1: warning: control may reach end of non-void fu=
nction [-Wreturn-type]
    }
    ^
    1 diagnostic generated.
    builtin/help.c:58:1: warning: control may reach end of non-void fun=
ction [-Wreturn-type]
    }
    ^
    1 diagnostic generated.
    builtin/pack-redundant.c:584:1: warning: control may reach end of n=
on-void function [-Wreturn-type]
    }
    ^
    1 diagnostic generated.
    builtin/push.c:252:1: warning: control may reach end of non-void fu=
nction [-Wreturn-type]
    }
    ^
    1 diagnostic generated.
    builtin/reflog.c:782:1: warning: control may reach end of non-void =
function [-Wreturn-type]
    }
    ^
    1 diagnostic generated.
   =20
 git-compat-util.h |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 02a73ee..c651cb7 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -183,7 +183,10 @@ extern char *gitbasename(char *);
 #define is_dir_sep(c) ((c) =3D=3D '/')
 #endif
=20
-#ifdef __GNUC__
+#ifdef __clang__
+#define NORETURN
+#define NORETURN_PTR __attribute__((__noreturn__))
+#elif __GNUC__
 #define NORETURN __attribute__((__noreturn__))
 #define NORETURN_PTR __attribute__((__noreturn__))
 #elif defined(_MSC_VER)
--=20
1.7.1
