From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 05/15] refs.c: update rename_ref to use a transaction
Date: Tue, 28 Oct 2014 13:56:16 -0700
Message-ID: <CAL=YDWm05PyO07HbiOTiweh+3AEvXnbptbzoreLw-b9YUrm-Hg@mail.gmail.com>
References: <1413923820-14457-1-git-send-email-sahlberg@google.com>
	<1413923820-14457-6-git-send-email-sahlberg@google.com>
	<xmqqppdcj9m9.fsf@gitster.dls.corp.google.com>
	<xmqqlho0j7dq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 28 21:56:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjDoc-00069M-FE
	for gcvg-git-2@plane.gmane.org; Tue, 28 Oct 2014 21:56:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337AbaJ1U41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2014 16:56:27 -0400
Received: from mail-qc0-f176.google.com ([209.85.216.176]:52932 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220AbaJ1U40 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2014 16:56:26 -0400
Received: by mail-qc0-f176.google.com with SMTP id x3so1288310qcv.7
        for <git@vger.kernel.org>; Tue, 28 Oct 2014 13:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=j5a0TQEfVVU4+g4rA8Rx7YNQ4Ev2ISOIc1iVy6nUDbA=;
        b=UEX4jylhLKeeThf+/CcEfZW4TOHdfyRYGC085egWwkiCz9gRRNq+Y5UfaeH6qTrxjW
         Kxh5haP9QPUBIPtnOjBtfYd6nNjRG2IXErclYoNHycP1rgSyE1vy3ofZGoaGCpjB/soS
         ZsYn2V8SXi2f/SoPcLh8OjntbzeszoMcu5AwW3qJvHdh5u9GYxV2rhYTDdS1ruQbLoUe
         cwnqRznRTGdEZnU+jXLMOUMAyM+mQCyOMP3aC00J2zLbU6IyBTTIPdWiaIdr3ZbEYY7i
         hm0o0c/05QEFv4xfHIYG825dcYNSwu3fo9PJGUMNdtDrViq53riKTyjzqYgoi+xb8nMG
         7wKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=j5a0TQEfVVU4+g4rA8Rx7YNQ4Ev2ISOIc1iVy6nUDbA=;
        b=Vd2m0VUL/u9TebiOozPA5G25rU/ElHULY+VVMvR2SgICNaq7Nf9BWnQLs5MsJl/ORp
         nxZaCohQ7Ry1RxCV8OLbk0B0EEzDFYyBZZ4x8eg/Rnsp5F0lTQ0sPzIDnK0AVks3eeXi
         1cJ9mtvTXU5VgCSyiG9+GmzfG6qobAmJvFvDU82v2txLktL9b9Bks+wxsA6F9rJb0Sn4
         BNkZZfHMK/z8j8ruKKivF8OojwJbzLRV/KhoLPYCNZlvk1NhFwv/fZN0h9CUzR956Xpu
         162bh9CYWsNvo8yPfh801ySAmw39gDJfWt9O/huXnGW1oZR0rSZUVvj2Mna4cOlsCTig
         UlFw==
X-Gm-Message-State: ALoCoQmEznXk3FAX57NY2s5DzPuNZEYXTq5uE8ZT5ljAxxaLGQHjiJkYiDGdYwt9gPLjTqs2zNk2
X-Received: by 10.224.2.135 with SMTP id 7mr9299664qaj.64.1414529776195; Tue,
 28 Oct 2014 13:56:16 -0700 (PDT)
Received: by 10.229.225.202 with HTTP; Tue, 28 Oct 2014 13:56:16 -0700 (PDT)
In-Reply-To: <xmqqlho0j7dq.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 28, 2014 at 12:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Ronnie Sahlberg <sahlberg@google.com> writes:
>>
>>> commit 0295e9cebc41020ee84da275549b164a8770ffba upstream.
>>>
>>> Change refs.c to use a single transaction to copy/rename both the refs and
>>> its reflog. Since we are no longer using rename() to move the reflog file
>>> we no longer need to disallow rename_ref for refs with a symlink for its
>>> reflog so we can remove that test from the testsuite.
>>
>> Do you mean that we used to do a single rename(2) to move the entire
>> logfile, but now you copy potentially thousands of reflog entries
>> one by one?
>>
>> Hmmmm,... is that an improvement?

I think so. It makes to code a lot simpler and more atomic. As a side
effect it removes restrictions for symlink handling and eliminates the
two renames colliding race.
Though, a read and then rewrite thousands of reflog entries will be
slower than a single rename() syscall.

>
> I see some value in "keep the original while creating a new one,
> just in case we fail to fully recreate the new one so that we can
> roll back with less programming effort".  But still, we should be
> able to copy the original to new without parsing and reformatting
> each and every entry, no?

Is renaming a branch with a long history is such a frequent or time
critical event?
I timed a git branch -m for a branch with ~2400 log entries and it
takes neglible time :
  real 0m0.008s
  user 0m0.000s
  sys 0m0.007s


During the special rename case, we are deleting one ref and creating
another. For cases such as m->m/m or the reverse we must delete the
old file/directory before we can create the new one.

The old rename code did this by renaming the file out to a common
directory and then back to the new location. Which is fast (but a bit
...)
The alternative is to read the old file into memory, delete it and
then write the content back to the new location, which is kind of what
the new code does.

If this turns out to be a bottleneck we can change the io when writing
the reflog entries to use fwrite(). Lets see if there is a problem
first.

regards
ronnie sahlberg
