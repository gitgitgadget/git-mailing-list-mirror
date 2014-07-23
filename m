From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v7 23/31] checkout: clean up half-prepared directories in
 --to mode
Date: Wed, 23 Jul 2014 15:02:03 +0700
Message-ID: <CACsJy8CmKZj8soQ09h=6LYf94OVjtydbb2HXBszTPCfta0_Khg@mail.gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
 <1405227068-25506-1-git-send-email-pclouds@gmail.com> <1405227068-25506-24-git-send-email-pclouds@gmail.com>
 <CAPig+cRE0xOhQM4mtJQRX_gSQ3_OMr6ws87wU03TZ1eaUXui2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Max Kirillov <max@max630.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 10:02:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9rVZ-0000Hz-VX
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 10:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755658AbaGWICg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 04:02:36 -0400
Received: from mail-qa0-f51.google.com ([209.85.216.51]:63543 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498AbaGWICe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 04:02:34 -0400
Received: by mail-qa0-f51.google.com with SMTP id k15so873365qaq.10
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 01:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YoVdl87Xxk9Co5yV9CffJFH0qAt7SJOnm18xpWkox2M=;
        b=aaIjejteole0ediTZrDSkKKK7X9Zh9cAHywejD4uitHmgWdX9qvN0plL0OUDv+S+J/
         KCYJrwwrzPvu2mOm/oYyqv467IcL4A3IGuMUlTkF7ZBDPkFzMMnFnqHqj8sd+RcwBY9F
         6j4AEr/O13FV8MghF4VEt1FETbe+lYQAF/6y5JjdZZID9TRx3Irrx7xdluArpnpFsRE3
         s+Pq312qRR+/nEbcjFsPHCVpTPIon/XtFlS4bo49W4G3vvXbp32XAul5E0u04L5C4Vvh
         kAqArFplMPg31X5zQ3QDNKikCzJCdGTHUm2Xuddh5V8bpGJCPIQmjqAUp1D3Rhw3CCeV
         XJGw==
X-Received: by 10.140.82.227 with SMTP id h90mr59987981qgd.80.1406102553670;
 Wed, 23 Jul 2014 01:02:33 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Wed, 23 Jul 2014 01:02:03 -0700 (PDT)
In-Reply-To: <CAPig+cRE0xOhQM4mtJQRX_gSQ3_OMr6ws87wU03TZ1eaUXui2g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254061>

On Mon, Jul 21, 2014 at 6:55 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> @@ -848,13 +878,21 @@ static int prepare_linked_checkout(const struct checkout_opts *opts,
>>                 strbuf_addf(&sb_repo, "%d", counter);
>>         }
>>         name = strrchr(sb_repo.buf, '/') + 1;
>> +
>> +       junk_pid = getpid();
>> +       atexit(remove_junk);
>> +       sigchain_push_common(remove_junk_on_signal);
>> +
>>         if (mkdir(sb_repo.buf, 0777))
>>                 die_errno(_("could not create directory of '%s'"), sb_repo.buf);
>> +       junk_git_dir = sb_repo.buf;
>
> I've managed to convince myself that, although junk_git_dir becomes a
> dangling pointer by the end of prepare_linked_checkout(), it should
> never afterward be accessed. Perhaps it would make sense to make this
> easier to follow by clearing junk_git_dir when is_junk is cleared?

You're right. And the dangling junk_git_dir can be accessed if "ret"
below is non-zero. Will strdup() both junk_*_dir and free them in "if
(!ret)" block. Thanks for catching.

>> @@ -879,7 +917,14 @@ static int prepare_linked_checkout(const struct checkout_opts *opts,
>>         memset(&cp, 0, sizeof(cp));
>>         cp.git_cmd = 1;
>>         cp.argv = opts->saved_argv;
>> -       return run_command(&cp);
>> +       ret = run_command(&cp);
>> +       if (!ret)
>> +               is_junk = 0;
>
> Here: perhaps also set is_junk_dir to NULL since it otherwise is about
> to become a dangling pointer.
>
>> +       strbuf_release(&sb);
>> +       strbuf_release(&sb_repo);
>> +       strbuf_release(&sb_git);
>> +       return ret;
-- 
Duy
