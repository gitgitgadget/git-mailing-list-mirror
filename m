From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] Lazily open pack index files on demand
Date: Sat, 26 May 2007 01:29:55 -0700
Message-ID: <7vabvsm1h8.fsf@assigned-by-dhcp.cox.net>
References: <20070526052419.GA11957@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dana How <danahow@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat May 26 10:30:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hrrf3-00061K-Rk
	for gcvg-git@gmane.org; Sat, 26 May 2007 10:30:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbXEZI35 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 04:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbXEZI35
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 04:29:57 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:58695 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075AbXEZI34 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 04:29:56 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070526082955.CUTT19731.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sat, 26 May 2007 04:29:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3kVv1X0081kojtg0000000; Sat, 26 May 2007 04:29:55 -0400
In-Reply-To: <20070526052419.GA11957@spearce.org> (Shawn O. Pearce's message
	of "Sat, 26 May 2007 01:24:19 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48461>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>  This conflicts (in a subtle way) with Dana How's
>  "sha1_file.c:rearrange_packed_git() should consider packs' object
>  sizes" patch as we now have num_objects = 0 for any indexes we
>  have not opened.  In the case of Dana's patch this would cause
>  those packfiles to have very high ranks, possibly sorting much
>  later than they should have.

I am keeping that rearrange stuff on hold, partly because I am
moderately hesitant to do the fp, which feels overkill at that
low level of code.

Also, I am hoping that we can discard that the object density
criteria altogether by making the default repack behaviour
friendlier to the pathological cases, e.g. by emitting huge
blobs at the end of the packstream, potentially pushing it out
to later parts of split packs by themselves and automatically
marking them with the .keep flag.  Until that kind of
improvements materialize, people with pathological cases could
(1) handcraft a pack that contains only megablob, (2) place that
on central alternate, (3) touch it with artificially old
timestamp, which hopefully is a good enough workaround.
