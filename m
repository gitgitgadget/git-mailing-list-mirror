From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Rebasing stgit stacks
Date: Sun, 28 Jan 2007 23:21:19 +0000
Message-ID: <b0943d9e0701281521i60da11dfscd8649f56960730d@mail.gmail.com>
References: <b0943d9e0701151446l45eff9dbgcae718c1461d0725@mail.gmail.com>
	 <b0943d9e0701161442t6b93e0d6nd88364600f2809ee@mail.gmail.com>
	 <20070116231735.GF7029@nan92-1-81-57-214-146.fbx.proxad.net>
	 <b0943d9e0701180105t7b01cb4di43b4db1fdc314bb7@mail.gmail.com>
	 <20070118205233.GK9761@nan92-1-81-57-214-146.fbx.proxad.net>
	 <eoq439$7ml$1@sea.gmane.org> <tnxirezueui.fsf@arm.com>
	 <20070122194756.GA4083@nan92-1-81-57-214-146.fbx.proxad.net>
	 <b0943d9e0701221458r77b2b48hfa41d3dffcb848d0@mail.gmail.com>
	 <20070128043312.GG9897@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Yann Dirson" <ydirson@altern.org>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Theodore Tso" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Jan 29 00:21:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBJKu-0001iP-Gn
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 00:21:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932971AbXA1XVV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Jan 2007 18:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932973AbXA1XVV
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jan 2007 18:21:21 -0500
Received: from nz-out-0506.google.com ([64.233.162.225]:6150 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932971AbXA1XVU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jan 2007 18:21:20 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1186529nze
        for <git@vger.kernel.org>; Sun, 28 Jan 2007 15:21:20 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Rp/vxOclVA9DPgWsxvtOhq1DxZjIcyUTvrVV/YwNutFM+GbOnXIReT2a1LpGU6nwtpecs4N3FtZsECzjBt30F8cCHb+6SVXAh0AsIn7Qg19A1UShdqPRL2SqPNlQf6jY/UNAt+xWqA+9+fA2bU+XzeiSkEVYRa89d08mi+2LXyk=
Received: by 10.114.75.1 with SMTP id x1mr225754waa.1170026479891;
        Sun, 28 Jan 2007 15:21:19 -0800 (PST)
Received: by 10.115.110.12 with HTTP; Sun, 28 Jan 2007 15:21:19 -0800 (PST)
In-Reply-To: <20070128043312.GG9897@thunk.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38054>

On 28/01/07, Theodore Tso <tytso@mit.edu> wrote:
> Well, a typical use case for me is:
>
>         stg branch master
>         git pull .
>         stg branch 2.6.20-rc5
>         stg export -d /tmp/temp-stack
>         stg branch master
>         stg branch -C 2.6.20-rc6
>         stg import -s /tmp/temp-stack/series
>
> That's because I want to keep the original patch series for
> 2.6.20-rc5, but I also want rebase the patch set to 2.6.20-rc6.  Is
> there a better way of doing this?

As Yann pointed out, you could just clone 2.6.20-rc5 into 2.6.20-rc6
and rebase the latter (currently with 'stg rebase v2.6.20-rc6').

If you have the branches already created, you can avoid the
export/import with a cherry-pick (with better merging than just
applying a patch). The 'pick' command only takes an argument (I'd like
to extend it to accept multiple or patch ranges) but you can use it
with 'series':

stg branch 2.6.20-rc6
stg series -b 2.6.20-rc5 --noprefix --showbranch [patches...] \
  | xargs -rn1 stg pick

You could even use the --missing instead of -b for the series command.
This option shows the patches on the remote branch which are missing
in current. Pretty useful if you want to continue importing after
fixing a conflict for example (that's a reason why I haven't extended
'pick' yet, 'series -m' seemed pretty powerful).

Another trick if you modify some patches in one branch (i.e.
2.6.20-rc5) is to use 'stg sync -b 2.6.20-rc5 [patches]' in the other
branch. It tries a three-way merge of each individual patch with the
corresponding one in the other branch, showing you any possible
conflicts (I usually have 'imerger' set to emacs... and 'autoimerge'
to 'yes' in the config file so that emacs' ediff is automatically
invoked for every conflict).

-- 
Catalin
