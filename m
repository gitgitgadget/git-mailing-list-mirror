From: David Turner <dturner@twopensource.com>
Subject: RFC: git cat-file --follow-symlinks?
Date: Wed, 29 Apr 2015 13:57:12 -0700
Organization: Twitter
Message-ID: <1430341032.14907.9.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 29 22:57:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnZ2s-0000Ik-27
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 22:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbbD2U5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 16:57:20 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:32893 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbbD2U5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 16:57:16 -0400
Received: by pdbnk13 with SMTP id nk13so38962852pdb.0
        for <git@vger.kernel.org>; Wed, 29 Apr 2015 13:57:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:organization
         :content-type:mime-version:content-transfer-encoding;
        bh=L1Fqv99+V0pcInVVgKNDjnm0Z/O05Whkjh/glkm5A+0=;
        b=Iz/a0j9GjkMXq+lDttLH7qK9XAMcgpkUX9djHTOONUeC7NxJM8OSVxjAdZlT6lRGws
         W2208fmYAcEZy7VC5Y7Gyry9ZkHndNVf7LfgEYMnPwpnZd71Wqnj18caKXstfRqUt+5H
         1YgmCbLslv/YfCzIkr6Se+TJonYbvqOOjoPR3p5uVuT8Vf81UiwH+B9o4usy51PKwnGS
         ZNrRIirdCiMxmj59Vzepghq0Ih4oisqOo78L47oKZCZ4PtjRcXj+Rdt5OyHI4VbykoZP
         RsuBgVV5wZEkjasAzMNnl+l2oJFQUkiBiQSSz/ERH6uwAGFJR9UUbXag8fxe3j2eza2n
         Iryg==
X-Gm-Message-State: ALoCoQlrByTPvB5jb7Th50p9yf68C0Nb+64W93DKzCV1/hAd/vG030ehKlFGU++zRup8KrnN7M+W
X-Received: by 10.68.238.162 with SMTP id vl2mr1592071pbc.149.1430341035641;
        Wed, 29 Apr 2015 13:57:15 -0700 (PDT)
Received: from [172.25.135.195] ([8.25.197.26])
        by mx.google.com with ESMTPSA id sc1sm92577pac.36.2015.04.29.13.57.13
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Apr 2015 13:57:14 -0700 (PDT)
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268001>

I recently had a situation where I was using git cat-file (--batch) to
read files and directories out of the repository -- basically, todo the
equivalent of open, opendir, etc, on an arbitrary revision.
Unfortunately, I had to do a lot of gymnastics to handle symlinks in the
repository.  Instead of just doing echo $SHA:foo/bar/baz | git cat-file
--batch, I would have to first check if foo was a symlink, and if so,
follow it, and then check bar, and so on.

Instead, it would be cool if cat-file had a mode in which it would
follow symlinks.

The major wrinkle is that symlinks can point outside the repository --
either because they are absolute paths, or because they are relative
paths with enough ../ in them.  For this case, I propose that
--follow-symlinks should output [sha] "symlink" [target] instead of the
usual [sha] "blob" [bytes].  Since --follow-symlinks is new, this format
change will not break any existing code.

(I also propose that we use Linux's limit of 40 symlinks by default, but
--follow-symlinks could also have =max_links_to_follow to adjust this if
anyone cares)

Do people think this is reasonable?  If so, I'll see if I can get some
time to work on it this month.
