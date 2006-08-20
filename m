From: Rutger Nijlunsing <rutger@nospam.com>
Subject: Re: Object hash (was: Re: [ANNOUNCE] git-rev-size: calculate sizes of repository)
Date: Sun, 20 Aug 2006 19:40:54 +0200
Organization: M38c
Message-ID: <20060820174054.GB21362@nospam.com>
References: <20060820105452.GA19630@nospam.com> <20060820152404.GA5679@nospam.com> <Pine.LNX.4.63.0608201805070.28360@wbgn013.biozentrum.uni-wuerzburg.de> <200608201837.33577.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.63.0608201846110.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: git@wingding.demon.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Rutger Nijlunsing <git@wingding.demon.nl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 20 19:41:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GErIF-0005sP-MY
	for gcvg-git@gmane.org; Sun, 20 Aug 2006 19:41:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbWHTRlA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Aug 2006 13:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbWHTRk7
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Aug 2006 13:40:59 -0400
Received: from post-23.mail.nl.demon.net ([194.159.73.193]:38349 "EHLO
	post-23.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id S1751024AbWHTRk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Aug 2006 13:40:59 -0400
Received: from wingding.demon.nl ([82.161.27.36]:46249)
	by post-23.mail.nl.demon.net with esmtp (Exim 4.51)
	id 1GErI9-000IkN-7N; Sun, 20 Aug 2006 17:40:57 +0000
Received: from rutger by wingding.demon.nl with local (Exim 4.62)
	(envelope-from <rutger@wingding.demon.nl>)
	id 1GErI6-0007S3-9j; Sun, 20 Aug 2006 19:40:54 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0608201846110.28360@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25759>

> Second, since you call hash_put() once per object, hash->nr cannot grow 
> too big, because grow_hash() doubles hash->alloc. And I call grow_hash() 
> once the hash map is half-full; Somebody once told me that would be the 
> optimal growing strategy.

Optimal growing mainly means to be O(n) (amortized) after n
inserts. That translates to at least _doubling_ (factor 2 or more) the
capacity once you're too full.

Assume doubling at a percentage full. Assume realloc(s) takes O(s)
(where s = number of bytes). Assume we start with 1 element.

We realloc() then when we've got 1 element, then at 2, 4, 8 etc. The
size of the realloc() at each point will also be 1, 2, 4, 8
etc. However, this cost of O(s) can be amortized over the number of
elements. So the work done _per insert_ is still a constant (amortized
again).

Ascilly:

   x x x x x x x x x x ...  (each insert)
     R   R       R     ...  (each realloc)
   1 2 0 4 0 0 0 8 0 0 ...  (cost of those realloc())

This has also to do with the infinite series of the sum(k>0) of 2^-k
being a constant.

-- 
Rutger Nijlunsing ---------------------------------- eludias ed dse.nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
