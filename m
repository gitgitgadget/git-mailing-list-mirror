From: Bill Zaumen <bill.zaumen+git@gmail.com>
Subject: Re: [PATCH] Implement fast hash-collision detection
Date: Tue, 29 Nov 2011 13:56:28 -0800
Message-ID: <1322603788.1728.190.camel@yos>
References: <1322546563.1719.22.camel@yos>
	 <20111129090733.GA22046@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
	spearce@spearce.org, torvalds@linux-foundation.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 29 22:56:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVVfX-0000jP-DA
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 22:56:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754126Ab1K2V4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Nov 2011 16:56:46 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46486 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020Ab1K2V4p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2011 16:56:45 -0500
Received: by yenl6 with SMTP id l6so4559947yen.19
        for <git@vger.kernel.org>; Tue, 29 Nov 2011 13:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=JWggVFWQUJ4dYt3ufIkSO6OE2LkKgO6CHeBV4Rt5ghw=;
        b=GARi4Q0BtXKI9NVG35dfLOLDFp0aYzDH3KHYBSvDBfyGSu2bYvofCJ+cOnirYWPETf
         x4xwwLGvYOrDyHxnTAA8F0/zdZTYvT6U9XaruaPxDAr3osCxic48wufTPCDs7GG0aYgh
         Dlwv8AUfx8FTAVy3NjW5nPgJWhPYzfZ7pcl2g=
Received: by 10.50.135.40 with SMTP id pp8mr59211874igb.1.1322603804963;
        Tue, 29 Nov 2011 13:56:44 -0800 (PST)
Received: from [192.168.1.20] (adsl-209-233-20-69.dsl.snfc21.pacbell.net. [209.233.20.69])
        by mx.google.com with ESMTPS id eb23sm64099600ibb.2.2011.11.29.13.56.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Nov 2011 13:56:43 -0800 (PST)
In-Reply-To: <20111129090733.GA22046@sigill.intra.peff.net>
X-Mailer: Evolution 2.30.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186090>

Thanks for mentioning the 100K limit, which I didn't know about.  Will
have to try to see how to split it into two patches.

The intent is to increase the cost of a malicious attack, which requires
generating two different files with the same SHA-1 value, detect such an
attack early, and to slow such an attack down - because of Git's rule
that the first object with a SHA-1 value is the one the repository has,
if it takes longer to generate a collision than the time it takes to get
the original object into all repositories (which is done manually by
multiple individuals), the forged file will never appear in any
"official" repository.

The additional CRC (easily changed to whatever message digest one might
prefer) makes a malicious attack far more difficult: the modified file
has to have both the same SHA-1 hash (including the Git header) and 
the same CRC (not including the Git header).  An efficient algorithm to
do both simultaneously does not yet exist.  So, if we could generate a
SHA-1 collision in one second, it would presumably take billions of
seconds (many decades of continuous computation) to generate a SHA-1
hash with the same CRC, and well before a year has elapsed, the original
object should have been in all the repositories, preventing a forged
object from being inserted. Of course, eventually you might need a
real message digest.

The weakness of a CRC as an integrity check is not an issue since it is
never used alone: it's use is more analogous to the few extra bits added
to a data stream when error-detecting codes are used.  I used a CRC in
the initial implementation rather than a message digest because it is
faster, and because the initial goal was to get things to work
correctly.  In any case, the patch does not eliminate any code in which
Git already does a byte-by-byte comparison.  In cases where Git
currently assumes that two objects are the same because the SHA-1 hashes
are the same, the patch compares CRCs as an additional test.

Regarding your [Jeff's] second concern, "how does this alternative
digest have any authority?" there are two things to keep in mind. First,
it is a supplement to the existing digest.  Second, any value of the CRC
that is stored permanently (baring bugs, in my implementation, of
course) is computed locally - when a loose object is created or when a
pack file's index is created.  At no point is a CRC that was obtained
from another repository trusted. While the patch modifies Git so that it
can send CRCs when using the git protocol, these CRCs are never stored,
but are instead used only for cross checks.  If one side or the other
"lies", you get an error.  

To give a concrete example, during a fetch, the git protocol currently
sends "have" messages that contain the SHA-1 hashes of commits.  The
extension allows two CRCs to be sent along with each hash.  If these do
not match the local values (tested only if the local values exist),
something is wrong and you get an error report that the server sends to
the client, but the server never uses these CRCs for any other purpose
and the server never sends its CRCs to the client because of
backwards-compatibility issues. For objects that are transferred, you
end up with a pack file, with index-pack called to build the index (and
with the patch, the corresponding MDS file), but index-pack already does
a byte-by-byte comparison to detect collisions - the comparison is much
faster than the SHA-1 computation index-pack has to do anyway.

Where this helps is when one is using multiple repositories. If you
fetch a commit from repository B, which we'll assume has a forged blob
(different content, but the original SHA-1 hash), and then run fetch
using repository A, which has has the same commit with the original
blob, the forged blob will not be transferred from Server A and the
client will not be notified that there is an inconsistency - the
protocol is "smart" enough to know that the client already has the
commit and assumes there is nothing to do regarding it.

BTW, regarding your [Jeff's] discussion about putting an additional
header in commit messages - I tried that.  The existing versions of
Git didn't like it: barring a bug in my test code, it seems that Git
expects headers in commit messages to be in a particular order and
treats deviations from that to be an error.  I even tried appending
blank lines at the end of a commit, with spaces and tabs encoding an
additional CRC, and that didn't work either - at least it never got
through all the test programs, failing in places like the tests
involving notes. In any case, you'd have to phase in such a change
gradually, first putting in the code to read the new header if it is
there, and subsequently (after ample time so that everyone is running
a sufficiently new version) enabling the code to create the new
header.

Also, regarding "At that point, I really wonder if a flag day to switch
to a new repository format is all that bad," if that turns out to be
the decision, I'd recommend doing it sooner rather than later. The
reason is cost, which grows with the number of git users and the
number and size of Git repositories.

Bill
