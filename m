From: Owen Taylor <otaylor@redhat.com>
Subject: git push --confirm ?
Date: Sat, 12 Sep 2009 13:51:37 -0400
Message-ID: <1252777897.2974.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-piiZj9msrj51zxTF9WeV"
Cc: Colin Walters <walters@verbum.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 12 19:51:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmWlL-00083a-Ia
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 19:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753798AbZILRvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 13:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753692AbZILRvh
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 13:51:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:65006 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753553AbZILRvg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 13:51:36 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n8CHpdMQ028543;
	Sat, 12 Sep 2009 13:51:39 -0400
Received: from [127.0.0.1] (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id n8CHpcSI027480;
	Sat, 12 Sep 2009 13:51:38 -0400
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128273>


--=-piiZj9msrj51zxTF9WeV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

People sometimes push things they don't mean to. Depending on the
workflow and environment, that can be anywhere between a trivial
nuisance to an embarrassing and awkward cleanup.

It would seem handy to me to have a --confirm option to git-push
(and 'core.confirm-push' to turn it on be default), that would
have the following behavior:

 * An initial --dry-run pass is done but with more verbosity -
   for updates of existing references, it would show what commits
   were being added or removed in a one-line format.

 * The user is prompted if they want to proceed
 
 * If the user agrees, then the push is run without --dry-run

I've attached a mockup of this as a porcelain 'git safe-push'.

(Done not using 'git push --porcelain' because I wanted it to work
with existing released Git versions. I was hoping to be able to do 
'git config alias.push safe-push', but no facility for interactive 
only aliases...)

I think this wouldn't be too hard to add to 'git push', though
I haven't tried to code it. Yes, it's not atomic without protocol
changes - I think that's OK:

 - If the push isn't being forced intermediate ref updates will
   be caught as a non-fast-forward in the second pass.

 - If the push is being forced, you might overwrite someone else's
   push anyways even without --confirm.

Thoughts on whether this makes sense as an addition?

- Owen


--=-piiZj9msrj51zxTF9WeV
Content-Disposition: attachment; filename="git-safe-push"
Content-Type: application/x-shellscript; name="git-safe-push"
Content-Transfer-Encoding: 7bit

#!/bin/sh

SUBDIRECTORY_OK=Yes
OPTIONS_SPEC="\
git safe-push [options] [<repository> <refspec>...]

git safe-push is exactly like git push, but the user is asked to
confirm before the push is run. (By default, can be disabled with
--no-confirm, or 'git config core.confirm-push false'.)
--
v,verbose           be verbose
repo=               repository
all                 push all refs
mirror              mirror all refs
tags                push tags
dry-run             dry run
f,force             force updates
thin                use thin pack
receive-pack=       receive pack program
exec=               receive pack program
confirm             confirm ask before pushing
"
. git-sh-setup

confirm=`git config --bool core.confirm-push || echo true`

first=true
for x in "$@" ; do
    case "$x" in
        --confirm)    confirm=true ;;
        --no-confirm) confirm=false ;;
	*)
	    if $first ; then
                set -- "$x"
		first=false
            else
		set -- "$@" "$x"
            fi
	    ;;
    esac
done

$confirm || exec git push "$@"

git push --dry-run "$@" 2>&1 |
(
    IFS=''
    have_changes=false
    while read line ; do
	echo "$line" | (
            unset IFS
	    # 'summary' is only the summary for a successful update - no flag. It
	    # could also end up as the flag (!*=) or as a random word
	    read summary from arrow to
    	    case $summary in
	    	 "*" | -) echo "$line" >&2 ; exit 0 ;; # new or deleted
	  	 [a-f0-9][a-f0-9][a-f0-9]*[a-f0-9]..[a-f0-9][a-f0-9][a-f0-9]*[a-f0-9] |\
	  	 [a-f0-9][a-f0-9][a-f0-9]*[a-f0-9]...[a-f0-9][a-f0-9][a-f0-9]*[a-f0-9]) ;;
		     # Succesful updated, ... used for non-fastforward updated
		 *) echo "$line" >&2 ; exit 1 ;;
	    esac
	    old=`echo $summary | sed 's/\.\+.*//'`;
	    new=`echo $summary | sed 's/[^.]*\.\+//'`;

	    echo >&2 "Updating remote reference '$to' from $old to $new (local '$from')"

	    old=`git rev-parse $old`
	    new=`git rev-parse $new`
	    base=`git merge-base $old $new`
	    if [ $base = $old ] ; then
		echo >&2 "New commits being added:"
		git >&2 log --pretty='format:  %h %s' $old..$new
	    else
		echo >&2 "NOT A FAST-FORWARD"
		echo >&2 "Commits being removed:"
		git >&2 log --pretty='format:  %h %s' $new..$old
		if [ $base = $new ] ; then : ; else
		    echo >&2 "Commits being added:"
		    git >&2 log --pretty='format:  %h %s' $old..$new
		fi
	    fi
	    exit 0
	) && have_changes=true
    done
    $have_changes
) || exit 0

printf 'Proceed [y/N]? '
read yesno
case $yesno in
     [yY]*) ;;
     *) exit 1;;
esac

echo >&2 "Pushing..."

exec git push "$@"

--=-piiZj9msrj51zxTF9WeV--
