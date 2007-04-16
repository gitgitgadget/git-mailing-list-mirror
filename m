From: Junio C Hamano <junkio@cox.net>
Subject: Re: git push over http is very dangerous
Date: Mon, 16 Apr 2007 12:55:17 -0700
Message-ID: <7vk5wcrt5m.fsf@assigned-by-dhcp.cox.net>
References: <462394AC.303@beronet.com>
	<Pine.LNX.4.64.0704161212140.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian <crich-ml@beronet.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 16 21:55:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdXIK-0003Yq-Gp
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 21:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030925AbXDPTzU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 15:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030928AbXDPTzU
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 15:55:20 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:46788 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030925AbXDPTzT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 15:55:19 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070416195518.DXKL1268.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Mon, 16 Apr 2007 15:55:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id nvvH1W00c1kojtg0000000; Mon, 16 Apr 2007 15:55:18 -0400
cc: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <Pine.LNX.4.64.0704161212140.5473@woody.linux-foundation.org>
	(Linus Torvalds's message of "Mon, 16 Apr 2007 12:38:24 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44691>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, 16 Apr 2007, Christian wrote:
>>
>> We have moved from CVS to git in the beginning of last week, all went well
>> until this weekend. This weekend one developer wanted to push some of his
>> local modifications, unfortunately during the push his http connection seemed
>> to have broken or so. Unfortunately git does not prove if the push went well.
>> Therefore our repository was broken this morning.
>
> I have to agree: pushing over http really is dangerous.
> ...

Just for the record, I do not think anybody during that #git
discussion actually proved that http-push was the culprit.  It
is a very plausible working conjecture, though.

I do not know if Nick is still using his own http-push (or if he
is still using git for that matter), but just in case he may
still be interested, I am cc'ing this message to him.

> I'd also love it if somebody were to actually look into making 
> http-pushing a bit safer. It really needs somebody who cares about it, or 
> it should likely just be disabled entirely (perhaps with a config option 
> that you have to enable to get it - so that people *realize* that it's not 
> maintained and not really supported).

I think the fetch side does the right thing, more or less, by
downloading to a temporary file and using move_temp_to_file()
after validating the SHA-1 matches.  I haven't followed the push
side but as we do not have a single line of code on the
receiving end, I would not be surprised if there is no error
checking beyond HTTP response code would give the pushing end.

I would still love to see the corrupt loose object to see how it
is broken.

Christian, can you do this with the first (i.e. older) commit
that is broken, and tar up these 7 files for the initial round
of inspection?

	$ git cat-file commit $commit >commit-text 2>commit-error
        $ git ls-tree ${commit} >toplevel-tree 2>toplevel-tree-error
        $ git ls-tree -r -t ${commit} >whole-tree 2>whole-tree-error
	$ cp .git/objects/cd/1aac1a43cfdac07118240f75c0ba7662eb8140 corrupt
