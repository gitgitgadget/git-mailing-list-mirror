From: skillzero@gmail.com
Subject: Re: Why do git submodules require manual checkouts and commits?
Date: Sun, 18 May 2008 21:38:16 -0700
Message-ID: <2729632a0805182138s3e268cdbxd0d7c42bbcf01f84@mail.gmail.com>
References: <2729632a0805152116o3c998324xb401674207dd2e1e@mail.gmail.com>
	 <32541b130805160643y3bfe609et22b2d00627f98c04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 19 06:39:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jxx9S-0006Uu-AB
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 06:39:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499AbYESEiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 00:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752512AbYESEiU
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 00:38:20 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:46779 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383AbYESEiT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 00:38:19 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1644785waf.23
        for <git@vger.kernel.org>; Sun, 18 May 2008 21:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=lwqs9/hdkWgtKrn/W+qf8TrdEwtFVIlb2cQ6rcFIwtU=;
        b=xd7t9SeaVvk7tnAF0l6g9ic7PsreYaJr4MhcioWzVYzApy4fxCWyntZ/sktUqU7QX6csAMCM7udNNS8WBAzzrOYh4WpRYT4+ltKU7irW1/NaNd50cTFNAnCOcZ/XCUeTqh2HpZuvZFWx3NytLKxGe8snE7dvbD7J2/nHs3Zd0js=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DaNXIiVjUDuZy/4/41V2SP5iRGQ5uWGLj1+uRsxMi3nXziYuabrvUq/az8quuXEyWZRtk+mt9stCXvIcIqLYJIGJd1jyL2OOOizkSQPcMyMRkaQMrh7RkwryY6ICQb0CbqTJEMMO3IeY3a8zUjXqQib/ozRRp9QReSJyzlUb7og=
Received: by 10.114.197.1 with SMTP id u1mr6964888waf.229.1211171896883;
        Sun, 18 May 2008 21:38:16 -0700 (PDT)
Received: by 10.114.193.9 with HTTP; Sun, 18 May 2008 21:38:16 -0700 (PDT)
In-Reply-To: <32541b130805160643y3bfe609et22b2d00627f98c04@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82411>

On Fri, May 16, 2008 at 6:43 AM, Avery Pennarun <apenwarr@gmail.com> wrote:

> The main reason the simple approach you suggested (just link to a
> branch instead of a particular commit) isn't good is that it doesn't
> guarantee you always get the same version every time.  If the
> supermodule links to submodule branch "foo" and makes supermodule
> commit 23abc918c, and someone later pushes to submodule branch "foo",
> then checking out commit 23abc918c in the supermodule would get the
> very latest submodule "foo", not the one you had when 23abc918c was
> created.  Thus all sorts of bad things could happen.

It seems like this could be handled by changing the way a commit is
tracked such that it also includes the commit hash of the submodules.
So for example, instead of refs/heads/master just being just a single
commit hash, it would be a list:

[refs/heads/master]
       1033bb1ed64d1dbac9f93360e69402195386d145
       libfoo = a13dcb7f26a160d85038385b3024b700dec208d9
       libbar = 123123123dcb7f26a160d85038385b3024b700de

If I commit a change to libfoo, it updates libfoo's commit hash to the latest.
If I do git pull on the supermodule, it recursively does git pull on
all submodules and then updates refs/heads/master (or whatever branch
you happen to be on) with the new commit hashes of the submodules.

If you checkout supermodule commit 1033bb1, it would look at the
supermodule's refs/heads/master for 1033bb and see that libfoo was at
a13dcb and libbar was at 123123 and it would then check out those
commits, respectively.

If you branch the supermodule, it recursively branches the submodules
with the same name, but using a namespace. Maybe super/<branch>
similar to how origin/branch is use for remote branches.

If you push the supermodule, it would also recursively push the
submodules using the URL specified when it was cloned (i.e. the one
specified in the .gitsubmodules file).

What I'm trying to do is use git to manage multiple, large
repositories that share a lot of code. I want to make things more
sparse so independent pieces can be used standalone or included as
submodules in other, larger projects.
