From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [WIP/RFC PATCH 1/2] Introduce GIT_INDEX_PREFIX
Date: Thu, 5 Jun 2008 10:15:26 +0700
Message-ID: <fcaeb9bf0806042015w72295f07k25ad709f5d976b20@mail.gmail.com>
References: <20080604162825.GB23975@laptop>
	 <7vabi1xepi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 05:16:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K45xs-0001Pn-Cw
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 05:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658AbYFEDP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 23:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752329AbYFEDP3
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 23:15:29 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:18398 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbYFEDP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 23:15:28 -0400
Received: by fg-out-1718.google.com with SMTP id 19so234660fgg.17
        for <git@vger.kernel.org>; Wed, 04 Jun 2008 20:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=taXNfPIN0UDyMoPvwf35tTWCR9qzw5H7rRUMxjqjZ5Y=;
        b=ROsj0eYC9m28sIw6gZNC3osa33SgTbeNWm+mKQ3mtDdtw/FfxUsDUwFK1RPpNFjPD5
         6LSR4PMSZqjkgb8PqJMOfEifeUOEG88gKtXDWMd5fxBNbUnXZ1RFq7dkzaVpIqseSrTe
         CcbWIp3HhvgjGq1+wJgsAVXavLSgzesefc3Xo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=mBCT4W32ol7cXbH2VQGxqBmA5P63MqxBewMhz5fSyntu2EB2gkNqzbNsQ+vvg7pzM5
         6i/xhueJQ9wfDX/R+FVwlLtDhHFwq0MP3jmDYx9aT39DBL2ylQSVvFk/TZFXfVNhBN2W
         wM4Vh7J7Pm9cnOQcoMLQFOj6wNJp23gv+Wfko=
Received: by 10.86.100.7 with SMTP id x7mr581932fgb.13.1212635726933;
        Wed, 04 Jun 2008 20:15:26 -0700 (PDT)
Received: by 10.86.79.17 with HTTP; Wed, 4 Jun 2008 20:15:26 -0700 (PDT)
In-Reply-To: <7vabi1xepi.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83847>

On Thu, Jun 5, 2008 at 1:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> GIT_INDEX_PREFIX is used to limit write access to a specific directory.
>> Only "important" information is protected by index prefix (those will
>> be used to create tree objects)
>>
>> When GIT_INDEX_PREFIX is set, any attempt to modify the index (refresh
>> it is okay though) will bail out. read-tree and merge, however, can
>> write to full index. For merge, no conflict is allowed outside index
>> prefix.
>
> This is kind of hard to judge as part of "narrow checkout" series, because
> it is not clear how this will actually _help_ narrow checkout.

When you do narrow checkout. You only have a subdirectory, so you
would not want some commands to accidentally change things outside
that subdirectory in index.

> In other words, as a standalone "protect parts outside a single
> subdirectory" it can be reviewed and judged, but it is unclear how it
> would help narrow checkout if you excempted only a _single_ subdirectory.
> E.g. you might want to limit yourself to arch/x86 _and_ include/asm-x86.

Well it could be extended to support multiple path separated by colon
later if someone needs it :)

> I sympathize that this series will be hard to get right as the places _you
> identify_ in the code as "touching index entries" are the only places that
> you _could_ write test scripts for --- if you missed one codepath it would
> be easy for you to forget writing the test for that codepath.
>
> Having said that...
>
>> @@ -71,6 +73,9 @@ static void setup_git_env(void)
>>       git_graft_file = getenv(GRAFT_ENVIRONMENT);
>>       if (!git_graft_file)
>>               git_graft_file = xstrdup(git_path("info/grafts"));
>> +     index_prefix = getenv(INDEX_PREFIX_ENVIRONMENT);
>> +     if (index_prefix && (!*index_prefix || index_prefix[strlen(index_prefix)-1] != '/'))
>> +             die("GIT_INDEX_PREFIX must end with a slash");
>
> Not nice (aka "why 'must'?").

Simpler handling. Maybe it should append slash by itself if missing.

>> diff --git a/read-cache.c b/read-cache.c
>> index ac9a8e7..4f8d44b 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -23,6 +23,11 @@
>>
>>  struct index_state the_index;
>>
>> +static int outside_index_prefix(const struct index_state *istate, const char *ce_name)
>> +{
>> +     return istate == &the_index && get_index_prefix() && prefixcmp(ce_name, get_index_prefix());
>> +}
>
> The first check above needs to be justified.
>
> If you say "outside of this path are off-limits", why do you allow a
> temporary index that is used during a partial commit and other
> index_states excempt from that rule?

Because unpack_trees writes new index from scratch so it will always
violate that. That check is IMO enough for simple index manipulation
like add/remove an entry. For unpack_trees, I have
check_index_prefix() to match a temporary index with  current index
before it gets written to disk.

Yes I did miss partial commit. Did not know it used temporary index too.

> [the rest]

OK will do.

-- 
Duy
