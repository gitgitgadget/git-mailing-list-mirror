Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AC071F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 09:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbfAPJSf (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 04:18:35 -0500
Received: from mail-it1-f180.google.com ([209.85.166.180]:54111 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbfAPJSf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 04:18:35 -0500
Received: by mail-it1-f180.google.com with SMTP id g85so1951427ita.3
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 01:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=rFBuxPTkwb9K6L01T4QDVmtefSmEB3zFPUm5/coeS/Y=;
        b=OX3jOMOm38It/ePWbuqNKK/S6pVotcCc3VU1lgJgBDxyKNovM7u48w66OJFzZNEd2o
         Op9yS7XI9s/GuWLSohSWcKjMV6etltYgNO4MN1nWej6HW4p0V2bka4jvpcvUIx6hVCh7
         hoevDrukYvO1BHwdfkByak3MWkrxYhuEUXyGB9S4V0cExTNE3QoEpTKL0Vy6cuIqQllF
         99bBrWbj3WNNClUTag7WTimp/3FQxG3HoFeiM0nulBCfAP6mU4oxVey6gtIKetmx2B2z
         XxmcGPGU+IivwfpqLNX6Vak1WpMGqZ/4ATCHj3h/I5ZznB39P60zrqPT0wQcKoqWUbxV
         I3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=rFBuxPTkwb9K6L01T4QDVmtefSmEB3zFPUm5/coeS/Y=;
        b=Z866R48ngwiKsLwJrqFm48KhtdJYcprGuU4Ph78vsrdIkhurMt/Aa0NAqx4XWELs+h
         89ZsPvhZ8nbrUgp1wJWNWe7v/h6yFdm/o0wefvx89DrPayMuHnNvsSNiwwKpPsHHpx5m
         qSGtyCaA+KMGEkAfCE8m0258Wfcc+NtFHEdyF5tFW6ngfC4PVgwqP2M7cM1axSSafGvZ
         Woz8U++Io6anPfafY7TGfs5iaCDJn2mdjK8pq+qVfNs8IL1Qb+JTRqqtVNAzGuc+MJ2v
         Sj5PDHN/0hgTR0BR5FkoldnwOx5Ch6l4yGJEV0mYv6GLdUIl3wEsOw65MaJOXRnwnVDj
         L11g==
X-Gm-Message-State: AJcUukf3f58CzrN9m0kuJcQa5OUsmPmXJ6ZRxbKHwYz7TR1XxcqHk6rk
        cxoxSeyp3QI0xb+iBKBohXkv5rwZHpE90sSJgyy4/aAiuFw=
X-Google-Smtp-Source: ALg8bN6VjCn9g2e0it7lYZzHhP8joiz3vwR4TUixrMnVn5QQqY3s9ZK0P7MSYwggBud00Mn7l8Pi2T/Tri5bevvrIW8=
X-Received: by 2002:a02:8894:: with SMTP id n20mr4948556jaj.52.1547630313748;
 Wed, 16 Jan 2019 01:18:33 -0800 (PST)
MIME-Version: 1.0
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 16 Jan 2019 01:18:23 -0800
Message-ID: <CAPUEspiz3RxwRsEJW2MwbVVEQh55Q9eA264=RPjtjkx8T-m7iw@mail.gmail.com>
Subject: null pointer dereference in refs/file-backend
To:     git@vger.kernel.org
Cc:     mhagger@alum.mit.edu, sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

while running HEAD cppcheck against git HEAD got the following error,
that seem to be in the code all the way to maint:

[refs/files-backend.c:2681] -> [refs.c:1044] -> [cache.h:1075]:
(error) Null pointer dereference: src

the code that uses NULL as the source OID was introduced with
b0ca411051 ("files_transaction_prepare(): don't leak flags to packed
transaction", 2017-11-05) and doesn't seem to be a false positive,
hence why I am hoping someone else with a better understanding of it
could come out with a solution

Carlo
