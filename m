From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] remote show: fix the -n option
Date: Mon, 09 Jun 2008 18:10:49 -0700
Message-ID: <7vd4mqdrhi.fsf@gitster.siamese.dyndns.org>
References: <484B2DD3.8050307@free.fr>
 <1212927772-10006-1-git-send-email-dkr+ml.git@free.fr>
 <7v63sjk6yo.fsf@gitster.siamese.dyndns.org> <484C7CBE.4070700@free.fr>
 <484C7DCC.6080303@free.fr> <484D5322.6050309@free.fr>
 <alpine.DEB.1.00.0806091733230.1783@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Olivier Marin <dkr+ml.git@free.fr>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 10 03:11:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5sOw-0000Jo-1g
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 03:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755177AbYFJBLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 21:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755074AbYFJBLA
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 21:11:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56148 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754934AbYFJBK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 21:10:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1881337F1;
	Mon,  9 Jun 2008 21:10:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2588537EE; Mon,  9 Jun 2008 21:10:52 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0806091733230.1783@racer> (Johannes
 Schindelin's message of "Mon, 9 Jun 2008 17:35:13 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 153FCE74-368A-11DD-A289-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84466>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 9 Jun 2008, Olivier Marin wrote:
>
>> diff --git a/builtin-remote.c b/builtin-remote.c
>> index c49f00f..efe74c7 100644
>> --- a/builtin-remote.c
>> +++ b/builtin-remote.c
>> @@ -421,10 +421,10 @@ static void show_list(const char *title, struct path_list *list)
>>  
>>  static int show_or_prune(int argc, const char **argv, int prune)
>>  {
>> -	int dry_run = 0, result = 0;
>> +	int no_query = 0, result = 0;
>
> Just for the record (not that I think anybody will care): I do not like 
> this change.

I do not think nobody cares ;-).

At least I care enough to point out that I think you are wrong in this
case.  "show -n" in the scripted version was never about "dry-run" but
was about "no-query".

The problem with the area of the code this patch touches is that compared
to the scripted version, show and prune now share their codepaths a bit
more, and it is less easy to keep -n disabled for prune (I think it is a
nonsense because you cannot "prune" sensibly without looking at what the
remote has.  It was a bug in the scripted version and losing it in C
rewrite was a "silent bugfix") while resurrecting -n for show (which is a
quick way to view where the URL points at without bothering to see what
remote branches there are).

I think a sensible thing to do would be to:

 - Agree that "-n" in the sense that "do not query" and "--dry-run" in the
   sense that "do not do anything but report what you would do" are
   different options.

 - Resurrect "show -n" as a quick way to view URLs without bothering to
   contact the remote end that is needed to show "the tracked branches"
   information.

 - Forbid "prune -n", which is nonsense.

 - Make "prune --dry-run" truly useful --- contact the other end, and
   report what will be pruned without really pruning them.

 - Perhaps as an enhancement, "show -n" could show what tracking branches
   we have from the remote, even though the information may be stale.
   The scripted version did not do this, I think, and it would be an
   improvement.

I am CC'ing Shawn who authored 859607d (Teach 'git remote' how to cleanup
stale tracking branches., 2007-02-02) to give him a chance to point out
why I am wrong in saying "prune -n" is nonsense.  Maybe there is a valid
use case for that option, even though I do not see one.
