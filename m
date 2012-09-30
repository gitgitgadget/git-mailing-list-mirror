From: Ben Walton <bdwalton@gmail.com>
Subject: Re: [PATCH] Remove the hard coded length limit on variable names in
 config files
Date: Sun, 30 Sep 2012 19:20:07 +0100
Message-ID: <CAP30j15wKa7wbLyaLo8omHcAh5u7O=Yt8Tjy4bD3V_0nT1zJPQ@mail.gmail.com>
References: <7vpq5yzkf3.fsf@alter.siamese.dyndns.org>
	<1348913979-27431-1-git-send-email-bdwalton@gmail.com>
	<5067C51F.6020908@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: gitster@pobox.com, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Sep 30 20:20:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIO87-00050m-66
	for gcvg-git-2@plane.gmane.org; Sun, 30 Sep 2012 20:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115Ab2I3SUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2012 14:20:10 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:42138 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790Ab2I3SUI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2012 14:20:08 -0400
Received: by wibhr7 with SMTP id hr7so1744446wib.1
        for <git@vger.kernel.org>; Sun, 30 Sep 2012 11:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=L/r7Z7kAY9uOfzgR8qOxp0thvfyO/9ySFB9i5HCLNNc=;
        b=Q4RA4aX+r0t6ad2sDk2Tp0jvlmzXIhVWvpKjtdf79eRw8dlqBtaS74HVcsW/OYO/VB
         srQmwmyJcJnhpifhkJiau3ed8tvEE3z/7ZdiYecm7XasOh1EdyTF/P79xXhjrU4jSUNf
         pPD8hfsBmE9lG4llPmOFVRtlmy4v5zcC4DlgyD0ENoazc01rHlhG/QBTGC/u4iFRpNrO
         bGPm/J4fAqdHK92i512q3kshGhbTND0aVNw45IiQduxBgObolcTBP+MA7CxhAerxbEgC
         Hm0DRPXdMVDX+ljlICzk6jT5ezgxWkK8Z/v8pLdQSMMJBLW4H51OkjoZ888QXUt9497d
         EDkg==
Received: by 10.180.90.201 with SMTP id by9mr9589421wib.5.1349029207276; Sun,
 30 Sep 2012 11:20:07 -0700 (PDT)
Received: by 10.216.146.72 with HTTP; Sun, 30 Sep 2012 11:20:07 -0700 (PDT)
In-Reply-To: <5067C51F.6020908@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206692>

Hi Michael,

> The patch doesn't apply to the current master; it appears to have been
> built against master 883a2a3504 (2012-02-23) or older.  It will have to
> be rebased to the current master.

Junio had asked that it be based on maint so that's what I (thought
I?) did.  I'm happy to redo it against master if that's better though.

> The preferred format for multiline comments in the git project is
>
>     /*
>      * Truncate the var name back to the section header prior to
>      * grabbing the suffix part of the name and the value.
>      */

Oops; Will fix.

> In the old code, get_base_var() read the string into var and returned
> var's length (or -1 on error).  The fact that the length of var was
> first "reset" to zero is somewhat implicit in the fact that no length
> parameter is being passed to get_base_var().
>
> But in the new version, get_base_var() is passed a strbuf.  Often,
> operations with strbufs append to the strbuf, and this is what I first
> assumed.  It took me a while to realize that get_base_var() calls
> strbuf_reset() before getting to work.  Moreover, get_base_var() still
> returns the length of what it found, which is redundant with a strbuf
> and therefore unexpected.  So when the return value of get_base_var() is
> stored into baselen, it is not really obvious that it is the string's
> length.

Ok, that's a fair criticism.  When I was creating the patch, I thought
that placing
the strbuf_reset in get_base_var() seemed nicer as it matched the
baselen = 0 which
effectively reset the old character array.  Your point is well taken
though and I think
it makes sense to switch things around the way you've suggested.

> Finally, I realize that the MAXNAME constant was not exported and I
> can't find the old length limits documented anywhere, but I nevertheless
> worry a little bit that one of the users of the config API has a
> built-in assumption that names can never be longer than 256 characters
> (for example, a config_fn_t function might try to store the name into a
> fixed-length buffer).  Hopefully such code would never have been written
> or accepted, but...?  If you have thought about this or audited the
> callers, please mention that in your commit message.

I did look through the code to see if anything was relying on fixed
size buffers and I didn't see anything.  I'll update the commit
message with this info too.

I'll send a modified patch shortly.

Thanks for the review!
-Ben
-- 
---------------------------------------------------------------------------------------------------------------------------
Take the risk of thinking for yourself.  Much more happiness,
truth, beauty and wisdom will come to you that way.

-Christopher Hitchens
---------------------------------------------------------------------------------------------------------------------------
