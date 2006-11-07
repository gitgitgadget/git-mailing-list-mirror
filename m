X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: win2k/cygwin cannot handle even moderately sized packs
Date: Tue, 7 Nov 2006 12:02:12 +0100
Message-ID: <81b0412b0611070302h50541cd5mf0758afe0d6befda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 7 Nov 2006 11:02:33 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FY9QpMGhb4sU5vtrw+/IBzOxUFCjwwUC/4MgOva7fCz66bI17FvUpskWp4dxapF9cdwhVboHLoEGF6AimeIGbkk5nmx98KnZQJHRj4VDMdqgNwsW7NanG1WeF+XDkKS3eEVx5gyln1N2IVyK1e02huuyL0DWJa3KH1RNsqKpAOc=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31062>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhOiq-00068Q-Fw for gcvg-git@gmane.org; Tue, 07 Nov
 2006 12:02:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754185AbWKGLCQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 06:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754188AbWKGLCQ
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 06:02:16 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:42973 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1754185AbWKGLCP
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 06:02:15 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1170399ugc for
 <git@vger.kernel.org>; Tue, 07 Nov 2006 03:02:14 -0800 (PST)
Received: by 10.78.68.18 with SMTP id q18mr4726829hua.1162897333062; Tue, 07
 Nov 2006 03:02:13 -0800 (PST)
Received: by 10.78.128.2 with HTTP; Tue, 7 Nov 2006 03:02:11 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

For me, it fails even on 332Mb pack:

$ git reset --hard 61bb7fcb
fatal: packfile .git/objects/pack/pack-ad37...pack cannot be mapped.

Instrumenting the code reveals that it fails on 348876870 bytes.
Strangely enough, a cygwin program which just reads that pack
many times without freeing the mem goes up to 1395507480 (1330Mb).

If I replace the malloc (cygwin) with native VirtualAlloc(MEM_COMMIT)
it reports that "Not enough storage is available to process this command",
which is just ENOMEM, I think.

This is a 2Gb machine, with almost 1.3Gb free, so I'm a bit confused,
what could here go wrong (besides what already is wrong).

