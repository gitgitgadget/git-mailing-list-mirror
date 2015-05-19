From: Fredrik Medley <fredrik.medley@gmail.com>
Subject: Re: [PATCH 2/3] upload-pack: Prepare to extend allow-tip-sha1-in-want
Date: Tue, 19 May 2015 22:19:14 +0200
Message-ID: <CABA5-zkLY9vnZnAffn7=NYOmaoXeK8LJiNBVmyvRmc803mfGVg@mail.gmail.com>
References: <xmqqy4l1sblq.fsf@gitster.dls.corp.google.com> <1431465265-18486-1-git-send-email-fredrik.medley@gmail.com>
 <1431465265-18486-2-git-send-email-fredrik.medley@gmail.com> <xmqqmw19earu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Dan Johnson <computerdruid@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 19 22:19:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YunzJ-0005fQ-N6
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 22:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbbESUTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 16:19:37 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:35513 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbbESUTg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 16:19:36 -0400
Received: by labbd9 with SMTP id bd9so42945142lab.2
        for <git@vger.kernel.org>; Tue, 19 May 2015 13:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=o64eJdNOjZI1IVw/H01dbp7itd/cfPTaryy1Tvk2AB8=;
        b=n/TSc3pr1LuCdLwiyMd7ocloi24uEvsgM/qHt9Bgtmc4ZWQ8FGqCD0OcEjFwxULlxS
         IHpLwLPV4lZ/z26xNCc4jcay7EB7/4Bl2iCEhs8GiWlYUop3S3Lig6yCoM8snxuJzqtA
         8i+2N/jRFA5Cc+cSWRQ0H2smz++9lORAbOSQuvWCQHMiRosAbXvrm23hdWvoUE/7JHcY
         MRLJACFz1IXBXfF1Rt0zE+MsxR9jcnNeDm9rCdhetDLLAEfSWrdqmbH4DhtEabtY+KFm
         yyyzNW8cssZ+/eiME8bhjaVroeWRMgII3FjzCbVf1rt6bxqAozPVzmcuHvjgrJ+GFt6d
         3zRg==
X-Received: by 10.112.17.68 with SMTP id m4mr23435445lbd.10.1432066775217;
 Tue, 19 May 2015 13:19:35 -0700 (PDT)
Received: by 10.114.246.235 with HTTP; Tue, 19 May 2015 13:19:14 -0700 (PDT)
In-Reply-To: <xmqqmw19earu.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269396>

2015-05-12 23:39 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
> Fredrik Medley <fredrik.medley@gmail.com> writes:
>
>> Subject: Re: [PATCH 2/3] upload-pack: Prepare to extend allow-tip-sha1-in-want
>>
>> diff --git a/fetch-pack.c b/fetch-pack.c
>> index 48526aa..77174f9 100644
>> --- a/fetch-pack.c
>> +++ b/fetch-pack.c
>> @@ -43,7 +43,10 @@ static int marked;
>>  #define MAX_IN_VAIN 256
>>
>>  static struct prio_queue rev_list = { compare_commits_by_commit_date };
>> -static int non_common_revs, multi_ack, use_sideband, allow_tip_sha1_in_want;
>> +static int non_common_revs, multi_ack, use_sideband;
>> +/* Allow specifying sha1 if it is a ref tip. */
>> +#define ALLOW_TIP    01
>> +static int allow_request_with_bare_object_name;
>
> This side is OK, as "request" is by the end user giving the object
> name from its command line.
>
>> diff --git a/upload-pack.c b/upload-pack.c
>> index aa84576..708a502 100644
>> --- a/upload-pack.c
>> +++ b/upload-pack.c
>> @@ -35,7 +35,9 @@ static int multi_ack;
>>  static int no_done;
>>  static int use_thin_pack, use_ofs_delta, use_include_tag;
>>  static int no_progress, daemon_mode;
>> -static int allow_tip_sha1_in_want;
>> +/* Allow specifying sha1 if it is a ref tip. */
>> +#define ALLOW_TIP    01
>> +static int allow_request_with_bare_object_name;
>
> This side is not quite good, as the request coming over wire is
> always 40-hex bare object name.  We are allowing requests against
> what we did not advertise (either the tip of hidden refs, or
> somewhere deep in the history from some tip that may or may not have
> been advertised).
>
> allow-unadvertised-object-request or something, perhaps?
>

My imagination is not any better, so I will stick with
allow_unadvertised_object_request. I do think that that name
fits okay in fetch-pack.c as well. The name will also allow for a
possibly future option of requesting (unadvertised) hidden refs by
name, but it would of course require larger changes of the protocol.
