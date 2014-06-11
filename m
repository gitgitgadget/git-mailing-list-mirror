From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/4] ack recoding in commit log
Date: Wed, 11 Jun 2014 11:46:48 +0300
Message-ID: <20140611084648.GD7248@redhat.com>
References: <1400447743-18513-1-git-send-email-mst@redhat.com>
 <53980DDA.1040407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 10:46:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WueAv-0007t5-67
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 10:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbaFKIqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2014 04:46:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32007 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750713AbaFKIqV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2014 04:46:21 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s5B8kKIP000776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2014 04:46:20 -0400
Received: from redhat.com (ovpn-116-85.ams2.redhat.com [10.36.116.85])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s5B8kItd000530;
	Wed, 11 Jun 2014 04:46:19 -0400
Content-Disposition: inline
In-Reply-To: <53980DDA.1040407@gmail.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251345>

On Wed, Jun 11, 2014 at 10:05:46AM +0200, Fabian Ruch wrote:
> Hi Michael,
> 
> On 05/18/2014 11:17 PM, Michael S. Tsirkin wrote:
> > As a maintainer, I often get patches by mail, then
> > acked-by,reviewed-by etc responses are sent by separate
> > mail.
> > 
> > I like making acks commits,
> > this way they are easy to keep track of
> > as part of git history.
> 
> In order to fully understand your additions, I think, I need some
> clarification on the term "ack commit".

I think the two additions should be judged separately, they aren't
related.

So I am not sure we need to spend time discussing
what is an ack commit.

What I mean is that I prefer using git history for
recording activity, and git rebase for modifying
history.
I think I am not alone in this.

To record acks, I wrote this tool to
create empty commits, that only record log
changes. They are named specially such that
rebase knows not to discard them, and to
automate the editing stage.

I added some features to the tool since.
Did not yet address all comments I got here, but just in case
you are curious it's attached at the end.

> What is an ack commit exactly?
> Suppose our principal commit has the commit message
> 
>     Some changes
> 
>     The changes are...
> 
>     Signed-off-by: A U Thor <author@example.com>
> 
> and we receive an email from Somebody saying
> 
>     > Some changes
>     >
>     > The changes are...
>     >
>     > Signed-off-by: A U Thor <author@example.com>
> 
>     Reviewed-by: Somebody <somebody@example.com>

Other possible cases I handle:
    people reply with:

    For the series:
        Reviewed-by: Somebody <somebody@example.com>

This uses the save/restore flags.

or an informal
    Ack the series
(this one I handle by creating ACKS file manually,
 then applying it with git ack restore)

Someone sends a fixup! patch, and someone else
replies to the fixup with Reviewed-by: tag.
(this was not handled correctly in the version
you reviewed, I attach latest one below where it is
handled correctly).


> . Now, if I understand correctly, we create an empty commit on top of
> the principal commit using the following commit message.
> 
>     Some changes
> 
>     Reviewed-by: Somebody <somebody@example.com>
> 
> Is this commit then called an ack commit?

git ack creates commits like this:

----
ack! Some changes

Reviewed-by: Somebody <somebody@example.com>
---

Other work-flows


> Can an ack commit be non-empty?

At the moment git ack does not create non empty commits.

> Is a commit still an ack if its description mentions additional text
> between the subject and the tag lines?

At the moment git ack does not create such commits.

> Maybe the ack command for todo lists and ack commits have little to do
> with one another.

I use them together but ack command is more powerful than git ack.
Same as commit --fixup, that is not the only way to
use fixup!.


> If we stick to the term "ack commit", then the command
> name suggests that it takes the tags from some commit b and appends them
> to the list of tags in the previous commit's (a) message:
> 
>     pick a A commit
>     ack  b The next commit
> 
> However, this obviously does not work by just appending messages. For
> instance, there could be additional text before or after some tag line
> in either commit message. If we treat the workflow you described as a
> very specific use case of the ack command instead, it seems reasonable
> to add such a todo list functionality for melding commits by silently
> appending messages. However, we might consider parametrizing a single
> squash command instead of defining just another name that one has to
> keep in mind for melding commits:

Hmm, I don't see why is flag any easier to remember than a separate command
frankly, and there's help text at the end to remind you.

> 
>     pick             a A commit
>     squash --no-edit b The next commit

That's too much typing I think, I just want to use a
single letter.
You could argue the same thing for fixup right?
It's really squash but discards the log, and there
is no requirement that it fixes anything, it can
add functionality or whatever.
So why not
squash --discardlog b The next commit

I think that would be bad usability, and so would --no-edit.

--no-edit also does not convey the fact that it allows
empty commits.


I don't mind renaming the command to something else
but I could not come up with a better name so far.

> > Since response mail happens to have appropriate
> > subject matching the patch, it's a natural fit to
> > then use git rebase mechanics if we want to smash
> > these acks into the original commit.
> > 
> > I have been using these patches without any problems
> > for a while now, and find the approach very convenient.
> > 
> > Included:
> > 	rebase: new ack! action to handle ack commits
> > 		this part seems ready for merge to me,
> > 		please review and comment
> > 
> > 	git-ack: new tool to record an ack
> > 		this does not have proper documentation
> > 		and tests yet, I definitely intend to
> > 		do this but wanted to see whether people
> > 		like the UI first.
> > 		posting for early review and feedback
> > 
> > [..]
> 
> Thanks for your time,
>    Fabian


## latest git-ack
## changes: handle fixup!/squash!/ack! messages in mail

msg=`mktemp`
patch=`mktemp`
info=`git mailinfo $msg $patch`
subj=`echo "$info"|sed -n 's/^Subject: //p'`
#strip ack!/fixup!/squash! prefix
subj=`echo "$subj"|sed "s/^fixup![ 	]*//"`
subj=`echo "$subj"|sed "s/^squash![ 	]*//"`
subj=`echo "$subj"|sed "s/^ack![ 	]*//"`
author=`echo "$info"|sed -n 's/^Author: //p'`
email=`echo "$info"|sed -n 's/^Email: //p'`
auth="$author <$email>"
date=`echo "$info"|sed -n 's/^Date: //p'`
sign=`mktemp`
echo "ack! $subj" > $sign
echo "" >> $sign
if
    git diff --cached HEAD
then
    nop < /dev/null
else
    echo "DIFF in cache. Not acked, reset or commit!"
    exit 1
fi
GIT_DIR=`pwd`/.git

usage () {
	echo "Usage: git ack " \
            "[-s|--save|-a|--append|-r|--restore |-c|--clear]\n" >& 2;
        exit 1;
}

append=
save=
clear=

while test $# != 0
do
	case "$1" in
	-a|--append)
		append="y"
		;;
	-s|--s)
		save="y"
		;;
	-r|--restore)
		restore="y"
		;;
	-c|--clear)
		clear="y"
                ;;
	*)
		usage ;;
	esac
	shift
done

if
    test "$clear"
then
    rm -f "${GIT_DIR}/ACKS"
fi

if
    test "$save"
then
    if
        test "$append"
    then
        cat $msg >> "${GIT_DIR}/ACKS"
    else
        cat $msg > "${GIT_DIR}/ACKS"
    fi
fi

if
    test "$restore"
then
    msg=${GIT_DIR}/ACKS
fi

echo $msg > /dev/tty
if
    grep '^[A-Z][A-Za-z-]*-by:' $msg >> $sign
then
    git commit --allow-empty -F $sign --author="$auth" --date="$date"
else
    echo "No signature found!"
    exit 2
fi
