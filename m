From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2] Teach rm to remove submodules when given with a trailing
 '/'
Date: Thu, 22 Nov 2012 23:32:26 +0100
Message-ID: <50AEA7FA.6070801@web.de>
References: <508DBF92.9090200@web.de> <508E2C05.9010109@viscovery.net> <50904677.2020308@web.de> <5090C54C.90902@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 22 23:33:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbfKo-0006rC-2o
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 23:33:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758491Ab2KVWdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 17:33:06 -0500
Received: from mout.web.de ([212.227.17.12]:59516 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758431Ab2KVWcu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 17:32:50 -0500
Received: from [192.168.178.41] ([91.3.162.204]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0LpNwf-1T5urj1n3V-00fbUG; Thu, 22 Nov 2012 23:32:30
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <5090C54C.90902@viscovery.net>
X-Enigmail-Version: 1.4.6
X-Provags-ID: V02:K0:BBm0lS4EahJGMT2ENOQo41GwhMRN88RPeKoYGiPK8bs
 lzi0/eMpNCbFpZQT3y2JMs24hgvz8Ne0fnFnTJgxvJFBtuh1FL
 X0Cofe96fKFRU8E7sS8i0M2SvWG7NoQMPn3yR5/jqD2dQYuTMR
 ciYS2YQ0AcMahscEvwRHe6ZUBRGDk/LgAu0gyzLapYVAgSQeeO
 WGenN2Warc/MP7YF4fAtQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210217>

Doing a "git rm submod/" on a submodule results in an error:
	fatal: pathspec 'submod/' did not match any files
This is really inconvenient as e.g. using TAB completion in a shell on a
submodule automatically adds the trailing '/' when it completes the path
of the submodule directory. The user has then to remove the '/' herself to
make a "git rm" succeed. Doing a "git rm -r somedir/" is working fine, so
there is no reason why that shouldn't work for submodules too.

Teach git rm to not error out when a '/' is appended to the path of a
submodule. Achieve this by chopping off trailing slashes from the path
names given if they represent directories. Add tests to make sure that
logic only applies to directories and not to files.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Am 31.10.2012 07:29, schrieb Johannes Sixt:
> Am 10/30/2012 22:28, schrieb Jens Lehmann:
>> Am 29.10.2012 08:11, schrieb Johannes Sixt:
>>> Am 10/29/2012 0:28, schrieb Jens Lehmann:
>>>> +	/* Remove trailing '/' from directories to find submodules in the index */
>>>> +	for (i = 0; i < argc; i++) {
>>>> +		size_t pathlen = strlen(argv[i]);
>>>> +		if (pathlen && is_directory(argv[i]) && (argv[i][pathlen - 1] == '/'))
>>>> +			argv[i] = xmemdupz(argv[i], pathlen - 1);
>>>> +	}
>>>> +
>>>>  	pathspec = get_pathspec(prefix, argv);
>>>>  	refresh_index(&the_index, REFRESH_QUIET, pathspec, NULL, NULL);
>>>
>>> That's wrong: Either move the check below get_pathspec() (which normalizes
>>> backslashes to forward-slashes on Windows) or use is_dir_sep().
>>
>> Thanks for bringing this up.

And sorry for taking so long to follow up on this, but I'm currently
pretty occupied with real life issues and am rather short on git time.

>>> But isn't it somewhat dangerous to check pathspec for existance in the
>>> worktree without interpreting them? Think of magic pathspec syntax (that
>>> we do not have yet, but which may materialize sometime in the future).
>>
>> I have to admit I'm not aware of magic pathspec syntax. Do you happen to
>> have any pointers where I could look at code doing similar things right?
> 
> cmd_mv() in builtin/mv.c looks like a good candidate. It has to check
> whether the destination (the last argument) is a directory.

Thanks, that was a good pointer (and judging from the comment just before
prefix_pathspec() in setup.c I currently can't do /that/ much about the
magic pathspec syntax as it has not materialized yet ;-).

I was thinking about reusing the copy_pathspec() function from mv.c but
came to the conclusion not to do so because it a) doesn't care if a '/'
is following a file (where I believe it should not be dropped but mv
should error out, but it currently doesn't) and b) it also has the
base_name argument I don't need (and which seems to be rather special to
the needs of mv.c). So I coded that loop myself using is_dir_sep()
(taking care that is_directory() will only be called on paths which have
a trailing directory separator).


 builtin/rm.c  | 15 +++++++++++++++
 t/t3600-rm.sh | 17 +++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/builtin/rm.c b/builtin/rm.c
index 2aea3b5..dabfcf6 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -234,6 +234,21 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	if (read_cache() < 0)
 		die(_("index file corrupt"));

+	/*
+	 * Drop trailing directory separators from directories so we'll find
+	 * submodules in the index.
+	 */
+	for (i = 0; i < argc; i++) {
+		size_t pathlen = strlen(argv[i]);
+		if (pathlen && is_dir_sep(argv[i][pathlen - 1]) &&
+		    is_directory(argv[i])) {
+			do {
+				pathlen--;
+			} while (pathlen && is_dir_sep(argv[i][pathlen - 1]));
+			argv[i] = xmemdupz(argv[i], pathlen);
+		}
+	}
+
 	pathspec = get_pathspec(prefix, argv);
 	refresh_index(&the_index, REFRESH_QUIET, pathspec, NULL, NULL);

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 97254e8..06f6384 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -302,6 +302,23 @@ test_expect_success 'rm removes work tree of unmodified submodules' '
 	test_cmp expect actual
 '

+test_expect_success 'rm removes a submodule with a trailing /' '
+	git reset --hard &&
+	git submodule update &&
+	git rm submod/ &&
+	test ! -d submod &&
+	git status -s -uno --ignore-submodules=none > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rm fails when given a file with a trailing /' '
+	test_must_fail git rm empty/
+'
+
+test_expect_success 'rm succeeds when given a directory with a trailing /' '
+	git rm -r frotz/
+'
+
 test_expect_success 'rm of a populated submodule with different HEAD fails unless forced' '
 	git reset --hard &&
 	git submodule update &&
-- 
1.8.0.91.gf07e555
