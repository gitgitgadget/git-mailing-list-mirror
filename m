From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] reflog: silence -O3 -Wuninitialized warning
Date: Wed, 16 Mar 2011 01:28:48 -0500
Message-ID: <20110316062831.GA5252@elie>
References: <20110316024959.GA24932@elie>
 <7vfwqnabbi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 07:29:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzkE9-0006Dw-Kz
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 07:29:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521Ab1CPG24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 02:28:56 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52364 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951Ab1CPG2y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 02:28:54 -0400
Received: by gwaa18 with SMTP id a18so533603gwa.19
        for <git@vger.kernel.org>; Tue, 15 Mar 2011 23:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=7TvsTzkWieLHbHryG5smZHtjQryWMlaY349v/x+wceY=;
        b=jiJ19cn0hxWUJS7jmmKX7xwIDZlKmCMu/xuWFGKYrbznkJv+/w4SXmRCzI28o595b/
         ovSqgkz1eoSEY0NsXgk2Wq6zGmY/Enb1yqZnhsfj2tkVKql+PKLW5e2KyTDSmKC4mf5U
         2eHCcuxfM8SCT3vSy/bhjpswK3pmoAXYbSt4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=QOFKk/4OuTURIQRfPumN7GmKWhNw3rwEPUnTLM+OfnBRUPtJAWI1ikxeswEckV6yyz
         BW0mJzW57hM3668qHvecBqICb7tmSIxxW+mH+mDAIrDEha2N5f6BDQC1NxqxzFN/5aCl
         VoO/HAGpI/qeC35OjVJ0LXHmOoxc/BnUph0Pk=
Received: by 10.236.194.73 with SMTP id l49mr328691yhn.132.1300256934391;
        Tue, 15 Mar 2011 23:28:54 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id i60sm414827yhj.17.2011.03.15.23.28.52
        (version=SSLv3 cipher=OTHER);
        Tue, 15 Mar 2011 23:28:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vfwqnabbi.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169107>

Junio C Hamano wrote:

> We could obviously do (2) or (3), but the thing is, I don't think we can
> have much confidence on -Wuninitialized warnings from this compiler once
> we go down that route.  Is it _guaranteed_ that the compiler bug _always_
> err on the false-positive side?
>
> IOW, I'd very much prefer (1) for this particular case and if somebody
> really cares (2).

*nod*.  The tricky heuristics here are that (A) a call to the function

 extern void foo(int *var);

is assumed to initialize *var (to support idioms like strbuf_init), while
(B) no assumption is made about the return value of a call to the function

 extern int bar(void);

The assumption (B) is the scourge of -Wuninitialized users.  It is
always going produce a lot of false positives --- the compiler simply
doesn't have enough information to completely analyze the flow through
a function.  (Even if it did have enough information, completely
solving the problem is Turing-complete.)

Problems from (A) are more rare.  -Wuninitialized will produce _some_
false negatives, but problems it misses would typically be due to
failure to check for errors and return early, which is not what
-Wuninitialized is about.

I don't mind the warning, especially since it only appears with -O3.
What makes this interesting to me is that it is a reminder that the
compiler has very little information about the flow of control.  A
simple

 #define error(...) (report_error(__VA_ARGS__), -1)

could open the door to some nice micro-optimizations.
