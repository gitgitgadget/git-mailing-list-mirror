From: Thomas Adam <thomas.adam22@gmail.com>
Subject: Git workflow: Managing topic branches.
Date: Mon, 24 Aug 2009 15:44:17 +0100
Message-ID: <18071eea0908240744g359f8b1ey622259e89ac7592a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 24 16:45:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mfamz-0006ci-2e
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 16:44:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbZHXOoi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 10:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752591AbZHXOoh
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 10:44:37 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:62512 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571AbZHXOoh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 10:44:37 -0400
Received: by mail-ew0-f207.google.com with SMTP id 3so2446391ewy.18
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 07:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=3DgtQR7DqgZsaLRLu7yGocTEbn7HoFCy8xpCjI1L/5s=;
        b=BEw/957RwHF4FV/W5ni1rXVYMYkcn/t82AVLDPioJAUvAIimvQ4sDgOoVQ6trWytxx
         Xcz9uKz3v26Q87wznTwB+/Oh+ahFH9OfqY4yRkNFKvRaM3X/t721VoveJZQsC4xeZe+c
         4pY1Lbw9lpTzwyS1bHSTxVjBLafQKX96k6CV8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=xKVJKw148oaAvxu5UAgSCVSCAomiDNPOn3rS/+C3bQrPGYbYacfM7iotX1gURLhE8F
         61iSrGPU89IrlMF0KWkLmlPAacbyfgBr+PISth7YPqeep14wDswm/Ry7EypdVbEBOcaB
         7Yau88zTzBcu/i4217nmfA9hnTXxcDGLeQSAc=
Received: by 10.216.87.140 with SMTP id y12mr1046316wee.4.1251125078285; Mon, 
	24 Aug 2009 07:44:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126936>

Hello all,

I've a question regarding a specific workflow which we're currently using
here at work, but I am not convinced it's particularly brilliant -- and
there's a number of oddities about it which I'd like to discus -- perhaps
with a way of coming up with a new solution.

We have a work-flow such as this:


         o---o---o---o--o--o (stable)
        /
o---o---o---o---o---o---o  (master)
     \
      o---o--o---o---o---o (featureA)


Master is where all our stable code lives after a release -- and also where
bug-fixes for released code is put.  When we're working on a new feature,
almost all developers here will push (in this case) to "featureA" ---
eventually this branch will get merged into master, tagged and the code
released.  Then a new branch, "featureB" is created off it, and process
continues.  (Yes, we're using Git in a very CVS-like way, alas.)

Periodically though we need to release updates for our product.  This the
area which is where my question lies about whether the workflow is good or
not.  Here's how we do that:

We have a branch called "stable" which contains all of our released code
plus any updates release.  When we wish to create a new update, we create a
new branch off the tip of stable:


                            o---o---o---o (updateN)
                           /
         o---o---o---o--o--o (stable)
        /
o---o---o---o---o---o---o  (master)
     \
      o---o--o---o---o---o (featureA)


Because bug-fixes happen on Master, we now want those fixes to appear on the
updateN branch so we can create a tarball from them (to release to our
customers).  We're using "git cherry" to get a list of SHA1s that are
relevant between updateN and master, as in:

git cherry updateN master

... and then manually deciding (based on it's "+"/"-" output whether that
SHA1 needs to be used and then:

git cherry-pick SHA1

... onto updateN as appropriate.  This branch is then pushed to our
"central" server as a public branch, is checked out elsewhere on another
macine to build this update.  If that's successful, various other bits and
bobs in terms of meta data is added into the commits onto the updateN branch
and it is merged into stable:

                            o---o---o---o (updateN)
                           /            / <-- (merge updateN to stable)
         o---o---o---o--o--o------------o (stable)
        /
o---o---o---o---o---o---o  (master)
     \
      o---o--o---o---o---o (featureA)

The "stable" branch is then merged into master so that when we create
another "featureX" branch, it's at a point where it's on a known set of
released code.

So my questions:  I am not convinced this workflow is very elegant, or
indeed a particularly good solution to what we're wanting to do.  Because
the cherry-picking that happens to the "updateN" branch happens from
"master" which itself will have had several local topic-branches merged into
it from other developers -- I've found "git-cherry" to give unreliable
results -- in some cases, the same two commits with the same data appear on
the "updateN" branch -- using git patch-id manually with processing on top
of that seems to give a much shorter and succient set of SHA1s to
cherry-pick.  (But this is kind of peripheral to my question).

I am interested to know if this branch and merge scenario is the right one.
I also don't believe we're using git-cherry in the right way to isolate the
correct commits.  I have toyed with the idea of rebasing, but am hesitant on
this idea, and unsure if that would even be the right way to go --
especially seeing as all the branches mentioned are tracking branches.

The eventual aim of all of this is to try and automate building of these
updates -- but we sure as hell can't do that at the moment with our current
workflow.  If anyone has any suggestions on any of this, I'd appreciate it.
If I've not explained things adequately. shout and I'll try and clarify.

Thanks in advance,

Thomas Adam
