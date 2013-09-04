From: "V.Krishn" <vkrishn4@gmail.com>
Subject: Re: Stalled git cloning and possible solutions
Date: Wed, 4 Sep 2013 06:36:48 +0530
Message-ID: <201309040636.48290.vkrishn4@gmail.com>
References: <201308300118.19166.vkrishn4@gmail.com> <201308300305.10440.vkrishn4@gmail.com> <xmqqvc2o16pn.fsf@gitster.dls.corp.google.com>
Reply-To: vkrishn4@gmail.com
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 04 03:19:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VH1lH-000846-4s
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 03:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755998Ab3IDBTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 21:19:55 -0400
Received: from mail-qe0-f45.google.com ([209.85.128.45]:61838 "EHLO
	mail-qe0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754747Ab3IDBTy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 21:19:54 -0400
Received: by mail-qe0-f45.google.com with SMTP id 6so1996281qea.32
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 18:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:reply-to:to:subject:date:user-agent:references:in-reply-to
         :mime-version:cc:content-type:content-transfer-encoding:message-id;
        bh=uhuWrFrNAA4Yk06qbfDf5gAPfzCWpQvaUrCDo0BKM4o=;
        b=ZJqWWNHe+nuMRpkIO33keDMoQlubIcMK715rMWDrQ0LAsCQagr5+/Im06//snhr49d
         BpWQ8NqefYRUsLcQZB3I0p/MY5EZIfkO1EUpN2nB7hcrjgyTevOT9zgo5PZ+woBhezrI
         8nfS+lN8E0TokqFsBtHDznn5YF0eZHebG+54ryfkGEOvjHjjXAz8OAQhpPzJ0XNmyLvB
         M1wtmtldbSriSpTsNhp5gGG/RXSKJTTdCn9WDbw+yri7uuP/YsoUIaR1p/3DuM7u6SYJ
         MYqnHBZVTHbrK3VQtVEq3uebFFDfCecdsLJTlov84hSJTzYnw6RlQ7VzwFCzKfdOix8s
         +ueQ==
X-Received: by 10.49.24.178 with SMTP id v18mr409184qef.12.1378257593725;
        Tue, 03 Sep 2013 18:19:53 -0700 (PDT)
Received: from microknoppix.localnet ([117.226.181.166])
        by mx.google.com with ESMTPSA id u8sm34030327qef.3.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 03 Sep 2013 18:19:53 -0700 (PDT)
User-Agent: KMail/1.13.7 (Linux/3.3.7-64; KDE/4.7.4; x86_64; ; )
In-Reply-To: <xmqqvc2o16pn.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233801>

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

What more files/info would be needed.
I noticed the tmp_pack_xxxxxx may not have object type commit/tree.
Do I need to manually create .git/refs..

I was wondering the following would further help in recovering.

A
1. If pack file was created in sequence to commit history(date), i.e 
blob+commit+tree....tags...+blob+commit+tree. 
also if in parallel idx was also created or atleast a tmp idx.
2. Update other files in .git dir before pack process.
    (as stated in previous email).
3. Objects are named like datestamp(epoch)+sha1 
     and stored in epoch directory. (date fmt can be yymmdd).
     (this might break back-compat)
4. Add "git fsck --defrag [1..4]" 
   #this can take another parameter like level, 
     applying various heuristic optimization.

B
Another option would be:
git clone <url> --use-method=rsync
this would transfer files as is in .git dir (ones necessary).
And run `git gc` or any other housekeeping upon completion.
This method would allow resuming.
Cons:
  Any change in pack file on server during download becomes a potential issue.

The clone resume may not be a priority but if a minor changes can help in 
recovery, this would be nice. 

I still like the bundle method if git services made this easy.

-- 
Regards.
V.Krishn
