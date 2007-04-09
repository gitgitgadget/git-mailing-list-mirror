From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/8] get-repack --max-pack-size: write_object() takes 'limit' arg
Date: Sun, 08 Apr 2007 17:15:32 -0700
Message-ID: <7vr6qu768r.fsf@assigned-by-dhcp.cox.net>
References: <46197994.70009@gmail.com>
	<7v4pnq8ld4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 09 02:15:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HahXm-0001k8-35
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 02:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbXDIAPe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Apr 2007 20:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752109AbXDIAPe
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Apr 2007 20:15:34 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:50728 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041AbXDIAPd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2007 20:15:33 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070409001532.RHUR1606.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 8 Apr 2007 20:15:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id koFY1W00R1kojtg0000000; Sun, 08 Apr 2007 20:15:33 -0400
In-Reply-To: <7v4pnq8ld4.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 08 Apr 2007 17:03:35 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44022>

Junio C Hamano <junkio@cox.net> writes:

> Dana How <danahow@gmail.com> writes:
>
>> Accept new 'limit' argument and check against it
>> before each group of writes.  Update delta usability rules
>> for possibility of delta base being in a previously-
>> written pack. Inline sha1write_compressed() so we know
>> the exact size of the written data when it needs to be compressed.
>>
>> Signed-off-by: Dana How <how@deathvalley.cswitch.com>
>
> My first reaction of open-coding sha1write_compressed() was
> "Ugh", but as you are removing the only user of that function,
> maybe this is not as bad as it looks.

Having said that, I suspect that for other possible users of
that function we might have later, it would be a better
interface to add an optional 'limit' and 'prelude' to
sha1write_compressed().  The function would write prelude
followed by the compressed payload, only if they fit the limit.

Then your write_object() would prepare the header (depending on
the type, the object header, ofs-delta header or ref-delta
header) in header[] but would not cal sha1write() itself.
Instead it would send header[] in as prelude, *buf as the
payload, with an appropriate limit.
