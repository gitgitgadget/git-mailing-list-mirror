From: Junio C Hamano <junkio@cox.net>
Subject: Re: removing content from git history
Date: Wed, 21 Feb 2007 11:01:55 -0800
Message-ID: <7vy7mrnxlo.fsf@assigned-by-dhcp.cox.net>
References: <20070221164527.GA8513@ginosko.local>
	<Pine.LNX.4.64.0702210904350.4043@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Hendricks <michael@ndrix.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 21 20:02:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJwj2-0004wR-OL
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 20:02:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422795AbXBUTB5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 14:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbXBUTB5
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 14:01:57 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:46082 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbXBUTB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 14:01:56 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070221190155.IBCI2670.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Wed, 21 Feb 2007 14:01:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SK1v1W0091kojtg0000000; Wed, 21 Feb 2007 14:01:55 -0500
In-Reply-To: <Pine.LNX.4.64.0702210904350.4043@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 21 Feb 2007 09:14:44 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40320>

Linus Torvalds <torvalds@linux-foundation.org> writes:

>  - explicit support for "missing objects". We don't do it right now, but 
>    we could add it. It was discussed for things like limited history etc 
>    (the "shallow clone" kind of thing, before people actually added 
>    shallow clones), and it would support the notion of "we export all our 
>    history, but for internal reasons we cannot make certain objects 
>    available" kinds of workflows.
> ...
> But at least in theory, it wouldn't be impossible to extend on the 
> ".git/grafts" kind of setup to say "this object has been consciously 
> deleted", and that could in some circumstances be a better model. The 
> biggest headache there would be the need to extend the native git protocol 
> with a way to add such objects.

While I agree in principle to the argument that there is no
taking it back what's already published, I've heard people
wanting to just stop distributing further, without worrying
about copies already out there.  'missing objects' support would
help us in such a situation.

Supporting 'missing objects' in general would be painful, when
they contain pointers to other objects (i.e. tags, commits, and
trees).

Thinking aloud...

 * missing blob: we can have 'stub blob' objects.  Probably the
   object header for such an object would look like:

	stub <length> NUL
	-----------------
        object <object name of the real blob object>
        type blob

   Hashing a 'stub' object (along with its header as usual, in
   write_sha1_file_prepare()) would instead just report the
   object name recorded there.

   When packing (this applies both to local repacking and
   push/fetch object transfer to other repositories), the stub
   object is included.  delta algorithm would probably not to
   delta other objects with it.

 * missing commit and tag: 'stub object' needs to be extended to
   include these object types, and we would also need 'stub
   commit' and 'stub tag' objects, that copy the structural
   fields from the corresponding true object.  So a stub commit
   would probably look like:

	stub <length> NUL
	-----------------
        object <object name of the real commit object>
        type commit
        tree <object name of the tree contained in the real commit object>
        parent <object name of the first parent in the real commit object>
        parent <object name of the first second in the real commit object>

 * missing tree would only be useful to conceal pathnames
   recorded in the real tree object.  I am not sure if that is
   needed.

 * fsck and verify-pack needs to be taught about 'stub' objects,
   so that they know that their filenames (or the data pointed
   at by pack .idx) do not match the result of hashing them.

If we were to do this, I suspect we can probably do nothing but
'missing blob' first to cover a lot of ground, but we would
eventually need 'missing commit' to replace real commit objects
that has sensitive information in its log message.

As Nico pointed out, this has serious security implications.  We
would need a separate list of objects that are Ok to be stubbed
out, with probably explanation of why they are stubbed out, and
fsck should compare the stub objects found in the repository
against that list.
