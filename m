From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: clone breaks replace
Date: Tue, 11 Jan 2011 11:56:21 -0600
Message-ID: <20110111175621.GC15133@burratino>
References: <20110106213338.GA15325@burratino>
 <4D276CD2.60607@cfl.rr.com>
 <20110107205103.GC4629@burratino>
 <4D278930.7010100@cfl.rr.com>
 <20110107214907.GA9194@burratino>
 <20110107220942.GB10343@sigill.intra.peff.net>
 <7vmxnc48yt.fsf@alter.siamese.dyndns.org>
 <20110111053653.GB10094@sigill.intra.peff.net>
 <7vr5cj49vi.fsf@alter.siamese.dyndns.org>
 <20110111175031.GA2085@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Susi <psusi@cfl.rr.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Stephen Bash <bash@genarts.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 11 18:56:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PciSW-0002Yp-0j
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 18:56:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530Ab1AKR4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 12:56:36 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59467 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754410Ab1AKR4d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 12:56:33 -0500
Received: by iyj18 with SMTP id 18so2095395iyj.19
        for <git@vger.kernel.org>; Tue, 11 Jan 2011 09:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=3WsbqKBOaB+3YJO5hJfZVPMWweame8y3yDpRa9f3Teg=;
        b=ZPb4aku/pAH+7GS55emhv6NZHCtcnfcQZyvaf7TV1WMdT4gVvhlxgSVget+heSqzz9
         YQ9kuY39u5ZbFMG7Now9vBvvvsyH3QeU/OuAcHq8iUBB8cqnrT4az4PsGh1xI5S4v/go
         s8UKT8sW2YzOSszvmXp1uneSwVFb1mWonF5SI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=EU11/P/6J5lKt3saOMjP4vSjrmA9ojEJt0c9oTLVjqkEQ2RNPzQ+JupC3ypp9H8VMm
         j3CgssoE0Jv8GGyyFpQDEItV0t13YM0wHEwbPNtZDC7F9c79V67OAueBOCZ+IYvT4p5C
         9aQBSK0eyxLgNaGHfsRotjjF9rKtz9RYCc7qM=
Received: by 10.42.219.132 with SMTP id hu4mr6041628icb.425.1294768592778;
        Tue, 11 Jan 2011 09:56:32 -0800 (PST)
Received: from burratino ([69.209.76.37])
        by mx.google.com with ESMTPS id 34sm27483653ibi.14.2011.01.11.09.56.30
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 11 Jan 2011 09:56:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110111175031.GA2085@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164963>

Jeff King wrote:

> I think you are stuck with something manual
> like:
> 
>   # grab "view" from upstream and name it; let's imagine it links 2010
>   # history into 2009
>   git fetch origin refs/replace/$sha1 refs/views/2009/$sha1
> 
>   # now we feel like using them
>   git for-each-ref --shell --format='%(refname)' refs/views/2009 |
>     while read ref; do
>       git update-ref "refs/replace/${ref#refs/views/2009}" "$ref"
>     done
> 
> Which is a little overkill for the simple example you gave, but would
> also handle something as complex as a view like "pretend the foo/
> subtree never existed" or even "pretend the foo/ subtree existed all
> along".
> 
> Not that I'm sure such things are actually sane to do, performance-wise.
> The replace system is fast, but it was designed for a handful of
> objects, not hundreds or thousands.
> 
> Anyway. My point is that we don't have the porcelain to do something
> like managing views or enabling/disabling them in a sane manner.

Maybe something like

	git fetch origin refs/views/2009/*:refs/replace/*

except that that does not provide a nice way to remove to replace
refs when done.

A potential usability enhancement might be to allow additional
replacement hierarchies to be requested on a per command basis, like

	GIT_REPLACE_REFS=refs/remotes/origin/views/2009 gitk --all

along the lines of GIT_NOTES_REF.
