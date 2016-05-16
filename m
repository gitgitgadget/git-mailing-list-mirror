From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Best Practices with code/build fixes post-merge?
Date: Mon, 16 May 2016 14:19:52 -0500
Message-ID: <CAHd499D7kgMtUXgBgsUzNLEMuuHRE7j_T1mikL21KJjDE8ey3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 16 21:20:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2O3m-0001dg-FQ
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 21:20:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754614AbcEPTTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 15:19:55 -0400
Received: from mail-vk0-f43.google.com ([209.85.213.43]:34896 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754371AbcEPTTx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 15:19:53 -0400
Received: by mail-vk0-f43.google.com with SMTP id f66so225660771vkh.2
        for <git@vger.kernel.org>; Mon, 16 May 2016 12:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to;
        bh=18iTeKAY4QWaUNXt/mdnfVJYGzV8/zd2QB44P8Ebw+c=;
        b=Fsf6N640kMqQEIn23oWUKhh3yhi9QjMM5kjMXeGkIf+xns2CzA0og6WHV0gcLOcETe
         hjxLUXo2ahP9OAF5BZA5KWccmS/UoZp0NgSVl1xKQ+Lwj7N6DLViAgajUei1PRtt1K1x
         qpzmaV5ceGYE4N54NSXKtwsGnWOB0q5JIqfSzqWcxgrJOlmhzQYTTYzyPHTuoQfXdXc0
         92Lnp3+T6vKRCNO0Q3enIwSODhisbMROOnpZeYawWQ0MujN2UwiJ9Ri3BB2gn87N5Fvz
         NXED7DDbs1058ZJ+Fn0biW0ZbRNvDtq/remuR2NVX4QPRICVWXcMCorxpTNz2VDNoxXw
         nnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:date:message-id:subject:from
         :to;
        bh=18iTeKAY4QWaUNXt/mdnfVJYGzV8/zd2QB44P8Ebw+c=;
        b=LOfBLF+JPOfixZ9htdpKhBveIzaupCs4OyDpCOWFLoMJjPjBSUUHpO5vk+blSgI5lx
         2s1+fzieYoXezzKivfGVDlR1FjmkZ7b8B5B2Nb56y/2RlrhUZM9e4BJj/29eiQRZjGWc
         o5ES9Wekrhp8mzlodlSbpFjxtA4DU8xSruw6uNRgNcdLXr7PZsvCHcXHZGU7bNWKTu18
         L2ICOOL+X51oqt7uw8DBDTFvSUc3tNtuF/6jJg6Le/1Z4cJuBrrVQhsODuTcft/SL5uN
         3RRaTU4J/xAc883B5maDNdGQM+uMWwwQlnscLppcDZD3ojcqFbqMJtqD/6GVVDQp1m4L
         ydeQ==
X-Gm-Message-State: AOPr4FUHt96zh2TIIaX0EnlY4pho0Bas8DiJtBKqlw4ufOdfCGfZ7fweUaLzguOpHaQ6+C8jcFrP4iOWOGXz4w==
X-Received: by 10.176.64.100 with SMTP id h91mr13669320uad.56.1463426392038;
 Mon, 16 May 2016 12:19:52 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.159.34.134 with HTTP; Mon, 16 May 2016 12:19:52 -0700 (PDT)
X-Google-Sender-Auth: qozpuVgPIrgUPF9hS0Ett84NVG0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294782>

Sometimes, I merge 2 branches that have deviated quite a bit. A
worst-case example would be some API change. The topic branch
(long-lived) may start using the old API. However, once I merge the
topic back to master, that API no longer exists. As such, every place
that introduces a usage of the old API will fail to build (but won't
necessarily cause a conflict during a merge).

Concerning best practices, which of the following is better?

1. Make the fixes (which may be vast), smoke test, get a general feel
that everything is working on master again. Amend the changes to the
previous merge commit.

2. Make the fixes as in step 1, but instead of amending to the merge
commit, create a new descendant commit representing the changes.

Concerns I see with either choice:

1. Pros: Changes are atomic. Cons: merge commits are typically very
difficult to view, especially from logs. For example, `git log
--name-status` does nothing for merge commits, so it makes it
less-intuitive to get a good overview of changes.

2. Opposite of #1: Changes are not atomic (con), but it makes it very
clear that these changes were made "on top of" the merge (pro)

Is there a best practice here? What do each of you do as a personal
preference or policy? Thanks in advance.
