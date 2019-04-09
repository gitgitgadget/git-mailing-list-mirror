Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A9A420248
	for <e@80x24.org>; Tue,  9 Apr 2019 06:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfDIGMB (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 02:12:01 -0400
Received: from mail-it1-f172.google.com ([209.85.166.172]:54583 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfDIGMB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 02:12:01 -0400
Received: by mail-it1-f172.google.com with SMTP id a190so3050839ite.4
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 23:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=Xx7aHXxRKowv0OAHqMxQTW2mhmqe49hl5cM8AAxTs4A=;
        b=ANGJjWRsjlenGaCcleA33tTAu6iH5Ey1YEOHHDeauKYTgqtZ7y0gWaG9m8VcgHNSbG
         hkXSLCSUuJcMGjA7Lvw5a7kZuMWjv2b6BmNnZN7vvn4SSQMRXo3JFfaFz5QpNkv43he8
         xY69C9zjDNDUiYv8Zdu+yzclxyxloJ32axmDkNF6LvXSvcm7uEdnnomTqIjJieZ3f4dO
         QO2cihamF0aTosgMgKBq5k6VDdQKEndqCUTAq04p9FBVpZ6GZGAD2d/8eZM8wi6oaMse
         a4sA7VuE994dGPd1/4DdwayOEPHOY88JeQvlHJXh1dWN3Xvpls/Ck/epVAXm74yLD3/9
         ncrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Xx7aHXxRKowv0OAHqMxQTW2mhmqe49hl5cM8AAxTs4A=;
        b=awwwbUdnVrrUtXbeb+MKjQaz6ccq+F0ioYmMMqOIW4/LymH+2SptP8hUg1Ku0b8uXP
         R7o+z5/wtrXFKCUVCplyo0Nsfek/rw1CA7kwxsKgve5HLcWJFYF+molY8B4nZSRsvzyL
         LZYAYZNhLOpev0tZWf9ylX8IjbxvprzmrDSM+dhYaqlNsUJXMyw2C2sS2/jK/WLjieIZ
         30fmAiT1o9rfFJnPQaO+h094UhPwVWwHFOqZkAvh+oN0BewTBqwd24TTqgT/fPZ2Z1+i
         SVLZLfPvhAvIL3qDz4MJTkGM1jY048tnvV/031j2KzVNDiq0BmpagcjZTdWX/bCX7j9f
         jFGA==
X-Gm-Message-State: APjAAAXt+k3BLAyX+FtJYddoiUpyF+Dmy39UR2GGuHmn2ORw7Sysmyr4
        XjMI/Xiow4Qd6DAiJ1thjtS0Z14tGQgenfQvt0GcZHW/nBc=
X-Google-Smtp-Source: APXvYqyzR/gZ3jl3TDqDGGfijZBjVINp7BYgddtJD8wlu0pf+Qyicw4TQR2FcVQkgC7gJc1mz2KJZNM20hXB/losn+U=
X-Received: by 2002:a24:3dc7:: with SMTP id n190mr23379530itn.62.1554790319345;
 Mon, 08 Apr 2019 23:11:59 -0700 (PDT)
MIME-Version: 1.0
From:   Bryan Turner <bturner@atlassian.com>
Date:   Mon, 8 Apr 2019 23:11:47 -0700
Message-ID: <CAGyf7-Fr3AE1cWXnAtpKU5quu9RciwfM9o9j0uw8sijr3cFMhQ@mail.gmail.com>
Subject: git push --atomic and HTTP(S) vs SSH
To:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A question came up on Stack Overflow[1], and then again through our
support channels, about "git push --atomic" and a behavior mismatch
between HTTP(S) and SSH. I'm easily able to reproduce the behavior,
but I don't see anything Bitbucket Server-related about how this works
(and I get exactly the same mismatched behavior against GitHub; but
that's not really a surprise given what I see in the wire protocol.

First, a setup: 2 commits, with the second commit then amended to make
a 3rd commit.

git init foo
cd foo
echo 'Hello, World' > file.txt
git add file.txt
git commit -m "Initial commit"
echo 'Goodbye, World' > file.txt
git commit -am "Second commit"
git tag original-message
echo 'Goodbye, Cruel World' > file.txt
git commit -a --amend --no-edit
git tag amended-message

Now, given an HTTP remote: (Assume "atomic-pushes" is an empty,
just-created repository)

git remote add http https://github.com/bturner/atomic-pushes.git
git push http original-message:refs/heads/master
git push --atomic http amended-message:refs/heads/master
amended-message:refs/heads/branch-1

So we push the original message commit to master first, and then we
try to push (without --force) the amended commit to both master and a
new branch. That'll produce this:

Total 0 (delta 0), reused 0 (delta 0)
remote:
remote: Create a pull request for 'branch-1' on GitHub by visiting:
remote:      https://github.com/bturner/atomic-pushes/pull/new/branch-1
remote:
To https://github.com/bturner/atomic-pushes.git
 * [new branch]      HEAD -> branch-1
 ! [rejected]        HEAD -> master (non-fast-forward)
error: failed to push some refs to
'https://github.com/bturner/atomic-pushes.git'
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart. Integrate the remote changes (e.g.
hint: 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.

Now let's try it with SSH: (Using a different branch because the HTTP
push created branch-1)

git remote add ssh git@github.com:bturner/atomic-pushes.git
git push --atomic ssh amended-message:refs/heads/master
amended-message:refs/heads/branch-2

Now we see:

error: atomic push failed for ref refs/heads/master. status: 2

To git@github.com:bturner/atomic-pushes.git
 ! [rejected]        HEAD -> master (non-fast-forward)
error: failed to push some refs to 'git@github.com:bturner/atomic-pushes.git'
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart. Integrate the remote changes (e.g.
hint: 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.

No mention of branch-2 at all, but if I do a "git ls-remote ssh" I see:

fe86a3eae65e18787040499c17a567096159b9ce HEAD
1b9c21b7aeb6ad03957cc8a023b2406d3ccee319 refs/heads/branch-1
fe86a3eae65e18787040499c17a567096159b9ce refs/heads/master

So branch-2 didn't get created.

Looking at the wire protocol with GIT_TRACE_PACKET, I see this
conversation for HTTP: (At this point I've done several tests, which
have created various branches, so I'm now trying to push master and
branch-4)

22:16:06.562939 pkt-line.c:46           packet:          git< #
service=git-receive-pack
22:16:06.562990 pkt-line.c:46           packet:          git< 0000
22:16:06.562994 pkt-line.c:46           packet:          git<
1b9c21b7aeb6ad03957cc8a023b2406d3ccee319
refs/heads/branch-1\0report-status delete-refs side-band-64k quiet
atomic ofs-delta agent=git/github-g4f6c801f9475
22:16:06.563013 pkt-line.c:46           packet:          git<
1b9c21b7aeb6ad03957cc8a023b2406d3ccee319 refs/heads/branch-2
22:16:06.563016 pkt-line.c:46           packet:          git<
1b9c21b7aeb6ad03957cc8a023b2406d3ccee319 refs/heads/branch-3
22:16:06.563019 pkt-line.c:46           packet:          git<
fe86a3eae65e18787040499c17a567096159b9ce refs/heads/master
22:16:06.563024 pkt-line.c:46           packet:          git< 0000
22:16:06.563329 pkt-line.c:46           packet:          git>
HEAD:refs/heads/branch-4
22:16:06.563346 pkt-line.c:46           packet:          git> 0000
22:16:06.563357 run-command.c:347       trace: run_command:
'send-pack' '--stateless-rpc' '--helper-status' '--thin' '--progress'
'https://github.com/bturner/atomic-pushes.git/' '--stdin'
22:16:06.563765 exec_cmd.c:129          trace: exec: 'git' 'send-pack'
'--stateless-rpc' '--helper-status' '--thin' '--progress'
'https://github.com/bturner/atomic-pushes.git/' '--stdin'
22:16:06.564691 git.c:348               trace: built-in: git
'send-pack' '--stateless-rpc' '--helper-status' '--thin' '--progress'
'https://github.com/bturner/atomic-pushes.git/' '--stdin'
22:16:06.564788 pkt-line.c:46           packet:          git<
HEAD:refs/heads/branch-4
22:16:06.564793 pkt-line.c:46           packet:          git< 0000
22:16:06.564797 pkt-line.c:46           packet:          git<
1b9c21b7aeb6ad03957cc8a023b2406d3ccee319
refs/heads/branch-1\0report-status delete-refs side-band-64k quiet
atomic ofs-delta agent=git/github-g4f6c801f9475
22:16:06.564805 pkt-line.c:46           packet:          git<
1b9c21b7aeb6ad03957cc8a023b2406d3ccee319 refs/heads/branch-2
22:16:06.564826 pkt-line.c:46           packet:          git<
1b9c21b7aeb6ad03957cc8a023b2406d3ccee319 refs/heads/branch-3
22:16:06.564830 pkt-line.c:46           packet:          git<
fe86a3eae65e18787040499c17a567096159b9ce refs/heads/master
22:16:06.564834 pkt-line.c:46           packet:          git< 0000
22:16:06.564970 pkt-line.c:46           packet:          git>
0000000000000000000000000000000000000000
6925c65344e87c65e5cd2b56d392cd06ef96ca71 refs/heads/branch-4\0
report-status side-band-64k agent=git/2.4.0
22:16:06.564989 pkt-line.c:46           packet:          git> 0000
22:16:06.565027 pkt-line.c:46           packet:          git<
00960000000000000000000000000000000000000000
6925c65344e87c65e5cd2b56d392cd06ef96ca71 refs/heads/branch-4\0
report-status side-band-64k agent=git/2.4.00000

Based on that, I see that the server advertises the existing refs, and
"atomic" support, and then the client _only_ sends branch-4; it
doesn't send anything for master at all. That implies the
non-fast-forward rejection for master is actually being done locally,
not on the server. Only one ref change gets sent to the server, which
applies without issue.

Looking at SSH shows very different output: (branch-4 now exists
because of the HTTP test above, so now I'm pushing master and
branch-5)

22:56:08.609608 pkt-line.c:46           packet:         push<
1b9c21b7aeb6ad03957cc8a023b2406d3ccee319
refs/heads/branch-1\0report-status delete-refs side-band-64k quiet
atomic ofs-delta agent=git/github-g4f6c801f9475
22:56:08.609774 pkt-line.c:46           packet:         push<
1b9c21b7aeb6ad03957cc8a023b2406d3ccee319 refs/heads/branch-2
22:56:08.609798 pkt-line.c:46           packet:         push<
1b9c21b7aeb6ad03957cc8a023b2406d3ccee319 refs/heads/branch-3
22:56:08.609801 pkt-line.c:46           packet:         push<
6925c65344e87c65e5cd2b56d392cd06ef96ca71 refs/heads/branch-4
22:56:08.609825 pkt-line.c:46           packet:         push<
fe86a3eae65e18787040499c17a567096159b9ce refs/heads/master
22:56:08.609831 pkt-line.c:46           packet:         push< 0000

There are no "push>" lines at all. The server sends its ref
advertisement, and then it seems like the non-fast-forward rejection
for master happens locally, similar to HTTPS, but then, unlike HTTPS,
the SSH push is simply aborted without ever sending anything to the
server at all.

I've verified this with Git 2.4.0 as a client (which appears to be
where "git push --atomic" was first introduced), and with Git 2.20.1
as a client, to ensure there wasn't a regression somewhere, and the
behavior is identical for both versions. (I've also verified it with
both Linux and Windows clients, just for extra paranoia.)

The result seems unexpected from a user perspective, but looking at
the code it seems like it's working as implemented. "remote-curl.c"
doesn't include "--atomic" when it runs "git send-pack", so it looks
like HTTP(S) pushes simply ignore "git push --atomic" entirely.

Am I misunderstanding how this is supposed to work? If not, should the
documentation be updated to clarify that HTTP(S) remotes don't support
"--atomic"?

Best regards,
Bryan Turner

[1] https://stackoverflow.com/questions/37531663/git-push-atomic-not-failing
