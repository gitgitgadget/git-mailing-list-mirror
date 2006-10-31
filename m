X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problem with git-push
Date: Tue, 31 Oct 2006 15:39:31 -0800
Message-ID: <7v64e0qclo.fsf@assigned-by-dhcp.cox.net>
References: <1162306098.41547.4.camel@mayday.esat.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 31 Oct 2006 23:40:21 +0000 (UTC)
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <1162306098.41547.4.camel@mayday.esat.net> (Florent Thoumie's
	message of "Tue, 31 Oct 2006 14:48:18 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30605>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gf3DE-0001gp-UA for gcvg-git@gmane.org; Wed, 01 Nov
 2006 00:40:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423857AbWJaXje (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 18:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423863AbWJaXje
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 18:39:34 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:27563 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S1423857AbWJaXjd
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 18:39:33 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061031233932.WFQL18985.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>; Tue, 31
 Oct 2006 18:39:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id hBfc1V00S1kojtg0000000 Tue, 31 Oct 2006
 18:39:37 -0500
To: Florent Thoumie <flz@xbsd.org>
Sender: git-owner@vger.kernel.org

Florent Thoumie <flz@xbsd.org> writes:

> I'm having some weird issues with git-push lately (1.4.1 on both ends):

Bear with some basic questions.

 - "lately" means this used to work with earlier git on the same
   machine with same configurations?

 - the three runs seem to be pushing the same ref to the same
   repository.  Did you want to illustrate that it fails upon
   writing out different objects and eventually succeeds?

 - what operating system and what filesystem?

 - are you working with a shared repository?

> : flz@cream:/tinderbox/portstrees/xorg-modular/ports; git push
> updating 'refs/heads/xorg'
>   from 6d1e4fce0a22da799175ec8e168dc0767f1131ef
>   to   496cbd4c75220c204aac4fd1ef9912e40e0314b2
> Generating pack...
> Done counting 16 objects.
> Result has 11 objects.
> Deltifying 11 objects.
>  100% (11/11) done
> Total 11, written 11 (delta 4), reused 0 (delta 0)
> Unpacking 11 objects
> unpack unpacker exited with error code
> ng refs/heads/xorg n/a (unpacker error)
> unable to write sha1 filename ./objects/2d: Is a directory
> fatal: failed to write object

This message comes from sha1_file.c::move_temp_to_file().  The
unpacker wrote the object whose name begins with 2d in a
temporary file .git/obj_XXXXXX by calling write_sha1_file(),
which in turn calls move_temp_to_file() to move it to its final
destination ".git/objects/2d/XXXXXX".

move_temp_to_file() first tries to make a hardlink in
.git/objects/2d/ directory, assuming that most of the time you
already have it.  If it succeeds, then it runs unlink() on the
temporary file ".git/obj_XXXXXX".  But taht is not what is
happening.

link_temp_to_file() function first tries to make a hardlink with
link(".git/obj_XXXXXX", ".git/objects/2d/XXXXXX").  This call
must be failing for you.  Then it tries to create the leading
directory ".git/objects/2d", and does adjust_shared_perm and
when it fails it returns (but forgets to restore the slash it
removed earlier -- a patch to fix this is attached at the end).

This explains why the final filename is truncated at the last
slash, hence ./objects/2d in the error message.  Also it
explains why repeated tries would succeed; the first run creates
.git/objects/2d/ directory so the second run will try hardlink
and will succeed.

So the next thing to see is why adjust_shared_perm() is failing
for you.

Oops.

I think this function is broken at the concept level.  This is
to work around people's broken umask (when you are working with
other people, your umask should not be stronger than 007) and
tries to flip group writability bit on.

First of all, if the necessary bits are already on, it is not
necessary to run chmod(), but more importantly, if the directory
in question was created by somebody else, I do not think this
chmod() would succeed even if you are in the same group as the
owner (i.e. previous creator) of the directory.

[jc: I am CC'ing Johannes to blame him on commit 457f06d6;
git-pickaxe is turning out to be quite handy ;-)

	git pickaxe -C -f L246,277 v1.4.1 -- path.c

]

A quick workaround until we sort this out would be:

 - make sure all your developers have umask suitable for group
   work (i.e. second octal-digit from the right should be zero
   to give group members the same rights as you do).

 - run "chmod g+w .git/objects/??" in the shared repository.

-- >8 --

diff --git a/sha1_file.c b/sha1_file.c
index e89d24c..5707069 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1400,8 +1400,10 @@ static int link_temp_to_file(const char
 	if (dir) {
 		*dir = 0;
 		mkdir(filename, 0777);
-		if (adjust_shared_perm(filename))
+		if (adjust_shared_perm(filename)) {
+			*dir = '/';
 			return -2;
+		}
 		*dir = '/';
 		if (!link(tmpfile, filename))
 			return 0;
