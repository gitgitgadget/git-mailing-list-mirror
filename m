From: Josiah Boning <jboning@gmail.com>
Subject: git log with ordering option and --first-parent is unnecessarily slow
Date: Fri, 8 Apr 2016 20:55:54 -0700
Message-ID: <CAKdicq8MnZMBV97K5O8Oa1T=PT9DsutmBS+P-bFYitATHH3s+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 09 05:56:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aok0F-0005xP-K8
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 05:56:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbcDIDz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 23:55:56 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:32848 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792AbcDIDzz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 23:55:55 -0400
Received: by mail-oi0-f53.google.com with SMTP id w85so156858597oiw.0
        for <git@vger.kernel.org>; Fri, 08 Apr 2016 20:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=ArEIELR3cZD+gYj201vz3JCq093oymp50wb+S+fVfrk=;
        b=cJKy4PImh5PTiRru7qZVrm7zyRNSBHstgjW831pE3olJtzW9ouUhe3IntyMckwO8Y4
         O+2BWE0E2b8x2LRyTXw6ILrzyDIs5jC8wtmoKmD6TGpP7YLGzZTOTv/RKROregkwdqfU
         QVNsiW063YtLwCZuUQ4B5mToxfqPVL+iV3iqJ37yipupPhAyhMK3OF88/iiVtvQrhF9M
         eQS4ocZFXH/J1HdPBP2VbTW9DG83cPgcs8ayVzz60GwRn4TU9nkjabIuYZOk3+RKzWlx
         k6GBgzpMpRDXYwnI4DHhlU05RRvXLefYsjQKZ3CxdWvxRGIshjleGHN1gmHtlKcJXvtO
         u6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ArEIELR3cZD+gYj201vz3JCq093oymp50wb+S+fVfrk=;
        b=QUZQPjNJsZSDGAXDD8yPoC76VHRELbsJtvK3oIVBKIOP3FdbMv+v87OSoDN9r6qqXa
         4YC5Kz5F2NvutmwwwQ07WDJjo9Q/3TR59Oik6sbwxhVDrwefcqGk6xy+ZcNsX3cNee52
         m8Jsk5fC2/fptmO0wcy1buIRtt3B8IPVuO4qi8Wi78lcCVl29ewDGY1o8xoibK3NMhVJ
         t/E3XZ0ZG26pK9XeOO+aZurc9/wg3gT8p0rdJ899exRS6TTTiFYOCECQvSN26wSgSDK8
         hue/79yAzibeL8H5g6y1iZwm6hi/GzuoCr13AeM6X8m9XvQgNkBdZ2mtz2s+Xc+n/LEk
         tVFw==
X-Gm-Message-State: AD7BkJJiZEgnoc0XX+PYiR3PnPubiZLrMfUVKV/yBliyYe0DqqyEWsXbEwDtev+QcdNUJaFIYgmW3BqIgvNikA==
X-Received: by 10.157.11.78 with SMTP id p14mr5191049otd.53.1460174154337;
 Fri, 08 Apr 2016 20:55:54 -0700 (PDT)
Received: by 10.182.177.10 with HTTP; Fri, 8 Apr 2016 20:55:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291079>

As measured on linux.git, adding --date-order to a log command can
result in a significant slowdown (~25x here; I've seen ~100x on other
repositories):

    $ time git log --first-parent --max-count=51 master > /dev/null
    real    0m0.024s
    user    0m0.006s
    sys    0m0.016s
    $ time git log --date-order --first-parent --max-count=51 master > /dev/null
    real    0m0.652s
    user    0m0.570s
    sys    0m0.074s

In combination with --first-parent, --date-order (or any other
ordering option) should be a no-op, since --first-parent selects a
linear history. So it seems like there's a significant performance win
available by ignoring ordering options when --first-parent is present.
Would this change be desirable? If so, I'll see about submitting a
patch.

More generally, it seems like it might be possible to identify when
the selected commits are linear and avoid the cost of sorting.

Josiah
