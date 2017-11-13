Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 126FD1F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 21:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754503AbdKMVHt (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 16:07:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59878 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753398AbdKMVHs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 16:07:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3379EA622C;
        Mon, 13 Nov 2017 16:07:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id; s=sasl; bh=JhT9wRa145edWZ1aD4iGG4Ng+fM
        =; b=r6up4ItxxUQWELPmPSN+bsC/qwMjirDTY33ExUqDe+HlVZVnqcVoefQBtS/
        yRhAxYSiT57tJH2GKQZeX0GXwq83c5XFFcKOncVu4pEEC/eClrhjMm4acTaEtenf
        eESjBq+8iyNwHmz1lu8UDXQDKqY3MXBWApQIjFAcj2feQTgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id; q=dns; s=sasl; b=Ma/NEmwo3IIHutc9CuwXa
        UsKoEWB7o8N2HlAR9ZabN/+szJiQT/WKM3sxJlQnsHdM4rDdzk98i6192FpdoS5T
        xbxcuVxZw3o0LIBjRR3RyR1x8/vqRyR2xFTKtRliB3aKbQWxCrg+Uuq+RGwQqAOC
        PQ8PpriZSbu34RMNKT5L10=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 29C4FA622B;
        Mon, 13 Nov 2017 16:07:47 -0500 (EST)
Received: from morphine.teonanacatl.net (unknown [173.67.181.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AEA36A622A;
        Mon, 13 Nov 2017 16:07:46 -0500 (EST)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Santiago Torres <santiago@nyu.edu>
Subject: [PATCH] t/lib-gpg: fix gpgconf stderr redirect to /dev/null
Date:   Mon, 13 Nov 2017 16:07:45 -0500
Message-Id: <20171113210745.24638-1-tmz@pobox.com>
X-Mailer: git-send-email 2.15.0
X-Pobox-Relay-ID: B2CE47F6-C8B6-11E7-BE7B-575F0C78B957-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 29ff1f8f74 (t: lib-gpg: flush gpg agent on startup, 2017-07-20), a
call to gpgconf was added to kill the gpg-agent.  The intention was to
ignore all output from the call, but the order of the redirection needs
to be switched to ensure that both stdout and stderr are redirected to
/dev/null.  Without this, gpgconf from gnupg-2.0 releases would output
'gpgconf: invalid option "--kill"' each time it was called.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---

I noticed that gpgconf produced error output for a number of tests on
CentOS/RHEL.  As an example:

    *** t5534-push-signed.sh ***
    gpgconf: invalid option "--kill"

Looking at the code in lib-gpg.sh, it appeared the intention was to ignore this
output.  Reading through the review of the patch confirmed that feeling[1].  The
current code gets caught by the subtleties of output redirection.  (Who hasn't
been burned at some point by the difference between '2>&1 >/dev/null' and
'>/dev/null 2>&1' ? ;)

[1] https://public-inbox.org/git/xmqq379qlvzi.fsf@gitster.mtv.corp.google.com/

Of course, beyond getting stderr to /dev/null, there is the fact that on
versions of gnupg < 2.1, gpgconf --kill is not available.  I noticed this with
gnupg-2.0.14 on CentOS 6.  It also occurs on CentOS 7, which provides
gnupg-2.0.22.

I don't know if there's much value in trying to better handle older gnupg-2.0
systems.  Using gpgconf --reload might be sufficient to work on gnupg-2.0 and
newer systems.  That might solve the issues with gpg-agent caching stale file
handles that motivated the initial patch.  If not, finding what works well with
both gnupg-2.0 and newer seems mildly painful.  This method works for me on
2.0, 2.1, and 2.2:

    pid=$(echo GETINFO pid | gpg-connect-agent | awk '/^D / {print $2}')

And people say crypto tools aren't intuitive.  Pfff. :/

A fairly gross way to use that in lib-gpg.sh might be:

    diff --git c/t/lib-gpg.sh w/t/lib-gpg.sh
    index 43679a4c64..c91d9b334f 100755
    --- c/t/lib-gpg.sh
    +++ w/t/lib-gpg.sh
    @@ -1,5 +1,10 @@
     #!/bin/sh

    +gpg_killagent() {
    +	pid=$(echo GETINFO pid | gpg-connect-agent | awk '/^D / {print $2}')
    +	test -n "$pid" && kill "$pid"
    +}
    +
     gpg_version=$(gpg --version 2>&1)
     if test $? != 127
     then
    @@ -31,7 +36,7 @@ then
     		chmod 0700 ./gpghome &&
     		GNUPGHOME="$(pwd)/gpghome" &&
     		export GNUPGHOME &&
    -		(gpgconf --kill gpg-agent 2>&1 >/dev/null || : ) &&
    +		(gpg_killagent >/dev/null 2>&1 || : ) &&
     		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import \
     			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
     		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import-ownertrust \

I have my doubts that doing something like the above is worthwhile.  It's
probably good enough to simply fix up the gpgconf stderr redirection and call
it a day.

I haven't seen any gpg failures in the test runs I've done, so I haven't had a
need to re-run those tests.  (I also have not run the test suite with the ugly
gpg_killagent() diff above.  I have run it with the change to fix stderr
redirection and confirmed it succeeds without the gpgconf error messages.)

Lastly, I also noticed that git-rebase.sh uses the same 2>&1 >/dev/null.  I
suspect it's similarly not intentional:

    $ git grep -h -C4 '2>&1 >/dev/null' -- git-rebase.sh
    apply_autostash () {
    	if test -f "$state_dir/autostash"
    	then
    		stash_sha1=$(cat "$state_dir/autostash")
    		if git stash apply $stash_sha1 2>&1 >/dev/null
    		then
    			echo "$(gettext 'Applied autostash.')" >&2
    		else
    			git stash store -m "autostash" -q $stash_sha1 ||

I'll send a separate patch to adjust that code as well.

 t/lib-gpg.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 43679a4c64..a5d3b2cbaa 100755
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -31,7 +31,7 @@ then
 		chmod 0700 ./gpghome &&
 		GNUPGHOME="$(pwd)/gpghome" &&
 		export GNUPGHOME &&
-		(gpgconf --kill gpg-agent 2>&1 >/dev/null || : ) &&
+		(gpgconf --kill gpg-agent >/dev/null 2>&1 || : ) &&
 		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import \
 			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
 		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import-ownertrust \
-- 
2.15.0

