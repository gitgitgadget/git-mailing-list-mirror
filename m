From: =?UTF-8?Q?erik_elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: Re: [PATCH v5 1/5] setup: add gentle version of read_gitfile
Date: Tue, 28 Apr 2015 22:07:43 +0200
Message-ID: <CAMpP7Nb3aiMoTjtPJNJPv38G54ZawS8B+NDX0x2iNe6FA-L+Lw@mail.gmail.com>
References: <xmqqfv7nzf56.fsf@gitster.dls.corp.google.com>
	<1430030985-14499-1-git-send-email-erik.elfstrom@gmail.com>
	<1430030985-14499-2-git-send-email-erik.elfstrom@gmail.com>
	<20150428061741.GL24580@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 28 22:07:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnBnI-0004bM-U9
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 22:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030933AbbD1UHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 16:07:45 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35243 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030690AbbD1UHn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 16:07:43 -0400
Received: by obcux3 with SMTP id ux3so4912746obc.2
        for <git@vger.kernel.org>; Tue, 28 Apr 2015 13:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OJ0M5pAH2tps2MxBiULr10sAH/ggtaDR9iLZASiceSc=;
        b=Bg472MINf8+uGk2gSOJsNUf9zBtIGta4we28LUT4/5ZhjZkg02ti7AOK5+V8XNGjd3
         TX5k4vvGEuh97JfYbsfob6DcWRO8UGUYNsb1qSZsOIBJQzVQrab/hsImTu+cUTBTj7/K
         C6wjw7+BottlDCluI4RJFvWG6gxMO8P8pXLw4fJoIDGImvVHSCpncZY+N4XhNIrgWkgA
         HyyXHoVebCC8fAk7wkyFtJ5cAGr3mC23pYc9Mfj/htQEhBFZDG4uHA+YZX0oiQ5ZYf43
         14KNIMOvDdepGR9+jNXte3x2H3NXSoSRwh3/K4Rr1CJTOeP6N4fnII49QuIHAn5ktSyl
         wVZg==
X-Received: by 10.202.198.149 with SMTP id w143mr15125729oif.72.1430251663289;
 Tue, 28 Apr 2015 13:07:43 -0700 (PDT)
Received: by 10.182.154.72 with HTTP; Tue, 28 Apr 2015 13:07:43 -0700 (PDT)
In-Reply-To: <20150428061741.GL24580@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267937>

On Tue, Apr 28, 2015 at 8:17 AM, Jeff King <peff@peff.net> wrote:
>
> There was a discussion not too long ago on strategies for returning
> errors, and one of the suggestions was to return an "error strbuf"
> rather than a code[1]. That's less flexible, as the caller can't react
> differently based on the type of error. But for cases like this, where
> the only fate for the code is to get converted back into a message,
> it can reduce the boilerplate.
>
> What you have here is OK to me, and I don't want to hold up your patch
> series in a flamewar about error-reporting techniques. But I think it's
> an interesting case study.
>
> -Peff

Thanks. I haven't had time to look through that thread yet, I'll try
to get to that later.

My initial reaction is a bit skeptical though. For this case we
currently don't want any error reporting, the NULL return is
sufficient and even allocating and sending in the int* is pure noise.
Allocating and releasing a strbuf seems like a lot more overhead for
this type of caller? The one other potential candidate caller for
read_gitfile_gently that I have seen (clone.c:get_repo_path) don't
want any error code or message either as far as i can tell.

Also if it turns out that we actually need to treat the "file too
large" error differently in clean (as discussed in thread on the file
size check) then we can no longer communicate that back using the
strbuf interface.

Overall it seems like a less attractive solution to me but I can be
persuaded if there is more support expressed for the strbuf direction.

/Erik
