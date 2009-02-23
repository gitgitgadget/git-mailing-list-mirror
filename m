From: Eugene Letuchy <eletuchy@facebook.com>
Subject: Re: [PATCH] adds --date=raw support to git blame and related documentation
Date: Mon, 23 Feb 2009 09:48:32 -0800
Organization: Facebook
Message-ID: <49A2E170.9030807@facebook.com>
References: <1235379429-20934-1-git-send-email-eletuchy@gmail.com> <7vprh9t6xt.fsf@gitster.siamese.dyndns.org>
Reply-To: eugene@facebook.com
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "eletuchy@gmail.com" <eletuchy@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 18:50:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbewR-0000eg-AY
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 18:50:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752482AbZBWRsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 12:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752241AbZBWRsj
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 12:48:39 -0500
Received: from cm.out.snc1.tfbnw.net ([69.63.179.25]:43802 "EHLO
	mailout-snc1.facebook.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119AbZBWRsj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 12:48:39 -0500
Received: from mail.thefacebook.com (intlb01.snat.snc1.facebook.com [10.128.203.17] (may be forged))
	by pp01.snc1.tfbnw.net (8.14.1/8.14.1) with ESMTP id n1NHmXxS005803
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Mon, 23 Feb 2009 09:48:33 -0800
Received: from eletuchy.local (192.168.18.252) by mail.TheFacebook.com
 (192.168.18.105) with Microsoft SMTP Server (TLS) id 8.1.340.0; Mon, 23 Feb
 2009 09:48:32 -0800
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.1b3pre) Gecko/20090223 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <7vprh9t6xt.fsf@gitster.siamese.dyndns.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.7400:2.4.4,1.2.40,4.0.166 definitions=2009-02-23_02:2009-02-10,2009-02-23,2009-02-23 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111162>

On 2/23/09 9:10 AM, Junio C Hamano wrote:
> eletuchy@gmail.com writes:
>
>> From: Eugene Letuchy<eugene@facebook.com>
>>
>> In the wake of Linus' 7dff9b3, git blame --date support needs to
>> incorporate --date=raw in addition to the previously supported
>> date formats.
>
> Thanks, but I do not understand what you meant by the following two lines:
>
>> Test:>  git grep relative | grep iso | grep -v raw
>>        >  git blame --date=raw builtin-blame.c
>
> With the patch to add --date=raw format already on 'master', I'd prefer a
> reroll of the original patch (it needs a fix for the config "don't ignore
> a misconfiguration" bug Peff pointed out anyway) with this documentation
> update patch squashed in.
>

Yeah I can do that.

>> diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
>> index e6717af..1316d4e 100644
>> --- a/Documentation/blame-options.txt
>> +++ b/Documentation/blame-options.txt
>> @@ -36,7 +36,7 @@ of lines before or after the line given by<start>.
>>   	Show long rev (Default: off).
>>
>>   -t::
>> -	Show raw timestamp (Default: off).
>> +	Synomym for --date=raw (Default: off).
>
> This is interesting.  It suggests that we should internally get rid of
> show_raw_time variable (and need to error out when --date= and -t options
> are given at the same time, as they are mutually incompatible).
>
> But do -t and --date=raw really behave identically?  I think they should
> but I didn't check.
>

The output of -t and --date=raw are exactly identical (well, after this patch 
they are); for that reason, I think providing both is redundant but not an 
error. However, I wanted to retain -t for "git annotate" compatibility, which 
has -t as the sole date option. In git-annotate mode, no other --date mode 
options can apply.

>> diff --git a/builtin-blame.c b/builtin-blame.c
>> index 48cedfd..bb0d20b 100644
>> --- a/builtin-blame.c
>> +++ b/builtin-blame.c
>> @@ -2288,12 +2288,16 @@ parse_done:
>>   	case DATE_RELATIVE:
>>   		blame_date_width = sizeof("14 minutes ago");
>>   		break;
>> +	case DATE_RAW:
>> +		blame_date_width = sizeof("1235155266 -0800");
>> +		output_option |= OUTPUT_RAW_TIMESTAMP;
>> +		break;
>
> I'd prefer it to see a same timestamp used consistently here.  You seem to
> have used "Thu, 19 Oct 2006 16:00:04 -0700" for other case arms (I do not
> know what significant things happened at that time) and what I queued in
> 'pu' has sizeof("1161298804 -0700") there instead.

Thu, 19 Oct 2006 16:00:04 -0700 is the date for the first line of builtin-blame.c
1161298804 -0700 is fine by me.

>
>>   	case DATE_LOCAL:
>>   	case DATE_NORMAL:
>>   		blame_date_width = sizeof("Thu Oct 19 16:00:04 2006 -0700");
>>   		break;
>>   	}
>> -	blame_date_width -= 1; /* strip the null */
>> +	blame_date_width -= 1; /* strip the terminating null */
>
> The character with byte value 0 is called NUL.

OK.

>
> Thanks.
