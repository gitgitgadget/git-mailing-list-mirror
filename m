From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 6/6] upload-pack: provide a hook for running pack-objects
Date: Thu, 19 May 2016 12:12:43 +0200
Message-ID: <CACBZZX5SVJ2CSB0AS3Lj1A8_S+ejGOPUDn6Sc3whotkyFwxEiA@mail.gmail.com>
References: <20160518223712.GA18317@sigill.intra.peff.net> <20160518224537.GF22443@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 19 12:13:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3Kx3-0004Vx-Vc
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 12:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754610AbcESKNF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 06:13:05 -0400
Received: from mail-qg0-f66.google.com ([209.85.192.66]:35449 "EHLO
	mail-qg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753910AbcESKND (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 06:13:03 -0400
Received: by mail-qg0-f66.google.com with SMTP id b14so6442753qge.2
        for <git@vger.kernel.org>; Thu, 19 May 2016 03:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=041KfEXE7lwiwap0D7aE3ghZt7lfMlqktRuW6gMOxmY=;
        b=HrfLkuhLLGxeIVaHjrAAgPBS7qFH3iC7SjqqBN2ycu5++nlze1JVqjz0ceKFoGBQWQ
         NrSUfiQMmywnQbOPtafC22qb93Topj+yfyorucbLLVvHgrZXtWGW4i7vbKbD00G/ngoU
         kdTfJv19AOu34zv4Sgw2ZyzFhlqaoQyFU/5T+ynBNxlvYoZK3Vaq7Qs55uaeUNBAdz4a
         NCCl16r9wMLsVWakalEWpaSMyPFNriOh07nc+cbCuI9e151xBR4q8bO3ulH6OlQy+Yzu
         1JP5YxXKbcGQhekV+H5FFnnSFXtZ5dyGiob/5ybw2W2myWldN1U7rPMJBTWHyy70HVyw
         ZWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=041KfEXE7lwiwap0D7aE3ghZt7lfMlqktRuW6gMOxmY=;
        b=WZ0rwLt53CZGasE4PcrZaka/Lhx64mH7oPT4zvvgBjowrAk/Cv19yPuZbR5vmOvue2
         WGSHTYqYKEhDdnDo21BTVMjg4RYOiBVAF7cC4AXt7RGrpnNXevbDYbdw6gKMeZKer/9V
         oFjCX1ea5aneFhHyEDvw5/G64eHm/+J9W8p0CUhymGzr0RzyiPyGcxR8lFe07zI60dGB
         A6+2XqrSkzztIGjEJiV/H+GZ6NVc0P5IZYhWKCI9jZktrRA/BGx5IOPiAUf1aVXbwSyu
         pp+wykU/F6y0YO0cdryR+YksGEo5CfsVFPWFh+Ors0NA1L2ZmYI2Z/DLbbxauWieGfN3
         VQwQ==
X-Gm-Message-State: AOPr4FVg33v8/E1Op5FaQUA8sxU7i9agkChZ9X+qb5n+OboQ1F2cMh6IxtQC1yj3IQ9cNjBK28bLUSrEwLW3wQ==
X-Received: by 10.140.108.183 with SMTP id j52mr12716575qgf.90.1463652782551;
 Thu, 19 May 2016 03:13:02 -0700 (PDT)
Received: by 10.55.77.133 with HTTP; Thu, 19 May 2016 03:12:43 -0700 (PDT)
In-Reply-To: <20160518224537.GF22443@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295055>

On Thu, May 19, 2016 at 12:45 AM, Jeff King <peff@peff.net> wrote:
>   3. You may want to insert a caching layer around
>      pack-objects; it is the most CPU- and memory-intensive
>      part of serving a fetch, and its output is a pure
>      function[1] of its input, making it an ideal place to
>      consolidate identical requests.

Cool to see this on the list after we talked briefly about this at Git
Merge. Being able to cache this so simply is a great optimization.

As I recall you guys at GitHub ended up writing your own utility to
cache output depending on stdin/argv because none existed already.

If anyone on-list knows about a generic command-line utility like that
(because apparently Peff couldn't think of any, and neither can I)
that would be useful to know.

> This hook is unlike the normal hook scripts found in the
> "hooks/" directory of a repository. Because we promise that
> upload-pack is safe to run in an untrusted repository, we
> cannot execute arbitrary code or commands found in the
> repository (neither in hooks/, nor in the config). So
> instead, this hook is triggered from a config variable that
> is explicitly ignored in the per-repo config.

So do I understand correctly that you're trying to guard against the
case where you e.g.:

    rsync untrusted.example.com:/tmp/poison.git /tmp/
    git clone /tmp/poison.git /tmp/safe.git

Not hosing your system if the poison.git/config has a
uploadpack.packObjectsHook that's "sudo rm -rf /".

And similarly having this run the hook on the remote:

    # foo.example.com has a /etc/gitconfig with
uploadpack.packObjectsHook "sudo rm -rf /";
    echo -n | ssh foo.example.com "git upload-pack /tmp/poison.git

But not this:

    # bar.example.com has a /tmp/poison.git/config with
uploadpack.packObjectsHook "sudo rm -rf /";
    echo -n | ssh foo.example.com "git upload-pack /tmp/poison.git

We've already accepted that "push" hooks like the pre-receive or
update hook can do something malicious like this, so on one hand maybe
we should say if you scp raw *.git repositories with hooks this sort
of thing might happen, or if you ssh to a remote box and run their
per-repo hooks it's really their problem to make sure their users
don't run malicious hooks on your behalf.

But I agree with you (if I've understand what this actually does) that
saying that it's always safe to "git clone" a repository is more
valuable and worth jumping through some hoops for.

But as you point out this makes the hook interface a bit unusual.
Wouldn't this give us the same security and normalize the hook
interface:

 * Don't do the uploadpack.packObjectsHook variable, just have a
normal "pack-objects" hook that works like any other git hook
 * By default we don't run this hook unless core.runDangerousHooks (or
whatever we call it) is true.
 * The core.runDangerousHooks variable cannot be set on a per-repo
basis using your new config facility.
 * If there's a pack-objects hook and core.runDangerousHooks isn't
true we warn "not executing potentially unsafe hook $path_to_hook" and
carry on

This would allow use-cases that are a bit inconvenient with your patch
(again, if I'm understanding it correctly):

 * I can set core.runDangerousHooks=true in /etc/gitconfig on my git
server because I also control all the repos, and I want to experiment
with trying this on a per-repo basis for users that are cloning from
me.
 * I can similarly play with this locally knowing I'm only cloning
repos I trust by setting core.runDangerousHooks=true in ~/.gitconfig
