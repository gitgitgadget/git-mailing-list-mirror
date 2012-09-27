From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Commit cache to speed up rev-list and merge
Date: Thu, 27 Sep 2012 08:51:51 -0700
Message-ID: <CAJo=hJtoqYEL5YiKawCt_SsSUqfCeYEQzY8Ntyb91cNfNS1w_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>, Colby Ranger <cranger@google.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 17:52:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THGO0-0003n3-6d
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 17:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754434Ab2I0PwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 11:52:14 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:64145 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945Ab2I0PwN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 11:52:13 -0400
Received: by qchd3 with SMTP id d3so1146595qch.19
        for <git@vger.kernel.org>; Thu, 27 Sep 2012 08:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=QPbFRoCg/J30MGMPoUboDJfiE5DnSQLYzyJsRvSFYlM=;
        b=AnV6yHIJTfd2oNUqPUxV1e+5CtJT5Xx7KBtQ75J78DABnZqkKrs8NJYbwD/9Xaw+TJ
         UvMLlGZ8evjiAQVLZ2TENdfIUMPravTCy92DYRSGUby91wPJAubHMRa+KlmkHFU5QVnZ
         qIlZPfMLlVJcY9f5Ur1lJ/rVY2oJ/PGcT0YnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type
         :x-gm-message-state;
        bh=QPbFRoCg/J30MGMPoUboDJfiE5DnSQLYzyJsRvSFYlM=;
        b=A60jX/UmnWqVrTIOd/LU+Q6cPyx6Za563d8hM+eCK47bm+F6c0UFpRn0SvZg62umSW
         1eAvxFKZitYIirwbleyE8LOQY9XvUCkFaBPMoJMlXlQgX06MeaZvD7/CbWof0XxNhBhL
         U0EBg9JQ0ALODJJcrUbAIQeNMdc2oU3wqsfNi8/5dZE1BPWPjNYZrQpxOE1kgmMlBpES
         PqJEaQTNZz32HBvdef7a862UpiLf4K3PJqWGbS3kEP3eEu9KqucrU+zgzyDmrB3iYF1p
         R2yYHznmkr/JmIwD9BCWECQ9S2LDs8IoMFh/pUYtEBKWen+tBwbS36eNzjXgT8yRcYwR
         e14Q==
Received: by 10.224.78.197 with SMTP id m5mr10534494qak.36.1348761132203; Thu,
 27 Sep 2012 08:52:12 -0700 (PDT)
Received: by 10.49.35.75 with HTTP; Thu, 27 Sep 2012 08:51:51 -0700 (PDT)
X-Gm-Message-State: ALoCoQl3Jbik+ueA8u1KTJ6tvbfFukYXNOfjT1oIbC3jgRF+bxEBetiQoZ3R4Esrc2SVPPf/kYfg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206485>

On Thu, Sep 27, 2012 at 5:17 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> I'd like to see some sort of extension mechanism like in
> $GIT_DIR/index, so that we don't have to increase pack index version
> often. What I have in mind is optional commit cache to speed up
> rev-list and merge, which could be stored in pack index too.

Can you share some of your ideas?

In Linus' Linux kernel tree there are currently about 323,178 commits.
If we store just the pre-parsed commit time as an int32 field this is
an additional 1.2 MiB of data in the pack-*.idx file, assuming we can
use additional data like pack offset position to correlate commit to
the parsed int. If we stored parent pointers in a similar way you
probably need at least 3.6 MiB of additional disk space on the index.
For example, use 12 bytes for each commit to store enough of the
parsed commit time to sort commits, and up to 2 parent pointers per
commit.... with a reserved magic value for octopus merges to mean the
commit itself has to be parsed to get the graph structure correct.
