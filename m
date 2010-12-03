From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: How to "pre-populate" a git message
Date: Fri, 3 Dec 2010 13:29:50 -0600
Message-ID: <20101203192950.GA14561@burratino>
References: <AANLkTim=dVxVLL31aEBrjw7OhXpdYOjAO9Sk16gGP3zJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Thomas Rast <trast@student.ethz.ch>
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 20:30:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PObKl-0004AT-OW
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 20:30:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362Ab0LCTaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 14:30:13 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:38402 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797Ab0LCTaM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 14:30:12 -0500
Received: by qwb7 with SMTP id 7so9977677qwb.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 11:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=WVo2jErnxgaJp4EaU5uXMUcyVgMGxlbjopWMa3lOuRg=;
        b=U71UWPUa3EwcweDIZs5ALv+Wk/xD6WqSeLs+w+IjggoRPX7ElxZzotVG2X4LZZgA2a
         FQa6k04EDG9JhKVTUKCHx/PI1Icc1C1gabjCgdF+9138izexapVnQ/lNOxAPmfuqvj+7
         wlHLgVV9eXPs5++eVBuAwUPhy2YS4cbzhBg1A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HPMna7d94vf95Zx8CnvYtrunt6GILJDL3PtAjOikUCZ5o4Akb+P4bCgQsoyDsQqhZ2
         VW76fusTYGdDsN3aR0j3Z7RnKiZGb3N5UQPfOqFjxDjy6u7DJnq7J1eUfbKJCPJQ4kcZ
         ZaYDErbKX964Qgf0xPDENr8F6LZz4Bsbo6ZWM=
Received: by 10.224.20.5 with SMTP id d5mr1590825qab.187.1291404610868;
        Fri, 03 Dec 2010 11:30:10 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id u2sm1442257qcq.7.2010.12.03.11.30.08
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 11:30:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTim=dVxVLL31aEBrjw7OhXpdYOjAO9Sk16gGP3zJ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162835>

(+cc: Jeff and Thomas, pioneers in application of notes)

Hi!

Patrick Doyle wrote:

> Once in a while, I would like to run some scripts that will
> automatically generate some files that I keep maintained in my
> repository.  (Yes, I know that I shouldn't have to keep them version
> controlled if I can regenerate them, but it's easier to check out old
> versions of the files than it is to check out old versions of the
> repository, wait 1/2 hour to regenerate the files, and then look at
> them).

Not what you asked, but here's an alternative approach.

The idea is that sometimes you might not want to wait 1/2 hour
for each commit and that keeping generated files in this case is
more about caching than tracking content.

So, wouldn't it be nice if you could ask to remember these
generated files _after_ commiting?  It works like this:

An expensive command to generate some files can be run
(asynchronously?) by explicit request, commit hook, or cron job.
First it would check if the file is already available.

	if git notes --ref=generated/expensive.result show HEAD >/dev/null 2>&1
	then
		# already cached
		exit 0
	elif test $? != 1
	then
		# exit with error message
		exec git notes --ref=generated/expensive.result show HEAD
	fi
	# no note found; let's make one!
	... expensive operation ...
	blob=$(git hash-object -w expensive.result) &&
	git notes --ref=generated/expensive.result add -C "$blob" HEAD ||
		exit

The result could be retrieved on checkout (see the post-checkout hook)
or explicitly.

	git notes --ref=generated/expensive.result show HEAD >expensive.result+
	mv expensive.result+ expensive.result

See v1.7.2-rc0~159^2~1 (diff: cache textconv output, 2010-04-01) for
a similar (but not identical) example.  Unfortunately the notes-cache
facility used there is not currently exposed for scripted use.

Sorry for the digression.  To return to your question:

> I also like to review the files before they get committed.

Maybe "git commit -v" or the prepare-commit-msg hook could help?

Thanks for an example.
Jonathan
