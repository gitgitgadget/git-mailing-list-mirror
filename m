Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE,STOX_REPLY_TYPE_WITHOUT_QUOTES shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C5311FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 21:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753240AbcHZVXu (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 17:23:50 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:56031 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752439AbcHZVXt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 17:23:49 -0400
Received: from PhilipOakley ([92.22.62.22])
        by smtp.talktalk.net with SMTP
        id dObKbt6QbHGLwdObKbhLU9; Fri, 26 Aug 2016 22:23:47 +0100
X-Originating-IP: [92.22.62.22]
X-Spam: 0
X-OAuthority: v=2.2 cv=dsCZMBo4 c=1 sm=1 tr=0 a=w1Q8IfJW877FHpoMWf3Y9Q==:117
 a=w1Q8IfJW877FHpoMWf3Y9Q==:17 a=8nJEP1OIZ-IA:10 a=uPZiAMpXAAAA:8
 a=NEAV23lmAAAA:8 a=4B_F3HFpNMI-xvp4j74A:9 a=wPNLvfGTeEIA:10
 a=svzibyHiZmA4t4YY0eFS:22 a=Bn2pgwyD2vrAyMmN8A2t:22
Message-ID: <2FA1998250474E76A386B82AD635E56A@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Git List" <git@vger.kernel.org>
Cc:     "self" <philipoakley@iee.org>
Subject: Are --first-parent and --ancestry-path compatible rev-list options?
Date:   Fri, 26 Aug 2016 22:23:46 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfOXfFfG/jplBo8+agklEcD7jIBZewjUq+9SFRhW8zoGwCgoJlN3dE8ZmjXqKdBjyyV7++q8FD0a9ebH8wiEa0ZbuY/gwfcsoTjHx5OUxW81amLHpnXv3
 lGeUCbiqlONTXD2s4A+CxS3WpLXhS48f1SswakdvxEdfShZBAnYCvnhKbuTQhib5TQqV4A8v8fmNiOoEkwKx1yvSx0aK6nyFPK0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While trying to answer a Stack Overflow question I thought I could 
contribute to, I've found a scenario that I don't understand that may be a 
bug.

In http://stackoverflow.com/questions/39144006/identify-merge-into-master 
MvG asked how to find the point at which a commit on a feature branch was 
later merged into the main-line.

After some discussion it appeared that
    `git log --oneline  --first-parent --merges --reverse  --ancestry-path 
:/j..  | head -1`
should find the point that 'j' was merged into master (when on master), 
however it appears that --first-parent and --ancestry-path interact badly to 
produce no output in the example, but if either is dropped, the expected 
commit is shown.

What am I missing?
--
Philip


The commit graph. We are looking for F based on knowing J.

. A - B - C - D -- E -- F -- G - H    <-first parent, --merges (C,F,H)
.  \  |  /    \        /    /
.   ----Z     |       /    /
.     |       |       |   /
.      \       \     /   /
.       I -[J]- K - L - M             <-since J, children of J
.        \         /
.         N - O - P

# Steps to reproduce the extended example from
# http://stackoverflow.com/q/39144006/1468366

git init .
echo a > txt
git add txt
git commit -m a
echo a > txt; git commit -a -m a
echo b > txt; git commit -a -m b
git checkout -b side :/a
echo z > txt; git commit -a -m z
git checkout master
git merge :/z; echo c > txt; git add -u; git commit -m c

#echo c > txt; git commit -a -m c
echo d > txt; git commit -a -m d
echo e > txt; git commit -a -m e
git checkout -b 2nd :/b
echo i > txt; git commit -a -m i
echo j > txt; git commit -a -m j
git merge :/d; echo k > txt; git add -u; git commit -m k
git checkout -b 3rd :/i
echo n > txt; git commit -a -m n
echo o > txt; git commit -a -m o
echo p > txt; git commit -a -m p
git checkout 2nd
git merge :/p; echo l > txt; git add -u; git commit -m l
echo m > txt; git commit -a -m m
git checkout master
git merge :/l; echo f > txt; git add -u; git commit -m f
git merge :/m; echo g > txt; git add -u; git commit -m g
echo h > txt; git commit -a -m h

git log --oneline  --first-parent --merges --reverse  --ancestry-path :/j.. 
| head -5

# why does this not work --ancestry-path and --first-parent appear to clash.

code available as 
https://gist.github.com/PhilipOakley/58f344f910e50b72f5a8a2bd55b6c175

