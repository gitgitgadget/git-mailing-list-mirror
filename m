From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Serious bug with pretty format strings & empty bodies?
Date: Wed, 19 Dec 2007 14:32:20 +0000
Message-ID: <57518fd10712190632o490af924n61326fddf1819014@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 19 15:32:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4zyZ-00075J-4i
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 15:32:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268AbXLSOcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 09:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753264AbXLSOcW
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 09:32:22 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:41689 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167AbXLSOcV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 09:32:21 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4761065wah.23
        for <git@vger.kernel.org>; Wed, 19 Dec 2007 06:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=SWTdLszeFp8G89kMyVSeWqKOwFJRlXgVakEsbK2eE+Y=;
        b=rGGG9RwHfmOizXdIfz1RiD6z7HhUnbDMTzy5XvkZ0Uzk9vWWnixzH0+Bq7GZH7gu+tvWA4wKa3GdJebC18KumpEDe06mG/dRHL3+DMLSqTqaiP5V4XfmMZ8StSIH3+lhkJV2cdBgFOKlgPAZ3Sn2D6dR3ipZ7RFo3MJTYbVa6Fo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=bs29FWtL+uZTVy6S2+bOPYU4bhxJoKHLTNc3i0KaeanCWTCfIo+A+GwotHIbDohyZLpN8wbWm2ygJpBKiJsGdvl5uTzzwLkxL+JXDJl5uXZKQHCERs2ZEuqJKZvg5F65zgcNZtJpjrgo5Sgo8PJN3gzHKpp8FRRlxqqIq1/8ATo=
Received: by 10.140.169.6 with SMTP id r6mr5896418rve.273.1198074740262;
        Wed, 19 Dec 2007 06:32:20 -0800 (PST)
Received: by 10.140.134.14 with HTTP; Wed, 19 Dec 2007 06:32:20 -0800 (PST)
Content-Disposition: inline
X-Google-Sender-Auth: 0ed1c6f8a3736750
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68910>

I'm struggling to come up with a minimal test case that confirms this,
but I seem to be hitting a bug in the pretty string formatter when
trying to print bodies of commits that don't have bodies.

For example, on a private repository, I'm trying to print the subject
& body of a commit.  This particular commit doesn't actually have a
body, so I'm expecting to see this output :

=================
commit 18d2480ab689b483ef1ebbdb3f7420904049ba0b
Try to flush log files before terminating the app

=================

However, when I actually run the command, I get gibberish in place of %b :
=================
$ git rev-list -1- --pretty=format:"%s%n%b"
18d2480ab689b483ef1ebbdb3f7420904049ba0b
commit 18d2480ab689b483ef1ebbdb3f7420904049ba0b
Try to flush log files before terminating the app
tree 57bc7cf30a10aee96251852125cf30fd2c81d7aa
parent 04c833865828538315fcdf6e187da077869ce444
author Jonathan del Strother <jon.delStrother@bestbefore.tv> 1197901755 +0000
committer Jonathan del Strother <jon.delStrother@bestbefore.tv> 1197901755 +0000

Check that ThreadWorker's work method actually returns a value with
method signatures
=================

So here you can see that the full details of a different commit is
appearing in place of the requested commit's (empty) body.  Rerunning
the rev-list produces the same output - the same string appears in
place of %b every time, but it's different for each commit.  Often you
only get a small fragment of another commit's message, rather than the
full commit as seen above.

When I use --pretty=full, it works fine.

This appears in quite a few places in my repository's history.
Repacking the repo semi-fixes it - I still get junk bodies, but not
quite so many.

It doesn't always happen when a commit message body is empty, but I've
never seen it happen where the message body has something in.

This happens with both git 1.5.3.7 and 1.5.4.rc0.1162.g3bfea, though
the output is slightly different - the former has a number of
<unknown> markers in it.  This is on OS X 10.5.1


Any suggestions?
Cheers,
Jon
