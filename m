Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47B951F437
	for <e@80x24.org>; Fri, 27 Jan 2017 13:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932494AbdA0NuW (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 08:50:22 -0500
Received: from mout.gmx.net ([212.227.15.18]:59887 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754879AbdA0NuU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 08:50:20 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MV5hN-1d0UqE3PPZ-00YRwn; Fri, 27
 Jan 2017 14:50:12 +0100
Date:   Fri, 27 Jan 2017 14:50:09 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Heiko Voigt <hvoigt@hvoigt.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] help: correct behavior for is_executable on Windows
Message-ID: <c1c6ccae4e60608259809914e8ff3d3d5e1ead5a.1485524999.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:R/vo1NNRzV5SbLTAMN/Hn2Imb7H6EoAy45nlnf8iVlczPm+irDT
 vao4sEOeKXwuargm29K+tjlTFn0Yk42Pj3dYMmGxUjIsyr5oqT3ScYbFVsFlCR7QbySnRYD
 e0gZQlMGeVs3iTYADloS/6Jx0C1hdrbvMgY6GZdjyF0+aM3iIPavq6NACnJJRCyRLfvQu5w
 JmK+CgYYbaIXlBrk6e3gg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:incv9o+7R7w=:LS6hYK21+DJWReC5cCXaGh
 pfHNNvQ5G0Zq2h/GeUpxkOUHNdyAWRs8U2zJ2gJe+Ji6p9RXOUWbFPMPyaN/ykigxnjyS9H78
 SW86e/m7RfZ6C8hAJQsBMupBex1OQMRfaW0jhLisX6T367mtiQ5LdaVSe5JVgbDE/IOUtcoXd
 PyQwoVT3UWOu5wsZRv+1nJvVEYF/xpgHBUtzgRjz+UQhxx+D1d/UzLdqXQntUYKEFp01geMS4
 Sj9Vg3FS7vVuxy0fh88xzhlEtiIqNs4v7LwtA+dyRB9E4d+QAWc2++pQ/G7FEWBKJBZYQil0N
 4eDNaPdqv43oVvopa4syAGIi1Ws8S+QlSagWk2E58yTopnXy0tvfBsrZPmYEt32dJVMoJ/kn4
 0oX3cEHoZxasoIQcXx8XDOF+ORO0LbRb2iyoNGgz7TeKjbvMAhqXBRmLM7qDe24uYID6QqRyK
 GxRSwsEc0TLdRBFmurkjICE0q3fEsHJRJnPznUSu1ytU03KbDSjBQ8UxShbFcgxseGPUqe74c
 qH+m4uOGMDJSUV4uQJJ7RJdDPCpohe8B3VWRQNtOXfrWG7PBID13Nier9q46i545CS6DHNvRs
 H9pEuZ7Nwmtep3fueaIbD1dRXNFK6e8+fX11bMWyIfAEDImMsVYjHuBK0VpUxzcPnag9DF+ax
 tKAB9xv6yURP93VFixyn/8yxjFmwCrzf+m/W5WdjNC5dwSaylTWzPLtar3S6eRC4bcbkvg5bm
 3IZgUbb0u+fIaxm8Os5O8XXQy/U3Gdi6RggBb5hUG40d3ZHxO5aFIw+nJDlDQHp6uvCfDtc7o
 4UDqVri8gfd6d5nN74TpetV2ek+Og==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heiko Voigt <hvoigt@hvoigt.net>

The previous implementation said that the filesystem information on
Windows is not reliable to determine whether a file is executable. To
gather this information it was peeking into the first two bytes of a
file to see whether it looks executable.

Apart from the fact that on Windows executables are defined as such by
their extension (and Git has special code to support "executing" scripts
when they have a she-bang line) it leads to serious performance
problems: not only do we have to open many files now, it gets even
slower when a virus scanner is running.

See the following measurements (in seconds) as an example, where we
execute a simple program that simply lists the directory contents and
calls open() on every listed file:

With virus scanner running (coldcache):

$ ./a.exe /libexec/git-core/
before open (git-add.exe): 0.000000
after open (git-add.exe): 0.412873
before open (git-annotate.exe): 0.000175
after open (git-annotate.exe): 0.397925
before open (git-apply.exe): 0.000243
after open (git-apply.exe): 0.399996
before open (git-archive.exe): 0.000147
after open (git-archive.exe): 0.397783
before open (git-bisect--helper.exe): 0.000160
after open (git-bisect--helper.exe): 0.397700
before open (git-blame.exe): 0.000160
after open (git-blame.exe): 0.399136
...

With virus scanner running (hotcache):

$ ./a.exe /libexec/git-core/
before open (git-add.exe): 0.000000
after open (git-add.exe): 0.000325
before open (git-annotate.exe): 0.000229
after open (git-annotate.exe): 0.000177
before open (git-apply.exe): 0.000167
after open (git-apply.exe): 0.000150
before open (git-archive.exe): 0.000154
after open (git-archive.exe): 0.000156
before open (git-bisect--helper.exe): 0.000132
after open (git-bisect--helper.exe): 0.000180
before open (git-blame.exe): 0.000718
after open (git-blame.exe): 0.000724
...

With this patch I get:

$ time git help git
Launching default browser to display HTML ...

real    0m8.723s
user    0m0.000s
sys     0m0.000s

and without

$ time git help git
Launching default browser to display HTML ...

real    1m37.734s
user    0m0.000s
sys     0m0.031s

both tests with cold cache and giving the machine some time to settle
down after restart.

Signed-off-by: Heiko Voigt <heiko.voigt@mahr.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/help-is-exe-v1
Fetch-It-Via: git fetch https://github.com/dscho/git help-is-exe-v1

 help.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/help.c b/help.c
index 53e2a67e00..bc6cd19cf3 100644
--- a/help.c
+++ b/help.c
@@ -105,7 +105,22 @@ static int is_executable(const char *name)
 		return 0;
 
 #if defined(GIT_WINDOWS_NATIVE)
-{	/* cannot trust the executable bit, peek into the file instead */
+	/*
+	 * On Windows there is no executable bit. The file extension
+	 * indicates whether it can be run as an executable, and Git
+	 * has special-handling to detect scripts and launch them
+	 * through the indicated script interpreter. We test for the
+	 * file extension first because virus scanners may make
+	 * it quite expensive to open many files.
+	 */
+	if (ends_with(name, ".exe"))
+		return S_IXUSR;
+
+{
+	/*
+	 * Now that we know it does not have an executable extension,
+	 * peek into the file instead.
+	 */
 	char buf[3] = { 0 };
 	int n;
 	int fd = open(name, O_RDONLY);
@@ -113,8 +128,8 @@ static int is_executable(const char *name)
 	if (fd >= 0) {
 		n = read(fd, buf, 2);
 		if (n == 2)
-			/* DOS executables start with "MZ" */
-			if (!strcmp(buf, "#!") || !strcmp(buf, "MZ"))
+			/* look for a she-bang */
+			if (!strcmp(buf, "#!"))
 				st.st_mode |= S_IXUSR;
 		close(fd);
 	}

base-commit: 4e59582ff70d299f5a88449891e78d15b4b3fabe
-- 
2.11.1.windows.prerelease.2.9.g3014b57
