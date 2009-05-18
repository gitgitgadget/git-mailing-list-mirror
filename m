From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] commit: add function to unparse a commit and its parents
Date: Sun, 17 May 2009 23:27:58 -0700
Message-ID: <7v3ab3exht.fsf@alter.siamese.dyndns.org>
References: <20090517153307.6403.73576.>
	<20090517153647.6403.44036.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon May 18 08:28:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5wKj-0002Z0-81
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 08:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754873AbZERG17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 02:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754254AbZERG16
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 02:27:58 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:34498 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761AbZERG15 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 02:27:57 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090518062758.NWLZ25927.fed1rmmtao106.cox.net@fed1rmimpo03.cox.net>;
          Mon, 18 May 2009 02:27:58 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id suTy1b0094aMwMQ04uTyTw; Mon, 18 May 2009 02:27:58 -0400
X-Authority-Analysis: v=1.0 c=1 a=4Mj9RkLmTmMA:10 a=wsYAPnAVpiQA:10
 a=dIu3SnmMAAAA:8 a=ZtQdXitFJ_k59hATaT4A:9 a=A-rj2hxJ0T2of8kqZPWX4YmzAtMA:4
 a=Rn8qiON8_f4A:10
X-CM-Score: 0.00
In-Reply-To: <20090517153647.6403.44036.chriscool@tuxfamily.org> (Christian Couder's message of "Sun\, 17 May 2009 17\:36\:45 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119420>

Christian Couder <chriscool@tuxfamily.org> writes:

> Its parents are recursively unparsed too, because they might have
> been changed. But its tree is not unparsed as it should not have
> been modifed.

It is a bug in any codepath if it used commit->tree without first checking
if commit->parsed is true to begin with, so you could NULLify commit->tree
but that shouldn't make any difference.  I agree leaving the tree object
as-is would make sense.

I am not convinced that unparsing all the _remaining_ parents recursively
like your patch does is enough.  Isn't there a codepath that

 - parses a commit A to find list of true parents X, Y, Z;

 - iterates over that list and descend into one of these parents X, doing
   nasty things such as pruning its parents list after parsing it; and

 - decides to prune that parent X from the parent list, making the parent
   list of A into Y and Z?

After such a sequence, calling your unparse_commit(A) will unparse A and
remaining parents of Y and Z, but will still leave X in the dirty state.
