From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] diffcore-delta.c: Ignore CR in CRLF for text files
Date: Fri, 29 Jun 2007 01:51:39 -0700
Message-ID: <7vbqezf8is.fsf@assigned-by-dhcp.pobox.com>
References: <1183098962312-git-send-email-gitster@pobox.com>
	<200706290813.l5T8DJ6w024507@mi1.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: GIT <git@vger.kernel.org>
To: =?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Fri Jun 29 10:51:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4CCd-0000dc-TG
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 10:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754522AbXF2Ivl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jun 2007 04:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753157AbXF2Ivl
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jun 2007 04:51:41 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:52795 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754491AbXF2Ivk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2007 04:51:40 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070629085140.MZOI1594.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Fri, 29 Jun 2007 04:51:40 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id HLrf1X0071kojtg0000000; Fri, 29 Jun 2007 04:51:40 -0400
In-Reply-To: <200706290813.l5T8DJ6w024507@mi1.bluebottle.com>
	(nanako3@bluebottle.com's message of "Fri, 29 Jun 2007 17:14:19
	+0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51166>

しらいしななこ  <nanako3@bluebottle.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>:
>
>> This ignores CR byte in CRLF sequence in text file when
>> computing similarity of two blobs.
>> ...
>> +test_expect_success 'diff -M' '
>> +
>> +	git diff-tree -M -r --name-status HEAD^ HEAD |
>> +	sed -e "s/R[0-9]*/RNUM/" >actual &&
>> +	echo "RNUM	sample	elpmas" >expect &&
>> +	diff -u expect actual
>> +
>> +'
>
> I tried this test but it does not give R100.  The new file is unchanged except for
> LF -> CRLF.  Could you explain why?

Heh, I hate when people nitpick me ;-)

The similarity code counts "bytes copied from the source
material to the destination" and "bytes added to the source to
create the destination".

Rename detection uses only the former value.  The amount of data
copied from the source is divided by the larger of the size of
source or destination.

In the case of our test script, the source material is about 560
bytes, while the destination material is about 590 bytes, after 
adding CR to the end of every line.  We find that 560 bytes have
been copied from the source material, and floor(560 * 100 / 590)
is 94%, which is what you would see as the result.

We could adjust max_size variable inside diffcore_count_changes,
but I am not sure if it is worth the trouble.
