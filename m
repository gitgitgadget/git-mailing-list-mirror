From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH 2/6] Teach remote.c about the remote.default configuration
 setting.
Date: Fri, 06 Jul 2012 10:36:53 -0400
Message-ID: <4FF6F805.20403@xiplink.com>
References: <1341526277-17055-1-git-send-email-marcnarc@xiplink.com> <1341526277-17055-3-git-send-email-marcnarc@xiplink.com> <7v4nplrfe4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, peff@peff.net,
	phil.hord@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 16:36:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sn9eO-0001dx-Im
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 16:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757501Ab2GFOgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 10:36:47 -0400
Received: from smtp146.ord.emailsrvr.com ([173.203.6.146]:58286 "EHLO
	smtp146.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757273Ab2GFOgq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 10:36:46 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp23.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 6ED111C8098;
	Fri,  6 Jul 2012 10:36:45 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp23.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id BB21E1C807E;
	Fri,  6 Jul 2012 10:36:44 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
In-Reply-To: <7v4nplrfe4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201112>

On 12-07-05 06:50 PM, Junio C Hamano wrote:
> marcnarc@xiplink.com writes:
> 
>> From: Marc Branchaud <marcnarc@xiplink.com>
>>
>> The code now has a default_remote_name and an effective_remote_name:
>>  - default_remote_name is set by remote.default in the config, or is "origin"
>>    if remote.default doesn't exist ("origin" was the fallback value before
>>    this change).
> 
> 
>>  - effective_remote_name is the name of the remote tracked by the current
>>    branch, or is default_remote_name if the current branch doesn't have a
>>    remote.
> 
> The explanation of the latter belongs to the previous step, I think.
> I am not sure if "effective" is the best name for the concept the
> above explains, though.

Well, the previous commit removes default_remote_name, so the explanation
wouldn't be valid verbatim.

How about keeping the above here, and I could add the following to the
previous commit's message:

	effective_remote_name is the remote name that is currently "in
	effect".  This is the currently checked-out branch's remote, or
	"origin" if the branch has no remote (or the working tree is a
	detached HEAD).

>> @@ -390,6 +391,7 @@ static int handle_config(const char *key, const char *value, void *cb)
>>  	}
>>  	if (prefixcmp(key,  "remote."))
>>  		return 0;
>> +
> 
> Why?

Oops, just a newline I neglected to clean up from some earlier hacking.  Sorry.

>>  	name = key + 7;
>> @@ -671,6 +680,18 @@ static int valid_remote_nick(const char *name)
>>  	return !strchr(name, '/'); /* no slash */
>>  }
>>  
>> +const char *remote_get_default_name()
> 
> const char *remote_get_default_name(void)

OK.

>> +{
>> +	read_config();
>> +	return default_remote_name;
>> +}
> 
> Hrmph.  I am too lazy to read outside the context of your patch to
> make sure, but isn't the root cause of the problem that when we try
> to find which remote the current branch is configured to interact
> with, we grab branch->remote_name (and this is done by calling
> git_config() to open and read the configuration file once already)
> and if it is empty we default to "origin"?  Wouldn't the callback
> function that is used for that invocation of git_config() a much
> better place to set "default_remote_name" variable, instead of
> having us to read the entire configuration file one more time only
> to get the value of this variable?

The read_config() function already has logic to avoid re-parsing the entire
config over and over again.  There are many places in remote.c that call
read_config(), and I thought I was just following that pattern.

Also, making the code be

	if (!default_remote_name)
		read_config();
	return default_remote_name;

would just replicate the check that read_config() already does.

>> +int remote_count()
> 
> int remote_count(void)

OK.

>> +{
>> +	read_config();
>> +	return remotes_nr;
>> +}
> 
> Likewise.

Doing something like

	if (!remotes_nr)
		read_config():
	return remotes_nr;

would be wrong, since having 0 remotes is perfectly fine.  And making the
check here be
	if (!default_remote_name)
seems confusing, and again it duplicates the check read_config() already does.

> Especially it is unclear who benefits from the function
> until a new caller is introduced.  I would prefer not to see the
> addition of this function in this patch.

OK, I can move it to the "git remote" patch.  The same could be said of
remote_get_default_name() though.

>>  struct remote *remote_get(const char *name)
>>  {
>>  	struct remote *ret;
>> diff --git a/remote.h b/remote.h
>> index 251d8fd..f9aac87 100644
>> --- a/remote.h
>> +++ b/remote.h
>> @@ -52,6 +52,8 @@ struct remote {
>>  
>>  struct remote *remote_get(const char *name);
>>  int remote_is_configured(const char *name);
>> +const char *remote_get_default_name();
>> +int remote_count();
> 
> const char *remote_get_default_name(void);
> int remote_count(void);

Got it.

I'll make these changes in a few days, after folks have had a chance to
review.  If things settle down I'll re-roll with the documentation updates too.

		M.
