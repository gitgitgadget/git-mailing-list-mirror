From: Shawn Pearce <spearce@spearce.org>
Subject: Re: RFC: Resumable clone based on hybrid "smart" and "dumb" HTTP
Date: Wed, 10 Feb 2016 12:11:46 -0800
Message-ID: <CAJo=hJuRxoe6tXe65ci-A35c_PWJEP7KEPFu5Ocn147HwVuo3A@mail.gmail.com>
References: <CAJo=hJtHgE_vye_1sPTDsvJ0X=Cs72HKLgRH8btpW-pMrDdk9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 10 21:12:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTb7V-0001B6-Qc
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 21:12:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753678AbcBJUMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 15:12:09 -0500
Received: from mail-vk0-f44.google.com ([209.85.213.44]:33288 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752906AbcBJUMH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 15:12:07 -0500
Received: by mail-vk0-f44.google.com with SMTP id k196so22023103vka.0
        for <git@vger.kernel.org>; Wed, 10 Feb 2016 12:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=gbFUauflY3YUOWuEddvFy8QKt8HJIC8UoI+JW5Fti28=;
        b=PtzFMj5ZDMZqxkdXm91i6q5F4hpElhreSEK8m15VDmZx0IibXccEHl/8yfJKdWj8WJ
         RS60fx/knkunvAP9A/Y0CfRhnFClY8uRUwcOTxGumfHSZ48+hQQRf7ERnLfeL78Ys+62
         izej5L2F3eHG5w7nG1qedDG+es7SYmxKMylEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-type;
        bh=gbFUauflY3YUOWuEddvFy8QKt8HJIC8UoI+JW5Fti28=;
        b=e6ccD6rBVCS+Ip5sCe49HorBx/4XMjx6nCWBDTmXS5p4AvyTFnim78FOHJUV12VWrf
         fwsjmcABtZHt92yJoegnGId5gGk3RjtNigad5FT+cdmXVbLnH1hPoY+rEzFq3Ju0jKpD
         OQfXqtbNYtB72L1qjsmkTThh9u/2ZWnmLGh9PGtYx/VxXLRa/gvox5SGvXAm+39j7sLv
         LrHw2fF40EOAkCgcrtphre0gu/gabAufnZnLsvUBIYNK7oQjna+vCOxjf3vcppSw5XOL
         U0wCi8MtJVk0FtNroXfMXJWk7tvawpI+7JmbY+DxxQ1kPnRInFxrUWq3eEnrR2M+qtAD
         LPsA==
X-Gm-Message-State: AG10YOTUHpooT4JsC4w6dQFCG+UOIFQws37xaGsysuJj3Z6QrwNLlqM8/6vYdbUXuZhG4hme+vnyOxEM6kCsOg==
X-Received: by 10.31.133.19 with SMTP id h19mr31386056vkd.127.1455135126487;
 Wed, 10 Feb 2016 12:12:06 -0800 (PST)
Received: by 10.103.71.211 with HTTP; Wed, 10 Feb 2016 12:11:46 -0800 (PST)
In-Reply-To: <CAJo=hJtHgE_vye_1sPTDsvJ0X=Cs72HKLgRH8btpW-pMrDdk9g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285923>

On Wed, Feb 10, 2016 at 10:59 AM, Shawn Pearce <spearce@spearce.org> wrote:
>
> ... Thoughts?

Several of us at $DAY_JOB talked about this more today and thought a
variation makes more sense:

1. Clients attempting clone ask for /info/refs?service=git-upload-pack
like they do today.

2. Servers that support resumable clone include a "resumable"
capability in the advertisement.

3. Updated clients on clone request GET /info/refs?service=git-resumable-clone.

4. The server may return a 302 Redirect to its current "mostly whole"
pack file. This can be more flexible than "refs/heads/*", it just
needs to be a mostly complete pack file that contains a complete graph
from any arbitrary roots.

5. Clients fetch the file using standard HTTP GET, possibly with
byte-ranges to resume.

6. Once stored and indexed with .idx, clients run `git fsck
--lost-found` to discover the roots of the pack it downloaded. These
are saved as temporary references.

7. Client runs incremental fetch, and then deletes the temporary
references from 6.


An advantage to this process is its much more flexible for the server.
There is no additional pack-*.info file required. GC can organize
packs anyway it wants, etc.

To make step 4 really resume well, clients may need to save the first
Location header it gets back from
/info/refs?service=git-resumable-clone and use that on resume. Servers
are likely to embed the pack SHA-1 in the Location header, and the
client wants to use this on subsequent GET attempts to abort early if
the server has deleted the pack the client is trying to obtain.
