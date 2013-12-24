From: Alexander Boyd <alex@opengroove.org>
Subject: git subtree split - nested subtree history not preserved on parent split
Date: Tue, 24 Dec 2013 03:15:17 -0700
Message-ID: <CAPFSJk8B5C3mvoHXtib5G5MFTEBZuo5zyLQp2UypS66Z9ASrWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 24 11:15:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VvP1I-00033O-3H
	for gcvg-git-2@plane.gmane.org; Tue, 24 Dec 2013 11:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017Ab3LXKPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Dec 2013 05:15:19 -0500
Received: from mail-ob0-f177.google.com ([209.85.214.177]:59694 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785Ab3LXKPS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Dec 2013 05:15:18 -0500
Received: by mail-ob0-f177.google.com with SMTP id vb8so6405021obc.8
        for <git@vger.kernel.org>; Tue, 24 Dec 2013 02:15:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:date:message-id:subject:from
         :to:content-type;
        bh=s7t/AcsvikRR85g9ksxaSDVF+zxvoKaScvtRdjMzqvI=;
        b=QHlqN73uakngCBaEHab3cMFRAf7lVbBzo11GYfOSCx3I8cOyd3gdlLxS3/4Xba5u2z
         h6JtrqgInvYe+gV7sf2+5Zs2B+vQ2osMs1/Tu910BjWEBJsJ3wwpMsU3UWnjdJDWX8Hr
         hl6//igp7B9v8QK7iE38Rgk0COT22tWAuivqEMVgPJCtSWt0s9vEDplg15idNEUHeATy
         fYp/Lm0DZYG2o/csuQIxXGKi+qk0Cu+l+2Dvt2Z/UP4Tfqd+UlYqy9cFdZ0uNvLHb4oV
         5j2eGnVxh4EAmD/GiYUZazYI4ssXiG1wsDl2ySLRVEB2KMXJiyUJ9iiV3x8JYevGsTge
         Wl8w==
X-Gm-Message-State: ALoCoQnpvPHNgF5T9MYk5PrpZ9A3OEFhUu2YwpUfSRy5xfCUmfSX1V5GhlfrQkYkGUQ7KBJ4SUjI
X-Received: by 10.182.204.41 with SMTP id kv9mr17851obc.78.1387880118047; Tue,
 24 Dec 2013 02:15:18 -0800 (PST)
Received: by 10.60.30.34 with HTTP; Tue, 24 Dec 2013 02:15:17 -0800 (PST)
X-Google-Sender-Auth: UnIaqgI62TKjTWS0neSfUq_beZo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239667>

Hello,

I've been playing around with nested subtrees, and I've discovered
what I'm pretty sure is a bug: when I import a repo into a nested
directory with `git subtree add`, then split the imported directory's
parent, the subtree's history is lost.

To clarify:

# Create a repo with a single file
git init nested
cd nested
echo contents > test
git add test
git commit -m "Add foo"
cd ..

# Create an outer repo
git init outer
cd outer
echo contents > bar
git add bar
git commit -m "Add bar"

# Import nested into outer/dir/nested
git subtree add --prefix dir/nested ../nested master

# Split outer/dir
git subtree split --prefix dir --branch history-of-dir

Now `git log master` includes "Add foo" in its history but `git log
history-of-dir` doesn't, even though 'nested' is a child of 'dir'.

I have a (very) rough guess as to what's going on: `git subtree split`
sees the side of the merge importing nested's changes as only touching
files "outside of" the directory it's splitting out, so it happily
omits them from the split history.

Has anyone else run into this?

-Alex
