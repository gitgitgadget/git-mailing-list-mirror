From: "Kevin P. Fleming" <kpfleming@digium.com>
Subject: Re: [PATCH] Add support for limiting number of lines generated in
 messages by post-receive-email
Date: Tue, 13 Jul 2010 15:56:31 -0500
Organization: Digium, Inc.
Message-ID: <4C3CD2FF.4040000@digium.com>
References: <1278615790-5433-1-git-send-email-kpfleming@digium.com> <4C3B4734.5070400@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Tue Jul 13 22:56:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYmWu-0002qj-OO
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 22:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755009Ab0GMU4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 16:56:36 -0400
Received: from mail.digium.com ([216.207.245.2]:54818 "EHLO mail.digium.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751076Ab0GMU4f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 16:56:35 -0400
Received: from zimbra.digium.internal ([10.24.55.203] helo=zimbra.hsv.digium.com)
	by mail.digium.com with esmtp (Exim 4.69)
	(envelope-from <kpfleming@digium.com>)
	id 1OYmWm-0001wT-G3
	for git@vger.kernel.org; Tue, 13 Jul 2010 15:56:32 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.hsv.digium.com (Postfix) with ESMTP id 68E65D8025
	for <git@vger.kernel.org>; Tue, 13 Jul 2010 15:56:32 -0500 (CDT)
Received: from zimbra.hsv.digium.com ([127.0.0.1])
	by localhost (zimbra.hsv.digium.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ofjnzr0A3MtY for <git@vger.kernel.org>;
	Tue, 13 Jul 2010 15:56:31 -0500 (CDT)
Received: from [10.24.250.46] (unknown [10.24.250.46])
	by zimbra.hsv.digium.com (Postfix) with ESMTPSA id E2F69D8023
	for <git@vger.kernel.org>; Tue, 13 Jul 2010 15:56:31 -0500 (CDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10) Gecko/20100528 Thunderbird/3.0.5
In-Reply-To: <4C3B4734.5070400@xiplink.com>
X-Enigmail-Version: 1.0.1
OpenPGP: id=05FB8DB2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150913>

On 07/12/2010 11:47 AM, Marc Branchaud wrote:
> On 10-07-08 03:03 PM, Kevin P. Fleming wrote:
>> We have become used to the features of svnmailer when used with Subversion,
>> and one of those useful features is that it can limit the maximum length
>> (in lines) of a commit email message. This is terribly useful since once the
>> goes beyond a reasonable number of lines, nobody is going to read the remainder,
>> and if they really want the entire contents of the commits, they can use
>> git itself to get them using the revision IDs present in the message already.
>>
>> This patch adds a new parameter to the post-receive-email hook script called
>> 'maxlines', that defaults to 2048 if not specified. The entire message is
>> filtered through a function that counts the number of lines generated
>> (including headers), and any lines beyond the limit are suppressed; if any
>> lines are suppressed, a final line is added indicating the number that
>> were suppressed.
> 
> Hi Kevin,
> 
> I appreciate the work and the need you're addressing.  Thanks!
> 
> I do have a request though, which is to make this match the current
> (unlimited) behavior by default instead of imposing an arbitrary (although
> seemingly large) limit.

Done.

> I admit I don't have a strong reason for this, mainly just a desire to not
> force features on folks that don't need them.  IMHO the limit is a bit too
> hidden and likely to surprise someone at an inopportune time.  Plus what
> would someone do if they *want* no limit?
> 
> (FYI, we dealt with large-email syndrome by taking the diffs out of the
> emails and using a custom format to embed a gitweb URL instead.  Folks who
> care about the actual code change can browse the commit in gitweb.  This also
> helped make it easier for humans to parse the emails and the commits they
> contain.)

Yes, we'll probably include a gitweb URL as well.

> A couple more comments below...
> 
>> Signed-off-by: Kevin P. Fleming <kpfleming@digium.com>
>> ---
>>  contrib/hooks/post-receive-email |   31 ++++++++++++++++++++++++++++++-
>>  1 files changed, 30 insertions(+), 1 deletions(-)
>>
>> diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
>> index 30ae63d..436c13f 100755
>> --- a/contrib/hooks/post-receive-email
>> +++ b/contrib/hooks/post-receive-email
>> @@ -55,6 +55,11 @@
>>  #     "t=%s; printf 'http://.../?id=%%s' \$t; echo;echo; git show -C \$t; echo"
>>  #   Be careful if "..." contains things that will be expanded by shell "eval"
>>  #   or printf.
>> +# hooks.maxlines
> 
> Why not call this something like "hooks.maxemaillines"?  "maxlines" is so
> generic that it might collide with something some other hook might use.

Changed.

> 
>> +#   The maximum number of lines that should be included in the generated
>> +#   email (including its headers). If not specified, defaults to 2048.
>> +#   Lines beyond the limit are suppressed and counted, and a final
>> +#   line is added indicating the number of suppressed lines.
>>  #
>>  # Notes
>>  # -----
>> @@ -642,6 +647,29 @@ show_new_revisions()
>>  }
>>  
>>  
>> +limit_lines()
>> +{
>> +    lines=0
>> +    skipped=0
>> +    limit=$(($1 - 2))
>> +    while IFS="" read line
>> +    do
>> +	lines=$((lines + 1))
>> +	if [ $lines -gt $limit ]
>> +	then
>> +	    skipped=$((skipped + 1))
>> +	else
>> +	    echo "$line"
>> +	fi
>> +    done
>> +    if [ $skipped -ne 0 ]
>> +    then
>> +	echo
>> +	echo "... $skipped lines suppressed ..."
>> +    fi
>> +}
>> +
>> +
>>  send_mail()
>>  {
>>  	if [ -n "$envelopesender" ]; then
>> @@ -679,6 +707,7 @@ announcerecipients=$(git config hooks.announcelist)
>>  envelopesender=$(git config hooks.envelopesender)
>>  emailprefix=$(git config hooks.emailprefix || echo '[SCM] ')
>>  custom_showrev=$(git config hooks.showrev)
>> +maxlines=$(git config hooks.maxlines || echo '2048')
>>  
>>  # --- Main loop
>>  # Allow dual mode: run from the command line just like the update hook, or
>> @@ -691,6 +720,6 @@ if [ -n "$1" -a -n "$2" -a -n "$3" ]; then
>>  else
>>  	while read oldrev newrev refname
>>  	do
>> -		generate_email $oldrev $newrev $refname | send_mail
>> +		generate_email $oldrev $newrev $refname | limit_lines $maxlines | send_mail
> 
> I'm a little concerned about the performance hit of piping the output through
> limit_lines(), which buffers all the lines in memory.  Folks who want large
> emails might get bitten by this.

The shell should start another process for limit_lines(), just as it
does for send_mail(), and thus only a small number of lines should ever
be in memory at once.

> 
> (That said, I don't know anything about the memory efficiency of the shell's
> pipes, or if "git diff-tree" itself would suck up a lot of memory on a series
> of huge patches.)
> 
> Maybe only pipe through limit_lines() if $maxlines > 0?

I've made this change as well; I'll post a new patch shortly.

-- 
Kevin P. Fleming
Digium, Inc. | Director of Software Technologies
445 Jan Davis Drive NW - Huntsville, AL 35806 - USA
skype: kpfleming | jabber: kfleming@digium.com
Check us out at www.digium.com & www.asterisk.org
