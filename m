From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Why do git submodules require manual checkouts and commits?
Date: Fri, 16 May 2008 09:43:33 -0400
Message-ID: <32541b130805160643y3bfe609et22b2d00627f98c04@mail.gmail.com>
References: <2729632a0805152116o3c998324xb401674207dd2e1e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "skillzero@gmail.com" <skillzero@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 15:44:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jx0EV-0006aU-Ei
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 15:44:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755983AbYEPNnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 09:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755962AbYEPNnh
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 09:43:37 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:26290 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755961AbYEPNng (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 09:43:36 -0400
Received: by fg-out-1718.google.com with SMTP id 19so710304fgg.17
        for <git@vger.kernel.org>; Fri, 16 May 2008 06:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4OIChxUEXoW5clk/6HAbZgmrePSB+RxoEfYwNFS+ths=;
        b=AFcZFpecp14pmuCYR8ky2CBouBJwTnL2dpByhpaNygCRKjFsUqGPXljaVdxrEBMH5FzrUeHRFDXAe+ILgmDbbNQQlZDVsAIL9FF/whQkJsaa5KHxXBknoGNhLFrokBrl7EZvbLbVNIH2RKEhzJzEr44P7DKDnNKrja7dk/MtZOk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VkktTtM/+8DPxqovMsNgEo4TWjSPPR54WFzsqrKsj2wDuwSRiHD6IZAh6D/RTc4bGwfAV42Jc55pnGVh8f5/2GoEL/z4WwhSuPi3izBkhzpow19zOzufwEbIJqQv6yHsDdLL7IE/Z1MAK+gWtUqs1wTo2gYkNzibBiw917wf640=
Received: by 10.82.182.18 with SMTP id e18mr472237buf.50.1210945413347;
        Fri, 16 May 2008 06:43:33 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Fri, 16 May 2008 06:43:33 -0700 (PDT)
In-Reply-To: <2729632a0805152116o3c998324xb401674207dd2e1e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82287>

On 5/16/08, skillzero@gmail.com <skillzero@gmail.com> wrote:
> Why do git submodules require manually committing the submodule itself
>  to each super repository after something in the submodule repository
>  changes? Is there some reason the super repository can't just "link"
>  to the submodules by branch name? It seems that if the .gitsubmodules
>  also specified the branch to use:

This is difficult but (contrary to what others might say :)) in my
opinion it's worth fixing.  Exactly how to fix it is an open question
though.

The main reason the simple approach you suggested (just link to a
branch instead of a particular commit) isn't good is that it doesn't
guarantee you always get the same version every time.  If the
supermodule links to submodule branch "foo" and makes supermodule
commit 23abc918c, and someone later pushes to submodule branch "foo",
then checking out commit 23abc918c in the supermodule would get the
very latest submodule "foo", not the one you had when 23abc918c was
created.  Thus all sorts of bad things could happen.

So I think it would be very bad if the supermodule automatically
updated to the latest version of the submodule whenever you commit in
the submodule.  *However*, the other way around might be fine: if you
commit in the supermodule, maybe it should commit in the submodule at
the same time and link to that specific commit.  I'm pretty sure that
idea doesn't have any *fundamental* flaws, it's just got a lot of
really tricky details that need to be worked out.  I've seen some
"recursive commit" and "recursive push" patches floating around, so
people are actively working on this.  One of the hardest things to
deal with is where to auto-push submodules to (which remote? which
branch?) when you push the supermodule.

Have fun,

Avery
