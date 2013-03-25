From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 6/9] streaming_write_entry: propagate streaming errors
Date: Mon, 25 Mar 2013 17:35:51 -0400
Message-ID: <CAPig+cRjK6mrRm+K4Qzf2CsjT3SYGotZ2PrVLniYzdBRC1Mv2A@mail.gmail.com>
References: <20130325201427.GA15798@sigill.intra.peff.net>
	<20130325202216.GF16019@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 25 22:36:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKF43-0000s6-92
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 22:36:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758960Ab3CYVfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 17:35:55 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:62729 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758686Ab3CYVfy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 17:35:54 -0400
Received: by mail-la0-f41.google.com with SMTP id fo12so12403982lab.0
        for <git@vger.kernel.org>; Mon, 25 Mar 2013 14:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=ygLUPWYEbHs7908VojZLjFpqMdUNLB0UXRe/IFlMMFk=;
        b=emVPxcDRdq6RCJVWYauVzu8XY8msSe8PanqrI88QEknGRqibsQzmwX4gEL+/rgmIEk
         x+96iFRAFQWOMOHm7xl3ONP26iewcMsNpz8K/egMtSdSUHKixlG+GAUCmz4RDgKticLo
         MGj9q1+rwRC0LgjK9r79aMlKXp4/pgR1WLCnq/vU+e0ABvBuozOBOCnNjcP7zJDxgdLY
         6IF7yKlNLsU9WYFvUSRxafcsCOf2JSEzxedWrkuMVO89SbARtclcCgnTtMrWAA9weMMY
         LQO6wu63KGpMgnkEETquzTvYbVVRMW8wjsY0alcZKL5K8GqEbFwB3eDmy4+2Q0R3ZN+Y
         lTBA==
X-Received: by 10.112.134.166 with SMTP id pl6mr6851423lbb.68.1364247351786;
 Mon, 25 Mar 2013 14:35:51 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Mon, 25 Mar 2013 14:35:51 -0700 (PDT)
In-Reply-To: <20130325202216.GF16019@sigill.intra.peff.net>
X-Google-Sender-Auth: J72_urbvrdqypr1auiXAULqMQFk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219094>

On Mon, Mar 25, 2013 at 4:22 PM, Jeff King <peff@peff.net> wrote:
> diff --git a/entry.c b/entry.c
> index 17a6bcc..002b2f2 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -126,8 +126,10 @@ static int streaming_write_entry(struct cache_entry *ce, char *path,
>         fd = open_output_fd(path, ce, to_tempfile);
>         if (0 <= fd) {
>                 result = stream_blob_to_fd(fd, ce->sha1, filter, 1);
> -               *fstat_done = fstat_output(fd, state, statbuf);
> -               result = close(fd);
> +               if (!result) {
> +                       *fstat_done = fstat_output(fd, state, statbuf);
> +                       result = close(fd);
> +               }

Is this intentionally leaking the opened 'fd' when stream_blob_to_fd()
returns an error?

>         }
>         if (result && 0 <= fd)
>                 unlink(path);

Won't the unlink() now fail on Windows since 'fd' is still open?

-- ES
