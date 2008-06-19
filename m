From: "marc zonzon" <marc.zonzon+git@gmail.com>
Subject: Re: sharing object packs
Date: Thu, 19 Jun 2008 19:01:39 +0200
Message-ID: <71295b5a0806191001ra1d4df1wb6fc709dac35f617@mail.gmail.com>
References: <20080618195726.GA20440@kernoel.dyndns.org>
	 <20080619090129.GJ11793@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jun 19 19:03:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9NXL-0004J3-SG
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 19:03:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962AbYFSRBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 13:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbYFSRBl
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 13:01:41 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:52346 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbYFSRBk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 13:01:40 -0400
Received: by rv-out-0506.google.com with SMTP id k40so5246889rvb.1
        for <git@vger.kernel.org>; Thu, 19 Jun 2008 10:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=ejlfXDXOoyv/go/6Ok0pc/MMFSClgKhL3GOe/TVECIQ=;
        b=mpFb1N4rIZmjCX852WJ10rPIHzEJUVWLkja2eqf6X76TLu4voam4ncpnv9znao3Am0
         3x6QcbqhbWezpW1i2hEHrnPNYW9/gjqhXtBKaNa+Wgvl5veiUJ8GAadHI4JLcNmkMuZC
         UTad9a3OQg5tfOuL9TeKnerjtJ4Pm2M/wkg68=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=TbtBcY4qItZtHbDdHvprLDDDfJtBlM2yCKoIvDtqQdhdKxknNpq8zQzsDbffzlgRCc
         FrcfZoGSrMrumbl9A1aMxId1lbW8/vRnPTrTQKhA3P0CTlgXslI1IBubX2w4WVk1wqiT
         HBCr4Eh+WHkIfZDdgdgzF4bAg40D3zJgdEKC0=
Received: by 10.141.193.1 with SMTP id v1mr6712899rvp.245.1213894899975;
        Thu, 19 Jun 2008 10:01:39 -0700 (PDT)
Received: by 10.140.187.11 with HTTP; Thu, 19 Jun 2008 10:01:39 -0700 (PDT)
In-Reply-To: <20080619090129.GJ11793@spearce.org>
Content-Disposition: inline
X-Google-Sender-Auth: 07c952d9c9212323
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85492>

Thank You Shawn

On Thu, Jun 19, 2008 at 11:01 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> marc.zonzon+git@gmail.com wrote:
>> I have a big bare repository 'main.git' and many small git repositories sub1, sub2, ... subn.
>>
>> All repositories lie in the same file file system, and each subx
>> repository track and fetch main.git in a remote branch.
>>
>> I would like to avoid duplicating main.git objects
> ...
>> - Using an objects/info/alternates with the path of main.git object repository.
>> It work well too, but I import objects from main.git inside subx,
>> and they don't have the same life time than those in main.git. So
>> they can, disapear during a git-prune-packed or gc. (The same
>> problem we have with: git clone --share)
>
> This is the approach you want to use.  The risk is that you do
> not allow objects to be added to main.git to later be deleted from
> main.git.  This means main.git cannot rewind/reset/delete a branch.
>
> If that is not acceptable perhaps you could instead create 3 tiers:
>
>        main.git ---
>                    \
>                    shared.git
>                    /
>        subx.git ---
>
> Have main.git and subx.git both use shared.git as an alternate
> (place path of shared.git/objects in their objects/info/alternates).
> You can still allow subx.git to fetch main.git.
>

Your solution of 3 tiers seems to solve the problems I met when trying
to take main.git as alternates.

But I feel we can even make it more secure than what you explain:

> Push only stable commits to shared.git that will never be
> rewind/reset/deleted.  Once something enters shared.git it should
> never be deleted.  This way shared objects will not be removed by
> git-prune or git-gc.  Every so often push newer stable branches from
> main.git to shared.git, once they cannot be rewind/reset/deleted.
>

My option is to fetch from shared not only the branches of main, but
all the branches of all the subx.

So shared.git host all the objects of the sum of main and all subx.

Then there is any problem to reset, delete, or rewind a
branch in main, even if you fetch the resetted branch from shared (a
non fast-forward fetch), The objects of the deleted branch are either
not in any sub directory, and nothing is lost when they are
pruned, or they have been imported in some branch and they will be
kept, since there is a reference to them.


> Repack main.git and subx.git using `git gc` as that includes the
> -l flag to `git repack`.  Any objects which are now available from
> shared.git will not be included in main.git or subx.git, so their
> usage will shrink after shared.git is updated.
>

Yes I tested that, with git gc, I had no immediate shrinking, I suppose
we have to wait for gc.pruneExpire to see the result.

But:
 * fetching the remotes of shared.git,
 * packing shared.git,
 * packing and pruning (with git prune) the directories subx and
 main.git

reduces immediately the object store of the subx to nearly nothing.

> If you also configure gc.packrefs to never in shared.git and
> symlink shared.git/refs into main.git/refs/shared and also into
> subx.git/refs/shared and do this configuration on both server and
> client systems you can have everyone transfer only the minimal
> objects necessary.

Thank you also for this setting, my level of knowledge of git transfer
mechanism is yet too low for understanding it without further
explanation/reading. If you can give some pointers they are welcome.


This solution seems great to implement some kind of submodules.

I suppose we could also use this 3 tiers solution to do a more clever
clone --share by the following scheme:

# mkdir shared
# cd shared
# git init
# cd ..
# git clone --no-hardlinks --bare shared shared.git
# rm -rf shared
# cd shared.git
# git remote add -f repo ../repo
 * [new branch]      master     -> repo/master
# cd ..
# git clone repo repo_copy
# echo $PWD/shared.git/objects >> repo/.git/objects/alternates
# cd shared.git
# git remote add -f repo_copy ../repo_copy
 * [new branch]      master     -> repo_copy/master
# cd ..
# echo $PWD/shared.git/objects >> repo_copy/.git/objects/alternates

then the sequence of repack, gc, prune outlined above.

But I have not yet the experience in git, to allow me to foresee the
consequences of these settings.


All criticisms are welcome.

Marc
