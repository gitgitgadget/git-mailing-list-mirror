From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: setup gitosis on Fedora 11
Date: Sat, 18 Jul 2009 07:14:48 +0530
Message-ID: <2e24e5b90907171844o11eb6699m929e3c0df621ef67@mail.gmail.com>
References: <1247867114.2384.15.camel@brizlyMobil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: brizly vaan van Ulciputz <brizly@freenet.de>
X-From: git-owner@vger.kernel.org Sat Jul 18 03:50:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRz4I-0007D2-3g
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 03:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756443AbZGRBuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 21:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754680AbZGRBuU
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 21:50:20 -0400
Received: from mail-px0-f185.google.com ([209.85.216.185]:53576 "EHLO
	mail-px0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107AbZGRBuT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 21:50:19 -0400
Received: by pxi15 with SMTP id 15so833144pxi.33
        for <git@vger.kernel.org>; Fri, 17 Jul 2009 18:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=26V37IHR+AUBBZb85NyPpzlUvqeyTnonXlWaQQzj3kw=;
        b=YDDg90TuRuveo+4HYzdmybbHP8fIIa4p+NUKduNp9xMx8sw1M2oSa+ZcLUqhnOrBLg
         bbJl3fiGT2T1ps8cTCVN+NzdwILx/IdHythMvzSfFQSWVvhAeehzYiqcU/UZdlVHnd7Y
         Dkrg3qUSl/FHbsruLrfw3XsoamVK8Tj8Hw27U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NzOKtlpv3eDKPFkTvhToWrSlhKdwuiSD9y80/G29+c66k8eC5MttEkFyYjcRfuadlM
         1EfJ2jMDlck6hEnnFlGEasq0+sFnapd/bWO0foG1PVyPV+EpG+mgwov8jtnhCtkbh2Sh
         0Sk+s0O0EL0JbTrv0ejoSASTpk6RWdB16Bnn0=
Received: by 10.114.155.5 with SMTP id c5mr1435764wae.34.1247881488820; Fri, 
	17 Jul 2009 18:44:48 -0700 (PDT)
In-Reply-To: <1247867114.2384.15.camel@brizlyMobil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123502>

On Sat, Jul 18, 2009 at 3:15 AM, brizly vaan van
Ulciputz<brizly@freenet.de> wrote:

> i tried to setup gitosis on a Fedora 11 system,
> since i dont seem to be the only person having trouble here,
> i am asking here now.
>
> someone pasted that:
> http://paste.org/pastebin/view/9154
> and that's just the way i did it and the way i end in :-(
>
> with the only difference i was using another 'tutorial'
> http://www.shakthimaan.com/installs/gitosis.html
>
> i tried a bit an sometimes ended in the prompt to enter password for
> gitosis@server after "git push..." No idea what to do.
>
> I asked #git and #fedora on freenode, was referred to this list.
> So can anyone gimme a hint?

line 12 in the first pastebin (and there's no need to use pastebins for a few
lines on the mailing list; it's on #git that is really needed!) says
    ERROR:gitosis.serve.main:Repository read access denied

This means you got past ssh issues, which is further along than most people
who come to #git with gitosis problems :-)

This error could mean one of the following:

(1) you're using the wrong key/repo pair.  Of course your key *is* in
gitosis.conf but the repo you're trying to push to isn't, or doesnot
list you as one of the valid users

(2) your gitosis.conf is all correct, but you forgot the "chmod" somewhere
above, and the post-update hook never ran, so the real gitosis.conf (which
gitosis uses -- this is ~git/.gitosis.conf) doesn't have the same data

I also don't like that howto; it appears to be doing everything on one
machine, with the same userid, so people who don't grok ssh very well will
still have trouble even after all this is done to translate that knowledge to a
real deployment.

Bottom line: here's what should match for that error to go away:

  - the public key corresponding to the private key your client-side ssh is
    using
  - must match *exactly* one of the public keys in the server-side
    ~git/.ssh/authorized_keys

[this is probably OK in your case, but please check there is *exactly one*.  I
have a vague memory of seeing a case when someone adds a key twice with
different usernames in error.  Ssh picks up perhaps the first one, while your
gitosis.conf talks about the second one...]

and

  - the name after "gitosis-init" on the pubkey line that matched above
  - must match a username in ~git/.gitosis.conf (which is a symlink to
    something but never mind)

and

  - this username must be mentioned in the members= line of some section in
    gitosis.conf which also has "writable = my-first-repo"

You can check *all* of this by looking at ~git/.gitosis.conf and
~git/.ssh/authorized_keys on the server and ~/.ssh/id_[rd]sa.pub on your
client
