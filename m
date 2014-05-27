From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC 2/3] rebase -i: Reschedule tasks that failed before the
 index was touched
Date: Tue, 27 May 2014 13:56:45 +0200
Message-ID: <53847D7D.5050000@alum.mit.edu>
References: <533C913C.20106@cisco.com> <5383BDEA.9070908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <hordp@cisco.com>
To: Fabian Ruch <bafain@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 14:11:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpGDd-00074u-Hj
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 14:11:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbaE0L4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 07:56:49 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:62652 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751637AbaE0L4r (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 May 2014 07:56:47 -0400
X-AuditID: 1207440c-f79656d000000c83-61-53847d7f9011
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 0A.BA.03203.F7D74835; Tue, 27 May 2014 07:56:47 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1362.dip0.t-ipconnect.de [93.219.19.98])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s4RBujkB004463
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 27 May 2014 07:56:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <5383BDEA.9070908@gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsUixO6iqFtf2xJssGItj8WhuffYLbqudDNZ
	nDr6ndWB2WPK742sHjtn3WX3+LxJLoA5itsmKbGkLDgzPU/fLoE7Y8bS9ewFp+Uqrr99yN7A
	+Ea8i5GTQ0LAROL5xxYWCFtM4sK99WxdjFwcQgKXGSWaJr5ngXDOMUlsb/nFDFLFK6Atce5r
	D1gHi4CqxISn85hAbDYBXYlFPc1ANgeHqECQxJ+zihDlghInZz4BKxcRMJc4vmMWO4jNLCAv
	sfnkJVYQW1ggVuL15ItgcSEBZ4kZe06ygdicApoSC1/eZgcZKSEgLtHTGATRqiPxru8BM8yY
	7W/nME9gFJyFZNssJGWzkJQtYGRexSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrqJebWaKXmlK6
	iRES0jw7GL+tkznEKMDBqMTDO8G3OViINbGsuDL3EKMkB5OSKO/ZqpZgIb6k/JTKjMTijPii
	0pzU4kOMEhzMSiK860uAcrwpiZVVqUX5MClpDhYlcV7VJep+QgLpiSWp2ampBalFMFkZDg4l
	CV7fGqBGwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFD8xhcDIxgkxQO0Nxuknbe4
	IDEXKArReopRl+PUnWNtTEIsefl5qVLivO7VQEUCIEUZpXlwK2AJ7BWjONDHwrw5IKN4gMkP
	btIroCVMQEt2dDSCLClJREhJNTCWiT3fxMjg/uXv85+L75omfk5anBQTxr1y6c7SU/F+q6MS
	X3ySTYmcGe5q131d5W7GtW/uR3fZsRz9PJ1nimSmfpq0iAcTV8Xp3Lc/o4rTU0T/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250163>

Hi,

Overall, this approach seems reasonable.

Please see the inline comments below.

On 05/27/2014 12:19 AM, Fabian Ruch wrote:
> When `rebase--interactive` processes a task, it removes the item from
> the todo list and appends it to another list of executed tasks. If a
> `pick` (this includes `squash` and `fixup`) fails before the index has
> recorded the changes, take the corresponding item and put it on the todo
> list again. Otherwise, the changes introduced by the scheduled commit
> would be lost.
> 
> That kind of decision is possible since the `cherry-pick` command
> signals why it failed to apply the changes of the given commit. Either
> the changes are recorded in the index using a conflict (return value 1)
> and `rebase` does not continue until they are resolved or the changes
> are not recorded in the index (return value neither 0 nor 1) and
> `rebase` has to try again with the same task.
> 
> Reported-by: Phil Hord <hordp@cisco.com>
> Signed-off-by: Fabian Ruch <bafain@gmail.com>
> ---
>  git-rebase--interactive.sh | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 9e1dd1e..bba4f3a 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -132,6 +132,16 @@ mark_action_done () {
>  	fi
>  }
>  
> +# Put the last action marked done at the beginning of the todo list
> +# again. If there has not been an action marked done yet, the list of
> +# items on the todo list is left unchanged.

The comment would read better if the second sentence were also in active
voice, like the first sentence:

    If there has not been an action marked done yet, leave the list of
    items on the todo list unchanged.

> +reschedule_last_action () {
> +	tail -n 1 "$done" | cat - "$todo" >"$todo".new
> +	sed -e \$d <"$done" >"$done".new
> +	mv -f "$todo".new "$todo"
> +	mv -f "$done".new "$done"
> +}
> +
>  append_todo_help () {
>  	git stripspace --comment-lines >>"$todo" <<\EOF
>  
> @@ -470,11 +480,15 @@ do_pick () {
>  			   --no-post-rewrite -n -q -C $1 &&
>  			pick_one -n $1 &&
>  			git commit --allow-empty --allow-empty-message \
> -				   --amend --no-post-rewrite -n -q -C $1 ||
> -			die_with_patch $1 "Could not apply $1... $2"
> +				   --amend --no-post-rewrite -n -q -C $1

"git cherry-pick" indicates its error status specifically as 1 or some
other value.  But here it could be that pick_one succeeds but "git
commit" fails; in that case ret is set to the return code of "git
commit".  So, if "git commit" fails with a retcode different than 1,
then reschedule_last_action will be called a few lines later.  This
seems incorrect to me.

>  	else
> -		pick_one $1 ||
> -			die_with_patch $1 "Could not apply $1... $2"
> +		pick_one $1
> +	fi
> +	ret=$?
> +	if test $ret -ne 0
> +	then
> +		test $ret -ne 1 && reschedule_last_action
> +		die_with_patch $1 "Could not apply $1... $2"
>  	fi
>  }
>  
> @@ -533,8 +547,11 @@ do_next () {
>  		author_script_content=$(get_author_ident_from_commit HEAD)
>  		echo "$author_script_content" > "$author_script"
>  		eval "$author_script_content"
> -		if ! pick_one -n $sha1
> +		pick_one -n $sha1
> +		ret=$?
> +		if test $ret -ne 0
>  		then
> +			test $ret -ne 1 && reschedule_last_action
>  			git rev-parse --verify HEAD >"$amend"
>  			die_failed_squash $sha1 "$rest"
>  		fi
> 

I suggest that you add a comment for pick_one explaining that if it
fails, its failure code is like that of cherry-pick, namely ...etc...
This will warn future developers to preserve the error code semantics.

It is preferable to squash the next commit, containing the tests,
together with this commit.

Thanks,
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
