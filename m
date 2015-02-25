From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Git Scaling: What factors most affect Git performance for a large repo?
Date: Wed, 25 Feb 2015 19:02:40 +0700
Message-ID: <CACsJy8CxdDxP5urp5dY=UjiNFb9vMOB=+BSZCiV4KovjynQ5hg@mail.gmail.com>
References: <CAH8BJxEr_v+aitpZduXPC4oiRhMuySpc7Wb1aGcYe_p3mWjn+w@mail.gmail.com>
 <CACsJy8Dortn4fHwF8xSgJ=KoJ9o1qzmc_UyaVq003D2sxFZEuQ@mail.gmail.com>
 <1424392969.30029.15.camel@leckie> <CACsJy8B6pLnx84Xxb0_p2+YuWTgg_8h0yQt7K+AXiaEaC4jSeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stephen Morton <stephen.c.morton@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 13:03:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQagQ-0008PD-Ol
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 13:03:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706AbbBYMDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 07:03:12 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:41843 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634AbbBYMDL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 07:03:11 -0500
Received: by iecrd18 with SMTP id rd18so4183656iec.8
        for <git@vger.kernel.org>; Wed, 25 Feb 2015 04:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/cY+gwlGZpkFBckyUylEhfxeqEFqkvUo4NOeiNtCs1o=;
        b=deIeKyssGSCQhkJODtSKT7gaUovqLv3Zn1gI6+3Hepbx+6lVQM5aIB7Gg+0s9LJuJL
         4MWwqrNRvkGzXFdT3VlsNplhNmrS7dB/7AqPaJoCvpVjAb1uktNT56HFBXrMkrIgsT4c
         wciIe3PoXO0UCBY5ehfTv3LrXXnz5BZxFHxUZpfyAbNUqj/ID30POst5uTSAdQwgIVSw
         FOjEf4NUi4eTwIzLjvSGgsWPSdF4K1tzZrh/wyEg+q8Nv3qkmY7D4fvX+j4/69ZulpLu
         Do1b7jUkDHSbKlGzQYcb7SrKRqWJokExoxw/O7M53xKOhVf7Q8j80O6w9MGVX88EvO4f
         JMIQ==
X-Received: by 10.43.126.196 with SMTP id gx4mr3403874icc.40.1424865791124;
 Wed, 25 Feb 2015 04:03:11 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Wed, 25 Feb 2015 04:02:40 -0800 (PST)
In-Reply-To: <CACsJy8B6pLnx84Xxb0_p2+YuWTgg_8h0yQt7K+AXiaEaC4jSeQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264386>

On Sat, Feb 21, 2015 at 11:01 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> I wonder how efficient rsync is for transferring these refs: the
> client generates a "file" containing all refs, the server does the
> same with their refs, then the client rsync their file to the server..
> The changes between the server and the client files are usually small,
> I'm hoping rsync can take advantage of that.

Some numbers without any actual coding. After the initial clone, we
store the server's refs in a file called base-file at client. At the
next push or pull, the server saves its refs in 'new-file'. Using
rsync to avoid initial ref advertisement would involve these steps
(rdiff command is from librsync)

client> rdiff signature base-file signature
(client sends "signature" file to server)
server> rdiff delta signature new-file delta
(server sends "delta" file back to client)
client> rdiff patch base-file delta new-file

The exchanged files over network are "signature" and "delta". I used
my git.git's packed-refs as the base-file (1416 refs, 78789 bytes) and
modifies three lines to create new-file. That produced a signature
file of 480 bytes and delta file of 6163 bytes. That's 7% the size of
the new file. Good.

When I modified more lines in new-file (15 lines), the delta file grew
to 26644 bytes ("sig" file remains the same because it only depends on
base-file). Total transferred bytes were 60% the size of new-file.
Less impressive. Maybe there's some tuning options for better
results...

The same process could be used to transfer the whole client refs to
server instead of sending lots of "have" lines. I suspect there will
be more changes between client's "have" file and server ref list. If
the changes spread out and cause a lot of blocks to be sent, the
saving would not be as high as I wanted. I guess that's it for rsync
idea.
-- 
Duy
