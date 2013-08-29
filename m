From: "V.Krishn" <vkrishn4@gmail.com>
Subject: Re: Stalled git cloning and possible solutions
Date: Fri, 30 Aug 2013 03:58:33 +0530
Message-ID: <201308300358.33272.vkrishn4@gmail.com>
References: <201308300118.19166.vkrishn4@gmail.com> <201308300305.10440.vkrishn4@gmail.com> <xmqqvc2o16pn.fsf@gitster.dls.corp.google.com>
Reply-To: vkrishn4@gmail.com
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 30 00:41:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFAu8-0007a5-W1
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 00:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754047Ab3H2WlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 18:41:20 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:58201 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753679Ab3H2WlT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 18:41:19 -0400
Received: by mail-pa0-f53.google.com with SMTP id lb1so1510815pab.12
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 15:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:reply-to:to:subject:date:user-agent:references:in-reply-to:cc
         :mime-version:content-type:content-transfer-encoding:message-id;
        bh=RTpwn7+0dEUqMX2lcP3LVIueFgJuNBq7Y7TFoJoH/B8=;
        b=K44fJkHrHQb0yf4k9APjyeyn8U5TlMR2wbumfsImWrojuKvsF/F/Hvt1vIYvQVV1YP
         2Ji/B58PRLyRVJ1Xwnd9BeV6INzH/WXTVu5g3L46sm45Hz+rjwIAC2yh/ObSUK++tGPr
         7LMGMVYV+DR0+l/CmCsbCmVAwgeO/xuJjt5I2/gKsmY+QT0WsS4KASb8K40vlZODtt7M
         3y8nLwlKpQBvAGxZ2/Z2k8w7E/jbDtDPbzN4EnOiMypYe1kRQQ8N6SLieegjwNRgttwD
         V7d71xBhrPIIAzYeehdqovjiAdbJnNdAJ8oLvcskLa+wbdyKe5IFbQA9gT8JtYfbjF+q
         sB+Q==
X-Received: by 10.66.102.1 with SMTP id fk1mr6969932pab.90.1377816079584;
        Thu, 29 Aug 2013 15:41:19 -0700 (PDT)
Received: from microknoppix.localnet ([117.227.53.141])
        by mx.google.com with ESMTPSA id nj9sm40248388pbc.13.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 15:41:18 -0700 (PDT)
User-Agent: KMail/1.13.7 (Linux/3.3.7-64; KDE/4.7.4; x86_64; ; )
In-Reply-To: <xmqqvc2o16pn.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233378>

On Friday, August 30, 2013 03:48:44 AM you wrote:
> "V.Krishn" <vkrishn4@gmail.com> writes:
> > On Friday, August 30, 2013 02:40:34 AM you wrote:
> >> V.Krishn wrote:
> >> > Quite sometimes when cloning a large repo stalls, hitting Ctrl+c
> >> > cleans what been downloaded, and process needs re-start.
> >> > 
> >> > Is there a way to recover or continue from already downloaded files
> >> > during cloning ?
> >> 
> >> No, sadly.  The pack sent for a clone is generated dynamically, so
> >> there's no easy way to support the equivalent of an HTTP Range request
> >> to resume.  Someone might implement an appropriate protocol extension
> >> to tackle this (e.g., peff's seed-with-clone.bundle hack) some day,
> >> but for now it doesn't exist.
> > 
> > This is what I tried but then realized something more is needed:
> > 
> > During stalled clone avoid  Ctrl+c.
> > 1. Copy the content .i.e .git folder some other place.
> > 2. cd <new dir>
> > 3. git config fetch.unpackLimit 999999
> > 4. git config transfer.unpackLimit 999999
> 
> These two steps will not help, as negotiation between the sender and
> the receiver is based on the commits that are known to be complete,
> and an earlier failed "fetch" will not (and should not) update refs
> on the receiver's side.
> 
> >> What you *can* do today is create a bundle from the large repo
> >> somewhere with a reliable connection and then grab that using a
> >> resumable transport such as HTTP.
> 
> Yes.
> 
> Another possibility is, if the project being cloned has a tag (or a
> branch) that points at a commit back when it was smaller, do this
> 
> 	git init x &&
>         cd x &&
>         git fetch $that_repository
> $that_tag:refs/tags/back_then_i_was_small
> 
> to prime the object store of a temporary repository 'x' with a
> hopefully smaller transfer, and then use it as a "--reference"
> repository to the real clone.

Would be nice if,
1. the clone process downloaded all files in .git before the blobs or packing 
process and added a lock file like .clone and then started the packing 
process.
2. Any interrupt((ctrl+c) should not delete the already dowloaded files but on 
re-clone process it should check .clone file and resume cloning.
3. Upon finishing cloning delete .clone file.

-- 
Regards.
V.Krishn
