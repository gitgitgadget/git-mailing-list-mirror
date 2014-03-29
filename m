From: Charles Bailey <cbailey32@bloomberg.net>
Subject: Re: [PATCH 2/2] Don't rely on strerror text when testing rmdir
 failure
Date: Sat, 29 Mar 2014 15:58:17 +0000
Message-ID: <20140329155817.GA23238@hashpling.org>
References: <1396107541-22974-1-git-send-email-cbailey32@bloomberg.net>
 <1396107541-22974-3-git-send-email-cbailey32@bloomberg.net>
 <5336EB5C.6040103@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Mar 29 16:58:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTveo-000698-1s
	for gcvg-git-2@plane.gmane.org; Sat, 29 Mar 2014 16:58:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbaC2P6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2014 11:58:20 -0400
Received: from avasout05.plus.net ([84.93.230.250]:58452 "EHLO
	avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbaC2P6T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2014 11:58:19 -0400
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout05 with smtp
	id jTyH1n0032iA9hg01TyJzD; Sat, 29 Mar 2014 15:58:18 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=SYp5d5hu c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=EBOSESyhAAAA:8
 a=0Bzu9jTXAAAA:8 a=zd_RDMET5nsA:10 a=NTeU1BlkvzsA:10 a=N2sEI2mohSIA:10
 a=BHUvooL90DcA:10 a=kj9zAlcOel0A:10 a=BNFp--SqAAAA:8 a=Ew9TdX-QAAAA:8
 a=5Te6cvpxoo64DLGfQhQA:9 a=CjuIK1q_8ugA:10
Received: from charles by hashpling.plus.com with local (Exim 4.72)
	(envelope-from <charles@hashpling.org>)
	id 1WTveD-00067Y-HZ; Sat, 29 Mar 2014 15:58:17 +0000
Content-Disposition: inline
In-Reply-To: <5336EB5C.6040103@web.de>
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245438>

On Sat, Mar 29, 2014 at 04:48:44PM +0100, Jens Lehmann wrote:
> Am 29.03.2014 16:39, schrieb Charles Bailey:
> > diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
> > index 3d30581..23eed17 100755
> > --- a/t/t3600-rm.sh
> > +++ b/t/t3600-rm.sh
> > @@ -709,10 +709,9 @@ test_expect_success 'checking out a commit after submodule removal needs manual
> >  	git commit -m "submodule removal" submod &&
> >  	git checkout HEAD^ &&
> >  	git submodule update &&
> > -	git checkout -q HEAD^ 2>actual &&
> > +	git checkout -q HEAD^ 2>/dev/null &&
> 
> Isn't this unrelated to the strerror issue you are fixing here?
> Why not just drop the redirection completely? But maybe I'm just
> being to pedantic here ;-)

Well, it's a write to 'actual' and the next thing that tests the
contents of 'actual' is the thing that I'm fixing so it's almost
related. (See context kept below.)

I changed the redirection here while investigating the bug. The
redirected output was being overwritten immediately and this was a
more explicit way to write "I don't care about whatever goes to stderr
from this command" which confused me less that merely overwriting the
file on the next line, but perhaps simply not redirecting is better. I
really didn't give it much thought.

> 
> >  	git checkout -q master 2>actual &&
> > -	echo "warning: unable to rmdir submod: Directory not empty" >expected &&
> > -	test_i18ncmp expected actual &&
> > +	test_i18ngrep "^warning: unable to rmdir submod:" actual &&

Charles.
