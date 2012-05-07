From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC] clone: inform the user we are checking out
Date: Mon, 7 May 2012 12:02:46 +0200
Message-ID: <CABPQNSYe6dDf20D2pQpF=K97rZnWxqe5weEdO+FdKck9rwwzWg@mail.gmail.com>
References: <1336381787-6484-1-git-send-email-kusmabite@gmail.com>
 <4FA7952C.90702@viscovery.net> <CABPQNSZ+FtMJ1msSmqvROP6YqRGKvz1uz8w1z5mF3YDXZyiPQw@mail.gmail.com>
 <CABPQNSbbH3ULjgYxW6RdH0emrgXoKf1mkiEAm2fR19LsC5q8_w@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>,
	Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 12:03:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRKmx-00043f-I1
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 12:03:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755938Ab2EGKD1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 06:03:27 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52973 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755544Ab2EGKD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 06:03:26 -0400
Received: by pbbrp8 with SMTP id rp8so6481526pbb.19
        for <git@vger.kernel.org>; Mon, 07 May 2012 03:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=cXsusRtW+kVBK+REr6S9ouw6fJF0KmcwjRD8m9Qj04A=;
        b=cNkRTEDPn+B7XOArPBmhrvJi4jnzsPZ2gOaGM1gsOLpWTGRPXzx7fvoR04vNxG/K8i
         /cEvh5eBlBCJm0DYOcenUFREVYSXXz1UlEkdE9bOKKc9keUalx++xla5piXt2UiaY8E/
         cDtprF0GbCe1HZLG+nAWV1XhLY/vNPzpIO9C5IwTf5vVWs4uUQ6BefO9rUaSrlccFFv1
         A7ZgbZHdrno5Dl5qz54MWNOdH65S9XBX6PXMxbZF5P4/UMWK4jO6u3rbcE9SWh/MFv3f
         26rCEDUe8aWXzq3WHh7LmjD9YOXZZDeU6+Si1EGcVO8rGnRh83vV1i+DmjY63OK1G8ti
         cMjQ==
Received: by 10.68.224.36 with SMTP id qz4mr1568355pbc.69.1336385006432; Mon,
 07 May 2012 03:03:26 -0700 (PDT)
Received: by 10.68.73.65 with HTTP; Mon, 7 May 2012 03:02:46 -0700 (PDT)
In-Reply-To: <CABPQNSbbH3ULjgYxW6RdH0emrgXoKf1mkiEAm2fR19LsC5q8_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197254>

On Mon, May 7, 2012 at 11:46 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> On Mon, May 7, 2012 at 11:35 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>> On Mon, May 7, 2012 at 11:26 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>>> Am 5/7/2012 11:09, schrieb Erik Faye-Lund:
>>>> I asked git
>>>> to clone, and it told me it finished, only to hang around for
>>>> several minutes while, judging by the output, doing nothing.
>>>
>>> We have a nice "Checking out files" progress indicator. I wonder why you
>>> do not see it.
>
> It seems progress is only enabled when cloning with the verbose-flag.
> This is because check_updates in unpack-trees.c only enabled progress
> if both o->update and o->verbose_update is set, and checkout in
> builtin/clone.c fills in opts.verbose_update with (option_verbosity >
> 0).
>
> So that's that mystery. I still think the output without the
> verbose-flag is confusing as-is.

OK, some blaming shows that this changed in 5bd631b3 ("clone: support
multiple levels of verbosity"), back in February 2010. Before this
patch, one would have to specify the "quiet"-flag to clone to suppress
progress-output, after the patch the default is progress being off.

This seems like the right thing to do if we want to resurrect the
progress-output's default-on behavior:
---8<---
diff --git a/builtin/clone.c b/builtin/clone.c
index 3f863a1..f48e603 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -569,7 +569,7 @@ static int checkout(void)
 	opts.update = 1;
 	opts.merge = 1;
 	opts.fn = oneway_merge;
-	opts.verbose_update = (option_verbosity > 0);
+	opts.verbose_update = (option_verbosity >= 0);
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;

---8<---
