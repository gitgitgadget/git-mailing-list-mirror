From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 0/3] Thinning the git toplevel directory
Date: Wed, 23 Feb 2011 02:29:29 -0600
Message-ID: <20110223082929.GB30485@elie>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org>
 <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie>
 <AANLkTik8wUrUnjTiUxUZbg3paaQEc7UERQ6J6jUzA2u5@mail.gmail.com>
 <20110218092518.GB30648@elie>
 <7vei75p3zr.fsf@alter.siamese.dyndns.org>
 <20110219111103.GA1841@elie>
 <20110222155637.GC27178@sigill.intra.peff.net>
 <7v4o7vdfz2.fsf@alter.siamese.dyndns.org>
 <20110223045143.GA11846@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 23 09:29:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsA6P-00008t-0r
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 09:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755045Ab1BWI3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 03:29:36 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:61007 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754970Ab1BWI3f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 03:29:35 -0500
Received: by qwd7 with SMTP id 7so3543281qwd.19
        for <git@vger.kernel.org>; Wed, 23 Feb 2011 00:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=9KEfujZ0FSMMaFK0OTn8jIjXm1rWivUN16/SPnhsPlQ=;
        b=wuPrbiirvikiXtr+3ZkrFSs0Edwf8MmT9PjRbmJMHcLE4bcFfskoWjRx1ZczhcSGcA
         37trZvHCwf4qrYOJrm379t6akjRjLKd2QwLP1oAHe7ae/av7gnkCQwCVb2TVOSfwLC9F
         LcWh0durPosrS+GyvXMBwgR8yK2zkd7G/JMPk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HcwviHIkf3yLjMhEckv9JwXBu0gg4EyLeCR4AB8nh2QP18N9IkYnxByiPsJEa1pCnU
         GZMD6fWYaogVWovmwrnKhOYjvEAqmJLrfYGiQaQut8bs5Np3hG3ssFE5zoWrA1yalG4t
         Q7TVJUDaG1Ff8J7sPJsgSHWmyfCkC6dQia7BQ=
Received: by 10.224.54.69 with SMTP id p5mr3077769qag.46.1298449774647;
        Wed, 23 Feb 2011 00:29:34 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.sbcglobal.net [69.209.53.52])
        by mx.google.com with ESMTPS id e29sm5291364qck.27.2011.02.23.00.29.32
        (version=SSLv3 cipher=OTHER);
        Wed, 23 Feb 2011 00:29:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110223045143.GA11846@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167677>

Jeff King wrote:
> On Tue, Feb 22, 2011 at 11:30:41AM -0800, Junio C Hamano wrote:

>> I had an impression that "make -C lib/" would be one of the goals, iow,
>> when we split the directory structure, the next step would be to split the
>> top-level Makefile so that each directory is covered by its own Makefile,
>> just like Documentation/ is already usable that way.
>
> Ugh.

Two half-baked ideas:

 A. top-level Makefile generates GIT-BUILD-OPTIONS and does not do
    any work itself --- it just calls "make" in subdirectories to
    do the real work.  Other Makefiles slurp in

     - GIT-BUILD-OPTIONS, to get the build options
     - build-helpers/Makefile, for some pattern rules describing
       how to build things

    Benefit:

    GIT-BUILD-OPTIONS becomes the normal way to pass build options,
    so it is well tested and robust.

    Downsides:

    If the project grows too much, all those "make" calls start to
    take time.  It is possible for parallel "make" invocations to
    trample on each other's work if they are not well coordinated.

 B. top-level Makefile slurps in Makefiles from subdirs.  Other
    Makefiles would

     - check if basic rules (pattern rules and GIT-BUILD-OPTIONS
       generation) have been slurped in yet, and if not, include
       them;
     - check if build options have been slurped in yet, and
       if not, include GIT-BUILD-OPTIONS;
     - keep careful track of what directory "make" was run from; [*]
     - define variables listing targets to be built in this
       directory and rules describing how to build them.

    Benefit:

    GIT-BUILD-OPTIONS becomes the normal [...].  Single "make"
    process, fast and predictable.  "make" still works from
    subdirectories.

    Downside:

    [*] is a little hazy and sounds hackish.

I admit that I have some irrational excitement about a lib/ that could
eventually be built and used separately from git.  Mostly because I
think it could encourage people to make lib/ code comprehensible and
hard to misuse and to keep commands/ code minimal.

>           I really like that I can trust it to handle dependencies
> correctly, because it means I can bisect without resorting to "make
> clean" for each step.

Cross-directory dependencies have to be declared just as carefully as
dependencies within a directory.  I wonder if there is any reason not
to make "make" under t/ imply "make -C .. all".

Sleepily,
Jonathan
