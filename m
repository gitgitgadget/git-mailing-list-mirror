From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: Question about 'branch -d' safety
Date: Sun, 11 Jul 2010 23:02:55 +0100
Message-ID: <1278885775.2308.27.camel@dreddbeard>
References: <20091230065442.6117@nanako3.lavabit.com>
	 <m3lj9jknlr.fsf@localhost.localdomain> <20100711065505.GA19606@localhost>
	 <201007110916.29567.jnareb@gmail.com> <20100711133730.GA10338@localhost>
	 <7v1vb9hnd9.fsf@alter.siamese.dyndns.org>
Reply-To: wmpalmer@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Clemens Buchacher <drizzd@aon.at>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 12 00:03:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OY4c8-00052Z-TV
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 00:03:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755310Ab0GKWDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jul 2010 18:03:00 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56374 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755252Ab0GKWC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jul 2010 18:02:59 -0400
Received: by wyf23 with SMTP id 23so2911114wyf.19
        for <git@vger.kernel.org>; Sun, 11 Jul 2010 15:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=Ymt6eiwAswIB6TNr6DrDGcY8KjhkUkShcRzEiJakig0=;
        b=ZpClIfkNXVkCO88zAsKouzpbwWoPvD/T3xg1HmA2nqDiQQcwfNURvR8m+WWV4FnDIO
         5UqlhU0198hB5h/m6H8yABrXOiTPBdjqNxEvirj8wN8c1/ac1rctZGztu0AIGmhD18CB
         REq2nQ4810pEIFRz5AVi08XmSFwh5QYWQywMw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=n9vGxMYqoXb86PuLlf8V0ND/C7PyiBiuQ+R0y0oD1kjiyUB9Dpdk1gK8BU6AEs1hb+
         GrOKTBIJ2ATodnHqSgHB7NDenkyTpkeouB3v2l/+E4eDwv7CDo0lqDotSjvLXFRWxvSF
         AWx+59lAUMsopcbIee1AdAkVzfVPilmEVtt4w=
Received: by 10.227.7.131 with SMTP id d3mr4135850wbd.83.1278885778395;
        Sun, 11 Jul 2010 15:02:58 -0700 (PDT)
Received: from [192.168.0.129] (5acc3a9a.bb.sky.com [90.204.58.154])
        by mx.google.com with ESMTPS id o11sm1339396wej.21.2010.07.11.15.02.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Jul 2010 15:02:56 -0700 (PDT)
In-Reply-To: <7v1vb9hnd9.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150784>

On Sun, 2010-07-11 at 11:41 -0700, Junio C Hamano wrote:
> What problem are you guys really trying to solve?

Almost every porcelain git operation is, in general, "safe". Safety is
defined as "will not lose data". I tried to come up with a list of
"unsafe" commands recently, and others in #git pointed out that a lot of
commands could be made safe by inserting "wait 90 days" into various
points. Other than that, there's reset --hard. That's pretty damn safe,
in my opinion.

The reflog is the safety-net which allows us to give users help without
worrying about (as we might in other VCSs) someone typing a command
slightly wrong and blowing away their repository. "Don't worry, you
aren't going to break it" is a git truism which helps us to encourage
git newbies to experiment a little. Even history rewriting is a "safe"
operation.

Personally, I thought "git branch -d" was quite safe enough, as the HEAD
reflog would still have a copy of the tip, but as was pointed out to me,
this would only be there if the branch in question had been checked-out
recently, and of course the reflog for that branch would also be
destroyed. I don't really mind the second half of that, but if we're
going to solve one problem, why not solve both?

The main thing which is lost when a ref is deleted (assuming no gc,
which doesn't happen during a delete without anything else happening) is
the association between the various objects which will show up during
"git fsck" and the name of the ref which was deleted. Without that loss
of association the conversation can move from:
	"don't panic! If you haven't done anything else yet, you can type "git
fsck" and go through the list of dangling commits one by one until you
find it. Disable automatic garbage collection in the mean-time just to
be safe."

to (wishful thinking):
	"don't panic! try typing "git restore-ref -i" and select the branch you
deleted"


What's really problem I'm really trying to solve? I suppose part is the
"I want porcelain commands to be safe, at least for 30 days", and the
rest is that I like having more ways to have a conversation which starts
off in panic end with "oh, thanks! git is awesome!"

-- 
-- Will
