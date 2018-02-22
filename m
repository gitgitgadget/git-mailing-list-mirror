Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40ADC1F404
	for <e@80x24.org>; Thu, 22 Feb 2018 12:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753649AbeBVMKN (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 07:10:13 -0500
Received: from mailout11.rmx.de ([94.199.88.76]:47963 "EHLO mailout11.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753570AbeBVMKM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 07:10:12 -0500
Received: from kdin01.retarus.com (kdin01.dmz1.retloc [172.19.17.48])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout11.rmx.de (Postfix) with ESMTPS id 3znCpn2MNMz40sT
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 13:10:09 +0100 (CET)
Received: from frhb101.fr.ge.conti.de (unknown [10.220.1.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin01.retarus.com (Postfix) with ESMTPS id 3znCpn0FLYz2xjV
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 13:10:09 +0100 (CET)
Received: from frhb101.fr.ge.conti.de (frhb101.fr.ge.conti.de [172.29.13.41])
        by frhb101.fr.ge.conti.de (8.14.4/8.14.4) with ESMTP id w1MCA7je061762
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 13:10:08 +0100
Received: from frhb008.auto.contiwan.com ([172.29.8.54])
          by frhb101.fr.ge.conti.de (IBM Domino Release 9.0.1FP6)
          with ESMTP id 2018022213100649-875602 ;
          Thu, 22 Feb 2018 13:10:06 +0100 
To:     git@vger.kernel.org
MIME-Version: 1.0
Subject: Issue  in switching branches with different submodules
X-KeepSent: 65A78D43:F69630E3-C125823B:0057EE88;
 type=4; flags=0; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP6 SHF603 February 03, 2016
Message-ID: <OF65A78D43.F69630E3-ONC125823B.0057EE88-C125823C.0042D7B0@continental-corporation.com>
From:   Christian.Zitzmann@continental-corporation.com
Date:   Thu, 22 Feb 2018 13:10:05 +0100
X-MIMETrack: Serialize by Router on frhb008/srvc7/srvc/cag(Release 9.0.1FP8HF240 | May 5, 2017) at
 02/22/2018 01:10:06 PM,
        Serialize complete at 02/22/2018 01:10:06 PM,
        Itemize by SMTP Server on frhb101/srvcMX/srvc/cag(Release 9.0.1FP6|April
  20, 2016) at 02/22/2018 01:10:06 PM,
        Serialize by Router on frhb101/srvcMX/srvc/cag(Release 9.0.1FP6|April  20, 2016) at
 02/22/2018 01:10:08 PM,
        Serialize complete at 02/22/2018 01:10:08 PM
X-TNEFEvaluated: 1
Content-Type: text/plain; charset="US-ASCII"
X-AutoFooter: AFMA Version 2.0.11 (frhb101.fr.ge.conti.de)
X-RMX-ID: 20180222-131009-3znCpn0FLYz2xjV-0@kdin01
X-RMX-TRACE: 2018-02-22 13:10:09 KdIn2013@kdin01/mailcc31 [0.1s] 20180222-131009-3znCpn0FLYz2xjV-0@kdin01 0:00:00
X-RMX-TRACE: 2018-02-22 13:10:09 RmxMSO@kdin01/mailcc09 [0.0s] 20180222-131009-3znCpn0FLYz2xjV-0@kdin01 0:00:00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
I've found an issue in git when working with submodules.
My Project is set up using hundreds of components by submodules (and 
nested submodules), that are independent created in central development 
groups.
Now it occurs that the structure of the submodules is changed over time.

E.g.
Project1(OldBranch)
  - ComponentX/SubComp1 -> ssh://Server/ComponentX/SubComp1
  - ComponentX/SubComp2 -> ssh://Server/ComponentX/SubComp2
  - ComponentX/SubComp2 -> ssh://Server/ComponentX/SubComp2

Project1(Masster)
  - ComponentX-> ssh://Server/ComponentX

There is both a repository for the old subcomponents, and for the new 
Component on the server.

When trying to switch between the branches all git commands are failing.
It seems like most git commands are not creating the SubComponent 
submodules because the .git file from the Component is not deleted

A 'git submodule sync' fails with:
fatal: Not a git repository: 
D:/Project1/ComponentX/../.git/modules/ComponentX

Looking into the folders I see:
D:/Project1/.git/modules/ComponentX/SubComp1
D:/Project1/.git/modules/ComponentX/SubComp2
D:/Project1/.git/modules/ComponentX/SubComp3
D:/Project1/ComponentX/.git (file)

A 'git submodule update --init also fails with this folders
Neither a forced checkout or a hard reset is working.

Similar errors can occur when switching between branches with a different 
number of components used as submodules vs. project specific content.
As a result it happens that people are working with an incosistend state 
of the working directory.

My expectation would be that, when switching between branches/commits with 
a git checkout --recurse-submodules the branche including all submodules 
is checked out fully to exactly the state of the desired branch/commit
I.e the following usecases are an issue
- Deleted submodule
- Added submodule as replacement of local directory
- Changed remote location of submodule (One component is available from 
different providers having individual repositories)
- Restructured Component (see example)

Similar issues are existing when creating the new structure to commit it, 
but here the error is more obvious and people are manually deleting as 
much as required to get the new submodules correctly in.

Best regards

Christian Zitzmann


P HEV E SW SF PMT

Continental Automotive GmbH
Siemensstrasse 12, 93055 Regensburg, Germany

Telefon/Phone: +49 941 790-7265
E-Mail: Christian.Zitzmann@continental-corporation.com
