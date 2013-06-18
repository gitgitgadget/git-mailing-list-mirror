From: Namhyung Kim <namhyung.kim@lge.com>
Subject: Re: [PATCH] name-rev: Allow to omit refs/tags/ part in --refs option
 when --tags used
Date: Tue, 18 Jun 2013 21:24:53 +0900
Message-ID: <51C05195.7000403@lge.com>
References: <1371455636-1378-1-git-send-email-namhyung.kim@lge.com> <7vip1chi50.fsf@alter.siamese.dyndns.org> <7vehc0hgy6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 14:25:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uouy4-0004mR-BS
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 14:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755579Ab3FRMY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 08:24:56 -0400
Received: from LGEMRELSE6Q.lge.com ([156.147.1.121]:48318 "EHLO
	LGEMRELSE6Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650Ab3FRMYz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 08:24:55 -0400
X-AuditID: 9c930179-b7c30ae0000047e1-eb-51c0519589e8
Received: from [192.168.0.2] ( [10.177.220.181])
	by LGEMRELSE6Q.lge.com (Symantec Brightmail Gateway) with SMTP id B8.2C.18401.59150C15; Tue, 18 Jun 2013 21:24:53 +0900 (KST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <7vehc0hgy6.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228211>

2013-06-18 AM 12:53, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Wouldn't it make more sense to see if the given pattern matches a
>> tail substring of the ref, instead of using the hardcoded "strip
>> refs/heads/, refs/tags or refs/, and then match once" logic?  That
>> way, --refs=origin/* can find refs/remotes/origin/master by running
>> fnmatch of origin/* against its substrings, i.e.
>>
>> 	refs/remotes/origin/master
>>          remotes/origin/master
>>          origin/master
>>
>> and find that the pattern matches it.
>>
>> Perhaps it is just the matter of adding something like:
>> ...
>> and then at the beginning of name_ref() do this:
>>
>> 	int can_abbreviate_output = data->name_only;
>>
>> 	if (data->tags_only && prefixcmp(path, "refs/tags/"))
>> 		return 0;
>> 	if (data->ref_filter) {
>>          	switch (subpath_matches(path, data->ref_filter)) {
>> 		case -1: /* did not match */
>> 			return 0;
>> 		default: /* matched subpath */
>> 			can_abbreviate_output = 1;
>> 			break;
>> 		case 0: /* matched fully */
>>                  	break;
>> 		}
>> 	}
>>
>> The logic before calling name_rev() will be kept as "only decide how
>> the output looks like", without mixing the unrelated "decide if we
>> want to use it" logic in.
>
> ... which may make the "call name_rev with this abbreviated path"
> logic look something like this:
>
> 	if (o && o->type == OBJ_COMMIT) {
>          	if (can_abbreviate_output)
> 			path = shorten_unambiguous_ref(path, 0);
> 		else if (!prefixcmp(path, "refs/heads/"))
> 			path = path + 11;
> 		else if (data->tags_only
> 		    && data->name_only
> 		    && !prefixcmp(path, "refs/tags/"))
> 			path = path + 10;
> 		else if (!prefixcmp(path, "refs/"))
> 			path = path + 5;
>
> 		name_rev((struct commit *) o, xstrdup(path), 0, 0, deref);
> 	}
>
>

Hmm.. I thought about it twice.

This will affects the output of `--name-only 
--refs=refs/remotes/origin/*` case.  (AFAIK it only affected to tags so 
far)  As the name_only always sets can_abbreviate_output, it'll shorten 
the name of remote ref even if it's fully matched.

  $ ./git name-rev --refs=refs/remotes/origin/* a2055c2
  a2055c2 remotes/origin/maint~642

  $ ./git name-rev --refs=refs/remotes/origin/* --name-only a2055c2
  origin/maint~642

I think it should be 'data->tags_only && data->name_only' for 
compatibility reason.

I also see that the 3rd condition of 'tags_only && name_only' turned out 
to be useless for the similar reason.  When name_only set, it'll take 
the first case so 3rd case cannot be reached. When it's not set it 
cannot take the third case too obviously.  So I'll just remove it.

Thanks,
Namhyung
