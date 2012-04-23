From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCHv2] git-remote-testgit: fix race when spawning fast-import
Date: Sun, 22 Apr 2012 19:40:59 -0700
Message-ID: <xmqq4nsbmapw.fsf@junio.mtv.corp.google.com>
References: <20120415105943.GD6263@ecki> <4F8AAE7C.1020507@gmail.com>
	<20120415114518.GB9338@ecki> <4F8AB7F1.1020705@gmail.com>
	<20120415125140.GA15933@ecki> <20120419233445.GA20790@padd.com>
	<4F9145A1.6020201@gmail.com> <20120421201524.GA18419@padd.com>
	<20120421234555.GA11808@padd.com>
	<xmqqty0cxtcd.fsf@junio.mtv.corp.google.com>
	<20120422203058.GA17290@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Clemens Buchacher <drizzd@aon.at>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 04:41:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SM9DH-0002pI-3y
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 04:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425Ab2DWClD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Apr 2012 22:41:03 -0400
Received: from mail-wi0-f202.google.com ([209.85.212.202]:32791 "EHLO
	mail-wi0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753399Ab2DWClB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2012 22:41:01 -0400
Received: by wibhj13 with SMTP id hj13so119033wib.1
        for <git@vger.kernel.org>; Sun, 22 Apr 2012 19:41:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=zf/ReDKyTnyen76IhpEGHFDZLBltiCs5acWaKNI55vo=;
        b=DvKv/0Aft/2Fl9uVfBLK08YApxtDbwzKKi7/+tf2ymoVYrcbTC/eQI2pYk72Ws+F6y
         RTJHrmT/jQNlJCl7NFkC9L2uVeppdkkjIDfW02gZhmTLdEiS7VpY7FTnQT7k/5gM5ApU
         k2SsUf0OSsUvvRuZnibNfnOHj8jZeEhjimtp6QDTs/NIWDQA7Mr6SmgTFzKuDH4Axx1I
         DsOQba7MF6d1NZbtOGi8XgL00CRGdEy1cHk0y8GcLvFxBxPw7PckJdwbnh6Nk9PfrCVl
         2SLoo+n2GfmzHaoq7N5++7lycctx6Pbvv1+ADl998ooUmeYAjVwOkMuDhray/9tP3pGt
         8z3w==
Received: by 10.14.199.133 with SMTP id x5mr3415482een.7.1335148860084;
        Sun, 22 Apr 2012 19:41:00 -0700 (PDT)
Received: by 10.14.199.133 with SMTP id x5mr3415468een.7.1335148860011;
        Sun, 22 Apr 2012 19:41:00 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id y52si13281086eef.2.2012.04.22.19.41.00
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Sun, 22 Apr 2012 19:41:00 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id CC21420004E;
	Sun, 22 Apr 2012 19:40:59 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 1C152E120A; Sun, 22 Apr 2012 19:40:59 -0700 (PDT)
In-Reply-To: <20120422203058.GA17290@padd.com> (Pete Wyckoff's message of
	"Sun, 22 Apr 2012 16:30:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQmJXZYe+CNBQQB6FGDvGTffI1sxJrBru4LcK6TWrkuyV1l1A++8L3jdsyVi8FpSQwG+fwdZh8v77nQ6JsFHEfy/ldU8Q+57n7Oh17i/SwRLnHH2VjxFCveh6UietyaAN5HBcYtcru+cbFZsDD5sq1ZmDxaCGZJXNrfLGn0OlBZdHXx040s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196095>

Pete Wyckoff <pw@padd.com> writes:

> Clemens suggested disabling the test by default, as I've done
> here.  I think it would be okay to remove it entirely, too.

Ok.

> +# Generally, skip this test.  It demonstrates a now-fixed
> +# race in git-remote-testgit, but is too slow to leave in
> +# for general use.
> +test_expect_success DEBUG_TESTGIT_RACE 'racily pushing to local repo' '
> +	cp -a server server2 &&
> +	git clone "testgit::${PWD}/server2" localclone2 &&
> +	test_when_finished "rm -rf server2 localclone2" &&

Shouldn't test_when_finished come before these two commands?  Otherwise
server2 or localclone2 directories will be left behind when they fail
before control reaches it...
