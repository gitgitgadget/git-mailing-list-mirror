From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v20 31/48] receive-pack.c: use a reference transaction for
 updating the refs
Date: Mon, 14 Jul 2014 11:51:25 -0700
Message-ID: <CAL=YDW=BNCSHGSVa5N6-GC4uZZLb6BPsiEjv6jXCsAXehT+kwg@mail.gmail.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
	<1403275409-28173-32-git-send-email-sahlberg@google.com>
	<53BBF016.7040107@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jul 14 20:51:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6lLW-00033F-Pj
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 20:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756791AbaGNSv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 14:51:27 -0400
Received: from mail-vc0-f181.google.com ([209.85.220.181]:34158 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756529AbaGNSv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 14:51:26 -0400
Received: by mail-vc0-f181.google.com with SMTP id lf12so4296558vcb.12
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 11:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ALzEidbfAnG7r7M0fqo1HOLTpFVAdyZ6ZzyEQ54IPVI=;
        b=Nq6om44dF7aASvZPkdq8svVhyLzYW4i2kbtwHj6G48GZEnJQ5SPLYs7TJT8TdOE2bI
         ShVTURRxBORJsbSOYMolkDf4Nt3Q2tH3tJd9iDcz50UyE8l17NpbULgNO+SWOcXzi0Ov
         WyME4AAZ/zlZJSWNwGvF9uBCVkgKrMGd3ORXdlRGQge6ttA9TBIfh5M3zZMt+3QSXZAO
         tuMcuTrzQr56j1lULVXcboC4BFGaqtfbFaG6V5gBjax3Yosg0yXqiG80tJorovE/IQld
         hxhy11WzSw4GBynrUteZY5m6MUAvxe3DsSyy314sfquCEZhiJQq9/EtWoSUaRLK95HZm
         B/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ALzEidbfAnG7r7M0fqo1HOLTpFVAdyZ6ZzyEQ54IPVI=;
        b=OTH303q7p10lT3dTrn3cxfVFRUtOI4D+nfGTT95HgpTY6lUGoIn3Yzf17B3/05etk/
         Y+hB6bNBLKKHsqm9ioo3/jyYMYmq2C2y7Jkt80yoSrTnRgAdWkGY+K6UUwZR1xpWN618
         sAE3KPWAJBU76DoifSecQjfcHxFZ+P840LgRz5RlwxeB4EVpwrMEmukESfI/bPc4ZbpX
         JXuZbIdNwsVR85ScpsJna/3fgUI0LnzoZeHtaLvfQPiTmOucGFO8q63ryaRQE0BRN9Vz
         M1WqS40S0v0afmOAElyYMlyCd0ZcevEGv9QwL4Vj3914SIirjnngsurZ4XZwhj2ij93+
         WvPg==
X-Gm-Message-State: ALoCoQn+qxH1Znn2G8rA/b54x9Cvh481TU4+g9JmQz2RoFIc0dfw7qzn3fKu7KS1SqYRtzmzrYx1
X-Received: by 10.52.108.234 with SMTP id hn10mr14563233vdb.4.1405363885476;
 Mon, 14 Jul 2014 11:51:25 -0700 (PDT)
Received: by 10.52.136.166 with HTTP; Mon, 14 Jul 2014 11:51:25 -0700 (PDT)
In-Reply-To: <53BBF016.7040107@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253509>

On Tue, Jul 8, 2014 at 6:20 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 06/20/2014 04:43 PM, Ronnie Sahlberg wrote:
>> Wrap all the ref updates inside a transaction.
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  builtin/receive-pack.c | 96 +++++++++++++++++++++++++++++++++-----------------
>>  1 file changed, 63 insertions(+), 33 deletions(-)
>>
>> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
>> index c323081..b51f8ae 100644
>> --- a/builtin/receive-pack.c
>> +++ b/builtin/receive-pack.c
>> [...]
>> @@ -647,6 +654,9 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
>>       char cmd_oldh[41], cmd_newh[41], dst_oldh[41], dst_newh[41];
>>       int flag;
>>
>> +     if (cmd->error_string)
>> +             die("BUG: check_alised_update called with failed cmd");
>
> s/check_alised_update/check_aliased_update/

Done, thanks.
