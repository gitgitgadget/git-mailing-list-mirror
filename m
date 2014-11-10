From: Bryan Turner <bturner@atlassian.com>
Subject: 2.2.0-rc behavior changes (2/2)
Date: Mon, 10 Nov 2014 19:51:00 +1100
Message-ID: <CAGyf7-GWBWrV9SjMY3n3B-0gCMZGfEsYfX-0vSvz6GT6r=vO6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 10 09:57:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xnkmn-0007rz-Hy
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 09:57:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbaKJI5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 03:57:18 -0500
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:38896 "HELO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750716AbaKJI5R (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Nov 2014 03:57:17 -0500
Received: from mail-oi0-f42.google.com ([209.85.218.42]) (using TLSv1) by na3sys009aob108.postini.com ([74.125.148.12]) with SMTP
	ID DSNKVGB97F0r0AnymYKml+wO46d87riuaJ5O@postini.com; Mon, 10 Nov 2014 00:57:17 PST
Received: by mail-oi0-f42.google.com with SMTP id a3so5080274oib.29
        for <git@vger.kernel.org>; Mon, 10 Nov 2014 00:57:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=npC0T3iM10OMnP09DcMxrksFkyzlbFDVetfApMi3XmM=;
        b=bIlIRGyP+ZyqZG0OqHqz1IHQ31cPtaLpUL65C9DmttTykQLkYHr/FDDRqqTj0Vf+w6
         wTVJXrb+azGc/jFytN0DeMxq2HNBGkvskhfPdEnvErgjGldT9+8oZ/t1cuzv8rGlH6/L
         p5QsnKcZdbKGjIBix/SOAe1GGf1jBdbMUJ1f57v+80oUR/gD7waFvdwp4sVDovFg6oi1
         Tx8pI5/0hnchDxRd52M2viPxnlVFRqVetcO5hVCBufOJe8rlZz6sJkLcczP1yl1d6OIN
         Wf3nQTBZZNRL6DsKsWPux9D3oKkbsi28TTwYAOkr41SDfDEp10OWcxcVUmvYDbk2o4M7
         jfWw==
X-Received: by 10.182.125.3 with SMTP id mm3mr25106734obb.7.1415609460958;
        Mon, 10 Nov 2014 00:51:00 -0800 (PST)
X-Gm-Message-State: ALoCoQk6DDK9G93qz3by4FOGxy4Mrh23E0fVDc88FSUZgHCLbA0yTYBOM6+iz+aTyGt4es13eDm2B89FqCcmizoMYC+YAZX4KFjELoi3prCBfeWVXqw2UjGgKjDdntMARsUTuuwfs9bulq9ytLRWsQA/yXemLWQDaw==
X-Received: by 10.182.125.3 with SMTP id mm3mr25106727obb.7.1415609460827;
 Mon, 10 Nov 2014 00:51:00 -0800 (PST)
Received: by 10.182.245.170 with HTTP; Mon, 10 Nov 2014 00:51:00 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've been running a test suite we use to verify Git behaviors across
versions, and the 2.2.0 RCs (0 and 1 both) have a couple of small
behavioral differences. I'm sending them in separate e-mails just to
make the contents easier to grok.

Important: It's entirely possible neither of these is a _bug_; they
may both be intentional changes in behavior.

Second change: git gc --auto now fails if there are loose empty blobs.

We have a test which just touched empty files in objects/17 to trigger
the gc --auto preconditions (Note: I realize this is completely
invalid, and I've changed the test to no longer do this; I'm only
surfacing the behavioral change).

On Xubuntu 14.10 I can reproduce this using bash with the following steps:
git init gc
cd gc
echo Hello, world > file.txt
git add file.txt
git commit -m "Initial commit"
mkdir .git/objects/17
git config gc.auto 2
git config --bool gc.autodetach false
for i in $(seq 1 20); do touch .git/objects/17/$(head -n 4096
/dev/urandom | openssl sha1 | cut -c 10-47); done

(openssl sha1 on my machine prefixes the SHA-1s with "(stdin)= ", so
the cut is both to shorten the SHA-1 and to drop that prefix)

In 2.1.x and prior, git gc --auto appears to ignore those objects and
exit 0, although it does note that there are still too many loose
objects:
bturner@felurian:~/tmp/gc$ git version
git version 2.1.0
bturner@felurian:~/tmp/gc$ git gc --auto
Auto packing the repository for optimum performance.
See "git help gc" for manual housekeeping.
Nothing new to pack.
warning: There are too many unreachable loose objects; run 'git prune'
to remove them.

In the 2.2.0 RCs git gc --auto exits with 255 and the following errors:
bturner@felurian:~/tmp/gc$ /opt/git-2.2.0-rc1/bin/git gc --auto
Auto packing the repository for optimum performance.
See "git help gc" for manual housekeeping.
Nothing new to pack.
error: object file
.git/objects/17/02d54e8fba95ef9968a0c9b183fe22ec551c86 is empty
fatal: unable to get object info for 1702d54e8fba95ef9968a0c9b183fe22ec551c86
error: failed to run prune

Making git gc more sensitive to invalid objects may be a good thing. I
only point out this behavior change because the change it bisects to
doesn't really cite this as an intentional change.

This change bisects to:

bturner@felurian:~/Development/git/git$ git bisect good
d3038d22f91aad9620bd8e6fc43fc67c16219738 is the first bad commit
commit d3038d22f91aad9620bd8e6fc43fc67c16219738
Author: Jeff King <peff@peff.net>
Date:   Wed Oct 15 18:41:35 2014 -0400

    prune: keep objects reachable from recent objects

Best regards,
Bryan Turner
