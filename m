From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [TESTCASE] Failing 'git am' when core.autocrlf=true
Date: Thu, 23 Aug 2007 12:44:37 -0700
Message-ID: <7vabsit4re.fsf@gitster.siamese.dyndns.org>
References: <46CD94AB.7070709@trolltech.com>
	<alpine.LFD.0.999.0708230956190.30176@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708231153150.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 23 21:44:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOIbo-0007Dw-SY
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 21:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbXHWTop (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 15:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752307AbXHWTop
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 15:44:45 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:40063 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560AbXHWTop (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 15:44:45 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 831F3126FED;
	Thu, 23 Aug 2007 15:45:01 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.999.0708231153150.30176@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 23 Aug 2007 12:23:39 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56520>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> And the reason is really interesting: it only happens if the index file 
> has the same date as the entry in the index, in which case we end up doign 
> the "careful" check in ce_smudge_racily_clean_entry() and there the 
> "ce_modified_check_fs()" will end up re-reading the file, and if we don't 
> have the right CRLF behaviour, we will now return DATA_CHANGED.
>
> So the call-chain for this is:
>
> 	cmd_write_tree ->
> 	  write_tree ->
> 	    write_index ->
> 	      ce_smudge_racily_clean_entry -> 
> 		ce_modified_check_fs ->
> 		  ce_compare_data ->
> 		    index_fd ->
> 		      convert_to_git ->
> 			** wrong answer unless auto_crlf is set **
>
> 		and now "ce_smudge_racily_clean_entry()" will do
> 			ce->ce_size = htonl(0);
>
> and the one-liner fix I sent out is actually the right fix.
>
> This was harder to find than it should have been, because it actually 
> depends on the datestamp of the index file matching the datestamp of the 
> file in question!

Ahhhh, I forgot that we made write-tree to write back into index
because at that point we have a fully populated cache-tree.

Your analysis makes sense to me.  Thanks.
