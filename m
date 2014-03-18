From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv2] branch.c: simplify chain of if statements
Date: Tue, 18 Mar 2014 19:50:59 -0400
Message-ID: <CAPig+cQKHQFNBob18g9UmZuE_mOpF3UMCBPfSKJYEYQpk1Z_tw@mail.gmail.com>
References: <1395071493-31435-1-git-send-email-dragos.foianu@gmail.com>
	<CAPig+cS9QApn1T3-R8n+W+1ee9FbNftsmhrr90SJKs+gqzvC5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Dragos Foianu <dragos.foianu@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 00:51:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQ3ml-0006y2-9V
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 00:51:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755351AbaCRXvC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 19:51:02 -0400
Received: from mail-yh0-f52.google.com ([209.85.213.52]:36646 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbaCRXvA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 19:51:00 -0400
Received: by mail-yh0-f52.google.com with SMTP id c41so7741789yho.11
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 16:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=T7ybpTQYwTJl9ZoQD+SfW419oQdO7z4aP9nfcYrdOSg=;
        b=L0yMATWi89+7yA+fyH2BY4osHeDQgWIy9el4xJr/b7bu6mJGcRb3WApGRk80eE28DL
         q88/zjfP3ud2gHgpi35psGdOfMNd0NjhuM/tYMlcbCrfjzyXidF3CmwIG0sa43EOzk9/
         X0IJ7XjdHa2uIZ4CGbapaks6CBzE1JYw+sDWq2zJgtzy18Bt/VE6rDZYkI1TVeesiH3b
         YYst8saIz5f5GwcXRcIYfAGQCDcE3fhj6gnM1km7Hyu8ap3M1YsvO1xmrAWh15ZX2eai
         x4V1xLKmNIb32tFHDZHr8x9omX4laANJx9rtP5BcoCnDjJ4yanpwZxf26JewVAw7nipK
         R4sg==
X-Received: by 10.236.79.134 with SMTP id i6mr22183638yhe.16.1395186659951;
 Tue, 18 Mar 2014 16:50:59 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Tue, 18 Mar 2014 16:50:59 -0700 (PDT)
In-Reply-To: <CAPig+cS9QApn1T3-R8n+W+1ee9FbNftsmhrr90SJKs+gqzvC5A@mail.gmail.com>
X-Google-Sender-Auth: iRxSlj21seO6C-HHwWQAD-y3eu4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244397>

On Tue, Mar 18, 2014 at 6:31 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Mar 17, 2014 at 11:51 AM, Dragos Foianu <dragos.foianu@gmail.com> wrote:
>> This patch uses a table to store the different messages that can
>> be emitted by the verbose install_branch_config function. It
>> computes an index based on the three flags and prints the message
>> located at the specific index in the table of messages. If the
>> index somehow is not within the table, we have a bug.
>>
>> Signed-off-by: Dragos Foianu <dragos.foianu@gmail.com>
>> ---
>>  branch.c | 44 +++++++++++++++++++++++++-------------------
>>  1 file changed, 25 insertions(+), 19 deletions(-)
>>
>> diff --git a/branch.c b/branch.c
>> index 723a36b..95645d5 100644
>> --- a/branch.c
>> +++ b/branch.c
>> @@ -54,6 +54,18 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
>> +       int index = 0;
>> +       if (origin)
>> +               index += 1;
>> +       if (remote_is_branch)
>> +               index += 2;
>> +       if (rebasing)
>> +               index += 4;
>> +
>> +               if (index < 0 || index > sizeof(messages) / sizeof(*messages))
>>                         die("BUG: impossible combination of %d and %p",
>>                             remote_is_branch, origin);

One other observation: You have a one-off error in your out-of-bounds
check. It should be 'index >= sizeof...'

> You can use ARRAY_SIZE() in place of sizeof(...)/sizeof(...).
>
> Since an out-of-bound index would be a programmer bug, it would
> probably be more appropriate to use an assert(), just after 'index' is
> computed, rather than if+die(). The original code used die() because
> it couldn't detect the error until the end of the if-chain.
>
>>         }
>> --
>> 1.8.3.2
