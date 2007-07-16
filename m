From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] Introduce commit notes
Date: Mon, 16 Jul 2007 10:56:43 -0700
Message-ID: <7vzm1w2pwk.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site>
	<200707160857.48725.andyparkins@gmail.com>
	<7vbqec4vk2.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707161724110.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Alberto Bertogli <albertito@gmail.com>,
	Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 16 19:56:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAUoS-0000Fc-2A
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 19:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244AbXGPR4p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 13:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752283AbXGPR4p
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 13:56:45 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:34142 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752225AbXGPR4o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 13:56:44 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070716175643.HSQJ1393.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Mon, 16 Jul 2007 13:56:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id QHwj1X00C1kojtg0000000; Mon, 16 Jul 2007 13:56:44 -0400
In-Reply-To: <Pine.LNX.4.64.0707161724110.14781@racer.site> (Johannes
	Schindelin's message of "Mon, 16 Jul 2007 17:26:31 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52702>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Hmph, you are right.  In this sequence:
>> 
>> 	hex = sha1_to_hex(commit->object.sha1);
>> 	snprintf(name, sizeof(name), "%s:%.*s/%.*s",
>> 			notes_ref_name, 2, hex, 38, hex + 2);
>> 	if (get_sha1(name, sha1))
>> 		return;
>> 
>> Instead, we could read the tree object by hand in the commit that is 
>> referenced by notes_ref_name, which has uniform two letter names for 
>> subtrees which can be binary searched, open the tree for that entry, 
>> again by hand, and do another binary search because that tree has 
>> uniform 38-letter names.  That certainly could be done.
>> 
>> Sounds like a "fun" project for some definition of the word.
>
> I disagree.  One disadvantage to using tree objects is that it is much 
> easier to have pilot errors.  You could even make a new working tree 
> checking out refs/notes/commits and change/add/remove files.

I suspect you read me wrong.  I was saying that it is possible
to use a specialized tree object parser in place of get_sha1()
only in the above code to read the tree objects that represents
a 'note'.  You obviously would want to do a sanity check such
as:

 - The size of the tree object your customized tree parser is
   fed is multiple of expected entry size (mode word + 20 SHA1 +
   2 + NUL for fan-out, replace 2 with 38 for lower level);

 - mode word for the entry is sane (an entry in the fan-out tree
   would point at a tree object, an entry in lower level would
   point at a blob);

 - The name part (2 or 38) are lowercase hexadecimal strings;
