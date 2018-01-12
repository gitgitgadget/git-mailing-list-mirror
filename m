Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4405E1F406
	for <e@80x24.org>; Fri, 12 Jan 2018 19:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965121AbeALTmb convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 12 Jan 2018 14:42:31 -0500
Received: from elephants.elehost.com ([216.66.27.132]:49773 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965044AbeALTma (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 14:42:30 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0CJgRsD015765
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 12 Jan 2018 14:42:28 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Subject: RE: [ANNOUNCE] Git v2.16.0-rc2 - breakages in t1308 and 1404
Date:   Fri, 12 Jan 2018 14:42:21 -0500
Message-ID: <004b01d38bdd$7a11da60$6e358f20$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdOL3Mn+j89TsvbiQOOvlTVgqqPdUg==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 11, 2018 11:11 PM, Junio C Hamano wrote:
> A release candidate Git v2.16.0-rc2 is now available for testing at the usual
> places.  It is comprised of 483 non-merge commits since v2.15.0, contributed
> by 80 people, 23 of which are new faces.
<snip>

Please forgive my not knowing the proper way to report this ... we have a few breakages on the NonStop port (which has finally caught up to 2.16, yay!). The test run takes a very long time to run, so this is preliminary. I'm also not sure who should try to resolve these.

For 1308:

Value not found for "foo.bar"
not ok 23 - proper error on directory "files"
#
#               echo "Error (-1) reading configuration file a-directory." >expect &&
#               mkdir a-directory &&
#               test_expect_code 2 test-config configset_get_value foo.bar a-directory 2>output &&
#               grep "^warning:" output &&
#               grep "^Error" output >actual &&
#               test_cmp expect actual
test_expect_code: command exited with 1, we wanted 2 test-config configset_get_value foo.bar a-directory

It looks like the exit code is coming back as 1 not 2. There is also a file except vs expect.
./trash directory.t1308-config-set: ls
a-directory  actual  config2  except  expect  output  result

For 1404: It looks like the error was detected, but the test case was not structured to handle where the detection occurred. Here's what I see:

not ok 52 - delete fails cleanly if packed-refs file is locked
#
#               prefix=refs/locked-packed-refs &&
#               # Set up a reference with differing loose and packed versions:
#               git update-ref $prefix/foo $C &&
#               git pack-refs --all &&
#               git update-ref $prefix/foo $D &&
#               git for-each-ref $prefix >unchanged &&
#               # Now try to delete it while the `packed-refs` lock is held:
#               : >.git/packed-refs.lock &&
#               test_when_finished "rm -f .git/packed-refs.lock" &&
#               test_must_fail git update-ref -d $prefix/foo >out 2>err &&
#               git for-each-ref $prefix >actual &&
#               test_i18ngrep "Unable to create $Q.*packed-refs.lock$Q: File exists" err &&
#               test_cmp unchanged actual
#

# failed 1 among 52 test(s)
1..52
./trash directory.t1404-update-ref-errors: ls
actual       commands  expected      expected-refs  out         unchanged
actual-refs  err       expected-err  input          output.err
./trash directory.t1404-update-ref-errors: cat err
error: Unable to create '/home/git/git/t/trash directory.t1404-update-ref-errors/.git/packed-refs.lock': File already exists.

Another git process seems to be running in this repository, e.g.
an editor opened by 'git commit'. Please make sure all processes
are terminated then try again. If it still fails, a git process
may have crashed in this repository earlier:
remove the file manually to continue.
./trash directory.t1404-update-ref-errors: cat out

Sincerely,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



