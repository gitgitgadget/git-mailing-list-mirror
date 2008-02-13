From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH updated] Add "--dirstat" for some directory statistics
Date: Tue, 12 Feb 2008 17:27:49 -0800
Message-ID: <7vbq6lzluy.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0802121308360.2920@woody.linux-foundation.org>
 <alpine.LFD.1.00.0802121346560.2920@woody.linux-foundation.org>
 <7v1w7h1xs1.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0802121701310.2920@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 13 02:29:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP6Qr-0007TP-I0
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 02:29:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756276AbYBMB2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 20:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765302AbYBMB2a
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 20:28:30 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62420 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765633AbYBMB22 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 20:28:28 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C1ABB358E;
	Tue, 12 Feb 2008 20:28:21 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 A42393584; Tue, 12 Feb 2008 20:27:57 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0802121701310.2920@woody.linux-foundation.org>
 (Linus Torvalds's message of "Tue, 12 Feb 2008 17:10:04 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73731>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 12 Feb 2008, Junio C Hamano wrote:
>> 
>> You can drop the "line count" idea and instead count the "amount
>> of damage" done to the preimage, just like we do in the rename
>> similarity computation.
>> 
>> The attached patch is just an outline.  There may need special
>> cases for unmerged paths.
>
> Ouch. I like the concept and the result, but an not a huge fan of the the 
> implementation. The problem with this is that it makes the whole damage 
> computation something separate from the earlier phases.
>
> So it actually seems to add a lot of cost. Right now there is basically 
> zero added cost to just adding a "--dirstat" to one of my common 
> operations, which is
>
> 	git diff -M --stat --summary
>
> (that's what I do on merges). 
>
> Wouldn't it be nicer to merge it with one of the stages we did earlier by 
> simply saving the data. If not the --stat phase, then the -M phase? 

We could add one ulong to diff_filepair struct to record
"damage", and populate it inside diffcore_rename().

Obviously:

 - You would need to diffcore_count_changes() in separate phase
   if you do not use -M;

 - Even if you use -M, we do not run diffcore_count_changes()
   for unrenamed paths during diffcore_rename(), so you would
   need to do that separately.

By the way, if you run "git diff --summary --dirstat -M" (that
is, without --stat), we will not have to run diffstat at all.
Instead, we only run diffcore_count_changes(), which can be
reused for renamed paths if we keep it in diff_filepair struct.
