From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Crash when pushing large binary file
Date: Fri, 16 Nov 2012 17:11:25 +0700
Message-ID: <CACsJy8DsKc5_i6VKeYv69ikQXQPwEh3UOa5_bLaa4ss5vLxOng@mail.gmail.com>
References: <CA+AoP-n07k0r11O6ShOT8jHiX+TL+=p8sZoei+Gi+9gG_YyJqA@mail.gmail.com>
 <CACsJy8AAd0odtLDiZ+A+MhX1En_G97gF2uoHjVeJvekznY3JSw@mail.gmail.com> <CA+AoP-keNcjGLtxbb9t7sggur1e+XmbMN5apVJfEdfhqU2-JGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Thomas Gay <tgay@tokyois.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 11:12:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZIuC-00009T-8j
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 11:12:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433Ab2KPKL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 05:11:58 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35931 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365Ab2KPKL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 05:11:57 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so2618094obb.19
        for <git@vger.kernel.org>; Fri, 16 Nov 2012 02:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2K403OvFV8U+MTqECb08QLi4erUEOmXkNo+wx8pxDO0=;
        b=pRmrFYNFs4Wt+KBPVJ2Jp0hCwTLxC9LhYNy13bWnmskT64vGbIcREy3odEAtx+muWi
         2KzPUhi4eHNLf/uBx4XJqshY6UMoLvRTNjfiUWKI9y7uta+OiJlFBvSoHv5fVVLykDfK
         zPUFYronwrtm7NsXG/B9Wu2vDPItDkflVmck4lm8TVbL6q5Z6qG+/Xl6xUtIWrW+hvX4
         TGYiA+8EyCqSPKxzxarp8oC5ckIWyLuphbY2jOCPrr+mkeDheB2kBlNRkxRyD2kx5MRp
         ewoj1ty9uFHoRLmfNaTkLu/X2ZupeJRA9SvXin64uP4vtuTnlwCGxHGgc87DYDRGULiw
         gS3g==
Received: by 10.60.13.132 with SMTP id h4mr3505892oec.72.1353060717268; Fri,
 16 Nov 2012 02:11:57 -0800 (PST)
Received: by 10.182.27.3 with HTTP; Fri, 16 Nov 2012 02:11:25 -0800 (PST)
In-Reply-To: <CA+AoP-keNcjGLtxbb9t7sggur1e+XmbMN5apVJfEdfhqU2-JGQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209868>

On Fri, Nov 16, 2012 at 1:54 PM, Thomas Gay <tgay@tokyois.com> wrote:
>> If you set receive.unpacklimit to 1 on the receiving end, does it still crash?
>
> Yes. The crash log looks the same too.

If it still says "unpack-objects died of signal 11" then it was not
done the right way. The receiving end can use either unpack-objects or
index-pack for storing the objects. I know unpack-objects is not ready
for large blobs (though I cannot explain your crash log, that's why I
still need you to test it this way). I was hoping to force it use
index-pack and see it still crashes. If it does, we have other
problems than unpack-objects not being ready for large blobs. If it
does not, I'd say it's a known issue with a known solution (I was
planning on merging unpack-objects functionality back to index-pack).

We can try again this way. index-pack will be used if the number of
transfer objects exceeds 100 (by default). You are pusing 16 objects,
which is why unpack-objects is used. We can try to push garbage to the
other end to meet the 100 limit, then reset the branch at the other
end later. You can run "git gc" early on the other end to clean up
garbage, or it'll be done automatically at some point in future. Make
sure there is no changes in index and worktree, or adjust you may want
to change the last four commands slightly.

mkdir tmp
for i in `seq 200`;do echo $i > tmp/$i; git add $i; done
git commit -m 'useless stuff'
git push <where?>   # should not crash again
git reset --hard HEAD^
git push <same-where?-above>
-- 
Duy
