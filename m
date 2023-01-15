Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D25C63797
	for <git@archiver.kernel.org>; Sun, 15 Jan 2023 15:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjAOPqW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Jan 2023 10:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjAOPqU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2023 10:46:20 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3954EB473
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 07:46:19 -0800 (PST)
Received: from letrec.thunk.org ([172.102.8.163])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 30FFkB3S021523
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Jan 2023 10:46:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1673797574; bh=LmvViCc2EiDB0mBt906+GfhzUk4dB/UxvJuUUH5JRBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=CMbh1QRNrsNvA9T3ibQkMAPdp0gbgvBpU+wnRDpIPnbWN2UbBLsSH9nAz44Ep622y
         C1p80pIUEDe1kEtx1kbP7V0ba1eS9F9TzdkXeGBKG1MYLJb/tdIrvDFbulkj0iunk2
         WtNKNd3YScupqDrGtpuAISi6KTlz7ZXUJOcBRyYwmwU4/fNBh2dL5sEICq3we1AyEP
         DO1P/um+MwJ7KhWQwff47pE5KzFcZbNJUxXADqMiyDwXXav6m/SMCjkMFFB377Ysr9
         hSpmDh4T0IUDcSw9G7g6mea3gtnp+SYK0NLCeZwAgYhEKV4DPd9JZlL5fLFYmycFvk
         +peP+J+Xi9XBw==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 7FCC78C04BE; Sun, 15 Jan 2023 10:45:19 -0500 (EST)
Date:   Sun, 15 Jan 2023 10:45:19 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Crls <kaploceh@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: ctrl-z ignored by git; creates blobs from non-existent repos
Message-ID: <Y8Qfj32h89hq5UD6@mit.edu>
References: <632d051b-d81b-b35d-0641-c2488a124810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <632d051b-d81b-b35d-0641-c2488a124810@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 13, 2023 at 05:01:01PM -0500, Crls wrote:
> Ctrl-Z is ignored by git; Git-clone injects blobs even with non-existent
> repos
> 
> Steps to reproduce 1- git clone github whateverrepo/whatevernonexistentrepo
> or 1- git clone gitlab whateverrepo/whatevernonexistentrepo 2= Git prompts
> for a username

% git clone github whateverrepo/whatevernonexistentrepo
fatal: repository 'github' does not exist

I think what you meant was:

% git clone https://github.com/whateverrepo/whatevernonexistentrepo
Cloning into 'whatevernonexistentrepo'...
Username for 'https://github.com': 

> 3- Press Ctrl-Z to stop *git* from running either on the virtual console/tty
> *git* automatically creates blobs with directories and disregards

So it's not that Control-Z is being ignored.  It's that by the time
you see the prompt for "Username for 'https://github.com': ", the
directories already exist.  Try looking at
whatevernonexistentrepo/.git as soon as the prompt shows up.  You'll
see that the .git directory has been greated.

Now, when you type ^Z, the git processes are stopped --- but the
objects are created already.

Username for 'https://github.com': ^Z
[1]+  Stopped                 git clone https://github.com/whateverrepo/whatevernonexistentrepo
% ps aux | grep git
tytso       5097  0.0  0.0   9736  4480 pts/0    T    10:41   0:00 git clone https://github.com/wha
tytso       5098  0.0  0.0   9736  3992 pts/0    T    10:41   0:00 /usr/lib/git-core/git remote-htt
tytso       5099  0.0  0.1 102332 16104 pts/0    T    10:41   0:00 /usr/lib/git-core/git-remote-htt
tytso       5140  0.0  0.0   6332  2072 pts/0    S+   10:43   0:00 grep git


The 'T' means that the processes are stopped.

> Expected: The same issue does not happen with other non-existent repos e.g.,
> git clone git.zx2c4/ it returns the message of fatal repo not found

So what's going on is that github.com is not returning a non-existent
repo error; it's prompting for a username/password, as _if_ the
repository exists.  That's presumably to prevent disclosing
information as to whether or not a private repository exists or not.

Once the authentication fails, git will remove the partially created
repro, so it's really not a problem in practice.

Cheers,

						- Ted
