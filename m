From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Distribution of longest common hash prefixes
Date: Mon, 02 Apr 2007 10:17:12 -0700
Message-ID: <86y7laitlz.fsf@blue.stonehenge.com>
References: <20070402145857.GA13293@bohr.gbar.dtu.dk>
	<Pine.LNX.4.64.0704020817250.6730@woody.linux-foundation.org>
	<86bqi6kae7.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0704020938470.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Eriksen <s022018@student.dtu.dk>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 02 19:17:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYQ9c-0001bE-GD
	for gcvg-git@gmane.org; Mon, 02 Apr 2007 19:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbXDBRRN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Apr 2007 13:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933686AbXDBRRN
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Apr 2007 13:17:13 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:9682 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933648AbXDBRRM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2007 13:17:12 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 43BDD1DE524; Mon,  2 Apr 2007 10:17:12 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.3.10; tzolkin = 7 Oc; haab = 3 Uayeb
In-Reply-To: <Pine.LNX.4.64.0704020938470.6730@woody.linux-foundation.org> (Linus Torvalds's message of "Mon, 2 Apr 2007 10:00:22 -0700 (PDT)")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43606>

>>>>> "Linus" == Linus Torvalds <torvalds@linux-foundation.org> writes:

Linus> No yay yet.. That counts hex digits, not bits.

I thought the goal was to figure out how long (on the average) you had to give
a SHA1 to be "unique".

But even that's wrong, because of the following:

CAFEFEED357
DEADBEEF123
DEADBEEF456
DEADBEEF467
DEADBEEF478

for that sequence, I'd count 0, 8, 9, 9 when in fact, it should be 8, 9, 9, 9.
It's not the items in common with the previous value... it's the longer of the
items in common with the string on either side.  The easiest way for that
would be to use a 3-item window:

git-rev-list --objects HEAD | sort | perl -lne '
  substr($_, 40) = "";
  if (defined $p) {
    ($p ^ $_) =~ /^(\0*)/;
    $common = length $1;
    if (defined $pcommon) {
      $count[$pcommon > $common ? $pcommon : $common]++;
    }
  }
  $p = $_;
  $pcommon = $common;
  END { print "$_: $count[$_]" for 0..$#count }
'

this also fixes the bug where I compare the first line to nothing.
With this, I get (on git.git):

    0: 
    1: 
    2: 6
    3: 21153
    4: 15008
    5: 1232
    6: 90
    7: 
    8: 2

which now makes sense.  There are 2 items that need 9 hex chars
to be unique.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
