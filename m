From: Bryan Turner <bturner@atlassian.com>
Subject: Re: git diff-tree commit detail bug in 2.0.2 and 2.0.3
Date: Mon, 28 Jul 2014 22:08:20 +1000
Message-ID: <CAGyf7-GVz8ME0Mq_DyHCSFCx5KN6qLGEgtgMSv2NkKb9AGEGdg@mail.gmail.com>
References: <CAGyf7-HKpfyi5OqXS9BhtfXUEZXbisawpTPK9UFOQObz1qhRUw@mail.gmail.com>
	<20140728103504.GB10737@peff.net>
	<20140728104409.GC10737@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git Users <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 28 14:08:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBjj7-0004SI-MS
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 14:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbaG1MIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 08:08:21 -0400
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:35241 "HELO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751674AbaG1MIV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jul 2014 08:08:21 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]) (using TLSv1) by na3sys009aob101.postini.com ([74.125.148.12]) with SMTP
	ID DSNKU9Y9NABySILKLDEbA1BBOdjb33jyHuMU@postini.com; Mon, 28 Jul 2014 05:08:21 PDT
Received: by mail-oa0-f45.google.com with SMTP id i7so8622172oag.32
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 05:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=cuQtwZOOKFbI7D97hHY2NuFXUe9GSJeOmsC/Kp3rSQM=;
        b=bAuTudPM8RPkgnYnxpDFURXDO1eaNK9hufBwCeWA5Zh9sk0meYkRzIIrD6MS8f83i0
         45S0FtcKm/+MrvTWR1wLexcGpY8uLTBoBZitxoxIVSoFNK6vf6g4J9S26ycpAla2aJ/I
         sQt12sIqEAJ4lzkvvpWMmM1gj1dnL/tFeOTLkiBW1v+jyyFn5rFl6CixhXsctvV7s1Mw
         wq6JLZmO/qs5Mae3jsyvClUIvHyYqJGkaGd5va1ZDmreCM9dPxKXEIqVFrEt0Uk0axiF
         KhrZd2B9kiwF55+G09HNbSZwnJFOi/bbSoADXbKwcCbQBvqh3dXvwWcVOg2kijCYN+6s
         fr6g==
X-Gm-Message-State: ALoCoQnoj23jDrT61Gx2U4XJFUVdIIq7LDn27p3UxJxVeMkulrYNKO2ZMWzUTqmZ0bjZmKt9FSvdt3QaYn/UIIZqegvnY/tAjJSytU4MFarS9vbX5SuCF0wpLqvO/aW3SHvf78mFpRS0
X-Received: by 10.182.18.101 with SMTP id v5mr33936721obd.64.1406549300365;
        Mon, 28 Jul 2014 05:08:20 -0700 (PDT)
X-Received: by 10.182.18.101 with SMTP id v5mr33936703obd.64.1406549300286;
 Mon, 28 Jul 2014 05:08:20 -0700 (PDT)
Received: by 10.182.51.130 with HTTP; Mon, 28 Jul 2014 05:08:20 -0700 (PDT)
In-Reply-To: <20140728104409.GC10737@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254324>

On Mon, Jul 28, 2014 at 8:44 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Jul 28, 2014 at 06:35:04AM -0400, Jeff King wrote:
>
>> I haven't reproduced here yet, but this is almost certainly the bug
>> where lookup_unknown_object causes a bogus commit->index field (and
>> prior to the commit you found, diff-tree did not use commit->index).
>>
>> The series that Junio has in jk/alloc-commit-id should fix the problem
>> (it's in master already, and slated for v2.1.0).
>
> Yep, that's definitely it. Here's the minimum reproduction:
>
>   git init
>   git commit --allow-empty -m one
>   git commit --allow-empty -m two
>   git rev-list HEAD | git diff-tree --stdin --always --format=%s
>
> That yields:
>
>   one
>   one
>
> on v2.0.3, but merging in jk/alloc-commit-id yields:
>
>   two
>   one
>
> -Peff

Thanks for digging into it, Jeff. I should have tried it against 2.1.0
myself. I've run my entire matrix of tests now against 2.1.0-rc0 and
the diff-tree bug appears fixed on that tag. I noticed a different
change, though:

bturner@ubuntu:~/tmp/test$ /opt/git/2.1.0-rc0/bin/git check-ref-format
ref/with/trailing/dot.
bturner@ubuntu:~/tmp/test$ echo $?
0
bturner@ubuntu:~/tmp/test$ /opt/git/2.0.3/bin/git check-ref-format
ref/with/trailing/dot.
bturner@ubuntu:~/tmp/test$ echo $?
1

It looks like refs ending in a dot are now legal in 2.1.0? Is that
intentional? A quick git bisect is fingering:
bturner@ubuntu:~/Development/oss/git/git$ git bisect bad
745224e04a03e4544c58d5d38d3c54f67100f8eb is the first bad commit
commit 745224e04a03e4544c58d5d38d3c54f67100f8eb
Author: David Turner <dturner@twopensource.com>
Date:   Wed Jun 18 01:54:42 2014 -0400

Best regards,
Bryan Turner
