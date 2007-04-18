From: Junio C Hamano <junkio@cox.net>
Subject: Re: [BUG] git-new-workdir doesn't understand packed refs
Date: Wed, 18 Apr 2007 14:31:29 -0700
Message-ID: <7v4pndfjym.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704172253140.14155@beast.quantumfyre.co.uk>
	<20070418055215.GA32634@xp.machine.xx>
	<7v7isajfl1.fsf@assigned-by-dhcp.cox.net>
	<20070418081122.GB32634@xp.machine.xx>
	<Pine.LNX.4.64.0704181251040.19261@reaper.quantumfyre.co.uk>
	<7vfy6xird9.fsf@assigned-by-dhcp.cox.net>
	<20070418174350.GB5913@xp.machine.xx>
	<7vlkgph7i0.fsf@assigned-by-dhcp.cox.net>
	<20070418183156.GF5913@xp.machine.xx>
	<7v647th6cv.fsf@assigned-by-dhcp.cox.net>
	<20070418210819.GG5913@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 18 23:31:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeHkV-0007dr-04
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 23:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992763AbXDRVbb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 17:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992796AbXDRVbb
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 17:31:31 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:37100 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992792AbXDRVba (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 17:31:30 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070418213128.MMCR1266.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 18 Apr 2007 17:31:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id olXV1W00f1kojtg0000000; Wed, 18 Apr 2007 17:31:29 -0400
cc: Julian Phillips <julian@quantumfyre.co.uk>
In-Reply-To: <20070418210819.GG5913@xp.machine.xx> (Peter Baumann's message of
	"Wed, 18 Apr 2007 23:08:20 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44952>

Peter Baumann <waste.manager@gmx.de> writes:

> On Wed, Apr 18, 2007 at 11:42:24AM -0700, Junio C Hamano wrote:
>> Peter Baumann <waste.manager@gmx.de> writes:
>> 
>> <ot>
>> 
>> Getting more and more annoyed by your stupid Mail-Followup-To...
>> I do *not* want to bother Julian with a message that points out
>> a flaw (in my opinion) in YOUR reasoning but you are forcing me
>> to send my message that way, which I have to waste time
>> correcting every time.  Grumble.
>> 
>> </ot>
>
> Hm. Sorry. I don't understand. I'm just pressing 'g' for group reply in
> mutt which should do the right thing; even your mail has a CC to Julian
> set so I _really_ don't understand the problem. I addressed him in the
> begining because he was the author of git-new-workdir. But please
> forgive me if I'm breaking some netiquette rules but I just started to
> hang out activly on mailinglists ...

Because you had Mail-Followup-To: set to point at me and Julian,
when I say "followup", by default I get this in my MUA:

    To: Julian Phillips <julian@quantumfyre.co.uk>
    Cc: git@vger.kernel.org
    Subject: Re: [BUG] git-new-workdir doesn't understand packed refs

Many people prioritize their e-mails depending on where in the
header their name appears (ones that have you on Cc: typically
gets lower priority than the ones addressed specifically to you
by having you on To: line), and if Julian is doing that, sending
my message in which I want to talk to YOU that way would steal
from Julian's time.  So as a general netiquette, I end up hand
fixing it, putting you on To: and demoting Julian to Cc:.

I know why you (or some version of mutt) do so.  It saves you
from filtering incoming duplicates (one addressed to you,
another addressed to the mailing list you subscribe to), but it
is a misfeature.

Anyhow...

>> Also, how is the above different from this?
>> 
>> 	git init a
>>         cd a ; git gc ; cd ..	# allowed
>> 	git new-workdir a b
>> 	cd b ; git gc ; cd ..	# NOT ALLOWED
>> 
>
> Sorry, you lost me here. Your above sequence _is_ allowed and that was
> just the point of the patch. I lightly tested it that it does the right
> thing, so perhaps I'm missing something?

What I was getting at was that if you do not allow new-workdir
to be done off of a symlinked one, that was like not allowing gc
in a symlinked one.  Both are limitations we _could_ lift.  But
I'd like to take that back, because...

> This is even dissallowed by the code in git-new-workdir (Sorry, I just
> saw it now; otherwise I wouldn't spend so much time in arguing this)):
>
> # don't link to a workdir
> if test -L "$orig_git/.git/config"
> then
>         die "\"$orig_git\" is a working directory only, please specify" \
>                 "a complete repository."
> fi

... I missed this one.  People cannot make a symlinked one off
of another by using new-workdir script, which means perhaps
something like this on top of your patch would be safe enough.
Sorry for the confusion.

> But with my patch it just works! I really tested it again. The link
> in b/.git/packed-refs -> a/.git/packed-refs (using the example from above)
> isn't broken up and in the new generated packed-refs are stored inside
> the repo a (as they should).

Oh, I never questioned that you made that basic case work.  I
was worried about not making sure the symlink we are looking at
really is the case we are willing to handle, and not erroring
out if that is not the case, perhaps like the attached patch on
top of yours.

An additional test or two in t/t3210 would be nice to accompany
this change.


diff --git a/builtin-pack-refs.c b/builtin-pack-refs.c
index afa9b5a..1ce4f55 100644
--- a/builtin-pack-refs.c
+++ b/builtin-pack-refs.c
@@ -123,6 +123,9 @@ int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 			die("readlink failed\n");
 		}
 		buf[st.st_size] = '\0';
+		if (!lstat(buf, &st) && S_ISLNK(st.st_mode))
+			die("cannot have doubly symlinked packed-refs file: %s",
+			    ref_file_name);
 		ref_file_name = buf;
 	}
 
