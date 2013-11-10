From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH v4 12/10] git-remote-testgit: support the new 'force'
 option
Date: Sun, 10 Nov 2013 17:46:15 -0500
Message-ID: <52800CB7.7080905@bbn.com>
References: <1382857521-7005-1-git-send-email-felipe.contreras@gmail.com> <1382908589-7000-1-git-send-email-rhansen@bbn.com> <526f74cf8307f_37cdfb1e7c31@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: srabbelier@gmail.com
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 10 23:46:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vfdlw-0000fR-Mh
	for gcvg-git-2@plane.gmane.org; Sun, 10 Nov 2013 23:46:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752440Ab3KJWqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Nov 2013 17:46:21 -0500
Received: from smtp.bbn.com ([128.33.0.80]:20420 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752298Ab3KJWqU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Nov 2013 17:46:20 -0500
Received: from socket.bbn.com ([192.1.120.102]:57613)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Vfdlp-00031x-Fj; Sun, 10 Nov 2013 17:46:17 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id C19A33FF72
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <526f74cf8307f_37cdfb1e7c31@nysa.notmuch>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237593>

On 2013-10-29 04:41, Felipe Contreras wrote:
> Richard Hansen wrote:
>> Signed-off-by: Richard Hansen <rhansen@bbn.com>
>> ---
>>  git-remote-testgit.sh | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/git-remote-testgit.sh b/git-remote-testgit.sh
>> index 6d2f282..80546c1 100755
>> --- a/git-remote-testgit.sh
>> +++ b/git-remote-testgit.sh
>> @@ -6,6 +6,7 @@ url=$2
>>  
>>  dir="$GIT_DIR/testgit/$alias"
>>  prefix="refs/testgit/$alias"
>> +forcearg=
>>  
>>  default_refspec="refs/heads/*:${prefix}/heads/*"
>>  
>> @@ -39,6 +40,7 @@ do
>>  		fi
>>  		test -n "$GIT_REMOTE_TESTGIT_SIGNED_TAGS" && echo "signed-tags"
>>  		test -n "$GIT_REMOTE_TESTGIT_NO_PRIVATE_UPDATE" && echo "no-private-update"
>> +		echo 'option'
>>  		echo
>>  		;;
>>  	list)
>> @@ -93,6 +95,7 @@ do
>>  		before=$(git for-each-ref --format=' %(refname) %(objectname) ')
>>  
>>  		git fast-import \
>> +			${forcearg} \
>>  			${testgitmarks:+"--import-marks=$testgitmarks"} \
>>  			${testgitmarks:+"--export-marks=$testgitmarks"} \
>>  			--quiet
>> @@ -115,6 +118,21 @@ do
>>  
>>  		echo
>>  		;;
>> +	option\ *)
>> +		read cmd opt val <<EOF
>> +${line}
>> +EOF
> 
> We can do <<-EOF to align this properly.

Good point.  I personally avoid tabs whenever possible, and <<- only
works with tabs, so I'm in the habit of doing <<EOF.

> 
> Also, I don't see why all the variables are ${foo} instead of $foo.

I'm in the habit of doing ${foo} because I like the consistency --
sometimes you need them to disambiguate, and sometimes you need special
expansions like ${foo##bar} or ${foo:-bar}.

In this case it's actually less consistent to do ${foo} because the rest
of the file doesn't use {} when not needed, so I agree with your change.

> 
>> +		case ${opt} in
>> +		    force)
> 
> I think the convention is to align these:
> 
> case $opt in
> force)

The existing case statement in this file indents the patterns the same
amount as the case statement, so this should be aligned to match.

In general I rarely see the case patterns indented at the same level as
the case statement, possibly because Emacs shell-mode indents the
patterns more than the case statement (by default).  The POSIX spec
contains a mix of styles:
  * the normative text documenting the format of a 'case' construct
    indents the patterns more than the 'case' statement
  * two of the four non-normative examples indent the patterns
    more than the 'case' statements; the other two do not

> 
>> +			case ${val} in
>> +			    true) forcearg=--force; echo 'ok';;
>> +			    false) forcearg=; echo 'ok';;
>> +			    *) printf %s\\n "error '${val}'\
>> + is not a valid value for option ${opt}";;
> 
> I think this is packing a lot of stuff and it's not that readable.
> 
> Moreover, this is not for production purposes, it's for testing purposes and a
> guideline, I think this suffices.
> 
> 
> 	option\ *)
> 		read cmd opt val <<-EOF
> 		$line
> 		EOF
> 		case $opt in
> 		force)
> 			test $val = "true" && force="true" || force=
> 			echo "ok"
> 			;;
> 		*)
> 			echo "unsupported"
> 			;;
> 		esac
> 		;;

Works for me.

> 
> But this is definetly good to have, will merge.

Thanks,
Richard
