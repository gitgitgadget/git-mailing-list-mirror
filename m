Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 278582023D
	for <e@80x24.org>; Mon, 22 May 2017 23:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763275AbdEVXpA (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 19:45:00 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:58178 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763272AbdEVXo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 19:44:58 -0400
Received: from [192.168.178.10] ([94.222.19.13]) by mrelayeu.kundenserver.de
 (mreue104 [212.227.15.183]) with ESMTPSA (Nemesis) id
 0MekDA-1db4Up3hiS-00OHHt for <git@vger.kernel.org>; Tue, 23 May 2017 01:44:55
 +0200
From:   ch <cr@onlinehome.de>
Subject: Passing revs to git-bundle-create via stdin
To:     git@vger.kernel.org
Message-ID: <76491764-cd43-ef7f-fbfc-939a15f2fb77@onlinehome.de>
Date:   Tue, 23 May 2017 01:44:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:SqhdyBmt8YQ/8jSxA5LayuyOqBybpSFvcgXpY1UzP65pFXNQvjy
 zIt/Av9iMxR/6wXgvcipi9PqsZIAJtyLk3+1rXfaGlaCtrBFH+OUGPNHJQIRKFg2wX1XnyL
 q9XAhiRyZUpxtNz4qgE2cR17piKAFixXIb/+KnoawUPsZwdvuIgEnGw3PzfCSwlFBNy/DFH
 QtUmm1JUHTykhJk0EMS+Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aZV8L+0sSTo=:atyX8P/ZsXZwh2wYTp0qAu
 dimhJTBNVRSx6u1UN3CBJ3tpmCcc1brVZHnuPPe0lV9x09b4UROozZoKqjXntRY9+JW9WYoKf
 jXlyPd0flrjHF6HPZYoo16iOntFJatnX64/MdT4fjnc47F+vV78QxVZRlzA2oQSKcevgP5QQn
 Do62BLBrpz80XaXmZsv5RSqxJB6yQBbEA0DyO3MssLBKUkCsWo5NcM9QyTTAAdZuypzBizIod
 IloCwprnWvE4OTQhIubhosZeZXJfNquY/TooUjiURinGUJ8XHTi6hruTPETRhdtO70onGU8/z
 upQdeNKqqmE3ag0C7OdUjbyhgjQaVs39hgB1Z7CTJ6KoXs3zooRBct2/PjXSYbbg24mgW+i+O
 9IsqWfXVUjosRTuOdkULA7PeTceo3oa97Gz0fcjOhVv03Au0pW5fLExopJ8Tj5z0mRuUsRGRC
 doKAWO9clJ8mXWTQaXIGmqtGtq6uHIuguu73SQZmHkT8y0rVkriFIV2IE1o/Z/Gi9QWLwGJgj
 SmmD+fHhKjci6AXjAD1xjPrjlaVrYAP0aZ6kGMJpn8M/rOpUKEJ9b8lJOTvQGnehtj3xdowhy
 PhvnwzjIVrqQGc7rZiTafP2TDZR0tT3H1HGlwXSHp5gv0wBGI5pBRKZyAXa6ckG6gVjRiPLzk
 EwuEcOgpsfh/ZlACqjxrZdW2gk/AhACcQTQcf8XSMq84xV7IftRaZkiusQ1yDV7bJUlCbow6W
 xbQ1tGjY2r2SdcDZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm using git bundles to create (incremental) backups of my local repositories.
This works quite well but for certain repositories I'm getting unexpectedly big
incremental bundles. I did some testing and from what I can tell it seems
git-bundle-create has issues processing revs passed via stdin. To illustrate
the problem I have included a small bash script below.

I'm using Git for Windows 2.13.0.windows.1 (64-bit). Unfortunately I don't have
access to a non-Windows box to check whether it's a problem specific to the
Windows port.

----
add_file()
{
     echo "$1" > "$1"
     git add "$1"
     git commit -m "$1"
}

git init .

add_file "test-1"
add_file "test-2"
add_file "test-3"

git checkout -b feature
add_file "test-4"
add_file "test-5"
add_file "test-6"

git checkout master
add_file "test-7"
add_file "test-8"
add_file "test-9"

echo -e "\nCreating test.git..."
git bundle create test.git --all ^feature ^master^

echo -e "\nCreating test-stdin.git..."
echo -e "^feature\n^master^\n" | git bundle create test-stdin.git --all --stdin

echo -e "\nCreating test-2.git..."
git bundle create test-2.git --all ^feature^ ^master^

echo -e "\nCreating test-2-stdin.git..."
echo -e "^feature^\n^master^\n" | git bundle create test-2-stdin.git --all --stdin

echo -e "\nCreating test-3-stdin.git..."
echo -e "feature\nmaster\n" | git bundle create test-3-stdin.git --stdin

echo
git branch -D feature
git tag -am "Annotated tag" annotated-tag master~2

echo -e "\nCreating annotated.git..."
git bundle create annotated.git --all ^annotated-tag

echo -e "\nCreating annotated-stdin.git..."
echo -e "^annotated-tag\n" | git bundle create annotated-stdin.git --all --stdin

echo
git tag -d annotated-tag
git tag lightweight-tag master~2
echo -e "\nCreating lightweight-stdin.git..."
echo -e "^lightweight-tag\n" | git bundle create lightweight-stdin.git --all --stdin
----

I'd expect test.git and test-stdin.git to be identical. In fact the contained-
and required-refs lists of both bundles are equal but the pack in
test-stdin.git is notably larger compared to the one in test.git. Interestingly
test-2.git and test-2-stdin.git are identical.

git-bundle-create does not appear to handle includes properly either. In this
specific case it won't create test-3-stdin.git and dies with
'error: Refusing to create empty bundle.'.

Last but not least git-bundle-create includes annotated-tag in
annotated-stdin.git even though the tag is excluded via stdin. It works alright
if the tag is excluded via commandline like in case of annotated.git. The issue
also seems to be specific to annotated tags as lightweight-tag is properly
excluded from lightweight-stdin.git.

Any help would be appreciated.

Thanks in advance.
