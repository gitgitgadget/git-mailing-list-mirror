Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60DB51F667
	for <e@80x24.org>; Tue, 22 Aug 2017 23:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752533AbdHVXQR (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 19:16:17 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38876 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751687AbdHVXQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 19:16:16 -0400
Received: by mail-wm0-f45.google.com with SMTP id l19so3934694wmi.1
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 16:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=HfK8tdkZcL4pG+prJI7xgqGgAsNMHeajvSG4ps31XOg=;
        b=nu+wrRApVj7IVLGFt3WfOrHORLlMVw0LHJDOroJLG9WFV7fdj2eQZGP9NgJM5pR4PB
         oSdjFVavNTCBp2yljEvRGUs7Nc5jU9SoGwF5oJcLEcPhHVlhzariVlj480tFBLsPAJG7
         VXanIlOYQYjk6IBBAyFxg+0USL2ZObXd1NMk62wyXWZuwwcuB1mI9a66zGe3kN7gaO2v
         Hd+5Enl5Yvjvs8gvL8YOFhWqDfJlnJOevaZWGS5PaIijwYWWCO6kaLSvlrCraS/bJUmY
         TKMFe9YbAM6gaEDDgiokY7O6PmTE6EXAQA5wxC1OuX0hUkJjoizMt5xRG2xyxqQl0Hze
         5fyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=HfK8tdkZcL4pG+prJI7xgqGgAsNMHeajvSG4ps31XOg=;
        b=pkgh9kU9kaHh5hv/xR+1ocEGwRJHAtgjGxhXoK4bh+8GIpYJxnAtf289w9udnPNeI9
         zrfSrTAsNePwxL3ayY/wLnGUE8fr/gbQsQe1mj+am9Bnie7C8lC8rYixgDvApY2cTJkD
         fvKXxVCsr92JYS1oAyNoVtXtJuI1NG6KixiQTt6qgXfDo5/LJQRG8KtvJ0GFT0GOGChF
         dr9btaLt9jG/F3CxRsRWEm9599IZQTE5EKcVSVk+k+RQ5j9jt2DS6mJvVRuiOcbEOF28
         VtCU/uU8GCDVpJbISz7GTAF8aYKIyJq6E6HUdNytG2ACnd+AMg0RgxTUAU/kDcKeYTJk
         C7lw==
X-Gm-Message-State: AHYfb5hk4xyowTG9sUR0xthPxt6KOomy26tuPEZSflzmLa1ECUvKvsRG
        G51drQj/cb0245OVHDCVV4BQIcIv2bBz
X-Received: by 10.80.219.133 with SMTP id p5mr1429153edk.104.1503443775147;
 Tue, 22 Aug 2017 16:16:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.182.5 with HTTP; Tue, 22 Aug 2017 16:15:54 -0700 (PDT)
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 22 Aug 2017 16:15:54 -0700
Message-ID: <CA+P7+xrtZYUjPcVMkA+x8B57w+LxjjU8YSKcE77DrWne7449rg@mail.gmail.com>
Subject: git send-email Cc with cruft not working as expected
To:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I recently found an issue with git-send-email where it does not
properly remove the cruft of an email address when sending using a Cc:
line.

The specific example is with a commit containing the following Cc line,

Cc: stable@vger.kernel.org # 4.10+

which is the standard way Linux upstream expects the stable Ccs to be,
and I saw several examples of this in the past.

However, this gets converted into a cc of
"stable@vger.kernel.org#4.10+" which isn't a valid address obviously.

This does work as expected if you remember to

Cc: <stable@vger.kernel.org> # 4.10+

I would have assumed that validate_address would kick in and let me
know that the address I'd given isn't valid, or something along those
lines.

I tried to come up with a test for this, but modifying t9001 seemed to
cause other failures and I couldn't detangle exactly how the tests fit
together.

Is this simply expected behavior and I need to remember to use <>
around the address?

Thanks,
Jake
