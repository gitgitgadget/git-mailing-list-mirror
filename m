From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t9010: svnadmin can fail even if available
Date: Thu, 6 Jan 2011 19:31:59 -0600
Message-ID: <20110107013159.GA23280@burratino>
References: <4D25E818.5050909@gmail.com>
 <20110106165958.GA11190@burratino>
 <4D25F9C5.6030503@gmail.com>
 <20110106180051.GC11346@burratino>
 <7vpqs9aiul.fsf@alter.siamese.dyndns.org>
 <20110106204605.GA15090@burratino>
 <7vpqs98qti.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 02:32:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pb1Bm-0000Y8-OQ
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 02:32:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755354Ab1AGBcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 20:32:17 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:38211 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755236Ab1AGBcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 20:32:16 -0500
Received: by yib18 with SMTP id 18so4405611yib.19
        for <git@vger.kernel.org>; Thu, 06 Jan 2011 17:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=M6ZWbX9IW9L+K+q1F/9TWW2aknuy+9JuH2IFhQ4cN0E=;
        b=sqTaz9ey2gudUVl8hz1J0CFvVT6StnMHIodELjGm6mM/ObhThHzPfg/+/Y7EmDkw7f
         KWY4SkQFUWX7XbwaaMEZk8qCEmRe0QLK8r5m3N+UcBUnOq9Ka5rYw+3e24vXH9UXrmOj
         70JCA8fdQdca64Hwr2lsgIZ06OV5KaQuXgpg4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qGM/eYIgAymM/fqGOY9g7dzw93+l2JQOqaKE0yPY8AsAKnNqINXbPQjFBDUQZuHgvA
         RdygF5qxqu8ziPtbZgyp38LBK89eunX82XPFslXBL0nqACumtEDLGrMsqQ0QtyhnTZXN
         Qr7hFY2eKfVHwtyqV1X1nmCr6v4k7y/WQavoY=
Received: by 10.150.58.5 with SMTP id g5mr24831499yba.216.1294363935213;
        Thu, 06 Jan 2011 17:32:15 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.sbcglobal.net [69.209.72.219])
        by mx.google.com with ESMTPS id v39sm43416yba.7.2011.01.06.17.32.12
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 06 Jan 2011 17:32:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vpqs98qti.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164693>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>>> Also isn't the breakage not just this test, but also in all the tests that
>>> try to run "svnadmin load"?  Shouldn't we somehow hoist this logic out of
>>> t9010 and put it in t/lib-vcs-svn.sh or somewhere?
>
> Am I mistaken and t9010 is the only one that needs the fix in your patch?

Everything except t9010 is testing git-svn.  My argument before was
that this libsvn_subr breakage is going to leave git-svn broken
anyway, so why bother guarding against it in tests?

That precise argument is broken in at least three ways:

 - the libsvn_subr breakage would only breaks "git svn dcommit" (and
   "git svn set-tree") and only when the remote svn repo is actually a
   local svn repo using the FSFS backend.

 - maybe the next time "svnadmin load" breaks it will not break
   git svn

 - this particular breakage seems especially unworthy of workarounds
   because it is so easy to fix on the svn side.

So why do I like the patch to t9010?  Two reasons: first, it means
t9010 could run on systems without svn installed at all, and second,
it means that there is one less test to worry about if svn fails in
some other way in the future.

To do the same for t91* would be impossible.  If svn is broken or not
installed, svn-fe will run fine, but "git svn" will not.  On the other
hand, if svnadmin were broken but svn still worked, "git svn" would be
fine but that would be quite strange and I do not think it is worth
spending time to prepare for.
