Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61B421F461
	for <e@80x24.org>; Sun, 23 Jun 2019 12:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfFWMPu (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jun 2019 08:15:50 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:41958 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfFWMPu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jun 2019 08:15:50 -0400
Received: by mail-ot1-f46.google.com with SMTP id 43so5977381otf.8
        for <git@vger.kernel.org>; Sun, 23 Jun 2019 05:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=zAQDhYuJARBRZlhBPSziylDMzzPrVcnBOWVJ+F7RQm4=;
        b=kNJIh7jPf87X4+8gAYMo0Ale+xNY6PZREVQOm8N8472LsvQX1FXVd45Wmdyo/WRFEU
         CXuPfHHKJ7Y3cEzzCUO4uqUO1rFU40fgU50AUvyV6z68kOC9D66PJGAylns156PGAIBV
         hr2EgyKq1+IYa6QWMSieYHDM/PtY9xCnCrRSmhG+i9IFrO85A8KlaNZi7/Sz2EGrfoNR
         lWWnbywIQMYuViG52Upt13qwwdTA2cytQmAqwva5ckeGs85mY1duws1FU/nHl4DQqpOV
         G1Mq5MAzbIKb9TDP30vRraoFiZ0Zk5+iIHhXzLgWkNnMOL8VE6Gy/ifVzmlw7T98S6RG
         I/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zAQDhYuJARBRZlhBPSziylDMzzPrVcnBOWVJ+F7RQm4=;
        b=qhvledt/bJF+2SzOMvya5nXbixTihK63NDzGbvSiUmupxrM3iBudCzXEtM4eMJYYk3
         tSbwCCG39QfZU8snPHhIBDnqTPRMmeNV5Ko6f5S1nxwy3mtRPfjWiUsogWtLbhaEuZ5s
         q4xsKF+kRErtnJ539WPMmsiFIyfDOdDBySYXGXV0b6tOzJABocu3nnwNjgxHX8MCrNS/
         Z5zSh55LBRBCJ/r9kkITwltnNXt7wug4Z0WKGra6EdkOZdKhzEe7WYZUm5JOz/Vtzwmy
         u8xi/HYCLR6BdpWMJI8nJIfIM57/c1BVzoZRI+qF5azfBhWtZOJr1O8/W3g5S3iiQSWm
         nZdw==
X-Gm-Message-State: APjAAAWCctEGnzdu0o0/vPIM4/fqzFsRR26rx03iYcB4NcXM1PPgBy8s
        DAtB5HSs1ea7mrTpAkZcE93eiKlwIG+MT2W+NvG7HtzeP/0=
X-Google-Smtp-Source: APXvYqx1jiUphRRdJ1kRU4ABfzzinynTveNrh5MYtYyhbCz+VXAHkdRvQFeRH3txub4Uz8dWh6a8MFZLnofKSG7PWLg=
X-Received: by 2002:a9d:bb8:: with SMTP id 53mr23927562oth.372.1561292149126;
 Sun, 23 Jun 2019 05:15:49 -0700 (PDT)
MIME-Version: 1.0
From:   Janos Farkas <chexum@gmail.com>
Date:   Sun, 23 Jun 2019 13:15:38 +0100
Message-ID: <CAEXt3sqno7RAtuwQ_OpD3aLkEORLaf6aNeNKGQL0BKezD+wWTw@mail.gmail.com>
Subject: 2.22.0 repack -a duplicating pack contents
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm using .keep files to... well.. keep packs to avoid some CPU time
spent on repacking huge packs and make the process somewhat more
incremental.

Something changed with 22.2.0.  Now .bitmap files are also created,
and no simple repacks re-create the pack data in a completely new
file, wasting quite some storage:

02d03::master> find objects/pack/pack* -type f|xargs ls -sht
108K objects/pack/pack-879f2c28d15e57d353eb8e0ddbcb540655c844c9.bitmap
524K objects/pack/pack-879f2c28d15e57d353eb8e0ddbcb540655c844c9.idx
4.7M objects/pack/pack-879f2c28d15e57d353eb8e0ddbcb540655c844c9.pack
108K objects/pack/pack-e7a7aebfc6dc6b1431f6f56bb8b2f7e730cc4a0c.bitmap
524K objects/pack/pack-e7a7aebfc6dc6b1431f6f56bb8b2f7e730cc4a0c.idx
4.6M objects/pack/pack-e7a7aebfc6dc6b1431f6f56bb8b2f7e730cc4a0c.pack
116K objects/pack/pack-994c76cb1999e3b29552677d05e6364e6be2ae5e.bitmap
524K objects/pack/pack-994c76cb1999e3b29552677d05e6364e6be2ae5e.idx
4.6M objects/pack/pack-994c76cb1999e3b29552677d05e6364e6be2ae5e.pack
   0 objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.keep
108K objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.bitmap
524K objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.idx
4.6M objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.pack
02d03::master > git repack -af
Enumerating objects: 19001, done.
Counting objects: 100% (19001/19001), done.
Delta compression using up to 2 threads
Compressing objects: 100% (18952/18952), done.
Writing objects: 100% (19001/19001), done.
warning: ignoring extra bitmap file:
./objects/pack/pack-e7a7aebfc6dc6b1431f6f56bb8b2f7e730cc4a0c.pack
warning: ignoring extra bitmap file:
./objects/pack/pack-994c76cb1999e3b29552677d05e6364e6be2ae5e.pack
warning: ignoring extra bitmap file:
./objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.pack
Reusing bitmaps: 104, done.
Selecting bitmap commits: 2550, done.
Building bitmaps: 100% (130/130), done.
Total 19001 (delta 14837), reused 4162 (delta 0)
02d03::master > find objects/pack/pack* -type f|xargs ls -sht
108K objects/pack/pack-8702a2550b7e29940af8bc62bc6fca011ccbd455.bitmap
524K objects/pack/pack-8702a2550b7e29940af8bc62bc6fca011ccbd455.idx
4.6M objects/pack/pack-8702a2550b7e29940af8bc62bc6fca011ccbd455.pack   <= ????
108K objects/pack/pack-879f2c28d15e57d353eb8e0ddbcb540655c844c9.bitmap
524K objects/pack/pack-879f2c28d15e57d353eb8e0ddbcb540655c844c9.idx
4.7M objects/pack/pack-879f2c28d15e57d353eb8e0ddbcb540655c844c9.pack
108K objects/pack/pack-e7a7aebfc6dc6b1431f6f56bb8b2f7e730cc4a0c.bitmap
524K objects/pack/pack-e7a7aebfc6dc6b1431f6f56bb8b2f7e730cc4a0c.idx
4.6M objects/pack/pack-e7a7aebfc6dc6b1431f6f56bb8b2f7e730cc4a0c.pack
116K objects/pack/pack-994c76cb1999e3b29552677d05e6364e6be2ae5e.bitmap
524K objects/pack/pack-994c76cb1999e3b29552677d05e6364e6be2ae5e.idx
4.6M objects/pack/pack-994c76cb1999e3b29552677d05e6364e6be2ae5e.pack
   0 objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.keep
108K objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.bitmap
524K objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.idx
4.6M objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.pack

The ccbd455 pack and its metadata seem quite pointless to be
containing apparently all the data based on the size.

If I use -ad, a new pack is still created,which, judging by the size,
is essentially everything again, (but at least the extra packs are
removed)

02d03::master> git repack -ad
Enumerating objects: 19001, done.
Counting objects: 100% (19001/19001), done.
Delta compression using up to 2 threads
Compressing objects: 100% (4114/4114), done.
Writing objects: 100% (19001/19001), done.
warning: ignoring extra bitmap file:
./objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.pack
Reusing bitmaps: 104, done.
Selecting bitmap commits: 2550, done.
Building bitmaps: 100% (130/130), done.
Total 19001 (delta 14838), reused 19001 (delta 14838)
02d03::master 9060> find objects/pack/pack* -type f|xargs ls -sht
116K objects/pack/pack-46ab64716d4220aac8d53b380d90a264d5293d3d.bitmap
524K objects/pack/pack-46ab64716d4220aac8d53b380d90a264d5293d3d.idx
4.6M objects/pack/pack-46ab64716d4220aac8d53b380d90a264d5293d3d.pack   <= ????
   0 objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.keep
108K objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.bitmap
524K objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.idx
4.6M objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.pack

Previously, the kept pack would be kept, and no additional packs would
be created if no new objects were born in the repro.

With the .keep placeholder removed, the duplication does not happen,
but all the repro is rewritten into a new pack, which does not look
correct.  Am I doing something unexpected?
