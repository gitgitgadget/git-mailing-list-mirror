From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/7] lockfile: introduce alloc_lock_file() to avoid
 valgrind noise
Date: Sat, 2 Oct 2010 11:43:25 -0500
Message-ID: <20101002164325.GA19675@burratino>
References: <wes62zknmki.fsf@kanis.fr>
 <7v1va760ip.fsf@alter.siamese.dyndns.org>
 <20100810032647.GA2386@burratino>
 <20101002082752.GA29638@burratino>
 <20101002083216.GC29638@burratino>
 <4CA75E21.1090407@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>,
	David Barr <david.barr@cordelta.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sat Oct 02 18:46:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P25EQ-0007xK-Hi
	for gcvg-git-2@lo.gmane.org; Sat, 02 Oct 2010 18:46:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754707Ab0JBQqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Oct 2010 12:46:37 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52503 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753967Ab0JBQqh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Oct 2010 12:46:37 -0400
Received: by iwn5 with SMTP id 5so5082219iwn.19
        for <git@vger.kernel.org>; Sat, 02 Oct 2010 09:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=2gUJSQfHxXVK5ZO8H2SBA4/p8j9PtLL2eznf4xam/I8=;
        b=loHFdNGM+6Ef4agrP0zE74ASmbYHwQ8I3PIwN5wJacW/JtWbWm0TSXpvnxYUNSubeQ
         H7p+ZzzFpRkRSeHOm4zwGE58Q1rVRXYiMfru8Kn6//fMeIloM/kBWdG2Ajt1sM2ZHFn7
         pvfYsxSvSVhoGK3Wujfqh84r99qPazjF23UyU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ceueWTQDvmusZeiwBGDKG0oyhtVHivVNRyBXxJkRttPEJ9Ptq6gWjY6T4vssxy3wbW
         S7xl73RqBXrHZ3ChXpkRuAN733L6mhF24qLdpxUzEXdp7W2eXD4zpZMkyoHbCB9O5iXB
         90/i0g7gCdK/1ihFzSU3IJJBn3q0Tc2NkoB+Y=
Received: by 10.231.169.149 with SMTP id z21mr7535555iby.11.1286037996443;
        Sat, 02 Oct 2010 09:46:36 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id n20sm2637110ibe.5.2010.10.02.09.46.35
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 02 Oct 2010 09:46:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4CA75E21.1090407@op5.se>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157808>

Andreas Ericsson wrote:

> So we're basically increasing runtime to shut up a leakchecking tool
> and also making that leakchecking tool falsely not report positives.

Yep, nice summary.  Probably I should have also mentioned:

 - An extra stack frame with no locals is not a lot of overhead, but
   in any case these are by design not in performance-critical places.

 - By using a special function like this, we make instances nicely
   grep-able and give the leak prominence in t/valgrind/default.supp.
   So a person can discover, for example, that writing a lot of trees
   in a single process (like cherry-pick -n foo..bar currently does)
   is going to be leaky.

 - valgrind would be most useful if it can be used to identify
   _regressions_ by running the test suite with --valgrind.  git is
   deliberately leaky in a lot of places; it is not useful to record
   that.

 - valgrind does have the ability to turn suppressions off if you want.
