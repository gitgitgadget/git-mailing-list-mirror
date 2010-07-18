From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: Question about 'branch -d' safety
Date: Sun, 18 Jul 2010 21:27:27 +0100
Message-ID: <1279484847.8999.22.camel@dreddbeard>
References: <20091230065442.6117@nanako3.lavabit.com>
	 <20100717093006.GA11452@localhost> <20100718004347.GA8665@burratino>
	 <201007181355.36691.jnareb@gmail.com>
Reply-To: wmpalmer@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 18 22:27:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaaSc-0001S6-Ej
	for gcvg-git-2@lo.gmane.org; Sun, 18 Jul 2010 22:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757286Ab0GRU1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jul 2010 16:27:34 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58849 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757252Ab0GRU1c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jul 2010 16:27:32 -0400
Received: by wyb42 with SMTP id 42so3756224wyb.19
        for <git@vger.kernel.org>; Sun, 18 Jul 2010 13:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=Sft8w7XpsdyKcNW4mJAUD5lXA5NrDfFyFaUq/dbJeDM=;
        b=oTuglnJxfKE91JN/jLMLr0wDFsKAIrUfdyldSNGCXh1Yp1ltoe4/G8TUVmaEoigUl2
         qGlPEmNoKPu8QABUuOqPniBEl4UPPIZAsUn5VYfmbplPhBwryFx7Xs3Cff9lo5ynCokT
         AsmZOsGmCTRzauQDi8CAUpdwolepSIpn7r4ho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=rW3TJ9hsFb5SgvZvRWBRkcUZXiTqtUs1oqxJUELQG8YktsHzx5+x97CZ7iw7BJdbHJ
         QvE2p44g0DNNO6ZVY2bEIDN6EVdWZcj9ODQbkgPJzcXXeMT/gRUhosTA12ySSUUMOpiJ
         dZ7HL+E5kQfti+ZjxSSmzCuuZ6JkCJZM98vqQ=
Received: by 10.227.146.142 with SMTP id h14mr3248587wbv.25.1279484850802;
        Sun, 18 Jul 2010 13:27:30 -0700 (PDT)
Received: from [192.168.0.129] (5acc3a9a.bb.sky.com [90.204.58.154])
        by mx.google.com with ESMTPS id p45sm1882393weq.45.2010.07.18.13.27.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 18 Jul 2010 13:27:29 -0700 (PDT)
In-Reply-To: <201007181355.36691.jnareb@gmail.com>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151241>

On Sun, 2010-07-18 at 13:55 +0200, Jakub Narebski wrote:
> On Sun, 18 Jul 2010, Jonathan Nieder wrote:
> The same as with D/F conflict.  If you rename branch 'foo' to 'bar',
> you also rename its reflog, but logs/refs/heads/bar would not conflict
> with reflog for deleted branch, logs/refs~/heads~/bar (if you had 
> deleted branch 'bar').

having any kind of suffix like refs~/heads~/bar is just asking for
someone to delete a branch twice.

Regardless of whether or not it would be difficult to implement, I think
the ideal (for me) would be:
 1) existing syntax should work as-is. I like my reflog and don't want
people screwing with it ;)
 2) new syntax should be added for "some/ref@{..even if it's been
renamed or deleted..}", perhaps an entry in the reflog which points to
the "old name" / fact that it's been resurrected, for
moves/resurrections
 3) getting rid of something "for real" should be a simple command away.
If the steps are getting too numerous (delete, expire, /then/ prune?
Anything else?) then perhaps we just need a "git shred <ref>" which
takes care of listing out what will be involved, giving you lots of
chances to abort, etc, and which maybe is less of a sledgehammer than
the current method.


>From the discussion, I think the things we agree that we all want are:
 1) For git to not lose data by accident. Maybe there is disagreement as
to whether or not this already happens. I think the information
currently lost is: a) the name (ie, ease of finding the "lost" commit)
b) the reflog (which I think is utterly lost on delete at the moment?).
Both of these are often useless after a delete, but sometimes wanted.
 2) A straightforward way to restore information which has not been lost
(again, perhaps there is disagreement as to whether this already exists)
 3) A way to distinguish between "the reflog entries of a deleted ref
with the same name as our new ref" and "the new ref's entries" (these
are the "attic" discussions, etc) (not applicable to the current
situation)
 4) A way to really get rid of things which are no longer wanted. This
should be straightforward and have sane defaults so that, as mentioned,
adding then removing the wrong remote doesn't leave you with an extra
repos' worth of data for the next six months. (obviously this one
already exists)

Did I miss anything?

-- 
-- Will
