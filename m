From: Namhyung Kim <namhyung.kim@lge.com>
Subject: Re: [PATCH] name-rev: Allow to omit refs/tags/ part in --refs option
 when --tags used
Date: Tue, 18 Jun 2013 20:55:57 +0900
Message-ID: <51C04ACD.1000003@lge.com>
References: <1371455636-1378-1-git-send-email-namhyung.kim@lge.com> <7vip1chi50.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 13:56:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UouW7-0000fv-Oe
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 13:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441Ab3FRL4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 07:56:00 -0400
Received: from LGEMRELSE6Q.lge.com ([156.147.1.121]:46979 "EHLO
	LGEMRELSE6Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932230Ab3FRLz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 07:55:59 -0400
X-AuditID: 9c930179-b7c30ae0000047e1-d3-51c04acd8887
Received: from [192.168.0.2] ( [10.177.220.181])
	by LGEMRELSE6Q.lge.com (Symantec Brightmail Gateway) with SMTP id FA.68.18401.DCA40C15; Tue, 18 Jun 2013 20:55:57 +0900 (KST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <7vip1chi50.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228201>

Hi Junio,

2013-06-18 AM 12:27, Junio C Hamano wrote:
> Namhyung Kim <namhyung.kim@lge.com> writes:
>
>> In its current form, when an user wants to filter specific ref using
>> --refs option, she needs to give something like --refs=refs/tags/v1.*.
>>
>> This is not intuitive as users might think it's enough to give just
>> actual tag name part like --refs=v1.*.
>
> I do not think "Users might think" is not particularly a good
> justification, but I agree that it would be useful to allow
> --refs=v1.\* to match refs/heads/v1.4-maint and refs/tags/v1.4.0; it
> is easy for the users to disambiguate with longer prefix if they
> wanted to.

Right.  I just failed to find right words. :)

>
>> It applies to refs other than
>> just tags too.  Change it for users to be able to use --refs=sth or
>> --refs=remotes/sth.
>>
>> Also remove the leading 'tags/' part in the output when --tags option
>> was given since the option restricts to work with tags only.
>
> This part is questionable, as it changes the output people's scripts
> have been reading from the command since eternity ago.

True.

>
> If the pattern asks to match with v1.* (not tags/v1.* or
> refs/tags/v1.*) and you find refs/tags/v1.*, it might be acceptable
> to strip "refs/tags/" part.  Existing users are _expected_ to feed a
> pattern with full refname starting with refs/, so they will not be
> negatively affected by such a usability enhancement on the output
> side.

This is what I wanted to do exactly. :)

>
>> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
>> index 6238247..446743b 100644
>> --- a/builtin/name-rev.c
>> +++ b/builtin/name-rev.c
>> @@ -97,7 +97,8 @@ static int name_ref(const char *path, const unsigned char *sha1, int flags, void
>>   	if (data->tags_only && prefixcmp(path, "refs/tags/"))
>>   		return 0;
>>
>> -	if (data->ref_filter && fnmatch(data->ref_filter, path, 0))
>> +	if (data->ref_filter && !prefixcmp(data->ref_filter, "refs/")
>> +	    && fnmatch(data->ref_filter, path, 0))
>>   		return 0;
>
> What does this mean?  "When --refs is specified, if it begins with
> refs/ then do not show unmatching path, but let any path be subject
> to the following if --refs does not begin with refs/" sounds like a
> broken logic, unless you add another fnmatch() later in the codepath
> to compensate.  And you indeed do so, but then at that point, do we
> still need this "if(...) return 0" at all?
>
> I think it can and should be improved here, and then the one in the
> main logic you added can be removed.
>
> Wouldn't it make more sense to see if the given pattern matches a
> tail substring of the ref, instead of using the hardcoded "strip
> refs/heads/, refs/tags or refs/, and then match once" logic?  That
> way, --refs=origin/* can find refs/remotes/origin/master by running
> fnmatch of origin/* against its substrings, i.e.
>
> 	refs/remotes/origin/master
>          remotes/origin/master
>          origin/master
>
> and find that the pattern matches it.
>
> Perhaps it is just the matter of adding something like:
>
> 	static int subpath_matches(const char *path, const char	*filter)
> 	{
> 		const char *subpath = path;
> 		while (subpath) {
>                  	if (!fnmatch(data->ref_filter, subpath, 0))
> 				return subpath - path;
> 			subpath = strchr(path, '/');
   					 subpath

>                          if (subpath)
> 	                        subpath++;
> 		}
> 		return -1;
> 	}
>
> and then at the beginning of name_ref() do this:
>
> 	int can_abbreviate_output = data->name_only;
>
> 	if (data->tags_only && prefixcmp(path, "refs/tags/"))
> 		return 0;
> 	if (data->ref_filter) {
>          	switch (subpath_matches(path, data->ref_filter)) {
> 		case -1: /* did not match */
> 			return 0;
> 		default: /* matched subpath */
> 			can_abbreviate_output = 1;
> 			break;
> 		case 0: /* matched fully */
>                  	break;
> 		}
> 	}
>
> The logic before calling name_rev() will be kept as "only decide how
> the output looks like", without mixing the unrelated "decide if we
> want to use it" logic in.

Looks good to me with the little change above!

I'll resend v2 with changes in this and your other reply.

Thanks,
Namhyung
