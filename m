From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] RESEND: git notes
Date: Sat, 16 May 2009 00:06:02 -0700
Message-ID: <7vpre9plwl.fsf@alter.siamese.dyndns.org>
References: <cover.1242437696.git.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat May 16 09:08:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5E09-00088T-NR
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 09:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753740AbZEPHGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2009 03:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753439AbZEPHGE
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 03:06:04 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:44354 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475AbZEPHGB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 03:06:01 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090516070603.QEYN17135.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sat, 16 May 2009 03:06:03 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id s7621b0014aMwMQ04762fR; Sat, 16 May 2009 03:06:02 -0400
X-Authority-Analysis: v=1.0 c=1 a=CeZos8cfAAAA:8 a=lYBbFc9F5KT3BAmnfAgA:9
 a=zqbvRYSHhEmj4Wq3fUcA:7 a=ArgpONEMRKvKOEn786SNxmcFon0A:4 a=8lZzlOcxvREA:10
X-CM-Score: 0.00
In-Reply-To: <cover.1242437696.git.johan@herland.net> (Johan Herland's message of "Sat\, 16 May 2009 03\:45\:03 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119338>

Johan Herland <johan@herland.net> writes:

> The following is a re-roll and resend of the patch series currently
> in pu, plus my own 2 patches for adding support for "-m" and "-F" to
> "git notes edit".
>
> On advice from Dscho, I have squashed the current bugfix and cleanup
> patches in js/notes into the first 4 "main" patches. As a result the
> original 15 + 2 patch series is now down to 5 (4 + 1) patches.
>
> In sum, these 5 patches produce the exact same result as the original
> js/notes series (plus my 2 patches).

Thanks, but you did no such thing, actually.

The result from this sequence

	git checkout -b jh/notes v1.6.3.1^0
        git am ./+jh-notes.mbox ;# these patches
	git checkout v1.6.3.1^0
        git merge js/notes ;# allow rerere to reapply the resolution
        git diff -R jh/notes^

should be empty, or should show your improvements over what has been
queued in 'pu'.

Here is what I see:

    diff --git b/git-notes.sh a/git-notes.sh
    index 6ec33c9..7c3b8b9 100755
    --- b/git-notes.sh
    +++ a/git-notes.sh
    @@ -20,15 +20,16 @@ edit)
                    die "Refusing to edit notes in $GIT_NOTES_REF (outside of refs/notes/)"
            fi

    -	MESSAGE="$GIT_DIR"/new-notes-$COMMIT
    +	MSG_FILE="$GIT_DIR/new-notes-$COMMIT"
    +	GIT_INDEX_FILE="MSG_FILE.idx"

Renaming of the variable MESSAGE to MSG_FILE may be an improvement, as the
former could have puzzled the reader if $MESSAGE contains the message
itself, or it has the name of a file that stores the message (the answer
is latter).

But I think there is a regression with a missing '$' here.  

    +	export GIT_INDEX_FILE
    +
            trap '
    -		test -f "$MESSAGE" && rm "$MESSAGE"
    +		test -f "$MSG_FILE" && rm "$MSG_FILE"
    +		test -f "$GIT_INDEX_FILE" && rm "$GIT_INDEX_FILE"
            ' 0

Another improvement is that the variable definitions were moved up before
the trap that uses these definitions.  This is a good change.

    -	GIT_NOTES_REF= git log -1 $COMMIT | sed "s/^/#/" > "$MESSAGE"
    -
    -	GIT_INDEX_FILE="$MESSAGE".idx
    -	export GIT_INDEX_FILE
    +	git log -1 $COMMIT | sed "s/^/#/" > "$MSG_FILE"

Dscho's version exports an empty GIT_NOTES_REF, presumably to avoid
triggering the notes mechanism, while running this "git log -1", but yours
don't.  Is there a reason behind this change?

The rest are fallouts from s/MESSAGE/MSG_FILE/ renaming.

    @@ -36,16 +37,16 @@ edit)
            else
                    PARENT="-p $CURRENT_HEAD"
                    git read-tree "$GIT_NOTES_REF" || die "Could not read index"
    -		git cat-file blob :$COMMIT >> "$MESSAGE" 2> /dev/null
    +		git cat-file blob :$COMMIT >> "$MSG_FILE" 2> /dev/null
            fi

            core_editor="$(git config core.editor)"
    -	${GIT_EDITOR:-${core_editor:-${VISUAL:-${EDITOR:-vi}}}} "$MESSAGE"
    +	${GIT_EDITOR:-${core_editor:-${VISUAL:-${EDITOR:-vi}}}} "$MSG_FILE"

    -	grep -v ^# < "$MESSAGE" | git stripspace > "$MESSAGE".processed
    -	mv "$MESSAGE".processed "$MESSAGE"
    -	if [ -s "$MESSAGE" ]; then
    -		BLOB=$(git hash-object -w "$MESSAGE") ||
    +	grep -v ^# < "$MSG_FILE" | git stripspace > "$MSG_FILE".processed
    +	mv "$MSG_FILE".processed "$MSG_FILE"
    +	if [ -s "$MSG_FILE" ]; then
    +		BLOB=$(git hash-object -w "$MSG_FILE") ||
                            die "Could not write into object database"
                    git update-index --add --cacheinfo 0644 $BLOB $COMMIT ||
                            die "Could not write index"

I am a bit reluctant to take this to replace js/notes as-is until I hear
answers to these points (and others may have comments too).
