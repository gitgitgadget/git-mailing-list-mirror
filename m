X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Fast access git-rev-list output: some OS knowledge required
Date: Sat, 9 Dec 2006 13:15:12 +0100
Message-ID: <e5bfff550612090415i26af8ea5q383889e951659d7e@mail.gmail.com>
References: <e5bfff550612061124jcd0d94em47793710866776e7@mail.gmail.com>
	 <20061206192800.GC20320@spearce.org>
	 <e5bfff550612061134r3725dcbu2ff2dd6284fcd651@mail.gmail.com>
	 <20061206194258.GD20320@spearce.org>
	 <20061206195142.GE20320@spearce.org> <45781639.1050208@op5.se>
	 <e5bfff550612081034q5e4c0c93s3512fce2f11b1fab@mail.gmail.com>
	 <f2b55d220612081210u6ec3e95ciec6665a6b5e6a827@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 9 Dec 2006 12:15:20 +0000 (UTC)
Cc: "Andreas Ericsson" <ae@op5.se>,
	"Shawn Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tMGyA3iaeI19/WralvXJWjhIOK5p04OSfHV3Xcqcdvqeumd+IgNmuvxDYbRXu92NcsuTiSnySCQgNQiPJNihM1mqCXzb1Fud0Xo3CRcGQrSMocahrnnlzoLCH7uLlgbEy/Z5j5sj3Y3X6YOEnFxsSOsv3Ha3Lo9T5B0Xoex113A=
In-Reply-To: <f2b55d220612081210u6ec3e95ciec6665a6b5e6a827@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33811>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gt16s-00023k-8a for gcvg-git@gmane.org; Sat, 09 Dec
 2006 13:15:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030645AbWLIMPO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 07:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030608AbWLIMPO
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 07:15:14 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:35056 "EHLO
 py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1030645AbWLIMPM (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec
 2006 07:15:12 -0500
Received: by py-out-1112.google.com with SMTP id a29so572096pyi for
 <git@vger.kernel.org>; Sat, 09 Dec 2006 04:15:12 -0800 (PST)
Received: by 10.35.66.13 with SMTP id t13mr4656072pyk.1165666512083; Sat, 09
 Dec 2006 04:15:12 -0800 (PST)
Received: by 10.35.93.11 with HTTP; Sat, 9 Dec 2006 04:15:12 -0800 (PST)
To: "Michael K. Edwards" <medwards.linux@gmail.com>
Sender: git-owner@vger.kernel.org

On 12/8/06, Michael K. Edwards <medwards.linux@gmail.com> wrote:
> There is a very handy solution to this problem called "tmpfs".  It
> should already be mounted at /tmp.  Put tmp.txt there and your problem
> will go away.
>

Thanks Michael,

It seems to work! patch pushed.

 Marco

P.S: I've looked again to Shawn idea (and code) of linking qgit
against libgit.a but I found these two difficult points:

- traverse_commit_list(&revs, show_commit, show_object) is blocking,
i.e. the GUI will stop responding for few seconds while traversing the
list. This is easily and transparently solved by the OS scheduler if
an external process is used for git-rev-list. To solve this in qgit I
have two ways: 1) call QEventLoop() once in a while from inside
show_commit()/ show_object() to process pending events  2) Use a
separate thread (QThread class). The first idea is not nice, the
second opens a whole a new set of problems and it's a big amount of
not trivial new code to add.

-  traverse_commit_list() having an internal state it's not
re-entrant. git-rev-list it's used to load main view data but also
file history in another tab, and the two calls _could_ be ran
concurrently. With external process I simply run two instances of
DataLoader class and consequently two external git-rev-list processes,
