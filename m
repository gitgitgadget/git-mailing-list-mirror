From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] Introduce commit notes
Date: Mon, 16 Jul 2007 01:11:41 -0700
Message-ID: <7vbqec4vk2.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site>
	<200707160857.48725.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alberto Bertogli <albertito@gmail.com>,
	Johan Herland <johan@herland.net>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 10:11:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IALgK-0002DG-BN
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 10:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774AbXGPILp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 04:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753795AbXGPILo
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 04:11:44 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:61902 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753731AbXGPILn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 04:11:43 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070716081142.HAP1428.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Mon, 16 Jul 2007 04:11:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Q8Bi1X0011kojtg0000000; Mon, 16 Jul 2007 04:11:42 -0400
In-Reply-To: <200707160857.48725.andyparkins@gmail.com> (Andy Parkins's
	message of "Mon, 16 Jul 2007 08:57:46 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52649>

Andy Parkins <andyparkins@gmail.com> writes:

> On Monday 2007 July 16, Johannes Schindelin wrote:
>
>> The biggest obstacle was a thinko about the scalability.  Tree objects
>> take free form name entries, and therefore a binary search by name is not
>> possible.
>
> I might be misunderstanding, but in the case of the notes tree objects isn't 
> it true that the name entries aren't free form, but are guaranteed to be of a 
> fixed length form:
>
>   XX/XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
>
> In which case you can binary search?

Hmph, you are right.  In this sequence:

	hex = sha1_to_hex(commit->object.sha1);
	snprintf(name, sizeof(name), "%s:%.*s/%.*s",
			notes_ref_name, 2, hex, 38, hex + 2);
	if (get_sha1(name, sha1))
		return;

Instead, we could read the tree object by hand in the commit
that is referenced by notes_ref_name, which has uniform two
letter names for subtrees which can be binary searched, open the
tree for that entry, again by hand, and do another binary search
because that tree has uniform 38-letter names.  That certainly
could be done.

Sounds like a "fun" project for some definition of the word.
