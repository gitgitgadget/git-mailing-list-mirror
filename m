From: Mike Herrick <mike.herrick@gmail.com>
Subject: fsck errors on newly cloned, newly imported git repository
Date: Sun, 24 Oct 2010 11:54:04 -0400
Message-ID: <AANLkTimxXXNxUOMQyDDoW9+vT9aKL5C5m+VD51jk0zL9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 24 17:54:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PA2tg-0007VS-JU
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 17:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932910Ab0JXPyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 11:54:06 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58400 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932662Ab0JXPyF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 11:54:05 -0400
Received: by wyf28 with SMTP id 28so2517623wyf.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 08:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=yMssSXPrKNHczE/FXyhvctc/G1/u9yVSWK0P0FIrHRQ=;
        b=h43GPXQDydaA45YzU5H98jwaWF+bfWnaUOPPzvNanWGwzWv3q6Jtp55C3yzE1UMdbo
         ST/uECoPExZ11FJROevsNdEAkzPizr0ZWCGyQHoI0NqjlYsPJSaKcy8LIPHbvdIPWjte
         dKhIZWFPMdmCFbG06kK/yTTmB+ixBrH66wkco=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=i2/SF2a+xvQqlYTtCgdjseooqg2iG2FUdQinEc/L23nJ3UJ+G8dO+6Gg+UtRnmQlMi
         BUHI3vlMTS0HobeZ2kNfN3OUBq1baYPw3S4xguEG6M9f5GWeVA9QIaAZ/QXjlKQFe0Sf
         GSkDN4sheCOQCt5DKmaIB4teyjOfC/wP1JFzU=
Received: by 10.227.156.136 with SMTP id x8mr5333997wbw.148.1287935644227;
 Sun, 24 Oct 2010 08:54:04 -0700 (PDT)
Received: by 10.216.255.143 with HTTP; Sun, 24 Oct 2010 08:54:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159882>

This weekend we're cutting over to use git for our source code control
system.  I've imported about 20 years worth of previous history using
"git cvsimport" (takes about four hours).  I then cloned the resulting
repository onto five different machines (four Linux, one Solaris).
I've set up a cron job to do a nightly "git fsck" on each of the five
machines, and last night, two of the machines reported fsck errors on
their initial run.  Here's a sample of the errors:

error: packed cd00921f75f91985d1b67181632a4764af50d4e8 from
.git/objects/pack/pack-b17f2e0a970084fed1f7a6c7664601e78059063f.pack
is corrupt
error: sha1 mismatch 20abcd833a10aad51ff7f59b6a5e179d77e9a388

error: 20abcd833a10aad51ff7f59b6a5e179d77e9a388: object corrupt or missing
error: sha1 mismatch 343c28f127a5e5b9b85b0bdc5419e131b10ff2f0
...
broken link from    tree df17bc72fd5f7cea686f97e14f71f8464149ed25
              to    blob d085a51be07285bec9ccf0323a7cf47856dbb31f
broken link from    tree ab9e5b7383bcde71680abe552e30ae5abf64cf6d
              to    blob 83e8475441911692d1a63d0272e17d62d1b7b8d1
...
missing blob ad3209e27bbc3676bf06f889779908928948b65a
missing blob 4d4829314e64e2a0524fa520f59f7d18482e2b0a
missing blob 9ed481a1970e5f38b1479241ed21a2296c09cda0
...

The errors reported on these two machines were different, but what's
interesting is that all of the missing blobs refer to various
revisions of the same file, namely our "Changes" file (which is
updated with each change).  It's also the largest file in our
repository (3.3M).  I immediately started looking at logs to see if
there was any indication of disk corruption and found none (no SMART
errors either).  Both of these machines have been stable over a
multi-year period of time (no unexplained crashes).  They're also
older Linux machines (running  2.6.5-1.358 and  2.6.1-1.65, with
relatively little memory: 1GB and .5GB), but with newly installed
version of git (1.7.3.1).  I initially used git-daemon for the clone
process, but even using ssh, I still see fsck errors on the resulting
clones on these two machines.

If I don't find an explanation for this behavior, our conversion to
git will need to be backed out before development begins tomorrow :-(.

Thanks for any pointers.

Mike.
