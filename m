From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] Use git_open_noatime when accessing pack data
Date: Thu, 4 Nov 2010 00:04:37 -0500
Message-ID: <20101104050437.GB15018@burratino>
References: <1288652061-19614-1-git-send-email-spearce@spearce.org>
 <1288652061-19614-2-git-send-email-spearce@spearce.org>
 <7v8w1axrnp.fsf@alter.siamese.dyndns.org>
 <20101103174148.GB13377@burratino>
 <7vvd4ew687.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 04 06:05:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDs1A-0000Wn-8K
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 06:05:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753207Ab0KDFFB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 01:05:01 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63195 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752942Ab0KDFFA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 01:05:00 -0400
Received: by ywc21 with SMTP id 21so1063426ywc.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 22:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=HtEvhPiw2LTvdg+7LzZ+a+xzY5WuWacHyKWGTV/hw9s=;
        b=CD0PB4EqpVNPaWGDEreSQJw6MjWq0BLQIv5YfvG6hg9KVbN0+eokly7pYWz6wXGSXg
         KKOWqJacm71y9kWk8rETGvSSR1izOEYZHdBqVn4nIAhkPLjQsJIJa+Pl0jNsn2K2ZZWT
         mQbM7UOSKH/Ef34ckRNIURZ+u1TxGcRIpjkMA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=YWVvn7J+PQp9Izdxit8rKtvnt0mjYG3mpaZiZr2L9yYzpsC6g8OhPHHT6PMEtNBaYJ
         hNUuqSASJAeonLCrWahCvjau5Tj2ywoxY9v1L4c7urCgKM5971ZKIvo8puiT63c7kenx
         6ihR4+Nr0LkX7zdRbNlVLobgMGqegMu8yBp+E=
Received: by 10.91.9.1 with SMTP id m1mr624432agi.21.1288847099373;
        Wed, 03 Nov 2010 22:04:59 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id g29sm6296258anh.36.2010.11.03.22.04.56
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 22:04:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vvd4ew687.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160690>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Judging from these three use cases, readonly open()s to the worktree
>> should indeed use noatime, but open()s of .git/config, say, should
>> not.  Hmm.
>
> Why not, when you are talking about readonly open?

A .git/config frequently accessed by git is being used, so tmpwatch
shouldn't delete it.  (Meanwhile, a worktree frequently accessed by
git is not precious on that account, and letting git touch the atime
there might mask more useful information about when other programs
touched the files.)

But that is all very fuzzy to me.  I tend to mount noatime except on
/usr (for popularity-contest).

I guess I should put it another way.  What if anything does readonly
have to do with O_NOATIME?  Why shouldn't we always use O_NOATIME?
Why should the operating system provide atime at all?
