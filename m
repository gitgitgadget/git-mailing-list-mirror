From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-send-pack SIGSEGV..
Date: Fri, 15 Jun 2007 19:00:24 -0700
Message-ID: <7v7iq47j5z.fsf@assigned-by-dhcp.pobox.com>
References: <alpine.LFD.0.98.0706142124380.14121@woody.linux-foundation.org>
	<7vvedp935y.fsf@assigned-by-dhcp.pobox.com>
	<7vr6od92nj.fsf@assigned-by-dhcp.pobox.com>
	<Pine.LNX.4.64.0706150949300.5848@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Jun 16 04:00:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzNaW-0000fX-42
	for gcvg-git@gmane.org; Sat, 16 Jun 2007 04:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758049AbXFPCA1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 22:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757834AbXFPCA1
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 22:00:27 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:56216 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757466AbXFPCA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2007 22:00:26 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070616020025.FKKB3133.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Fri, 15 Jun 2007 22:00:25 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id C20R1X0011kojtg0000000; Fri, 15 Jun 2007 22:00:25 -0400
In-Reply-To: <Pine.LNX.4.64.0706150949300.5848@iabervon.org> (Daniel
	Barkalow's message of "Fri, 15 Jun 2007 10:27:46 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50284>

Daniel Barkalow <barkalow@iabervon.org> writes:

>> I suspect this has an side effect of allowing
>> 
>> 	fetch = refs/heads/*
>> 
>> to mean the same thing as
>> 
>> 	fetch = refs/heads/*:refs/heads/*
>> 
>> which is suitable for a bare mirroring repository, but I do not
>> think of any downside, so it might be Ok.
>> 
>> But that is something from a person who was under anesthesia a
>> few hours ago, so you should take it with a big grain of salt ;-)
>
> Yeah, that's not right; "push = refs/heads/*" works like that, but 
> "fetch = refs/heads/*" puts them in MERGE_HEAD without storing them 
> anywhere, unlike "fetch = refs/heads/*:refs/heads/*".

While I appreciate the proper fix, I have to say "Wait a minute".

First of all, do you really mean MERGE_HEAD in the above?  My
fix would obviously change the way how "git fetch" would STORE
what was fetched when you have "fetch = refs/heads/*" line in
the configuration file, which is what I already said in my
message.  However, using or not using tracking branches to store
the result should never affect if the fetched object is used in
MERGE_HEAD, so the fix you are responding to should not affect
what goes there at all.  If it does, then there is something
wrong in the current code.

I did not even realize that "push/fetch = $prefix/*" was
allowed.  IIRC, it has always been "$prefix1/*:$prefix2/*" form,
and "$prefix/*" was illegal.  Somehow a change in sematics
sneaked in without me knowing that makes it legal, and the
updated semantics is that for push "$prefix/*" is the same as
listing every ref under the prefix (without any colon, so it
pushes to the same name), and for fetch "$prefix/*" is the same
as $prefix/$x: (i.e. with colon and empty RHS) for all refs
under $prefix.

Now, I am not opposed to _having_ enhanced semantics.  Earlier,
"$prefix/*" was illegal, so it is not like you have introduced
any incompatibility.  On the push side, I do not think of any
sane interpretation for it other than treating it exactly as
"$prefix/*:$prefix/*".  On the fetch side, however, I am not
sure not to use any tracking _and_ grabbing everything is a sane
semantics.  You fetch everything under $prefix/ and list them in
FETCH_HEAD --- now what?  On the other handl, treating it as if
the user wrote "$prefix/*:$prefix/*" makes some sense.  It is a
natural operation to keep a bare mirroring repository up to
date.

But I am somewhat upset about us having the enhanced semantics
without me knowing.  I see two possible reasons for it: (1) I
was not being extra careful when I accepted your patches, and
(2) the change in the semantics were not documented, either in
the log nor Documentation/.

We obviously cannot fix (1) overnight, but could you please at
least fix (2)?  git-push.txt and pull-fetch-param.txt would be
the two places that talk about "$prefix1/*:$prefix2/*", and they
should talk about the new "$prefix/*" syntax as well.

I think "fetch = refs/heads/*" syntax, if it just fetches
without storing, does not make much sense.  In a separate-remote
repository, "[remote "foo"] fetch = refs/heads/*" would probably
be useful if we treated it as "refs/heads/*:refs/remotes/foo/*".
In a bare repository used for mirrors, it would be useful if it
stood for "refs/heads/*:refs/heads/*".
