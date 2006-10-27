X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: fetching packs and storing them as packs
Date: Fri, 27 Oct 2006 10:08:17 +0200
Message-ID: <81b0412b0610270108t7b93d04y2c99be20b7f41387@mail.gmail.com>
References: <4540CA0C.6030300@tromer.org> <45413209.2000905@tromer.org>
	 <Pine.LNX.4.64.0610262038320.11384@xanadu.home>
	 <20061027014229.GA28407@spearce.org> <45417205.6020805@tromer.org>
	 <20061027030054.GB28407@spearce.org> <4541850B.8060608@tromer.org>
	 <20061027044233.GA29057@spearce.org>
	 <81b0412b0610270042w29279b90t7c94d8590d701519@mail.gmail.com>
	 <20061027075229.GD29057@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 27 Oct 2006 08:08:37 +0000 (UTC)
Cc: "Eran Tromer" <git2eran@tromer.org>,
	"Nicolas Pitre" <nico@cam.org>, "Junio C Hamano" <junkio@cox.net>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rX2kuXUlJbtfxkzccYIyI4UNKFtGj8b63MJwt8omj43dsDwRCvW/Q4pNK57YA7Iwl3Ce26g4u6xZxPntQtIgcCGdr1baBpot46Tjoi4IvXaSLKJkusx4aph+2Z9/mZkh9JhD4ImrbhsjVYwyAuCuNCBXyClXPmI4FRTLtNTIS88=
In-Reply-To: <20061027075229.GD29057@spearce.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30303>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdMlO-0007a2-7T for gcvg-git@gmane.org; Fri, 27 Oct
 2006 10:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946237AbWJ0IIV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 04:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946241AbWJ0IIV
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 04:08:21 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:49181 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1946237AbWJ0IIT
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 04:08:19 -0400
Received: by nf-out-0910.google.com with SMTP id c2so1212377nfe for
 <git@vger.kernel.org>; Fri, 27 Oct 2006 01:08:17 -0700 (PDT)
Received: by 10.78.188.19 with SMTP id l19mr3388231huf; Fri, 27 Oct 2006
 01:08:17 -0700 (PDT)
Received: by 10.78.128.2 with HTTP; Fri, 27 Oct 2006 01:08:17 -0700 (PDT)
To: "Shawn Pearce" <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

>> >So the receive-pack process becomes:
>> >
>> > a. Create temporary pack file in $GIT_DIR/objects/pack_XXXXX.
>> >b. Create temporary index file in $GIT_DIR/objects/index_XXXXX.
>>
>> Why not $GIT_DIR/objects/tmp/pack... and ignore it everywhere?
>
> Because there is a race condition.

Oh, right. Incidentally, is there a lockfile for packs?

On 10/27/06, Shawn Pearce <spearce@spearce.org> wrote:
> Alex Riesen <raa.lkml@gmail.com> wrote:
> > >So the receive-pack process becomes:
> > >
> > > a. Create temporary pack file in $GIT_DIR/objects/pack_XXXXX.
> > >b. Create temporary index file in $GIT_DIR/objects/index_XXXXX.
> >
> > Why not $GIT_DIR/objects/tmp/pack... and ignore it everywhere?
>
> Because there is a race condition.
>
> The contents of the new pack must be accessable as a normal pack
> before we update and unlock the refs that are being changed.  This
> means it must be a normal pack in $GIT_DIR/objects/pack.
>
> Currently all packs under $GIT_DIR/objects/pack are deleted during
> `repack -a -d`.  Those packs may have been added to that directory
> after the repack started resulting in them getting deleted when
> the repack completes, but with none of their contained objects in
> the newly created pack.  Thus the repository is suddenly missing
> everything that was just pushed (or fetched).
>
> --
> Shawn.
