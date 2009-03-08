From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http: add_fill_function checks if function has been
 added
Date: Sun, 08 Mar 2009 12:38:45 -0700
Message-ID: <7vd4crls8q.fsf@gitster.siamese.dyndns.org>
References: <49B266B0.4020304@gmail.com>
 <7vy6vhm6it.fsf@gitster.siamese.dyndns.org>
 <be6fef0d0903071249s42ac7f94o82461ca32dcdfcd5@mail.gmail.com>
 <7vd4ctm29m.fsf@gitster.siamese.dyndns.org>
 <be6fef0d0903080327u551c0b4mcb86f2ba76473efc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 20:43:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgOua-0006CI-RG
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 20:43:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753188AbZCHTiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 15:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753071AbZCHTix
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 15:38:53 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47803 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908AbZCHTix (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 15:38:53 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BD65A47CC;
	Sun,  8 Mar 2009 15:38:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 13A5C47CB; Sun, 
 8 Mar 2009 15:38:47 -0400 (EDT)
In-Reply-To: <be6fef0d0903080327u551c0b4mcb86f2ba76473efc@mail.gmail.com>
 (Tay Ray Chuan's message of "Sun, 8 Mar 2009 18:27:17 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BFFFECCC-0C18-11DE-91E5-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112633>

Tay Ray Chuan <rctay89@gmail.com> writes:

> In the current use instances in http-push and http-walker,
> run_active_slot and finish_all_active_slots (which calls
> run_active_slot) will always be called, because they are the functions
> that actually start the http requests[1], and that means the fill
> functions will be called repeated, because
>
> run_active_slot, in its while loop, repeatedly calls
>   step_active_slots calls
>     fill_active_slots calls
>       our fill functions.

That is not what I was worried about.  There are two callsites to
add_fill_function().

http-push.c:2439:		add_fill_function(NULL, fill_active_slot);
http-walker.c:936:	add_fill_function(walker, (int (*)(void *)) fill_active_slot);

The caller in http-push.c always passes NULL as the callback data for the
fill_active_slot callback, which means that the callback function, as long
as it does not depend on the state other than the callback function
parameter (which is always NULL), will do the same thing whether you queue
it only once or as many times as add_fill_function() was called, which the
improvement your patch brings in.

But it is not immediately obvious in http-walker.c callchain if multiple
calls to add_fill_function(), if they were ever made, give the same
"walker" as the callback data.  Your patch only looks at the function but
not the callback data for its filtering.  Doesn't it mean that if a caller
made two calls to add_fill_function() with walker#1 and then walker#2 as
the callback data, you would discard the request for walker#2 and call the
callback function fill_active_slot() with walker#1 inside run_active_slot
repeatedly, without ever calling it for walker#2?

I do not know if that actually happens in the current http-walker.c
codepath, or the caller _happens to_ call the add_fill_function() only
once and making my worry a non-issue, but as a patch submitter, you would
know the answer to the question.

If it is the former, then your change is introducing a bug. If it is the
latter, your change won't break anything immediately, but still introduces
a potential bug waiting to happen, as the API looks as if you can call
add_fill_function() to ask for callback functions to be called with
different callback data and the caller can rely on both of them to be
called at appropriate times, but in reality that guarantee does not hold.
