From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Tracking file metadata in git -- fix metastore or enhance git?
Date: Sat, 9 Apr 2011 19:15:18 -0500
Message-ID: <20110410001518.GA6380@elie>
References: <Pine.BSM.4.64L.1104071923580.4692@herc.mirbsd.org>
 <BANLkTink-c8JuxnMBCAmXiVwFkBxJrTucw@mail.gmail.com>
 <4D9EDCEA.9010903@drmicha.warpmail.net>
 <20110408185924.GA25840@elie>
 <Pine.BSM.4.64L.1104081903550.22999@herc.mirbsd.org>
 <20110408194548.GA26094@elie>
 <Pine.BSM.4.64L.1104081955490.22999@herc.mirbsd.org>
 <BANLkTi=3LPRzohnZStAogddpL5ZLehb97Q@mail.gmail.com>
 <20110409081108.GE13750@arachsys.com>
 <BANLkTim5DPjGjJ=SfnNfXpzCd6=PKnSs6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Webb <chris@arachsys.com>, Thorsten Glaser <tg@mirbsd.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git List <git@vger.kernel.org>
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 10 02:15:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8iJb-0006QU-3v
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 02:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050Ab1DJAP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2011 20:15:29 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53991 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838Ab1DJAP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2011 20:15:29 -0400
Received: by iwn34 with SMTP id 34so4523266iwn.19
        for <git@vger.kernel.org>; Sat, 09 Apr 2011 17:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=vI9pUwGgV3s/MMEG+FbkYny8fE53QXD6PyjNrZMAtxc=;
        b=UnVK2yvswVjTrFuTUaqgMoUbIVxRb0KAHmaPQioN0b7cx06BmPllsAOSvuRytvWx5U
         VIZdfdjB9uzbiLrbtJXnyrI3fHswaYZ3zu8HlvAGV5dpu44vhpb6hrONY2jFtRQzAb/K
         9lZSDXhcp1+8mAisc+LNlJhgihHUFf+AUabLI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DXNV4PZRSyTomAJd+Wa/91BhZ5H3oa32WyaWwSU7Uh8SPG+InCbJ4NVCEImYO3FT59
         t0hOvWZcvEC7Xbm/czARw2w0Ru1HcoQ4BoJ15h2NVCBvVMlKb6uhrqr2fMUoicrdaX4c
         HEFZCaRcVhheDI1hi/XL673AHn47GqKCkX3q0=
Received: by 10.42.146.197 with SMTP id k5mr4989658icv.140.1302394528316;
        Sat, 09 Apr 2011 17:15:28 -0700 (PDT)
Received: from elie (adsl-69-209-48-73.dsl.chcgil.sbcglobal.net [69.209.48.73])
        by mx.google.com with ESMTPS id gx2sm2999802ibb.26.2011.04.09.17.15.25
        (version=SSLv3 cipher=OTHER);
        Sat, 09 Apr 2011 17:15:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTim5DPjGjJ=SfnNfXpzCd6=PKnSs6g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171225>

Hi again.

Chris Webb wrote:

> (Disclaimer: I've never tried using smudge filters; maybe they can't be used
> in the way I describe!)

In the current form, they couldn't.  smudge/clean filters take their
input through stdin and write their output to stdout --- there is not
a chance to look at the on-disk directory entry to get metadata.

It might be possible to introduce a new %p substitution pointing to
the actual file the filter is working on, since with a few exceptions,
the file passed to a clean filter is already on-disk.  Exceptions:

 * "git blame --contents=- -- <path>" reads from stdin instead of <path>.

 * the low-level --renormalize facility (see git-merge(1)) and its
   callers feed a clean filter with output from a smudge filter before
   content hits the disk.

 * "git hash-object --path=<path> --stdin" reads from stdin instead of
   <path>.

I'd be worried about using a clean filter to store timestamps.
Treating a file as changed whenever mtime changes could be confusing.
Treating atime changes as content changes would be even stranger.

Richard Hartmann wrote:

> One large question in my mind is if anyone who's familiar enough with
> the codebase and has the time would be interested in actually
> implementing this.

I don't think this has to touch git core, except perhaps as mentioned
above.  Please feel free to cc me if working on hooks (pre-commit hook
or clean filter) to automatically track metadata and some mechanism to
restore it.  I'd be glad to give feedback and help in any other way I
can.

To be clear, I will not be driving this forward --- it's just not
something I've ever needed, so I'd trust others to do a better job of
taking good care of the actual use cases.

Ciao,
Jonathan
