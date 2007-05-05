From: Yann Dirson <ydirson@altern.org>
Subject: Re: [RFC PATCH] Rename "bury" back to "sink".
Date: Sat, 5 May 2007 22:13:07 +0200
Message-ID: <20070505201307.GE19253@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070504224639.26133.6157.stgit@gandelf.nowhere.earth> <f1gf8i$p52$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>,
	Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 22:13:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkQdf-000437-9Y
	for gcvg-git@gmane.org; Sat, 05 May 2007 22:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933305AbXEEUNw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 16:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933306AbXEEUNw
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 16:13:52 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:40867 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933305AbXEEUNv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2007 16:13:51 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 69BEC5ECF9;
	Sat,  5 May 2007 22:13:50 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 2D1142006; Sat,  5 May 2007 22:13:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <f1gf8i$p52$1@sea.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46283>

The whole debate around burying, sinking and floating patches made me
think a bit more about this.  So we have:

float:		move specified patches to top of stack
bury/float:	move specified patches to bottom of stack or any place
		in the stack identified by a nearby patch

All in all, that all "move specified patches to a specified place".
So wouldn't it be possible to end the debate by merging those commands
into a single "stg move" command ?

Side note about the "stg move" name: yes it could possible to mistake it
for "move file" (especially as we don't have "stg mv").  My current
state of mind would be to drop add/rm/cp from stgit, and move the "stg
cp" logic to a new git-cp command.  This way, stgit would just be
about handling series of patches, with git being used for the
working-copy.  Any opinions on this ?

Now to the new command.  We could have something like:

 stg move -t base <patches>	<=> stg sink <patches>
 stg move -t <patch> <patches>	<=> stg sink -t <patch> <patches>
 stg move -t current <patches>	<=> stg float <patches>

Note the introduction of a new "curent" stg_id for the tip of the
stack.

The semantics of the arg to -t would be something like "the limit
between the patches that will end up below <patches> and those that
will end up above".  I suppose "-t current" should be the default, so
it may not even be necessary to expose "current" to the command-line.

The "conceptual algorithm" would be:
 1. stg pop <patches>
 2. stg push <patches>
 3. stg goto "where I was"

"-s [<series>]" would be allowed as an alternative to <patches>, so
"move" would be a strict superset of "float".

By default, consistently with "float", the <patches> (and hence
everything originally under the target point) will end up applied if
the target of the move was "within $applied" (ie. an applied patch or
"current" - something we could call "below the surface", hi float and
sink ;), and all patches that were applied (ie. those between the
target and the former tip) will end up being reapplied, consistently
with "sink".

If the target point is in $unapplied, then the command will be
equivalent to "stg pop <patches>" with those patches reordered at the
target (ie. no need to really execute steps 2 and 3 above).  That's no
rocket science, but a useful I have already missed, eg. when I just
want to move the patches away from my working set (nowadays we could
hide them, but that may not be always adequate).

A --dont-come-back flag of some sort will skip step 3 of the
conceptual algorithm above.  When the target will be in $applied, it
will be the equivalent of "sink --nopush".  When the target is in
$unapplied, we will "goto <last of <patches>>" after reorering the
unapplied patches.  Never missed this one till now, but who knows,
this side-effect might come handy.

Opinions ?
-- 
Yann.

PS: this RFC is known as "bury sink and float" ;)
