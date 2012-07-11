From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH 2/6] Teach remote.c about the remote.default configuration
 setting.
Date: Wed, 11 Jul 2012 16:41:15 -0400
Message-ID: <4FFDE4EB.3060100@xiplink.com>
References: <1342020841-24368-1-git-send-email-marcnarc@xiplink.com> <1342020841-24368-3-git-send-email-marcnarc@xiplink.com> <7vr4siduq3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, peff@peff.net,
	phil.hord@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 22:41:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sp3io-00056l-UZ
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 22:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933201Ab2GKUlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 16:41:13 -0400
Received: from smtp138.ord.emailsrvr.com ([173.203.6.138]:49087 "EHLO
	smtp138.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754099Ab2GKUlM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 16:41:12 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp26.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 235031C01A7;
	Wed, 11 Jul 2012 16:41:12 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp26.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id A808D1C00FE;
	Wed, 11 Jul 2012 16:41:11 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
In-Reply-To: <7vr4siduq3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201328>

On 12-07-11 02:21 PM, Junio C Hamano wrote:
> marcnarc@xiplink.com writes:
> 
>> From: Marc Branchaud <marcnarc@xiplink.com>
>>
>> The code now has a default_remote_name and an effective_remote_name:
>>
>>  - default_remote_name is set by remote.default in the config, or is "origin"
>>    if remote.default doesn't exist ("origin" was the fallback value before
>>    this change).
>>
>>  - effective_remote_name is the name of the remote tracked by the current
>>    branch, or is default_remote_name if the current branch doesn't have a
>>    remote.
>>
>> This has a minor side effect on the default behavior of "git push".  Consider
>> the following sequence of commands:
>>
>>       git config remote.default foo                 # Set default remote
>>       git checkout somelocalbranch                  # Does not track a remote
>>       git remote add origin ssh://example.com/repo  # Add a new "origin"
>>       git push
>>
>> Prior to this change, the above "git push" would attempt to push to the new
>> "origin" repository at ssh://example.com/repo.  Now instead that "git push"
>> will attempt to push to the repository named "foo".
> 
> Hrm, is this a _minor_ side effect?

Well, I thought so...  :)

It's minor because of what you say:

> Isn't that a natural and direct consequence of "now you can set
> remote.default configuration to name the remote you want to use in
> place of traditional 'origin'" feature?  I think changing the
> behaviour of "git push" in such a way is the point (may not be the
> only but one of the important points) of this series.

I agree.  Phil Hord pointed out the change in behaviour and felt the commit
message should explain it.

Should I just remove "minor"?

>> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
>> index cb97cc1..fc17d39 100644
>> --- a/Documentation/git-push.txt
>> +++ b/Documentation/git-push.txt
>> @@ -27,10 +27,16 @@ documentation for linkgit:git-receive-pack[1].
>>  OPTIONS[[OPTIONS]]
>>  ------------------
>>  <repository>::
>> -	The "remote" repository that is destination of a push
>> +	The "remote" repository that is the destination of the push
>>  	operation.  This parameter can be either a URL
>>  	(see the section <<URLS,GIT URLS>> below) or the name
>>  	of a remote (see the section <<REMOTES,REMOTES>> below).
>> +	If this parameter is omitted, git tries to use the remote
>> +	associated with the currently checked-out branch.  If there
>> +	is no remote associated with the current branch, git uses
>> +	the remote named by the "remote.default" configuration variable.
>> +	If "remote.default" is not set, git uses the name "origin" even
>> +	if there is no actual remote named "origin".
> 
> This comment applies to other changes to the documentation in this
> patch I didn't quote, but I think the phrasing 'even if there is no
> acutual remote named "origin"' needs to be rethought, because "we
> use it even if there is no such remote determined with this logic"
> applies equally to branch.$name.remote, remote.default or built-in
> default value of remote.default which happens to be "origin".

I'm sorry, but I'm having trouble understanding what you mean.  I don't see
how the "because ..." part of your sentence suggests what aspect needs
rephrasing.

(BTW, I'm under the impression that when git sets branch.$name.remote it
doesn't ever have to fall back to the default remote name.  That is, commands
that set the value always have the user explicitly, though perhaps
indirectly, specifying the remote.  Did I miss something?)

>> diff --git a/remote.c b/remote.c
>> index 6f371e0..2ebdbbd 100644
>> --- a/remote.c
>> +++ b/remote.c
>> @@ -47,6 +47,7 @@ static int branches_alloc;
>>  static int branches_nr;
>>  
>>  static struct branch *current_branch;
>> +static const char *default_remote_name;
>>  static const char *effective_remote_name;
> 
> Coming from UNIX background, "effective" gives me an impression that
> it is contrasted with "real" (i.e. there is "real remote" for the
> branch, but during this particular invocation it is overridden and
> "effective remote" is used instead).  Perhaps it is just me.

I did have something like that in mind when I chose "effective":  There's a
default remote name that's normally used, but in the certain circumstances
it's overridden.  Perhaps "effective_default_remote_name" would be better,
though that's getting to be a mouthful (plus it would mean having an
"explicit_effective_default_remote_name", which IMHO is a bit much).

> Something along the line of remote-name-to-use, use-remote, might
> sound more natural.

current_remote_name?

		M.
