From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Silence error messages unless 'thorough_verify' is set
Date: Sun, 10 Jun 2007 01:15:52 -0700
Message-ID: <7vwsyc8bt3.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
	<7vwsydf1m8.fsf@assigned-by-dhcp.cox.net>
	<200706092028.54459.johan@herland.net>
	<200706092142.05446.johan@herland.net>
	<Pine.LNX.4.64.0706100741310.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 10 10:16:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxIae-0001mS-Nn
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 10:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762636AbXFJIP7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 04:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762228AbXFJIP6
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 04:15:58 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:50217 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761973AbXFJIPy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 04:15:54 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070610081553.YNOJ12207.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sun, 10 Jun 2007 04:15:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 9kFt1X0021kojtg0000000; Sun, 10 Jun 2007 04:15:53 -0400
In-Reply-To: <Pine.LNX.4.64.0706100741310.4059@racer.site> (Johannes
	Schindelin's message of "Sun, 10 Jun 2007 07:48:35 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49671>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 9 Jun 2007, Johan Herland wrote:
> ...
>> @@ -80,26 +82,26 @@ int parse_and_verify_tag_buffer(struct tag *item,
>>  	}
>>  
>>  	if (size < 65)
>> -		return error("Tag object failed preliminary size check");
>> +		return FAIL("Tag object failed preliminary size check");
>
> This is ugly.

... quite a bit.  A less uglier alternative we seem to use in
other places is not much better (return NULL on failure or an
error message string on error).

> ...  Guess how surprised 
> _I_ was, when I hit the error message which made me go mad.

To be fair, that ugly "char%d" was taken from mktag and not
Johan's invention.

> To drive that point home: strict checking when creating tags is good. 
> Strict checking when reading tags is bad.
>
> I strongly encourage keeping both validations separate.

While I tend ot think that keeping two separate versions is
probably better for this particular case, the above statement
has a leap in its logic.  With your "error code" scheme, you
could implement a single, verifier/parser that defines the
concrete and complete rule of how the data should look like.
That unified verifier/parser itself should be silent.  Then, you
can have each of the callers decide how lenient it wants to be,
depending on the seriousness of the error.  You can make
producer very strict and chatty while leaving consumer liberal
and more silent.

There are pros-and-cons, however.

 - Such a scheme to return error codes and have two callers that
   have different behaviours is cumbersome to set up and use.

   A good example of this is the switch/case mess in each of the
   callers of run_command_v_opt() in builtin-push.c,
   builtin-revert.c, receive-pack.c etc.  For run_command, the
   mess is justifiable because the function has enough number of
   different callers, but in the current thread, we are only
   talking about two callers (parsing vs verifying of tag
   objects).

 - It has a risk to introduce inconsitent definition of the data
   format to have completely separate producer and consumer
   implementations; this is especially true when the data in
   question is complex.

   However, a tag is sufficiently simple that my personal
   feeling is that, combined with the cumbersomeness argument
   against the unified verifier, separate producer and consumer
   implementations would be easier to manage for this particular
   case.
