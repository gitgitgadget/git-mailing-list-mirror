From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCHv3] git-rebase--interactive.sh: extend "edit" command to be more useful
Date: Fri, 3 Dec 2010 00:16:21 -0800
Message-ID: <048EACFB-2038-4D49-B6C3-7E7354F62171@sb.org>
References: <20101110015327.GB1503@burratino> <1290629960-60917-1-git-send-email-kevin@sb.org> <20101203080603.GC18202@burratino>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Yann Dirson <dirson@bertin.fr>,
	Eric Raible <raible@nextest.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 09:16:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POQoh-0004mt-CQ
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 09:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758495Ab0LCIQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 03:16:25 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41398 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758486Ab0LCIQY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Dec 2010 03:16:24 -0500
Received: by iwn5 with SMTP id 5so173018iwn.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 00:16:24 -0800 (PST)
Received: by 10.231.10.137 with SMTP id p9mr1419631ibp.186.1291364183641;
        Fri, 03 Dec 2010 00:16:23 -0800 (PST)
Received: from [10.0.1.14] (c-24-130-32-253.hsd1.ca.comcast.net [24.130.32.253])
        by mx.google.com with ESMTPS id 8sm1314118iba.10.2010.12.03.00.16.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 00:16:23 -0800 (PST)
In-Reply-To: <20101203080603.GC18202@burratino>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162769>

On Dec 3, 2010, at 12:06 AM, Jonathan Nieder wrote:

> Hi,
> 
> Kevin Ballard wrote:
> 
>> [Subject: [PATCHv3] git-rebase--interactive.sh: extend "edit" command to be more useful
> 
> Maybe something like
> 
> 	rebase-i: treat "edit" without sha1 as a request to amend previous commit
> 
> would make the meaning more obvious in a shortlog.

That seems a bit misleading, though. This command really has nothing to do with
amending the previous commit. You can do anything you want once you break back to
the shell. I personally used it to run git-merge at that point in the history.
For this reason I'm a bit uneasy about overloading "edit", but it does have the
benefit that people already know "edit" brings them to the shell.

>> Extend the "edit" command to simply stop for editing if no sha1 is
>> given or if the sha1 is equal to "-". This behaves the same as "x false"
>> but is a bit friendlier for the user.
> 
> Nice.  I like the semantics.
> 
>> * Picked up the extended explanation suggested by Jonathan Nieder.
>>  I left off the last line about "noop" as that doesn't seem related.
> 
> Right, please feel free to remind me if I forget to pick that up again.
> 
>> * If the line given is "edit - some comments", emit "some comments" when
>>  stopped. This is undocumented
> 
> I think that's okay for now (though of course it would be best to explain
> some example uses in Documentation/git-rebase.txt in the form of examples).

Yep, I definitely need to add documentation.

>> --- a/git-rebase--interactive.sh
>> +++ b/git-rebase--interactive.sh
>> @@ -469,12 +469,29 @@ do_next () {
>> +			comment="$rest"
>> +			line=$(git rev-list --pretty=oneline -1 --abbrev-commit --abbrev=7 HEAD)
> 
> Hmm, the script seems to assume rev-list will not fail throughout.  :/
> Ok.
> 
>> +			sha1="${line%% *}"
>> +			rest="${line#* }"
>> +			echo "$sha1" > "$DOTEST"/stopped-sha
> 
> Maybe this can be done without relying on details of --pretty=oneline
> format?
> 
> 			sha1=$(git rev-parse --short HEAD)
> 			rest=$(git show -s --format=%s HEAD)

Does this not similarly assume that rev-parse and show will not fail? Or was
the above comment only meant to point out this potential issue without
suggesting that it needed to be fixed?

> (Yes, elsewhere the script uses
> 
> 	git rev-list --no-merges --pretty=oneline --abbrev-commit \
> 		--abbrev=7 --reverse --left-right --topo-order "$@" |
> 	sed -n "s/^>//p" |
> 	while read -r shortsha1 rest
> 
> but in that loop, avoiding an extra exec seems more important.)
> 
>> +		fi
>> 		git rev-parse --verify HEAD > "$AMEND"
>> 		warn "Stopped at $sha1... $rest"
>> +		if test -n "$comment"; then
>> +			warn
>> +			warn "	$comment"
>> +			warn
> 
> Thanks, looks good to me.
> 
> Ideas for tests?  (see t3404 for inspiration)

I'll look into that. I wasn't really sure how to test this before, but t3404
does have some examples of testing the edit command already.

-Kevin Ballard