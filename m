From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [GSoC/RFC] Ideas on git fetch --deepen
Date: Sun, 8 Mar 2015 16:34:41 +0700
Message-ID: <CACsJy8B5HwwZei+ao6Z4dt1eG27Mj4z2_QDKzVPTLphm6JrVWA@mail.gmail.com>
References: <CABwkPcoHPyid0gKjjg0NiXY4TYtCbeSJe6XK5HEDFNKR+-_tFQ@mail.gmail.com>
 <CABwkPcoWUcK2vzqUBcEcuNzizYMtP=qUiew2HmDgqtivfDXbDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Dongcan Jiang <dongcan.jiang@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 10:35:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUXcJ-0008VZ-Ps
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 10:35:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbbCHJfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 05:35:15 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:42515 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbbCHJfM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 05:35:12 -0400
Received: by iecvy18 with SMTP id vy18so31846431iec.9
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 01:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9g1UBhhBmxkCbThELHLohk4WsSUsJUFxC1kg1jmkgZU=;
        b=DgjOQHtl5BMNss02IBA8VGb+AfdrmOnEmY6CeYh4Ilxxb6mq4aifhsdZnA+dXip3kb
         P4O0GmMb+SjJrzx8b/cv8KAb3TT95rCHqXnljXSoJrRV66xLxyzAbDUV46zMTxh5hOBu
         E8cqReQ72VwS9D5LtCl9rGlTd7t6lECOVEyuiydWtOaWG7jhBG+a7ylPsAnz2sl5if5i
         ZeDjrdXza1hxAfpxuWzWxyzI+iqVkXs9Gg6UBDFWf13TBPYzSHSREhNN/nsBedyQ7ugC
         WKmO9vDuVMI05BbTKnzuJENdVnWFypMpyrlRUOVECB1IajSe8wlGhO7ekBmIR7jR/0XU
         cS+g==
X-Received: by 10.43.69.68 with SMTP id yb4mr8105914icb.96.1425807311893; Sun,
 08 Mar 2015 01:35:11 -0800 (PST)
Received: by 10.107.131.33 with HTTP; Sun, 8 Mar 2015 01:34:41 -0800 (PST)
In-Reply-To: <CABwkPcoWUcK2vzqUBcEcuNzizYMtP=qUiew2HmDgqtivfDXbDg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265050>

On Sun, Mar 8, 2015 at 3:57 PM, Dongcan Jiang <dongcan.jiang@gmail.com> wrote:
> Hi, all
>
> After digging into how "git fetch" works, I have found that my previous
> understanding was too rash. I'm sorry for that.
>
> I find that the current workflow of "git fetch --depth" is as follows:
>
>   1. 'fetch module' calls 'git-upload-pack service' via 'transport module'
>      to fetch ref with `depth`.
>   2. Such call is finished by pipe I/O.
>   3. git-upload-pack receives arguments such as 'depth' to fetch commits,
>      and send back to the caller.
>
> Therefore, if we want to implement "--deepen" for "git fetch", we have to
> modify the arguments protocol of git-upload-pack service by adding the
> 'shallow commit' hash.
> Then, we can fetch `depth` commits before the 'shallow commit' in
> git-upload-pack service.
> Apparently, we have to output error message when the 'shallow commit' hash
> is not in the repository.

Close. You can't figure this shallow commit hash from client side
(client repo is shortened). So you can't send it. What you send is
exactly what the user gives you (e.g. --deepen=5, then you send
"deepen 5" or similar). The server side (git-upload-pack) knows about
the shallow boundary of the client and can walk its (i.e. server-side)
commit graph to find out the new, deepened boundary. Then the server
sends necessary objects plus instructions to update shallow boundary
to the client.

Also, I think  this work would include support for smart-http
protocol. It goes a slightly different route, "git fetch" ends up at
transport.c, but then transport-helper.c and calls git-remote-http(s)
which is implemented by remote-curl.c. This one handles http stuff
then passes control to git-fetch-pack.c. It's fetch-pack that talks to
upload-pack.c

Have a look at Documentation/technical/pack-protocol.txt and
protocol-capabilities.txt (and http-protocol.txt for smart-http). The
function that "draws" shallow boundary based on --depth is
get_shallow_commits() in shallow.c. I suspect you need to improve it a
bit to use with --deepen. I guess you can look at these [1]. Those
changes touch shallow repo in a bit different way, but the main code
path is more or less the same (smart-http not touched).

[1] https://github.com/pclouds/git/commits/7edde8b83a20abb3cd404e2c5f07e3c29a2891f7
-- 
Duy
