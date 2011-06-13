From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Best way to check for a "dirty" working tree?
Date: Mon, 13 Jun 2011 17:22:48 -0500
Message-ID: <20110613222225.GA14446@elie>
References: <4DF381BF.3050301@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Tue Jun 14 00:23:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWFXH-0004cU-3e
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 00:23:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282Ab1FMWXB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jun 2011 18:23:01 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56798 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193Ab1FMWXA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jun 2011 18:23:00 -0400
Received: by iyb14 with SMTP id 14so4209601iyb.19
        for <git@vger.kernel.org>; Mon, 13 Jun 2011 15:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=KyEbLdXqw5hoWYwP7tJw2xPeHyg798i8bykx4t9Fsx8=;
        b=tEtirXDcZzzeVAOTd6Td4GNBwTCtejQnNI4HpOr28Ug+UbBAKlA1SmpIl4UgB42Q37
         E481u8g+oltJrr4LdrIpb8/mAFHaUISh94Q9nrXQNCtl0Tdpc2rHlvoyXErS6WzEOSaV
         MA1/A/mPLZ5r0+DmicJXpBf6I0lxZjFRq7u9g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=fwUXoHhz4RESOkrH79ECOZXOz5+zjYst64GOl6SrPKaWVHQUKEXxKvM+UyM6I0kBOt
         OrEV8p3Jfgiurm8mu25aQLHHAaOcC+AWtvZpMxFtnY8EzuyZpLIJO0pNC+w1bXFeKxlM
         9U5ipA/j26diuLLuSCY+uhWaf28lzrpzYfEcA=
Received: by 10.42.217.3 with SMTP id hk3mr7311811icb.258.1308003779999;
        Mon, 13 Jun 2011 15:22:59 -0700 (PDT)
Received: from elie (adsl-68-255-110-0.dsl.chcgil.ameritech.net [68.255.110.0])
        by mx.google.com with ESMTPS id er6sm1703952ibb.40.2011.06.13.15.22.57
        (version=SSLv3 cipher=OTHER);
        Mon, 13 Jun 2011 15:22:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4DF381BF.3050301@dirk.my1.cc>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175734>

Hi Dirk,

Dirk S=C3=BCsserott wrote:

> I have a script which moves data from somewhere to my local repo and
> then checks it in, like so:
>
> -----------
> mv /tmp/foo.bar .
> git commit -am "Updated foo.bar at $timestamp"
> -----------
>
> However, before overwriting "foo.bar" in my working directory, I'd li=
ke
> to check whether my working tree is dirty (at least "foo.bar").

Interesting example.  Sensible, as long as you limit the commit to
foo.bar (i.e., "git commit -m ... --only foo.bar")!

> I tried
>
> A) if ! git diff-index --quiet HEAD -- foo.bar; then
>        dirty=3D1
>    fi

To piggy-back on what Ram wrote, this is a question about the
difference between porcelain (high-level) and plumbing (low-level)
commands.

Generally speaking, plumbing is meant to give more stable behavior for
scripts, in two ways:

 - On one hand we make a concerted effort to keep the command-line
   usage and output of plumbing stable.  By contrast, porcelain will
   change over time as we learn about the way people work.

 - On the other hand plumbing is designed to produce simple, reliable,
   and machine-friendly behavior.  For example, while "git checkout"
   will guess what the caller is trying to do based on whether its
   first argument is a branch name or a file, "git checkout-index"
   only accepts pathspecs.  Plumbing tends to produce parseable
   output and not to automatically spawn a pager when its output is
   going to the terminal or to change behavior based on configuration.

Now, a word of warning.  One aspect of this "do not second-guess the
caller" behavior is that low-level commands like "git diff-index"
blindly trust stat() information in the index, rather than going to
re-read a seemingly modified file and updating the index if the
content is not changed.  You can see this by running "touch foo.bar";
"git diff-index" will report the file as changed, until you use "git
update-index" to refresh the stat information:

	git update-index --refresh --unmerged -q >/dev/null || :
	if ! git diff-index --quiet HEAD -- foo.bar; then
		dirty=3D1
	fi

Alas, this doesn't seem to be documented anywhere (except for the
gitcore-tutorial(7))!  It ought to be.

> Both A) and B) work. But which one is better/faster/more reliable?

I suspect the fastest (by virtue of saving a fork + exec and not
having to stat files twice, once for update-index and again for
diff-index) is

	git -c diff.autorefreshindex=3Dtrue diff --quiet -- foo.bar

by a sad accident of history --- the "opportunistic index refresh"
behavior it implements does not seem to be exposed as plumbing.
If you are going to be performing such operations in a loop, then

	git update-index --refresh --unmerged -q >/dev/null || :
	for i in loop
	do
		... actions like diff-index that trust the index ...
	done

will be faster.  And the latter is plumbing, with all the niceties
that entails, so if I were in your shoes I'd use the latter.

Hope that helps,
Jonathan
