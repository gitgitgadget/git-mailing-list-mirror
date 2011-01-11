From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: clone breaks replace
Date: Tue, 11 Jan 2011 12:22:25 -0600
Message-ID: <20110111182225.GE15133@burratino>
References: <20110106213338.GA15325@burratino>
 <4D276CD2.60607@cfl.rr.com>
 <20110107205103.GC4629@burratino>
 <4D278930.7010100@cfl.rr.com>
 <20110107214907.GA9194@burratino>
 <20110107220942.GB10343@sigill.intra.peff.net>
 <4D27B33C.2020907@cfl.rr.com>
 <20110111054735.GC10094@sigill.intra.peff.net>
 <20110111065244.GB8631@burratino>
 <4D2C7948.6080304@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Stephen Bash <bash@genarts.com>
To: Phillip Susi <psusi@cfl.rr.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 19:22:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pcirl-0000by-BP
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 19:22:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283Ab1AKSWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 13:22:40 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54975 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756237Ab1AKSWj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 13:22:39 -0500
Received: by fxm20 with SMTP id 20so20204128fxm.19
        for <git@vger.kernel.org>; Tue, 11 Jan 2011 10:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=AY+y4TkaNi+dhcAStq4wyacpje4WwvuFEUCC9fjnl00=;
        b=qbPdI2G8xKTcYm+gA1CMyadqxp/3bmwS2uCW318ta2+H3txP0MIMamYYamxpojo0Gl
         HNLLRI2LcH4LE0SmgA0l8IkqOKV9mHuKIeomPtSgcsLcBt2GZ9hj6Z84KTpb4wihIbOH
         EweNq4n3+KLYi8gsnxo7Yj6Po7SIN5Dn19Wks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AnsOq3cVENggNHobxMSNRrVm2Rc8EhbGqRCm88snTuD4Zy2HiAEjTL6IYFaHcdP04I
         ZhcebM4r62qMwJ6CHfFhsYPkirRue+vpho8okTRnwF2+oGZV5cyhEMWQE4IPMwsV3U0+
         8crcbhvvrvbcAQVPye12b7bsJ/puxin8/+zn0=
Received: by 10.223.81.76 with SMTP id w12mr5308072fak.26.1294770157834;
        Tue, 11 Jan 2011 10:22:37 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id l14sm7515924fan.9.2011.01.11.10.22.34
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 11 Jan 2011 10:22:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D2C7948.6080304@cfl.rr.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164966>

Hi,

Thoughts on use cases.  Jeff already explained the main protocol
problem to be solved very well (thanks!).

Phillip Susi wrote:

> 1)  Those tracking your repo don't have breakage when they next fetch
> because the chain of commits they were tracking has been destroyed and
> replaced by a completely different one.

This does not require transport respecting replacements.  Just start
a new line of history and teach "git pull" to pull replacement refs
first when requested in the refspec.

It could work like this:

	alice$ git branch historical
	alice$ git checkout --orphan newline
	alice$ git branch newroot
	alice$ ... hack hack hack ...
	alice$ git replace newroot historical
	alice$ git push world refs/replace/* +HEAD:master

	bob$ git remote show origin
	  URL: git://git.alice.example.com/project.git
	  Ref specifier: refs/replace/*:refs/replace/* refs/heads/*:refs/remotes/origin/*
	  HEAD branch: master
	  Remote branch:
	    master tracked
	  Local branch configured for 'git pull':
	    master merges with remote master
	bob$ git pull
	remote: Counting objects: 18, done.
	remote: Compressing objects: 100% (11/11), done.
	remote: Total 11 (delta 8), reused 0 (delta 0)
	Unpacking objects: 100% (11/11), done.
	From git://git.alice.example.com/project.git
	 * [new replacement]      87a8c7yc65c87c98c87c6a87c8a     -> replace/87a8c7yc65c87c98c87c6a87c8a
	   a78c9df..8c98df9  master     -> origin/master

> 2)  It is obvious when a replace has been done, and the original is
> still available.  This is good for auditing and traceability.  Paper
> trails are good.

With the method you are suggesting, others do _not_ always have the
original still available.  After I fetch from you with
--respect-hard-replacements, then while I am on an airplane I will
have this hard replacement ref staring at me that I cannot remove.

If the original goes missing or gets corrupted on the few machines
that had it, the hard replacement ref is permanent.

> 3)  Inserting a replace record takes a lot less cpu and IO than
> filter-branch rewriting the entire chain.

If the modified history is much shorter than the original (as in the
use case you described), would building it really take so much CPU and
I/O?  Moreover, is the extra CPU time to keep checking all the
replacements on the client side worth saving that one-time CPU time
expenditure on the server?

If (and only if) so then I see how that could be an advantage.

Sorry for the longwinded message.  Hope that helps,
Jonathan
