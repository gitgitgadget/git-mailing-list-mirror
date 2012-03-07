From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Replacing large blobs in git history
Date: Wed, 07 Mar 2012 10:04:37 +0100
Message-ID: <4F5724A5.7050405@alum.mit.edu>
References: <CAD-6W7byTiuE9MFZY1yG_ann-Ox7+wGjYduZ=Wwmw0ToF5Pynw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Barry Roberts <blr@robertsr.us>
X-From: git-owner@vger.kernel.org Wed Mar 07 10:04:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5Cni-0005Ee-NS
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 10:04:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752927Ab2CGJEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 04:04:43 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:48290 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437Ab2CGJEk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 04:04:40 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q2794blU022596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 7 Mar 2012 10:04:37 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.27) Gecko/20120216 Lightning/1.0b2 Thunderbird/3.1.19
In-Reply-To: <CAD-6W7byTiuE9MFZY1yG_ann-Ox7+wGjYduZ=Wwmw0ToF5Pynw@mail.gmail.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192432>

On 03/06/2012 05:09 PM, Barry Roberts wrote:
> I started this question on #git last week, but this is getting long,
> and things have changed some, so I'm going to try here.
> 
> I had a 3rd party jar file checked in to our git repository.  It was
> about 4 mb, so no big deal.  Then about 17 months ago somebody checked
> in a 550 mb version.  There were several versions of the original file
> in several different directories.  The large version replaced the
> small version in some of those directories (but not all of them).
> Then somebody found a "small" version that was only 110 mb and
> replaced some of the 550 mb files and some of the old 4 mb files.
> Finally several months after that we got the correct updated 5 mb
> latest version.  But I'm still carrying around an extra 660 mb in my
> object database, and we are adding developers and moving to an
> off-site location with lower bandwidth and higher latency, so I would
> like to clean this up.
> 
> My first attempt just removed the blob (by hash ID).  It's been over a
> year since the small correct file was checked in, so the odds of ever
> needing to build anything that old are very slim. But after thinking
> about it some, I came up with this to replace the blob with the
> correct one and wanted to see if this is a reasonable way to do this
> before I actually backup and then replace my central git repository.
> 
> git filter-branch --index-filter 'killem=$(git ls-files --stage  |
> grep 7a36af54a6c47\\\|abe809091bcb3 ) ; if [ -n "$killem" ] ; then git
> ls-files --stage |grep 7a36af54a6c47\\\|abe809091bcb3 | sed -f
> /home/blr/tmp/chgblob.sed |  git update-index --index-info ; fi'
> 
> chgblob.sed looks like this:
> s/7a36af54a6c47a29eb9690caefa132489d39c4d0/8924ef0f78b3d09957a8697ca93cce6700771071/g
> s/abe809091bcb37a06284f8353366074622d72373/8924ef0f78b3d09957a8697ca93cce6700771071/g
> 
> 7a36af is the 550 mb blob, abe80909 is the 110 mb, and 8924ef0f is the
> 5 mb new version.

You could use "git replace" to cause the bad blobs to be replaced
everywhere they appear:

    $ git replace 7a36af54a6c47a29eb9690caefa132489d39c4d0 \
                  8924ef0f78b3d09957a8697ca93cce6700771071
    $ git replace abe809091bcb37a06284f8353366074622d72373 \
                  8924ef0f78b3d09957a8697ca93cce6700771071

Then you could use "git filter-branch" to "bake in" the substitutions
(but please see the caveats mentioned by Neal).

It seems like an alternative to using "git filter-branch" would be to
share the "git replace" references across repositories.  This would make
the short versions of the file appear wherever they should without
requiring history to be rewritten entirely.  But I don't believe that
this approach would allow the long versions of the file to be discarded
by the git garbage collector, so it would not help you reduce clone sizes.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
