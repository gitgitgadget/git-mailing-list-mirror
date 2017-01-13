Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52FF820756
	for <e@80x24.org>; Fri, 13 Jan 2017 15:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751972AbdAMPxW (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 10:53:22 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33362 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751880AbdAMPxV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 10:53:21 -0500
Received: by mail-qt0-f195.google.com with SMTP id n13so6678288qtc.0
        for <git@vger.kernel.org>; Fri, 13 Jan 2017 07:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TD8+1hjbwai10aHZ3iQOUu1rgNnf32wo20zR4lhf2FM=;
        b=lSxSfI+Ys1tF5CooOzjvgB+M/bOS4YaGiTyUalw1YEXKEGzpPjndQaqFgvl/CnIAYD
         HpYzhzH6sp2vAl7FojKD/W8d+XtifUL05t2YKzLkCbr4pr5NV5uYjDb8X5Huis9CCl0O
         Xc36MpO+v5YO+DWQxo4dHZnhKeZgd2zOPi4swUBKRlF4PX1a6ldYvAoSXOWgUJS73WyY
         UT4FQxUer1YqkN+ExRaVAYiBFpCv9csubXi5xad1a3xW4jV4knvaHS+v0Jb0Yz8p7hlu
         lach83WuBdU750zePczPaTkQ20Zdhxiv/7YniptVuAMDwXoubxKsKP59NHuJrXpf4gPK
         zg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TD8+1hjbwai10aHZ3iQOUu1rgNnf32wo20zR4lhf2FM=;
        b=spzO2tpl/tZbz52x1aEOIXPt9BQluVD1oCaWw84m9DPgqDcVtMmmq6Zgrog2SzzsaN
         VG2WFGPMRH/azOoDgVCY3d3aQLK79VfZAC4MqA89H41RXeWjRXa+AggFJ7AOEc3KZu9L
         pLVojgzR3rxNkUlykSBMGGOdUv8A4yR9pCcXwbKeaDifXvBmpsEtaRbXw7lVbaGUcXRL
         g9jO2Lry5cpOZ2PrlN1/gfG0VY9KZfkRjmiWynEpzZXUq5TgweKkynhFW1ZMQj/rN2kZ
         FKRQORre5Go8CgziwbvYnz/73L3i56IKOu83cZ13Zph4Z0dronm6t7IrhI8dZcMbA1EF
         mBXw==
X-Gm-Message-State: AIkVDXKytzkmEhtUWGziSf4on5y8AH87efj+yFXM9JRLgz6NAyge4rdq2QffN+L7fVBJpQ==
X-Received: by 10.200.44.185 with SMTP id 54mr17697845qtw.224.1484322800281;
        Fri, 13 Jan 2017 07:53:20 -0800 (PST)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id k65sm754569qkf.38.2017.01.13.07.53.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Jan 2017 07:53:19 -0800 (PST)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     benpeart@microsoft.com
Subject: [RFC] Add support for downloading blobs on demand
Date:   Fri, 13 Jan 2017 10:52:53 -0500
Message-Id: <20170113155253.1644-1-benpeart@microsoft.com>
X-Mailer: git-send-email 2.11.0.windows.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Goal
~~~~

To be able to better handle repos with many files that any individual 
developer doesn’t need it would be nice if clone/fetch only brought down 
those files that were actually needed.  

To enable that, we are proposing adding a flag to clone/fetch that will
instruct the server to limit the objects it sends to commits and trees
and to not send any blobs.  

When git performs an operation that requires a blob that isn’t currently
available locally, it will download the missing blob and add it to the
local object store.

Design
~~~~~~

Clone and fetch will pass a “--lazy-clone” flag (open to a better name 
here) similar to “--depth” that instructs the server to only return 
commits and trees and to ignore blobs.

Later during git operations like checkout, when a blob cannot be found
after checking all the regular places (loose, pack, alternates, etc), 
git will download the missing object and place it into the local object 
store (currently as a loose object) then resume the operation.

To prevent git from accidentally downloading all missing blobs, some git
operations are updated to be aware of the potential for missing blobs.  
The most obvious being check_connected which will return success as if 
everything in the requested commits is available locally.

To minimize the impact on the server, the existing dumb HTTP protocol 
endpoint “objects/<sha>” can be used to retrieve the individual missing
blobs when needed.

Performance considerations
~~~~~~~~~~~~~~~~~~~~~~~~~~

We found that downloading commits and trees on demand had a significant 
negative performance impact.  In addition, many git commands assume all 
commits and trees are available locally so they quickly got pulled down 
anyway.  Even in very large repos the commits and trees are relatively 
small so bringing them down with the initial commit and subsequent fetch 
commands was reasonable.  

After cloning, the developer can use sparse-checkout to limit the set of 
files to the subset they need (typically only 1-10% in these large 
repos).  This allows the initial checkout to only download the set of 
files actually needed to complete their task.  At any point, the 
sparse-checkout file can be updated to include additional files which 
will be fetched transparently on demand.

Typical source files are relatively small so the overhead of connecting 
and authenticating to the server for a single file at a time is 
substantial.  As a result, having a long running process that is started 
with the first request and can cache connection information between 
requests is a significant performance win.

Now some numbers
~~~~~~~~~~~~~~~~

One repo has 3+ million files at tip across 500K folders with 5-6K 
active developers.  They have done a lot of work to remove large files 
from the repo so it is down to < 100GB.

Before changes: clone took hours to transfer the 87GB .pack + 119MB .idx

After changes: clone took 4 minutes to transfer 305MB .pack + 37MB .idx

After hydrating 35K files (the typical number any individual developer 
needs to do their work), there was an additional 460 MB of loose files 
downloaded.

Total savings: 86.24 GB * 6000 developers = 517 Terabytes saved!

We have another repo (3.1 M files, 618 GB at tip with no history with 
3K+ active developers) where the savings are even greater.

Future Work
~~~~~~~~~~~

The current prototype calls a new hook proc in sha1_object_info_extended 
and read_object, to download each missing blob.  A better solution would 
be to implement this via a long running process that is spawned on the 
first download and listens for requests to download additional objects 
until it terminates when the parent git operation exits (similar to the 
recent long running smudge and clean filter work).

Need to do more investigation into possible code paths that can trigger 
unnecessary blobs to be downloaded.  For example, we have determined 
that the rename detection logic in status can also trigger unnecessary 
blobs to be downloaded making status slow.

Need to investigate an alternate batching scheme where we can make a 
single request for a set of "related" blobs and receive single a 
packfile (especially during checkout).

Need to investigate adding a new endpoint in the smart protocol that can 
download both individual blobs as well as a batch of blobs.
