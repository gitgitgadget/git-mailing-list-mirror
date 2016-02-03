From: Andrew Martin <amartin@xes-inc.com>
Subject: Re: git object-count differs between clones
Date: Wed, 3 Feb 2016 09:21:41 -0600 (CST)
Message-ID: <386465007.95896.1454512901907.JavaMail.zimbra@xes-inc.com>
References: <2142875754.710575.1454428371555.JavaMail.zimbra@xes-inc.com> <vpq7finm6v8.fsf@anie.imag.fr> <203317792.714602.1454430077194.JavaMail.zimbra@xes-inc.com> <20160202165246.GA17822@sigill.intra.peff.net> <1978336183.727736.1454433728105.JavaMail.zimbra@xes-inc.com> <20160203043411.GB21561@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 03 16:22:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQzFl-0001NG-3P
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 16:21:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754374AbcBCPVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 10:21:53 -0500
Received: from xes-mad.com ([216.165.139.218]:49499 "EHLO xes-mad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751524AbcBCPVx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 10:21:53 -0500
Received: from zimbra.xes-mad.com (zimbra.xes-mad.com [10.52.0.127])
	by xes-mad.com (8.13.8/8.13.8) with ESMTP id u13FLgOV021562;
	Wed, 3 Feb 2016 09:21:42 -0600
In-Reply-To: <20160203043411.GB21561@sigill.intra.peff.net>
X-Originating-IP: [10.52.16.96]
X-Mailer: Zimbra 8.0.6_GA_5922 (ZimbraWebClient - GC47 (Linux)/8.0.6_GA_5922)
Thread-Topic: git object-count differs between clones
Thread-Index: NXBBchcmU049cxstq2N4Mh34z0zb3A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285370>

----- Original Message -----
> From: "Jeff King" <peff@peff.net>
> To: "Andrew Martin" <amartin@xes-inc.com>
> Cc: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
> Sent: Tuesday, February 2, 2016 10:34:12 PM
> Subject: Re: git object-count differs between clones
> 
> On Tue, Feb 02, 2016 at 11:22:08AM -0600, Andrew Martin wrote:
> 
> > Thanks for the clarification. I now ran "git repack -A" followed by
> > "git gc --prune=now", however I am still seeing the same number of objects.
> > What
> > else can I try to successfully mark these and unreachable and garbage
> > collect them?
> 
> That should clear out any unreachable objects. Are we sure that the
> objects in question are, in fact, unreachable?
> 
> Try:
> 
>   git rev-list --objects --all --reflog | wc -l
> 
> which should give a count of reachable objects. I'd expect that to line
> up with that "git count-objects -v" reports after having run your gc
> above.
> 
> In your original email, the discrepancy was between your "original"
> repository and the one that had round-tripped to a clone. Is it possible
> there are refs in the original that did not get pushed? Try comparing
> "git for-each-ref" in each repository.
> 
> We also consider objects in the index to be reachable for packing. Could
> your original perhaps have some uncommitted objects mentioned in the
> index?
> 
> -Peff
> 

Jeff,

This did it - those commits were still referenced by some remotes:
$ git for-each-ref
945c3a60dfb4d9ab774708d19f7aa74dd545db90 commit refs/heads/master
945c3a60dfb4d9ab774708d19f7aa74dd545db90 commit refs/remotes/origin/brancha
8b331e4bb42f6291c33eb0847c4481407e3d753c commit refs/remotes/origin/branchb

I removed them:
$ git update-ref -d refs/remotes/origin/brancha
$ git update-ref -d refs/remotes/origin/branchb

And then I was able to garbage collect and get the expected object count:
$ git reflog expire --expire=now --expire-unreachable=now --all
$ git gc --prune=now

Thanks for the help!

Andrew
