From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 11/19] dir.c: use a single struct exclude_list per
 source of excludes
Date: Fri, 04 Jan 2013 23:54:34 -0800
Message-ID: <7v623cqd39.fsf@alter.siamese.dyndns.org>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
 <1356575558-2674-12-git-send-email-git@adamspiers.org>
 <7v1ue0veww.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Sat Jan 05 08:57:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrOct-0006cv-A3
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 08:57:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754753Ab3AEHyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 02:54:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51154 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751208Ab3AEHyy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 02:54:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 465CB82B3;
	Sat,  5 Jan 2013 02:54:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dFbqZYUEqpntl3tipLp8DL5w6Cw=; b=bFR2fC
	f/jGGGlun2ujKMGXqlOSD6GDp5ppUKiz4DDKR+8hfs8JUxK03T8uCo37uun06cJB
	m/715dF0qse0qczD6YGhq/sBHTQ5LbePgXWMVDLUSHjPfnFqTdN5I5xCn+2NOJ3G
	OaeXiFX6lEZqoN2LVupQnj27f95VNYlJuDObQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QPK/ImS7C0yGLCP5qLd5u8n+dcTPmWBd
	FWXjL2WLkFN8a4AyJ+c/YMP4ZzSvK+XznwxNU2iE/6Mgb9V5KdGPmBrxqgMDtjcB
	h8QfrgqlMXAgZrH31Vr3vcbbWiZ722DvLk04PZ6rENNnfHQOqZDX9+Z+Z0Oh/vRJ
	pXZaJQiqDcc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3908282B1;
	Sat,  5 Jan 2013 02:54:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D609B82AC; Sat,  5 Jan 2013
 02:54:48 -0500 (EST)
In-Reply-To: <7v1ue0veww.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 04 Jan 2013 13:03:59 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2DC881C2-570D-11E2-8134-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212680>

Junio C Hamano <gitster@pobox.com> writes:

> Adam Spiers <git@adamspiers.org> writes:
>
>> diff --git a/builtin/clean.c b/builtin/clean.c
>> index 0c7b3d0..bd18b88 100644
>> --- a/builtin/clean.c
>> +++ b/builtin/clean.c
>> @@ -97,9 +97,10 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>>  	if (!ignored)
>>  		setup_standard_excludes(&dir);
>>  
>> +	add_exclude_list(&dir, EXC_CMDL);
>>  	for (i = 0; i < exclude_list.nr; i++)
>>  		add_exclude(exclude_list.items[i].string, "", 0,
>> -			    &dir.exclude_list[EXC_CMDL]);
>> +			    &dir.exclude_list_groups[EXC_CMDL].ary[0]);
>
> This looks somewhat ugly for two reasons.
>
>  * The abstraction add_exclude() offers to its callers is just to
>    let them add one pattern to the list of patterns for the kind
>    (here, EXC_CMDL); why should they care about .ary[0] part?  Are
>    there cases any sane caller (not the implementation of the
>    exclude_list_group machinery e.g. add_excludes_from_... function)
>    may want to call it with .ary[1]?  I do not think of any.
>    Shouldn't the public API function add_exclude() take a pointer to
>    the list group itself?
>
>  * When naming an array of things, we tend to prefer naming it
>
>      type thing[count]
>
>    so that the second element can be called "thing[2]" and not
>    "things[2]".  dir.exclude_list_group[EXC_CMDL] reads better.

Also, "ary[]" is a bad name, even as an implementation detail, for
two reasons: it is naming it after its type (being an "array") not
after what it is (if it holds the patterns from the same information
source, e.g. file, togeter, "src" might be a better name), and it
uses rather unusual abbreviation (I haven't seen "array" shortened
to "ary" anywhere else).

>
>> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
>> index ef7f99a..c448e06 100644
>> --- a/builtin/ls-files.c
>> +++ b/builtin/ls-files.c
>> @@ -420,10 +420,10 @@ static int option_parse_z(const struct option *opt,
>>  static int option_parse_exclude(const struct option *opt,
>>  				const char *arg, int unset)
>>  {
>> -	struct exclude_list *list = opt->value;
>> +	struct exclude_list_group *group = opt->value;
>>  
>>  	exc_given = 1;
>> -	add_exclude(arg, "", 0, list);
>> +	add_exclude(arg, "", 0, &group->ary[0]);
>
> This is another example where the caller would wish to be able to say
>
> 	add_exclude(arg, "", 0, group);
>
> instead.
