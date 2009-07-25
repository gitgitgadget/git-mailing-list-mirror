From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git init: optionally allow a directory argument
Date: Fri, 24 Jul 2009 23:41:18 -0700
Message-ID: <7v7hxxz2lt.fsf@alter.siamese.dyndns.org>
References: <20090725065928.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 08:42:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUaxP-0001jB-Ej
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 08:42:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755146AbZGYGlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 02:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755131AbZGYGlZ
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 02:41:25 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36103 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755086AbZGYGlY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 02:41:24 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9E94910AB2;
	Sat, 25 Jul 2009 02:41:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3CC1310AB1; Sat, 25 Jul 2009
 02:41:19 -0400 (EDT)
In-Reply-To: <20090725065928.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Sat\, 25 Jul 2009 06\:59\:28 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2B8CF928-78E6-11DE-A307-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123992>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> When starting a new repository, I see my students often say
>
>     % git init newrepo
>
> and curse git.  They could say
>
>     % mkdir newrepo; cd newrepo; git init
>
> but allowing it as an obvious short-cut may be nicer.
>
> Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
> ---
>
>  Please be gentle; I don't write C very well.

As I already said, the patch looked reasonable.

> +	if (i == argc - 1) {
> +		int mkdir_tried = 0;
> +	retry:
> +		if (chdir(argv[1]) < 0) {
> +			if (!mkdir_tried) {
> +				if (mkdir(argv[1], 0777) < 0)
> +					die_errno("cannot mkdir %s", argv[1]);
> +				mkdir_tried = 1;
> +				goto retry;
> +			}
> +			die_errno("cannot chdir to %s", argv[1]);
> +		}

But I have to wonder if we would also want to allow

	$ git init --bare project/repo-000.git

when you do not even have "project" directory.  After all, we are talking
about people who do not bother "mkdir repo-000.git", so instead of doing
equivalent of "mkdir project/repo-000.git", it would make more sense to do
an equivalent of "mkdir -p project/repo-000.git" instead.

Here is a patch to do so on top of yours, possibly you may want to squash
in.

 builtin-init-db.c |   19 +++++++++++++++++++
 t/t0001-init.sh   |   43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 100db73..b7f708d 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -410,6 +410,25 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	retry:
 		if (chdir(argv[1]) < 0) {
 			if (!mkdir_tried) {
+				int saved;
+				/*
+				 * At this point we haven't read any configuration,
+				 * and we know shared_repository should always be 0;
+				 * but just in case we play safe.
+				 */
+				saved = shared_repository;
+				shared_repository = 0;
+				switch (safe_create_leading_directories_const(argv[1])) {
+				case -3:
+					errno = EEXIST;
+					/* fallthru */
+				case -1:
+					die_errno("cannot mkdir %s", argv[1]);
+					break;
+				default:
+					break;
+				}
+				shared_repository = saved;
 				if (mkdir(argv[1], 0777) < 0)
 					die_errno("cannot mkdir %s", argv[1]);
 				mkdir_tried = 1;
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 0ded031..8c55404 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -242,4 +242,47 @@ test_expect_success 'init recreates a new bare directory' '
 	)
 '
 
+test_expect_success 'init creates a new deep directory' '
+	rm -fr newdir &&
+	(
+		# Leading directories should honor umask while
+		# the repository itself should follow "shared"
+		umask 002 &&
+		git init --bare --shared=0660 newdir/a/b/c &&
+		test -d newdir/a/b/c/refs &&
+		ls -ld newdir/a newdir/a/b > lsab.out &&
+		! grep -v "^drwxrw[sx]r-x" ls.out &&
+		ls -ld newdir/a/b/c > lsc.out &&
+		! grep -v "^drwxrw[sx]---" lsc.out
+	)
+'
+
+test_expect_success 'init notices EEXIST (1)' '
+	rm -fr newdir &&
+	(
+		>newdir &&
+		test_must_fail git init newdir &&
+		test -f newdir
+	)
+'
+
+test_expect_success 'init notices EEXIST (2)' '
+	rm -fr newdir &&
+	(
+		mkdir newdir &&
+		>newdir/a
+		test_must_fail git init newdir/a/b &&
+		test -f newdir/a
+	)
+'
+
+test_expect_success 'init notices EPERM' '
+	rm -fr newdir &&
+	(
+		mkdir newdir &&
+		chmod -w newdir &&
+		test_must_fail git init newdir/a/b
+	)
+'
+
 test_done
