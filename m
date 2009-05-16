From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 0/5] RESEND: git notes
Date: Sat, 16 May 2009 13:20:45 +0200
Message-ID: <200905161320.45426.johan@herland.net>
References: <cover.1242437696.git.johan@herland.net>
 <7vpre9plwl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 16 13:24:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5Hzu-0006lg-EE
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 13:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753812AbZEPLVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2009 07:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753290AbZEPLVv
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 07:21:51 -0400
Received: from mx.getmail.no ([84.208.15.66]:61040 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753262AbZEPLVu (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 May 2009 07:21:50 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KJQ00M6ZI8EB920@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 16 May 2009 13:21:50 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KJQ000VXI6LKT90@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 16 May 2009 13:21:50 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.5.16.110423
User-Agent: KMail/1.11.3 (Linux/2.6.29-ARCH; KDE/4.2.3; x86_64; ; )
In-reply-to: <7vpre9plwl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119354>

On Saturday 16 May 2009, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > In sum, these 5 patches produce the exact same result as the original
> > js/notes series (plus my 2 patches).
>
> Thanks, but you did no such thing, actually.
>
> The result from this sequence
>
> 	git checkout -b jh/notes v1.6.3.1^0
>         git am ./+jh-notes.mbox ;# these patches
> 	git checkout v1.6.3.1^0
>         git merge js/notes ;# allow rerere to reapply the resolution
>         git diff -R jh/notes^
>
> should be empty, or should show your improvements over what has been
> queued in 'pu'.

Sorry for the screwup. The diff should in any case not be empty, since
the first patch (the cleanup/bugfix part) of my original 2 patches
(which are NOT in js/notes on 'pu') has been squashed into the first 4
patches of this new series.

Therefore, the diff you quote below is simply this first patch from my
original two-part series (the second patch of that series is now the
5th patch in this series - adding '-m' and '-F' support to 'git notes
edit').

> Here is what I see:
>
>     diff --git b/git-notes.sh a/git-notes.sh
>     index 6ec33c9..7c3b8b9 100755
>     --- b/git-notes.sh
>     +++ a/git-notes.sh
>     @@ -20,15 +20,16 @@ edit)
>                     die "Refusing to edit notes in $GIT_NOTES_REF (outside of refs/notes/)" fi
>
>     -	MESSAGE="$GIT_DIR"/new-notes-$COMMIT
>     +	MSG_FILE="$GIT_DIR/new-notes-$COMMIT"
>     +	GIT_INDEX_FILE="MSG_FILE.idx"
>
> Renaming of the variable MESSAGE to MSG_FILE may be an improvement, as
> the former could have puzzled the reader if $MESSAGE contains the message
> itself, or it has the name of a file that stores the message (the answer
> is latter).

Indeed. If you look at the next patch (adding support for '-m' and
'-F'), you will see that I reuse $MESSAGE to hold the _actual_ message
(given by '-m' or '-F').

> But I think there is a regression with a missing '$' here.

Yes. Thanks for catching.

>     +	export GIT_INDEX_FILE
>     +
>             trap '
>     -		test -f "$MESSAGE" && rm "$MESSAGE"
>     +		test -f "$MSG_FILE" && rm "$MSG_FILE"
>     +		test -f "$GIT_INDEX_FILE" && rm "$GIT_INDEX_FILE"
>             ' 0
>
> Another improvement is that the variable definitions were moved up before
> the trap that uses these definitions.  This is a good change.
>
>     -	GIT_NOTES_REF= git log -1 $COMMIT | sed "s/^/#/" > "$MESSAGE"
>     -
>     -	GIT_INDEX_FILE="$MESSAGE".idx
>     -	export GIT_INDEX_FILE
>     +	git log -1 $COMMIT | sed "s/^/#/" > "$MSG_FILE"
>
> Dscho's version exports an empty GIT_NOTES_REF, presumably to avoid
> triggering the notes mechanism, while running this "git log -1", but
> yours don't.  Is there a reason behind this change?

Oh, so _that's_ what he did... I was puzzled by that "stray"
'GIT_NOTES_REF= '...

Yet another screwup on my part.

> The rest are fallouts from s/MESSAGE/MSG_FILE/ renaming.
>
>     @@ -36,16 +37,16 @@ edit)
>             else
>                     PARENT="-p $CURRENT_HEAD"
>                     git read-tree "$GIT_NOTES_REF" || die "Could not read index"
>     -		git cat-file blob :$COMMIT >> "$MESSAGE" 2> /dev/null
>     +		git cat-file blob :$COMMIT >> "$MSG_FILE" 2> /dev/null
>             fi
>
>             core_editor="$(git config core.editor)"
>     -	${GIT_EDITOR:-${core_editor:-${VISUAL:-${EDITOR:-vi}}}} "$MESSAGE"
>     +	${GIT_EDITOR:-${core_editor:-${VISUAL:-${EDITOR:-vi}}}} "$MSG_FILE"
>
>     -	grep -v ^# < "$MESSAGE" | git stripspace > "$MESSAGE".processed
>     -	mv "$MESSAGE".processed "$MESSAGE"
>     -	if [ -s "$MESSAGE" ]; then
>     -		BLOB=$(git hash-object -w "$MESSAGE") ||
>     +	grep -v ^# < "$MSG_FILE" | git stripspace > "$MSG_FILE".processed
>     +	mv "$MSG_FILE".processed "$MSG_FILE"
>     +	if [ -s "$MSG_FILE" ]; then
>     +		BLOB=$(git hash-object -w "$MSG_FILE") ||
>       		die "Could not write into object database"
>       	git update-index --add --cacheinfo 0644 $BLOB $COMMIT ||
>       		die "Could not write index"
>
> I am a bit reluctant to take this to replace js/notes as-is until I hear
> answers to these points (and others may have comments too).

Thanks for the review.
I will send an updated series with the above fixes.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
