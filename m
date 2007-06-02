From: Matthijs Melchior <mmelchior@xs4all.nl>
Subject: Re: [PATCH] Add option -L to git-tag.
Date: Sat, 02 Jun 2007 15:09:45 +0200
Message-ID: <46616C19.4020800@xs4all.nl>
References: <1180773465209-git-send-email-mmelchior@xs4all.nl> <7vfy5avf89.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jun 02 15:23:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuTa8-0007Lw-4q
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 15:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755479AbXFBNXi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 09:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756081AbXFBNXi
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 09:23:38 -0400
Received: from smtp-vbr17.xs4all.nl ([194.109.24.37]:4596 "EHLO
	smtp-vbr17.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755479AbXFBNXh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 09:23:37 -0400
X-Greylist: delayed 825 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Jun 2007 09:23:37 EDT
Received: from [10.0.0.3] (zwaan.xs4all.nl [213.84.190.116])
	by smtp-vbr17.xs4all.nl (8.13.8/8.13.8) with ESMTP id l52D9kpX098916;
	Sat, 2 Jun 2007 15:09:48 +0200 (CEST)
	(envelope-from mmelchior@xs4all.nl)
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
In-Reply-To: <7vfy5avf89.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48929>

Junio C Hamano wrote:
> Matthijs Melchior <mmelchior@xs4all.nl> writes:
>
>   
>>   This will list the selected tags and include annotations, if any.
>>
>> Signed-off-by: Matthijs Melchior <mmelchior@xs4all.nl>
>> ---
>>
>> This patch has been created to allow me to easily see the annotations with tags.
>> I have not found any other way to do this...
>>     
>
> Hmmmm.  This feature ought to belong to git-show, but that
> command already has its own interpretation of how a tag should
> be shown.
>
> Do we care about the "one line summary"?  Perhaps...
>
> 	$ git tag --pretty=short -L v2.6.11-tree
> 	v2.6.11-tree
>             This is the 2.6.11 tree object.
>
> 	$ git tag -L v2.6.11-tree
> 	v2.6.11-tree
>             This is the 2.6.11 tree object.
>
> 	    NOTE! There's no commit for this, since it happened...
>
> The answer to this question would really depend on why we would
> want to have this feature.  "git-tag" started as a way to
> "create", and then it gained -l to "list" and -v to "verify".  I
> think your -L is meant to be an extension to "list", but I
> suspect that while you are listing many things you would keep
> the annotation short-and-sweet, and you would want to view the
> full description when your interest is focused at a single one.
> Maybe we would want a separate "print" action for the full
> contents and use the short one for "list but more verbosely than
> usual"?
>
> I dunno; I've never been very good at the user interfaces.
>   
Yes, since I have this command and have seen the tag annotations in the
git repository, I think we need this extra parameter.
I propose to give the number of lines you want to see, with 0 gives all.
So it will be --pretty=<max-number-lines> to limit the output and be
able to find interesting stuff before looking at the complete message.

In the project where I wanted this, the tag annotations are only a few
lines max...
I have used this to remember special status of of a commit, such as release
version and date.  In order to quickly find such a thing I wanted to see
all the annotations.
>   
>>  - Sorting the tag names resulting from git-rev-parse is not nessecary since
>>    the list of tags is already deliverd in sorted order.
>>     
>
> This I am a bit reluctant about, as that sorting done by
> rev-parse is purely by accident (i.e. it is an implementation
> detail).
>   
This accident can be repaired by documenting it.... :)
>   
>>  - Using git-cat-file -t on every tag is expensive, but there is no alternative
>>     
>
> This is Ok, as we have somebody working on doing git-tag as a
> built-in, and once that happens, we do not have to pay the
> performance penalty.  So I would think at this point we should
> concentrate on discussing the usefulness of this new feature and
> correctness of your implementation, as that would set the course
> for the future.  On the other hand, "cat-file -t" performance
> issues will not stay with us forever.
>
>   
>> @@ -26,13 +26,23 @@ do
>>      -f)
>>  	force=1
>>  	;;
>> -    -l)
>> -	case "$#" in
>> -	1)
>> -		set x . ;;
>> -	esac
>> +    -l|-L)
>> +	TAGSONLY=true
>> +	[ "$1" = -L ] && TAGSONLY=false
>> +	[ "$#" = 1 ] && set x .
>>  	shift
>> +	git rev-parse --symbolic --tags | grep "$@" |
>> +	    while read TAG
>> +	    do
>> +		echo "$TAG"
>> +		$TAGSONLY && continue
>> +		OBJTYPE=$(git cat-file -t "$TAG")
>> +		case $OBJTYPE in
>> +		    tag)    git cat-file $OBJTYPE "$TAG" |
>> +				sed '1,/^$/d;/^-----BEGIN PGP SIGNATURE-----$/Q;s/^/    /'
>> +			    ;;
>> +		esac
>>     
>
> Micronit.  If you already know it is a tag, you do not have to
> say "cat-file $OBJTYPE".
>   
Yes, this was left over from an older prototype.....
> Style.  Please indent the case arm to the same level as, not
> deeper than, case/esac.
> This is the same as C's switch() { case ...: } indentation rule.
>
> Please do not feed multiple expressions concatenated with
> semicolon to sed, as it is one of the often observed portability
> issues (not all the world is GNU yet).  Write it like this
> instead:
>
>         case "$OBJTYPE" in
>         tag)
>                 git cat-file tag "$TAG" |
>                 sed -e '1,/^$/d' \
>                     -e '/^-----BEGIN PGP SIGNATURE-----$/Q' \
>                     -e s/^/    /'
>                 ;;
>         esac
>
>   
>> +	    done
>>  	exit $?
>>     
OK, I'll use this style.
> What does this command exit with now?  It used to be that
>
> 	$ git tag -l no-such-tag-at-all ; echo $?
>
> said "1", I think, because grep did not match.
>   
It will always exit 0, either from sed or git-cat.

I will send a new patch with better style, a --pretty=n option and
again exit code from grep.
 (maybe the exit code is not worth the added complexity...).


Thanks.

-- 
Regards,
----------------------------------------------------------------  -o)
Matthijs Melchior                                       Maarssen  /\\
mmelchior@xs4all.nl                                  Netherlands _\_v
---------------------------------------------------------------- ----
