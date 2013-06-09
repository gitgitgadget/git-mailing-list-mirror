From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 11/45] cherry-pick: don't barf when there's nothing to do
Date: Sun, 9 Jun 2013 14:32:53 -0500
Message-ID: <CAMP44s1we+wVc6pwNFr+CxusEKp+yLswZKCL8RCiw4PVbA1ahw@mail.gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
	<1370796057-25312-12-git-send-email-felipe.contreras@gmail.com>
	<20130609192143.GC12122@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 21:33:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllMK-0006Kp-Ly
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:33:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008Ab3FITc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:32:56 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:53193 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792Ab3FITcz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:32:55 -0400
Received: by mail-lb0-f179.google.com with SMTP id w20so5685139lbh.10
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=c25DDsy54W0430DYI9eW9JEIvWUcTEbMOpG5dy9JPOA=;
        b=RdF4hLa6gvwDs3Len0NXGKq4/eRFHwINLHQ+jfdX5W3HrpYI4oFj3Kx5iYk6WwExOz
         lCs4pnNCooI+G8bE58MkkZ1mwRZNYpO7IQ6W4F3W7ptMCFWpWL66u6p2L5oCHa4PpsLE
         VyNtTA2/NYFLHCTIE82k1n1dbqB/aPHy3/ZTBRFPnBWj+qFqBya247Ot6nnLj4p5kVy6
         KvLnxsNI4EEgwVZ7XRkiiJy5O0RLUDeyRmnCb+ZVUfJ6e+lJC3lHTyx1F/6EsqGmFHbS
         rMy1F+XlgD5jd57lbaY3DX6VYW+GPHMcWS4RoVmrBgmFZiMPLmN7BsFJ+VJDVOiNo3Cr
         hXnQ==
X-Received: by 10.112.166.67 with SMTP id ze3mr5160721lbb.25.1370806373934;
 Sun, 09 Jun 2013 12:32:53 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 12:32:53 -0700 (PDT)
In-Reply-To: <20130609192143.GC12122@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227148>

On Sun, Jun 9, 2013 at 2:21 PM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
> On Sun, Jun 09, 2013 at 11:40:23AM -0500, Felipe Contreras wrote:
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  builtin/sequencer.c             | 4 ++--
>>  t/t3510-cherry-pick-sequence.sh | 2 +-
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/builtin/sequencer.c b/builtin/sequencer.c
>> index 23b01b7..4d7dc8b 100644
>> --- a/builtin/sequencer.c
>> +++ b/builtin/sequencer.c
>> @@ -565,8 +565,8 @@ static void prepare_revs(struct replay_opts *opts)
>>       if (prepare_revision_walk(opts->revs))
>>               die(_("revision walk setup failed"));
>>
>> -     if (!opts->revs->commits)
>> -             die(_("empty commit set passed"));
>> +     if (!opts->revs->commits && !opts->quiet)
>> +             error(_("empty commit set passed"));
>>  }
>>
>>  static void read_and_refresh_cache(struct replay_opts *opts)
>> diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
>> index 7b7a89d..33c5512 100755
>> --- a/t/t3510-cherry-pick-sequence.sh
>> +++ b/t/t3510-cherry-pick-sequence.sh
>> @@ -472,7 +472,7 @@ test_expect_success 'malformed instruction sheet 2' '
>>
>>  test_expect_success 'empty commit set' '
>>       pristine_detach initial &&
>> -     test_expect_code 128 git cherry-pick base..base
>> +     git cherry-pick base..base
>
> Shouldn't this result in the error "empty commit set passed"? If so,
> shouldn't that be checked to actually print that error?

Probably, yeah.

-- 
Felipe Contreras
