From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v3] Isolate If-Modified-Since handling in gitweb
Date: Thu, 22 Mar 2012 13:46:34 +0100
Message-ID: <201203221346.35295.jnareb@gmail.com>
References: <7v62dy4zhf.fsf@alter.siamese.dyndns.org> <m3sjh2ay6j.fsf@localhost.localdomain> <7v1uol3m5m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "W. Trevor King" <wking@drexel.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 13:46:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAhPj-0006lP-7o
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 13:46:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757872Ab2CVMqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 08:46:42 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:44355 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755115Ab2CVMql (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 08:46:41 -0400
Received: by eekc41 with SMTP id c41so676612eek.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 05:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=J7ZMhuRpX9f2oQKkqCpxzp9fYuJsrhedyYyWKfMVP5E=;
        b=D3duqEbzo6qKrlEWjLBStS/hmexS1V/z3VBAlQYCIG3NvajjT1mLM7BrCUakx0njHX
         KnbdB7pJIbtEIUOsl1++INz2ObBS2Ig4kEtO8XZiAUN0s+shjNBPBXbpM512X2vjDz7s
         miCVXa+xEEWRkNJUSjwFtbVwTTuEr0uA8nDjStxuLXp1pealZla8h2hgJ3QUxZXTRuZs
         soIzTSPA7XVLPNqS2FqyWpuMaYQImnZ273ODtajPuuRNiQ8vGplOe0birSh+5I/QdBNs
         HOQly8whpt7Y2PamUO4508Q3g+plpfzur4JsJ7L3e8odLQhNRANNAYzwkHhEIlYo5YQ5
         wpqA==
Received: by 10.213.20.80 with SMTP id e16mr581998ebb.135.1332420400363;
        Thu, 22 Mar 2012 05:46:40 -0700 (PDT)
Received: from [192.168.1.13] (abwe160.neoplus.adsl.tpnet.pl. [83.8.228.160])
        by mx.google.com with ESMTPS id n55sm16733612eef.6.2012.03.22.05.46.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Mar 2012 05:46:39 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v1uol3m5m.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193649>

On Wed, 21 Mar 2012, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > By the way, it is custom on this mailing list to usually Cc (send a
> > copy) to all people participating in discussion, and not only to git
> > mailing list.
> >
> > "W. Trevor King" <wking@drexel.edu> writes:
> >
> > > Subject: [PATCH v3] Isolate If-Modified-Since handling in gitweb
> >
> > Perhaps a better title would be:
> >
> >   gitweb: Refactor If-Modified-Since handling, support in snapshot
> 
> With "gitweb: " prefix to denote what area it affects, that is certainly
> better.  Given the primary objective and effect is that the snapshot
> feature starts honoring i-m-s,
> 
> 	gitweb: honor If-Modified-Since request header in snapshot
> 
> would be sufficient.

That is a very good title... and if all changes were to be put in single
commit (see below), that is what we should concentrate on.  Refactoring
would be just a detail.
 
> > to mention all that thispatch does.  Though trouble with coming up
> > with a short but fairly complete one-line summary might mean that this
> > patch would be better split in two: refactoring and adding support for
> > If-Modified-Since to snapshots.
> 
> If many existing callsites had duplicated code to handle i-m-s, we may
> want two patch series, the first of which consolidates them into a single
> helper function without changing anything else (most importantly, without
> regression) and the second that uses the helper to add support in the
> snapshot feature.  But if that is not the case, I think we can go either
> way.

There is only one callsite, so theoretically we could do it in single
commit, refactoring to add support in new callsite...

...if not for the fact that control flow changes from using conditional
and early return to [longjump] "exception" based one.  That is why
I think it would be better to put tests and refactoring in a commit
separate from adding If-Modified-Since handling to 'snapshot' action.

tl;dr.  Two commits.
-- 
Jakub Narebski
Poland
