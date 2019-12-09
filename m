Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2821EC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 16:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057FF20692
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 16:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfLIQTR convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 9 Dec 2019 11:19:17 -0500
Received: from esg256-2.itc.swri.org ([129.162.232.95]:47446 "EHLO
        esg256-2.itc.swri.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfLIQTQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 11:19:16 -0500
Received: from smtp.swri.org (MBX256.adm.swri.edu [129.162.26.125])
        by esg256-2.itc.swri.edu (8.16.0.27/8.16.0.27) with ESMTPS id xB9GJ8eD119268
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 9 Dec 2019 10:19:09 -0600
Received: from mbx260-2.adm.swri.edu (129.162.29.120) by MBX256.adm.swri.edu
 (129.162.26.125) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 9 Dec
 2019 10:19:09 -0600
Received: from mbx260-2.adm.swri.edu ([192.168.222.13]) by
 mbx260-2.adm.swri.edu ([192.168.222.13]) with mapi id 15.00.1497.000; Mon, 9
 Dec 2019 10:19:09 -0600
From:   "Strain, Roger L." <roger.strain@swri.org>
To:     "emaste@freebsd.org" <emaste@freebsd.org>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "marc@msys.ch" <marc@msys.ch>
Subject: Re: Regression in git-subtree.sh, introduced in 2.20.1, after
 315a84f9aa0e2e629b0680068646b0032518ebed
Thread-Topic: Regression in git-subtree.sh, introduced in 2.20.1, after
 315a84f9aa0e2e629b0680068646b0032518ebed
Thread-Index: AQHVrbKXNpX9IVDGJUeg6jm3c9jaIqeyPikA///Xd4CAAExUAA==
Date:   Mon, 9 Dec 2019 16:19:09 +0000
Message-ID: <1c62a65d7effb49c6bd258f462f34221ac1c7ff1.camel@swri.org>
References: <CANxxO2MGJ2Wo6Y-33KzzPXz6vktRACk0Oi2Y6o_s-cDFRhG7+Q@mail.gmail.com>
         <3b9408a9bd87ea488c4a6b9bc2583aba56ce3949.camel@swri.org>
         <CAPyFy2BjWx2Hp+H__kDFRFZZjcK4hc99oKqkZQjXPLfQE=2SPg@mail.gmail.com>
In-Reply-To: <CAPyFy2BjWx2Hp+H__kDFRFZZjcK4hc99oKqkZQjXPLfQE=2SPg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [129.162.26.94]
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <6E5E0E7CE6F09D449CD969A96D134750@sw.pvt>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-09_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=-40 reason=mlx
 scancount=1 engine=8.0.1-1911140001 definitions=main-1912090139
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So it's been quite a while since I made this specific change, but I'll
attach the relevant portion of the diff below. I may be completely
misremembering portions, and apologize in advance. This was based on an
earlier version of the script, and I can see some other changes have
been made since I forked, but perhaps this will still explain what I
tried to do to work around our problem.

Within process_split_commit, there's logic that tries to distinguish
between commits which are mainline and commits which are subtree.
There's even a comment in the relevant section asking "Is there no
better way? Does it matter?" Well, the answer was yes, it mattered,
because we were picking up mainline commits that there before the
initial add of a subtree, and those were getting sucked in as if they
were subtree commits, and then all the remaining hashes were off.

What this change was meant to do was to check for the existence of a
single, known file. We keep a file called "subtrees.csv" in the root of
our mainline repo, and it defines the various subtrees that comprise
the mainline. Therefore, if that file exists, I can say with certainty
that it is a mainline commit. So when that dodgy check comes up, it
checks for the file first, then falls back to the old behavior.

Partial diff follows, feel free to try it out if it sounds like a
similar problem that you're facing. Change the specific filename for
your needs, obviously.

To be clear, this is NOT something I'm submitting for inclusion in the
general release; it's very repo-specific, and I just hope it might help
a fellow soul.

@@ -506,6 +499,20 @@ subtree_for_commit () {
        done
 }
 
+subtree_for_csv () {
+       commit="$1"
+       dir="$2"
+       git ls-tree "$commit" -- "$dir" |
+       while read mode type tree name
+       do
+               assert test "$name" = "$dir"
+               assert test "$type" = "blob" -o "$type" = "commit"
+               test "$type" = "commit" && continue  # ignore
submodules
+               echo $tree
+               break
+       done
+}
+
 tree_changed () {
        tree=$1
        shift
@@ -667,9 +674,17 @@ process_split_commit () {
        if test -z "$tree"
        then
                set_notree "$rev"
-               if test -n "$newparents"
+               subtreescsv=$(subtree_for_csv "$rev" "subtrees.csv")
+               debug "${indentprefix}  subtrees.csv tree is:
$subtreescsv"
+
+               # ugly.  is there no better way to tell if this is a
subtree
+               # vs. a mainline commit?  Does it matter?
+               if test -z "$subtreescsv"
                then
-                       cache_set "$rev" "$rev"
+                       if test -n "$newparents"
+                       then
+                               cache_set "$rev" "$rev"
+                       fi
                fi
                return
        fi


-- 
Roger Strain

-----Original Message-----
From: Ed Maste <emaste@freebsd.org>
To: "Strain, Roger L." <roger.strain@swri.org>
Cc: git@vger.kernel.org <git@vger.kernel.org>, marc@msys.ch <
marc@msys.ch>
Subject: Re: Regression in git-subtree.sh, introduced in 2.20.1, after
315a84f9aa0e2e629b0680068646b0032518ebed
Date: Mon, 09 Dec 2019 06:45:57 -0500

[EXTERNAL EMAIL]

On Mon, 9 Dec 2019 at 09:29, Strain, Roger L. <roger.strain@swri.org>
wrote:

I've had to further
customize the script for our internal use, and those changes aren't
something that would be useful for the public at large.

Would you describe the sort of problem you have to work around with
custom changes?

I'm starting on a path of trying to fix git-subtree for failures[1]
encountered in a prototype conversion of the FreeBSD repository from
svn to git. The misbehaviour I encounter occurs when split encounters
a commit for which the path being split is empty in 'git ls-tree', and
the commit is actually not a subtree commit. I'm currently
experimenting with hacks to skip specific hashes during the initial
subtree split. On reading your mail I realize I could address my issue
by testing for the existence of a specific file though, which makes me
wonder if the issue you have is similar.

[1] 
https://lore.kernel.org/git/CAPyFy2AsmaxU-BDf_teZJE5hiaVpTSZc8fftnuXPb_4-j7j5Fw@mail.gmail.com/


