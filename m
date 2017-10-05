Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4BE91FA21
	for <e@80x24.org>; Thu,  5 Oct 2017 23:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751459AbdJEXj1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 19:39:27 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:46806 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdJEXj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 19:39:26 -0400
Received: by mail-pg0-f41.google.com with SMTP id k7so4096827pga.3
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 16:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=date:from:to:subject:message-id:user-agent:mime-version;
        bh=NJJfrLkF1xwt5oxOVk3y2B1rdo4Zczmqwk5u7+nDiGE=;
        b=GSQnMLIkq3cA75yFqU2I988F03RIuVSaTTskCWeqlqGSOgvocTUctIcXqUOTD0liWT
         e0dg5u8RTjw+1jgNl03X25L/MM4fGzg8UtgEXpSkIKBufoVNRNI4TFtHEThv9/0naHU8
         o4VUgEdfujNXF4HReXCzUincVSD+z85SiwFJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:user-agent
         :mime-version;
        bh=NJJfrLkF1xwt5oxOVk3y2B1rdo4Zczmqwk5u7+nDiGE=;
        b=jTuHsN9Zo+hlTl6fQui6lnbzwYPpz5AslRxPSLUedgZ9ARSZcvKJrG2xcTqwlaVFYP
         4zD74t+gJdEuDU3ZJBT26vVBZG3mjEUPZT4kegaeBq0AqHieQ6ymrOZXfr/TfgdXMUu9
         hUQZ0OTxgf5jkCgN9B+qGUF5g6ROFVVlnWWTGsMGGOY1MKKjStkKU8bMaWx22HzR7a2v
         cLNWWd03FkU+k4AITleNl44U/9IZG1n7hlCehEzPI6ZVNnlQbkyx8ga0vWUGmA/6BVRg
         NZhZXAILVztDyNIByOLLo9kdZh6qWXrh8ZHnm9RLGDcny+UrF1Bru3IExZhIZD/WIx1Y
         jcYA==
X-Gm-Message-State: AMCzsaWKyVfq2Q1yBCJ6s2G76SZKEai2B9Bs3RQhs8/56Lw8wn0bohez
        YUFnB7lLRzDO4aBTbhA/S4kBNmZC/i0=
X-Google-Smtp-Source: AOwi7QBR4Rf5Gfb5Rqdj1mPMGYjMcDcyQPCX1HSn88IVKlVFepO93nFK/4OjJbVgofmHVZS4EhPNMA==
X-Received: by 10.101.64.72 with SMTP id h8mr281339pgp.110.1507246765798;
        Thu, 05 Oct 2017 16:39:25 -0700 (PDT)
Received: from alexmv-linux.corp.dropbox.com (Guest-GW2.corp.dropbox.com. [205.189.0.166])
        by smtp.gmail.com with ESMTPSA id m10sm148489pgs.77.2017.10.05.16.39.24
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Oct 2017 16:39:25 -0700 (PDT)
Date:   Thu, 5 Oct 2017 16:39:20 -0700 (PDT)
From:   Alex Vandiver <alexmv@dropbox.com>
X-X-Sender: alexmv@alexmv-linux
To:     git@vger.kernel.org
Subject: [RFC] Reporting index properties
Message-ID: <alpine.DEB.2.10.1710051625430.812@alexmv-linux>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heya,

As part of gathering some automated performance statistics of git, it
would be useful to be able to extract some vital properties of the
index.  While `git update-index` has ways to _set_ the index version,
and enable/disable various extensions, AFAICT there is no method by
which one can ask for reporting about the current state of them --
short of re-implementing all of the index-parsing logic external to
Git, which is not terribly appealing.

I hesitate to propose adding a flag to `git update-index` which reads
but does no updating, as that seems to make a misnomer of the
command.  But this also doesn't seem worthy of a new top-level command.

Do folks have feelings about surfacing this information, and where such
logic should live?

 - Alex
