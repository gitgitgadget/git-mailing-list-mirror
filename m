Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 106251F453
	for <e@80x24.org>; Wed, 30 Jan 2019 08:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbfA3I7I (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 03:59:08 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33628 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725850AbfA3I7H (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 30 Jan 2019 03:59:07 -0500
Received: from genre.crustytoothpaste.net (host-85-27-49-13.dynamic.voo.be [85.27.49.13])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 94FE160737;
        Wed, 30 Jan 2019 08:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1548838743;
        bh=A2TTuYufGJ2RBquJX/6tRo4M0MWnavi9Vzj8X5Uc5Rk=;
        h=Date:From:To:Cc:Subject:Content-Type:Content-Disposition:From:
         Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
         Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
        b=qm+s6tmzspLH4mF0NnhlkRYKiG7BD5hFpQd2mXyHsmv5qrzmV5+YFgl2/mnCOWcN8
         rAy33lY9q1MUutrrZkLYr8Szc5f9ywAp2UJ0uGUZx9drwTcCLiYDlkV8WEtzyP8d1c
         hkeQqps6Mr5YgZ2ONrYslckNxqK8pXHvnzRVnRyZFccUjndzM5s5FAyGirXjhiYz3P
         2U1dtLYE2smNpfNHIPrnawXuJqd3IXmwq/lhYrT68wo70JJdszk9Bf4DYDjRrkmnOq
         KUxRvLJMLAp0j8ZDAVKZhLUaObImHyRUVgbNI49NQRrN9Jzu3sjtvU6uEazEACoVJ5
         saR1Oj2jI9ssg9E+CoS3mo3vC+YjMyi5yPWbgWj6b8Vk95f/OajDooZK7xPvraSsLm
         Aty6oc4VqwtInYC9Tb6W9MNRcZlOHOgfHwvJVJiku6UJMBrCOefLGgn05qFvQfCRpo
         tdwZqgNRyZmG5m8EqFqnuEhBo87nLJ+Y88i48hGBujxImy1eik2
Date:   Wed, 30 Jan 2019 08:58:56 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: t5702 failing under ASan on master
Message-ID: <20190130085855.GA24387@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It looks like t5702 is failing on master under ASan (output below). It
bisects to the merge of my sha-256 series, but the error makes it look
like it's unrelated. I'm wondering if we just happened to have a
different memory layout with that series that's triggering this issue in
combination with one of the protocol v2 series from Jonathan Tan, and
the correct solution is something like this:

----- %< -------
diff --git a/fetch-pack.c b/fetch-pack.c
index 577faa6229..c9dda154da 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1489,6 +1489,7 @@ static void update_shallow(struct fetch_pack_args *ar=
gs,
 			rollback_lock_file(&shallow_lock);
 		} else
 			commit_lock_file(&shallow_lock);
+		alternate_shallow_file =3D "";
 		return;
 	}
=20
@@ -1512,6 +1513,7 @@ static void update_shallow(struct fetch_pack_args *ar=
gs,
 						&alternate_shallow_file,
 						&extra);
 			commit_lock_file(&shallow_lock);
+			alternate_shallow_file =3D "";
 		}
 		oid_array_clear(&extra);
 		return;
@@ -1551,6 +1553,7 @@ static void update_shallow(struct fetch_pack_args *ar=
gs,
 		commit_lock_file(&shallow_lock);
 		oid_array_clear(&extra);
 		oid_array_clear(&ref);
+		alternate_shallow_file =3D "";
 		return;
 	}
=20
----- %< -------

This does appear to pass the testsuite, but I'm unsure if it's correct.
It's also possible I've just broken something and am too dense to
realize it, so please point out if that's the case.

Output:

expecting success:
        rm -rf server client trace &&

        test_create_repo server &&
        test_commit -C server one &&
        test_commit -C server two &&
        test_commit -C server three &&
        git clone --shallow-exclude two "file://$(pwd)/server" client &&

        git -C server tag -a -m "an annotated tag" twotag two &&

        # Triggers tag following (thus, 2 fetches in one process)
        GIT_TRACE_PACKET=3D"$(pwd)/trace" git -C client -c protocol.version=
=3D2 \
                fetch --shallow-exclude one origin &&
        # Ensure that protocol v2 is used
        grep "fetch< version 2" trace

Initialized empty Git repository in /home/bmc/checkouts/git/t/trash directo=
ry.t5702-protocol-v2/server/.git/
[master (root-commit) 1581e3e] one
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 one.t
[master 5680d21] two
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 two.t
[master 94705d7] three
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 three.t
Cloning into 'client'...
remote: Enumerating objects: 5, done.
remote: Counting objects: 100% (5/5), done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 5 (delta 0), reused 0 (delta 0)
Receiving objects: 100% (5/5), done.
remote: Enumerating objects: 4, done.
remote: Counting objects: 100% (4/4), done.
remote: Compressing objects: 100% (3/3), done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
remote: Enumerating objects: 1, done.
remote: Counting objects: 100% (1/1), done.
remote: Total 1 (delta 0), reused 0 (delta 0)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D628655=3D=3DERROR: AddressSanitizer: heap-use-after-free on address 0=
x60c000000a00 at pc 0x14c115e7e8cd bp 0x7ffe4f405a00 sp 0x7ffe4f4051b0
READ of size 2 at 0x60c000000a00 thread T0
    #0 0x14c115e7e8cc in strdup (/usr/lib/x86_64-linux-gnu/libasan.so.5+0x3=
a8cc)
    #1 0x5572f1a4ebe0 in xstrdup /home/bmc/checkouts/git/wrapper.c:44
    #2 0x5572f1773f33 in argv_array_push /home/bmc/checkouts/git/argv-array=
=2Ec:26
    #3 0x5572f183b380 in get_pack /home/bmc/checkouts/git/fetch-pack.c:786
    #4 0x5572f183fb59 in do_fetch_pack_v2 /home/bmc/checkouts/git/fetch-pac=
k.c:1391
    #5 0x5572f183fb59 in fetch_pack /home/bmc/checkouts/git/fetch-pack.c:16=
20
    #6 0x5572f1a1172a in fetch_refs_via_pack /home/bmc/checkouts/git/transp=
ort.c:365
    #7 0x5572f1a1554d in transport_fetch_refs /home/bmc/checkouts/git/trans=
port.c:1296
    #8 0x5572f1623b84 in fetch_refs builtin/fetch.c:1016
    #9 0x5572f162b056 in backfill_tags builtin/fetch.c:1221
    #10 0x5572f162b056 in do_fetch builtin/fetch.c:1321
    #11 0x5572f162b056 in fetch_one builtin/fetch.c:1551
    #12 0x5572f162b056 in cmd_fetch builtin/fetch.c:1640
    #13 0x5572f15af748 in run_builtin /home/bmc/checkouts/git/git.c:422
    #14 0x5572f15af748 in handle_builtin /home/bmc/checkouts/git/git.c:648
    #15 0x5572f15b2651 in run_argv /home/bmc/checkouts/git/git.c:702
    #16 0x5572f15b2651 in cmd_main /home/bmc/checkouts/git/git.c:799
    #17 0x5572f15ad5e3 in main /home/bmc/checkouts/git/common-main.c:45
    #18 0x14c115a5e09a in __libc_start_main ../csu/libc-start.c:308
    #19 0x5572f15aef89 in _start (/home/bmc/checkouts/git/git+0x169f89)

0x60c000000a00 is located 0 bytes inside of 124-byte region [0x60c000000a00=
,0x60c000000a7c)
freed by thread T0 here:
    #0 0x14c115f2cb70 in free (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe8b=
70)
    #1 0x5572f19e56ae in strbuf_release /home/bmc/checkouts/git/strbuf.c:64
    #2 0x5572f1a04e85 in deactivate_tempfile /home/bmc/checkouts/git/tempfi=
le.c:127
    #3 0x5572f1a0625a in rename_tempfile /home/bmc/checkouts/git/tempfile.c=
:305
    #4 0x5572f187e0b2 in commit_lock_file_to /home/bmc/checkouts/git/lockfi=
le.h:293
    #5 0x5572f187e0b2 in commit_lock_file /home/bmc/checkouts/git/lockfile.=
c:206
    #6 0x5572f183f463 in update_shallow /home/bmc/checkouts/git/fetch-pack.=
c:1491
    #7 0x5572f183f463 in fetch_pack /home/bmc/checkouts/git/fetch-pack.c:16=
43
    #8 0x5572f1a1172a in fetch_refs_via_pack /home/bmc/checkouts/git/transp=
ort.c:365
    #9 0x5572f1a1554d in transport_fetch_refs /home/bmc/checkouts/git/trans=
port.c:1296
    #10 0x5572f1623b84 in fetch_refs builtin/fetch.c:1016
    #11 0x5572f1629fbd in do_fetch builtin/fetch.c:1307
    #12 0x5572f1629fbd in fetch_one builtin/fetch.c:1551
    #13 0x5572f1629fbd in cmd_fetch builtin/fetch.c:1640
    #14 0x5572f15af748 in run_builtin /home/bmc/checkouts/git/git.c:422
    #15 0x5572f15af748 in handle_builtin /home/bmc/checkouts/git/git.c:648
    #16 0x5572f15b2651 in run_argv /home/bmc/checkouts/git/git.c:702
    #17 0x5572f15b2651 in cmd_main /home/bmc/checkouts/git/git.c:799
    #18 0x5572f15ad5e3 in main /home/bmc/checkouts/git/common-main.c:45
    #19 0x14c115a5e09a in __libc_start_main ../csu/libc-start.c:308

previously allocated by thread T0 here:
    #0 0x14c115f2d2e0 in realloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0x=
e92e0)
    #1 0x5572f1a4ed01 in xrealloc /home/bmc/checkouts/git/wrapper.c:138
    #2 0x5572f19e5b60 in strbuf_grow /home/bmc/checkouts/git/strbuf.c:98
    #3 0x5572f19ea7e3 in strbuf_addch /home/bmc/checkouts/git/strbuf.h:231
    #4 0x5572f19ea7e3 in strbuf_add_absolute_path /home/bmc/checkouts/git/s=
trbuf.c:780
    #5 0x5572f1a05da5 in create_tempfile /home/bmc/checkouts/git/tempfile.c=
:137
    #6 0x5572f187d12c in lock_file /home/bmc/checkouts/git/lockfile.c:82
    #7 0x5572f187db28 in lock_file_timeout /home/bmc/checkouts/git/lockfile=
=2Ec:110
    #8 0x5572f187db28 in hold_lock_file_for_update_timeout /home/bmc/checko=
uts/git/lockfile.c:175
    #9 0x5572f19de0f1 in hold_lock_file_for_update /home/bmc/checkouts/git/=
lockfile.h:175
    #10 0x5572f19de0f1 in setup_alternate_shallow /home/bmc/checkouts/git/s=
hallow.c:350
    #11 0x5572f1841499 in receive_shallow_info /home/bmc/checkouts/git/fetc=
h-pack.c:1272
    #12 0x5572f1841499 in do_fetch_pack_v2 /home/bmc/checkouts/git/fetch-pa=
ck.c:1384
    #13 0x5572f1841499 in fetch_pack /home/bmc/checkouts/git/fetch-pack.c:1=
620
    #14 0x5572f1a1172a in fetch_refs_via_pack /home/bmc/checkouts/git/trans=
port.c:365
    #15 0x5572f1a1554d in transport_fetch_refs /home/bmc/checkouts/git/tran=
sport.c:1296
    #16 0x5572f1623b84 in fetch_refs builtin/fetch.c:1016
    #17 0x5572f1629fbd in do_fetch builtin/fetch.c:1307
    #18 0x5572f1629fbd in fetch_one builtin/fetch.c:1551
    #19 0x5572f1629fbd in cmd_fetch builtin/fetch.c:1640
    #20 0x5572f15af748 in run_builtin /home/bmc/checkouts/git/git.c:422
    #21 0x5572f15af748 in handle_builtin /home/bmc/checkouts/git/git.c:648
    #22 0x5572f15b2651 in run_argv /home/bmc/checkouts/git/git.c:702
    #23 0x5572f15b2651 in cmd_main /home/bmc/checkouts/git/git.c:799
    #24 0x5572f15ad5e3 in main /home/bmc/checkouts/git/common-main.c:45
    #25 0x14c115a5e09a in __libc_start_main ../csu/libc-start.c:308

SUMMARY: AddressSanitizer: heap-use-after-free (/usr/lib/x86_64-linux-gnu/l=
ibasan.so.5+0x3a8cc) in strdup
Shadow bytes around the buggy address:
  0x0c187fff80f0: fa fa fa fa fa fa fa fa fd fd fd fd fd fd fd fd
  0x0c187fff8100: fd fd fd fd fd fd fd fa fa fa fa fa fa fa fa fa
  0x0c187fff8110: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fa
  0x0c187fff8120: fa fa fa fa fa fa fa fa fd fd fd fd fd fd fd fd
  0x0c187fff8130: fd fd fd fd fd fd fd fd fa fa fa fa fa fa fa fa
=3D>0x0c187fff8140:[fd]fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c187fff8150: fa fa fa fa fa fa fa fa fd fd fd fd fd fd fd fd
  0x0c187fff8160: fd fd fd fd fd fd fd fa fa fa fa fa fa fa fa fa
  0x0c187fff8170: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fa
  0x0c187fff8180: fa fa fa fa fa fa fa fa 00 00 00 00 00 00 00 00
  0x0c187fff8190: 00 00 00 00 00 00 00 00 fa fa fa fa fa fa fa fa
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
=3D=3D628655=3D=3DABORTING
Aborted
not ok 30 - ensure that multiple fetches in same process from a shallow rep=
o works
#
#               rm -rf server client trace &&
#
#               test_create_repo server &&
#               test_commit -C server one &&
#               test_commit -C server two &&
#               test_commit -C server three &&
#               git clone --shallow-exclude two "file://$(pwd)/server" clie=
nt &&
#
#               git -C server tag -a -m "an annotated tag" twotag two &&
#
#               # Triggers tag following (thus, 2 fetches in one process)
#               GIT_TRACE_PACKET=3D"$(pwd)/trace" git -C client -c protocol=
=2Eversion=3D2 \
#                       fetch --shallow-exclude one origin &&
#               # Ensure that protocol v2 is used
#               grep "fetch< version 2" trace
#

expecting success:
        rm -rf server client trace &&

        test_create_repo server &&
        test_commit -C server one &&
        test_commit -C server two &&
        test_commit -C server three &&
        git clone --depth 1 "file://$(pwd)/server" client &&
        test_commit -C server four &&

        # Sanity check that only "three" is downloaded
        git -C client log --pretty=3Dtformat:%s master >actual &&
        echo three >expected &&
        test_cmp expected actual &&

        GIT_TRACE_PACKET=3D"$(pwd)/trace" git -C client -c protocol.version=
=3D2 \
                fetch --deepen=3D1 origin &&
        # Ensure that protocol v2 is used
        grep "fetch< version 2" trace &&

        git -C client log --pretty=3Dtformat:%s origin/master >actual &&
        cat >expected <<-\EOF &&
        four
        three
        two
        EOF
        test_cmp expected actual

Initialized empty Git repository in /home/bmc/checkouts/git/t/trash directo=
ry.t5702-protocol-v2/server/.git/
[master (root-commit) 3735e1b] one
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 one.t
[master 581c9db] two
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 two.t
[master f6e0668] three
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 three.t
Cloning into 'client'...
remote: Enumerating objects: 5, done.
remote: Counting objects: 100% (5/5), done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 5 (delta 0), reused 0 (delta 0)
Receiving objects: 100% (5/5), done.
[master e79f779] four
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 four.t
remote: Enumerating objects: 6, done.
remote: Counting objects: 100% (6/6), done.
remote: Compressing objects: 100% (4/4), done.
remote: Total 5 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (5/5), done.
=46rom file:///home/bmc/checkouts/git/t/trash directory.t5702-protocol-v2/s=
erver
   f6e0668..e79f779  master     -> origin/master
 * [new tag]         four       -> four
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
remote: Total 0 (delta 0), reused 0 (delta 0)
=3D=3D628707=3D=3DERROR: AddressSanitizer: heap-use-after-free on address 0=
x60c000000ac0 at pc 0x1519f5dd78cd bp 0x7ffe67609620 sp 0x7ffe67608dd0
READ of size 2 at 0x60c000000ac0 thread T0
    #0 0x1519f5dd78cc in strdup (/usr/lib/x86_64-linux-gnu/libasan.so.5+0x3=
a8cc)
    #1 0x561ad07c7be0 in xstrdup /home/bmc/checkouts/git/wrapper.c:44
    #2 0x561ad04ecf33 in argv_array_push /home/bmc/checkouts/git/argv-array=
=2Ec:26
    #3 0x561ad05b4380 in get_pack /home/bmc/checkouts/git/fetch-pack.c:786
    #4 0x561ad05b8b59 in do_fetch_pack_v2 /home/bmc/checkouts/git/fetch-pac=
k.c:1391
    #5 0x561ad05b8b59 in fetch_pack /home/bmc/checkouts/git/fetch-pack.c:16=
20
    #6 0x561ad078a72a in fetch_refs_via_pack /home/bmc/checkouts/git/transp=
ort.c:365
    #7 0x561ad078e54d in transport_fetch_refs /home/bmc/checkouts/git/trans=
port.c:1296
    #8 0x561ad039cb84 in fetch_refs builtin/fetch.c:1016
    #9 0x561ad03a4056 in backfill_tags builtin/fetch.c:1221
    #10 0x561ad03a4056 in do_fetch builtin/fetch.c:1321
    #11 0x561ad03a4056 in fetch_one builtin/fetch.c:1551
    #12 0x561ad03a4056 in cmd_fetch builtin/fetch.c:1640
    #13 0x561ad0328748 in run_builtin /home/bmc/checkouts/git/git.c:422
    #14 0x561ad0328748 in handle_builtin /home/bmc/checkouts/git/git.c:648
    #15 0x561ad032b651 in run_argv /home/bmc/checkouts/git/git.c:702
    #16 0x561ad032b651 in cmd_main /home/bmc/checkouts/git/git.c:799
    #17 0x561ad03265e3 in main /home/bmc/checkouts/git/common-main.c:45
    #18 0x1519f59b709a in __libc_start_main ../csu/libc-start.c:308
    #19 0x561ad0327f89 in _start (/home/bmc/checkouts/git/git+0x169f89)

0x60c000000ac0 is located 0 bytes inside of 124-byte region [0x60c000000ac0=
,0x60c000000b3c)
freed by thread T0 here:
    #0 0x1519f5e85b70 in free (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe8b=
70)
    #1 0x561ad075e6ae in strbuf_release /home/bmc/checkouts/git/strbuf.c:64
    #2 0x561ad077de85 in deactivate_tempfile /home/bmc/checkouts/git/tempfi=
le.c:127
    #3 0x561ad077f25a in rename_tempfile /home/bmc/checkouts/git/tempfile.c=
:305
    #4 0x561ad05f70b2 in commit_lock_file_to /home/bmc/checkouts/git/lockfi=
le.h:293
    #5 0x561ad05f70b2 in commit_lock_file /home/bmc/checkouts/git/lockfile.=
c:206
    #6 0x561ad05b8463 in update_shallow /home/bmc/checkouts/git/fetch-pack.=
c:1491
    #7 0x561ad05b8463 in fetch_pack /home/bmc/checkouts/git/fetch-pack.c:16=
43
    #8 0x561ad078a72a in fetch_refs_via_pack /home/bmc/checkouts/git/transp=
ort.c:365
    #9 0x561ad078e54d in transport_fetch_refs /home/bmc/checkouts/git/trans=
port.c:1296
    #10 0x561ad039cb84 in fetch_refs builtin/fetch.c:1016
    #11 0x561ad03a2fbd in do_fetch builtin/fetch.c:1307
    #12 0x561ad03a2fbd in fetch_one builtin/fetch.c:1551
    #13 0x561ad03a2fbd in cmd_fetch builtin/fetch.c:1640
    #14 0x561ad0328748 in run_builtin /home/bmc/checkouts/git/git.c:422
    #15 0x561ad0328748 in handle_builtin /home/bmc/checkouts/git/git.c:648
    #16 0x561ad032b651 in run_argv /home/bmc/checkouts/git/git.c:702
    #17 0x561ad032b651 in cmd_main /home/bmc/checkouts/git/git.c:799
    #18 0x561ad03265e3 in main /home/bmc/checkouts/git/common-main.c:45
    #19 0x1519f59b709a in __libc_start_main ../csu/libc-start.c:308

previously allocated by thread T0 here:
    #0 0x1519f5e862e0 in realloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0x=
e92e0)
    #1 0x561ad07c7d01 in xrealloc /home/bmc/checkouts/git/wrapper.c:138
    #2 0x561ad075eb60 in strbuf_grow /home/bmc/checkouts/git/strbuf.c:98
    #3 0x561ad07637e3 in strbuf_addch /home/bmc/checkouts/git/strbuf.h:231
    #4 0x561ad07637e3 in strbuf_add_absolute_path /home/bmc/checkouts/git/s=
trbuf.c:780
    #5 0x561ad077eda5 in create_tempfile /home/bmc/checkouts/git/tempfile.c=
:137
    #6 0x561ad05f612c in lock_file /home/bmc/checkouts/git/lockfile.c:82
    #7 0x561ad05f6b28 in lock_file_timeout /home/bmc/checkouts/git/lockfile=
=2Ec:110
    #8 0x561ad05f6b28 in hold_lock_file_for_update_timeout /home/bmc/checko=
uts/git/lockfile.c:175
    #9 0x561ad07570f1 in hold_lock_file_for_update /home/bmc/checkouts/git/=
lockfile.h:175
    #10 0x561ad07570f1 in setup_alternate_shallow /home/bmc/checkouts/git/s=
hallow.c:350
    #11 0x561ad05ba499 in receive_shallow_info /home/bmc/checkouts/git/fetc=
h-pack.c:1272
    #12 0x561ad05ba499 in do_fetch_pack_v2 /home/bmc/checkouts/git/fetch-pa=
ck.c:1384
    #13 0x561ad05ba499 in fetch_pack /home/bmc/checkouts/git/fetch-pack.c:1=
620
    #14 0x561ad078a72a in fetch_refs_via_pack /home/bmc/checkouts/git/trans=
port.c:365
    #15 0x561ad078e54d in transport_fetch_refs /home/bmc/checkouts/git/tran=
sport.c:1296
    #16 0x561ad039cb84 in fetch_refs builtin/fetch.c:1016
    #17 0x561ad03a2fbd in do_fetch builtin/fetch.c:1307
    #18 0x561ad03a2fbd in fetch_one builtin/fetch.c:1551
    #19 0x561ad03a2fbd in cmd_fetch builtin/fetch.c:1640
    #20 0x561ad0328748 in run_builtin /home/bmc/checkouts/git/git.c:422
    #21 0x561ad0328748 in handle_builtin /home/bmc/checkouts/git/git.c:648
    #22 0x561ad032b651 in run_argv /home/bmc/checkouts/git/git.c:702
    #23 0x561ad032b651 in cmd_main /home/bmc/checkouts/git/git.c:799
    #24 0x561ad03265e3 in main /home/bmc/checkouts/git/common-main.c:45
    #25 0x1519f59b709a in __libc_start_main ../csu/libc-start.c:308

SUMMARY: AddressSanitizer: heap-use-after-free (/usr/lib/x86_64-linux-gnu/l=
ibasan.so.5+0x3a8cc) in strdup
Shadow bytes around the buggy address:
  0x0c187fff8100: fd fd fd fd fd fd fd fd fa fa fa fa fa fa fa fa
  0x0c187fff8110: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fa
  0x0c187fff8120: fa fa fa fa fa fa fa fa fd fd fd fd fd fd fd fd
  0x0c187fff8130: fd fd fd fd fd fd fd fa fa fa fa fa fa fa fa fa
  0x0c187fff8140: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
=3D>0x0c187fff8150: fa fa fa fa fa fa fa fa[fd]fd fd fd fd fd fd fd
  0x0c187fff8160: fd fd fd fd fd fd fd fd fa fa fa fa fa fa fa fa
  0x0c187fff8170: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c187fff8180: fa fa fa fa fa fa fa fa fd fd fd fd fd fd fd fd
  0x0c187fff8190: fd fd fd fd fd fd fd fd fa fa fa fa fa fa fa fa
  0x0c187fff81a0: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
=3D=3D628707=3D=3DABORTING
Aborted
not ok 31 - deepen-relative
#
#               rm -rf server client trace &&
#
#               test_create_repo server &&
#               test_commit -C server one &&
#               test_commit -C server two &&
#               test_commit -C server three &&
#               git clone --depth 1 "file://$(pwd)/server" client &&
#               test_commit -C server four &&
#
#               # Sanity check that only "three" is downloaded
#               git -C client log --pretty=3Dtformat:%s master >actual &&
#               echo three >expected &&
#               test_cmp expected actual &&
#
#               GIT_TRACE_PACKET=3D"$(pwd)/trace" git -C client -c protocol=
=2Eversion=3D2 \
#                       fetch --deepen=3D1 origin &&
#               # Ensure that protocol v2 is used
#               grep "fetch< version 2" trace &&
#
#               git -C client log --pretty=3Dtformat:%s origin/master >actu=
al &&
#               cat >expected <<-\EOF &&
#               four
#               three
#               two
#               EOF
#               test_cmp expected actual
#

--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxRZ08ACgkQv1NdgR9S
9ovv/w/9Eb4q/8H6yjTvYHgR1XMBel2zMbkSIzHDE+/yGJxtRMNxddy+ALY1nrK4
4/QvlYVu5Zfn/88eOA2zg+jfj1KE8/o7FSzH4ynAhi5kaBH13mJxsWYQseOsHAf8
NF3HZclbQMluDiURTfdmvczP/qWhn+xBSw/m43knarV8uWyZOXUp8QzGaY6dvQC+
HZLmn3kr3NCZGl5Cd7px8KPzjoa1Hj1eibkYPqoxXYz+KJoX06t1WZOupy5YNdwb
TbbFwp7euP0LCicLbmeJjRs+QnlplgqZf/6HcSl1NU9vjTTS3JBDd/qQSTdAYWLs
4HvFs6GWtCfwrHQZquVauEiN/tQg0KknOlSmgr9Jj3ki7rSYLEgzh3RZbtHZnveV
FSHNy36CF8GEcVkgkiPT/3vx/xU3hGPmTMB07c8o9NcwqNzGuuuhGuwkoSeAU6JQ
aE+/+M0QZmu7nNaGc5gzUH3ewGI6yI2T6c3Nwbyjrs+xUzXmqVJIVZzfILEtFPuw
EmNDFd1z/xD0YCyPNl5ese8pk+287ZUTr1ES5d12niFHZiQtCFsCmogsocku5VjN
GmIDprIxGmBCZWWM33UZUOpYYv78FxoDTfXKtsRqoZ/27pUs+K0h9vSvzw0ARZvS
ReaFyxpfSO9cfJvgL/yd93Is2WK2SnLAQPht4x/r4uE3GOP1Fj0=
=c6yN
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
