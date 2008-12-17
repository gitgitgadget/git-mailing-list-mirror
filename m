From: demerphq <demerphq@gmail.com>
Subject: git clone rsync:// broken
Date: Wed, 17 Dec 2008 14:45:23 +0100
Message-ID: <9b18b3110812170545y59eb5732sf776504da578c2fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 17 14:46:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCwjd-00066L-0i
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 14:46:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbYLQNp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 08:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbYLQNp0
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 08:45:26 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:64692 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847AbYLQNpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 08:45:25 -0500
Received: by qyk4 with SMTP id 4so3732855qyk.13
        for <git@vger.kernel.org>; Wed, 17 Dec 2008 05:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=2u7Ve3R4nFbYjjGYz96/63eIi+ECXFymJMdDWOY14C4=;
        b=BtFmropCtYLmTefA28lyqH8zaXZ5gg1P41M83iPxooIfqLyLsIzo0LSXw/bjuvqSOa
         +Mef4XwCNQxw7atq7iXsDa2hp5be2bqlNBcMM1YmzV+IfvOVKQea4O40pUs92//Rt+lg
         KV5QDfcbVrddLU4sThrmK9Zvj9xwAtA8Gcgtk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=LqUs+vl3ho1iXh88nekNHQaEcDFAqyfg8J8k8jk+sbpK6Xlc4lxFuzmXcm7zGW3a7C
         jW11GrSw8gxLMeRYXgqRM55dARUiAfFH5Y+VLmUPpVT0m7KgoF1FGBWmkSxxeDIyKm4Q
         FcbIkefLqh4Kjf//3T2d0sv1p3fxHgP1gDkg0=
Received: by 10.214.25.15 with SMTP id 15mr772752qay.119.1229521523080;
        Wed, 17 Dec 2008 05:45:23 -0800 (PST)
Received: by 10.214.241.11 with HTTP; Wed, 17 Dec 2008 05:45:23 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103350>

Hi,

Summary:

There seems to be a problem with cloning via rsync in that a corrupted
packed-refs file is/maybe transmitted, and the HEAD file is not
correctly transfered.

Detail:

I've been encountering some problems getting things set up so people
can clone using rsync.

The object repository seems to transfer fine, in that the resulting
directory is the right size approximately, but the cloning fails with
the error message

    warning: remote HEAD refers to nonexistent ref, unable to checkout

Inspecting the .git/HEAD file it points at refs/heads/master,  which
doesn't exist as for historical reasons our master is called 'blead'.

Looking at the packed-refs file there was a duplicate incorrect entry
in the file. Which was remedied by executing

    git pack-refs --all

on the source repository which improves the situation somewhat, as
after a clone fails we were able do a

   git checkout -b blead origin/blead

and things seem ok. But the clone still fails as the HEAD is not correct.

If we use git://, http://, or ssh:// protocols to clone everything
transfers fine.

I checked in the #git channel and there were a number of comments by
people that helped me investigate:

because git transport via rsync seems to assume packed-refs is sorted
- which it maybe wasnt (cant check now anymore).
That caused the failure like "fatal: Duplicated ref, and SHA1s don't
match: refs/remotes/origin/p4/maint-5.10/perl"
The remaining problem is, that HEAD seems not get fetched at all
And I dont see how HEAD should get fetched in the transport.c code
The other dumb protocol aka http explicitly gets it
So i would bugreport this

For anyone wanting to try the repo is public at:
perl5.git.perl.org/perl, which works fine with http://, and git://,
but currently rsync:// is broken.

This isnt the official perl repository yet. We were planning to go
live with it tomorrow. Meaning if you do clone it please be aware that
we might replace the repository with a complete new version before it
goes live.

cheers,
Yves
ps: Im not on list, so please cc me in any replies.



-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
