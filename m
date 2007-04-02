From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Distribution of longest common hash prefixes
Date: Mon, 02 Apr 2007 10:33:13 -0700
Message-ID: <86r6r2isva.fsf@blue.stonehenge.com>
References: <20070402145857.GA13293@bohr.gbar.dtu.dk>
	<Pine.LNX.4.64.0704020817250.6730@woody.linux-foundation.org>
	<86bqi6kae7.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0704020938470.6730@woody.linux-foundation.org>
	<86y7laitlz.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Eriksen <s022018@student.dtu.dk>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 02 19:33:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYQP6-00010B-QL
	for gcvg-git@gmane.org; Mon, 02 Apr 2007 19:33:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965052AbXDBRdO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Apr 2007 13:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965164AbXDBRdO
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Apr 2007 13:33:14 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:4029 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965052AbXDBRdN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2007 13:33:13 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 2D6AE1DE524; Mon,  2 Apr 2007 10:33:13 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.3.10; tzolkin = 7 Oc; haab = 3 Uayeb
In-Reply-To: <86y7laitlz.fsf@blue.stonehenge.com> (Randal L. Schwartz's message of "Mon, 02 Apr 2007 10:17:12 -0700")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43608>

>>>>> "Randal" == Randal L Schwartz <merlyn@stonehenge.com> writes:

Randal> git-rev-list --objects HEAD | sort | perl -lne '
Randal>   substr($_, 40) = "";
Randal>   if (defined $p) {
Randal>     ($p ^ $_) =~ /^(\0*)/;
Randal>     $common = length $1;
Randal>     if (defined $pcommon) {
Randal>       $count[$pcommon > $common ? $pcommon : $common]++;
Randal>     }
Randal>   }
Randal>   $p = $_;
Randal>   $pcommon = $common;
Randal>   END { print "$_: $count[$_]" for 0..$#count }
Randal> '

And that's off by one on either end. :)

    git-rev-list --objects HEAD | sort | perl -lne '
      substr($_, 40) = "";
      if (defined $p) {
        ($p ^ $_) =~ /^(\0*)/;
        $common = length $1;
        if (defined $pcommon) {
          $count[$pcommon > $common ? $pcommon : $common]++;
        } else {
          $count[$common]++; # first item
        }
      }
      $p = $_;
      $pcommon = $common;
      END {
        $count[$common]++; # last item
        print "$_: $count[$_]" for 0..$#count;
      }
    '

Which now yields:

    0: 
    1: 
    2: 6
    3: 21155
    4: 15008
    5: 1232
    6: 90
    7: 
    8: 2

And *that* totals to 37493, which is the number of objects.  Yeay.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
