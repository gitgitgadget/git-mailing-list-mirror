From: Ali Tofigh <alix.tofigh@gmail.com>
Subject: test t1050.large fails
Date: Mon, 6 Aug 2012 23:13:48 -0400
Message-ID: <CAD=7RJaz3rvQ-UnTG-DhMCQaecFMd5JevRwGaTmgjYiDtj2nFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Mailinglist git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 07 05:14:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyaFf-0001jD-Ln
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 05:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757186Ab2HGDOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Aug 2012 23:14:30 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:44825 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757182Ab2HGDO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 23:14:29 -0400
Received: by obbuo13 with SMTP id uo13so6848741obb.19
        for <git@vger.kernel.org>; Mon, 06 Aug 2012 20:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=su2V1i1yph/hAOiiCBCQLh+Q3g62c/PI8liW3cgkCqo=;
        b=JRD+ABYmGml3KBbNjrfki25g9nhNLopX46zkroGhMrIv9CwouIcsJX1hlBXaFTW2Wa
         wO828Ciiyx39KFwSGqEhPs2csfx8l/zbcMlDjsETYrsy71WOwMNMQjbVEVdKCOnHM8H1
         5SkunRKcIQV3rRLqx5Bzi6MX2K8ZtnjQpV47hqZrgC2q2I4RNaDjiZWWcnYTiRLlucMa
         o6H/JLdjS8o0wPBlnkhVp2ubilalUZFGFR7mVmgFU+MXaEL5VJxWbvx/aZr11YR71+Ce
         Ht2IyCLeKBGezup5b/W7KOfm4e6+3saErvY1bcv65y6L/RYjYdsSZ17dVZ29nV2VuHd+
         xfhA==
Received: by 10.60.6.73 with SMTP id y9mr22346971oey.17.1344309269036; Mon, 06
 Aug 2012 20:14:29 -0700 (PDT)
Received: by 10.182.159.2 with HTTP; Mon, 6 Aug 2012 20:13:48 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203008>

I'm trying to compile git from source on a linux machine and "make
test" fails unexpectedly. Specifically test t1050.large.sh fails
(details below). The test fails both in version 1.7.11.4 and on the
master branch. Can I trust and use the build? if not, could someone
help me figure out what is going on?

Below are the contents of the test output (t1050-large.out):

/ali

>> cat test-results/t1050-large.out
Initialized empty Git repository in
/usr/local/pkgs/repositories/git/t/trash directory.t1050-large/.git/
expecting success:
        # clone does not allow us to pass core.bigfilethreshold to
        # new repos, so set core.bigfilethreshold globally
        git config --global core.bigfilethreshold 200k &&
        echo X | dd of=large1 bs=1k seek=2000 &&
        echo X | dd of=large2 bs=1k seek=2000 &&
        echo X | dd of=large3 bs=1k seek=2000 &&
        echo Y | dd of=huge bs=1k seek=2500 &&
        GIT_ALLOC_LIMIT=1500 &&
        export GIT_ALLOC_LIMIT

0+1 records in
0+1 records out
2 bytes (2 B) copied, 0.000303677 s, 6.6 kB/s
0+1 records in
0+1 records out
2 bytes (2 B) copied, 0.00026004 s, 7.7 kB/s
0+1 records in
0+1 records out
2 bytes (2 B) copied, 0.00024059 s, 8.3 kB/s
0+1 records in
0+1 records out
2 bytes (2 B) copied, 0.00027323 s, 7.3 kB/s
ok 1 - setup

expecting success:
        git add large1 huge large2 &&
        # make sure we got a single packfile and no loose objects
        bad= count=0 idx= &&
        for p in .git/objects/pack/pack-*.pack
        do
                count=$(( $count + 1 ))
                if test -f "$p" && idx=${p%.pack}.idx && test -f "$idx"
                then
                        continue
                fi
                bad=t
        done &&
        test -z "$bad" &&
        test $count = 1 &&
        cnt=$(git show-index <"$idx" | wc -l) &&
        test $cnt = 2 &&
        for l in .git/objects/??/??????????????????????????????????????
        do
                test -f "$l" || continue
                bad=t
        done &&
        test -z "$bad" &&

        # attempt to add another copy of the same
        git add large3 &&
        bad= count=0 &&
        for p in .git/objects/pack/pack-*.pack
        do
                count=$(( $count + 1 ))
                if test -f "$p" && idx=${p%.pack}.idx && test -f "$idx"
                then
                        continue
                fi
                bad=t
        done &&
        test -z "$bad" &&
        test $count = 1

ok 2 - add a large file or two

expecting success:
        large1=$(git rev-parse :large1) &&
        git update-index --add --cacheinfo 100644 $large1 another &&
        git checkout another &&
        cmp large1 another ;# this must not be test_cmp

ok 3 - checkout a large file

expecting success:
        test_create_repo mid &&
        (
                cd mid &&
                git config core.bigfilethreshold 64k &&
                git config pack.packsizelimit 256k &&

                # mid1 and mid2 will fit within 256k limit but
                # appending mid3 will bust the limit and will
                # result in a separate packfile.
                test-genrandom "a" $(( 66 * 1024 )) >mid1 &&
                test-genrandom "b" $(( 80 * 1024 )) >mid2 &&
                test-genrandom "c" $(( 128 * 1024 )) >mid3 &&
                git add mid1 mid2 mid3 &&

                count=0
                for pi in .git/objects/pack/pack-*.idx
                do
                        test -f "$pi" && count=$(( $count + 1 ))
                done &&
                test $count = 2 &&

                (
                        git hash-object --stdin <mid1
                        git hash-object --stdin <mid2
                        git hash-object --stdin <mid3
                ) |
                sort >expect &&

                for pi in .git/objects/pack/pack-*.idx
                do
                        git show-index <"$pi"
                done |
                sed -e "s/^[0-9]* \([0-9a-f]*\) .*/\1/" |
                sort >actual &&

                test_cmp expect actual
        )

Initialized empty Git repository in
/usr/local/pkgs/repositories/git/t/trash
directory.t1050-large/mid/.git/
fatal: Unexpected checksum for .git/objects/pack/tmp_pack_ImJEj4 (disk
corruption?)
not ok - 4 packsize limit
#
#               test_create_repo mid &&
#               (
#                       cd mid &&
#                       git config core.bigfilethreshold 64k &&
#                       git config pack.packsizelimit 256k &&
#
#                       # mid1 and mid2 will fit within 256k limit but
#                       # appending mid3 will bust the limit and will
#                       # result in a separate packfile.
#                       test-genrandom "a" $(( 66 * 1024 )) >mid1 &&
#                       test-genrandom "b" $(( 80 * 1024 )) >mid2 &&
#                       test-genrandom "c" $(( 128 * 1024 )) >mid3 &&
#                       git add mid1 mid2 mid3 &&
#
#                       count=0
#                       for pi in .git/objects/pack/pack-*.idx
#                       do
#                               test -f "$pi" && count=$(( $count + 1 ))
#                       done &&
#                       test $count = 2 &&
#
#                       (
#                               git hash-object --stdin <mid1
#                               git hash-object --stdin <mid2
#                               git hash-object --stdin <mid3
#                       ) |
#                       sort >expect &&
#
#                       for pi in .git/objects/pack/pack-*.idx
#                       do
#                               git show-index <"$pi"
#                       done |
#                       sed -e "s/^[0-9]* \([0-9a-f]*\) .*/\1/" |
#                       sort >actual &&
#
#                       test_cmp expect actual
#               )
#
