From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Git performance results on a large repository
Date: Tue, 7 Feb 2012 20:43:50 +0700
Message-ID: <CACsJy8AxOZQ7S42V1g-b0vdBxPpjhFZe6qDkGaALnxQ6LiUssw@mail.gmail.com>
References: <CB5074CF.3AD7A%joshua.redstone@fb.com> <CACsJy8DkLCK0ZUKNz_PJazsxjsRbWVVZwjAU5n2EAjJfCYtpoQ@mail.gmail.com>
 <243C23AF01622E49BEA3F28617DBF0AD5912CA85@SC-MBX02-5.TheFacebook.com>
 <CACsJy8Bf95JMp1qOiruR7+Tdi7JN42KNeMqGLud+z3O26DREnw@mail.gmail.com> <20120206154043.GA14632@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Tue Feb 07 14:44:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RulLQ-0005xR-Bx
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 14:44:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755771Ab2BGNoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 08:44:23 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:38021 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590Ab2BGNoW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 08:44:22 -0500
Received: by werb13 with SMTP id b13so5017640wer.19
        for <git@vger.kernel.org>; Tue, 07 Feb 2012 05:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WVRPfBrrT52VBpayeC2iLe9lNQ7tkTOOcgzmU8xPSxo=;
        b=k3dlgbseZHGrEtPs2TGSIKjegutAok5/swft+WOkO4UjsQ9ObIDw/mn3JbwpSu2fb1
         6TIHig/Mm+61s/9oJ8A9PMIdsn1EpbfYhcQyOXeNZXoGZU4J0qC7F+L/Lixhpo5OuJsj
         MMAPr3BuLEgH6VLOTnPocrVxi6XyeDA/S2LZs=
Received: by 10.216.136.17 with SMTP id v17mr8582895wei.26.1328622261315; Tue,
 07 Feb 2012 05:44:21 -0800 (PST)
Received: by 10.223.2.139 with HTTP; Tue, 7 Feb 2012 05:43:50 -0800 (PST)
In-Reply-To: <20120206154043.GA14632@gnu.kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190175>

On Mon, Feb 6, 2012 at 10:40 PM, Joey Hess <joey@kitenet.net> wrote:
>> Someone on HN suggested making assume-unchanged files read-only to
>> avoid 90% accidentally changing a file without telling git. When
>> assume-unchanged bit is cleared, the file is made read-write again.
>
> That made me think about using assume-unchanged with git-annex since it
> already has read-only files.
>
> But, here's what seems a misfeature...

because, well.. assume-unchanged was designed to avoid stat() and
nothing else. We are basing a new feature on top of it.

> If an assume-unstaged file has
> modifications and I git add it, nothing happens. To stage a change, I
> have to explicitly git update-index --no-assume-unchanged and only then
> git add, and then I need to remember to reset the assume-unstaged bit
> when I'm done working on that file for now. Compare with running git mv
> on the same file, which does stage the move despite assume-unstaged. (So
> does git rm.)

This is normal in the lock-based "checkout/edit/checkin" model. mv/rm
operates on directory content, which is not "locked - no edit allowed"
(in our case --assume-unchanged) in git. But lock-based model does not
map really well to git anyway. It does not have the index (which may
make things more complicated). Also at index level, git does not
really understand directories.

I think we could add a protection layer to index, where any changes
(including removal) to an index entry are only allowed if the entry is
"unlocked" (i.e no assume-unchanged bit). Locked entries are read-only
and have assume-unchanged bit set. "git (un)lock" are introduced as
new UI. Does that make assume-unchanged friendlier?
-- 
Duy
