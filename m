From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Borrowing objects from nearby repositories
Date: Sun, 23 Mar 2014 14:04:12 -0400
Message-ID: <CABURp0rKz9s7aPx_6ucTQ5C8NpPZMcJL3jaB_v_rQaBE+sFt1Q@mail.gmail.com>
References: <BFF5FBC7-8F53-4958-8D56-90EADD3AD626@kellerfarm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git List <git@vger.kernel.org>
To: Andrew Keller <andrew@kellerfarm.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 19:04:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRmlC-0005Y5-Kw
	for gcvg-git-2@plane.gmane.org; Sun, 23 Mar 2014 19:04:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752470AbaCWSEe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2014 14:04:34 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:35570 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335AbaCWSEd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Mar 2014 14:04:33 -0400
Received: by mail-wg0-f42.google.com with SMTP id y10so2816564wgg.1
        for <git@vger.kernel.org>; Sun, 23 Mar 2014 11:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=4P18F4UBlzcgMnHzd4Ki/tH4myE8+B8yT5wizRv1AR0=;
        b=WETRdVh5QEJFFAXSVvXCxRuvkMAPRrByNmAwbS9pRWJdmCJ2EKkRaaKsFMGMmR+Gmy
         P28LStJ5BeAAS136L9SNaBbCf7BVij+nVSxwGU/S54bnMnXFns+sOESIc4k7qHjFX3lO
         79S3LEsuMfs36OMP8eY1vreAw0aq4mRbxxEQ1rKXMWzPa3f7pKlbgaxt1pfUMzhVb/F4
         euyfCvrEIpsQKPBtyR1a+65WMsnph0epLsjVc4bFkB+kSLBYJhet0gXl8ly6KC+bbtBJ
         5/TUCwOPitvNM8tarmJ+IQu8TMKpInTXlUerrBXVz4tqMqoC1mpbfBZ22g0oUVHmBMAq
         loLA==
X-Received: by 10.180.79.73 with SMTP id h9mr10196172wix.3.1395597872094; Sun,
 23 Mar 2014 11:04:32 -0700 (PDT)
Received: by 10.227.147.3 with HTTP; Sun, 23 Mar 2014 11:04:12 -0700 (PDT)
In-Reply-To: <BFF5FBC7-8F53-4958-8D56-90EADD3AD626@kellerfarm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244797>

On Tue, Mar 11, 2014 at 11:37 PM, Andrew Keller <andrew@kellerfarm.com> wrote:
> I am considering developing a new feature, and I'd like to poll the group for opinions.
>
> Background: A couple years ago, I wrote a set of scripts that speed up cloning of frequently used repositories.  The scripts utilize a bare Git repository located at a known location, and automate providing a --reference parameter to `git clone` and `git submodule update`.  Recently, some coworkers of mine expressed an interest in using the scripts, so I published the current version of my scripts, called `git repocache`, described at the bottom of <https://github.com/andrewkeller/ak-git-tools>.
>
> Slowly, it has occurred to me that this feature, or something similar to it, may be worth adding to Git, so I've been thinking about the best approach.  Here's my best idea so far:
>
> 1)  Introduce '--borrow' to `git-fetch`.  This would behave similarly to '--reference', except that it operates on a temporary basis, and does not assume that the reference repository will exist after the operation completes, so any used objects are copied into the local objects database.  In theory, this mechanism would be distinct from '--reference', so if both are used, some objects would be copied, and some objects would be accessible via a reference repository referenced by the alternates file.

Interesting.  I do something similar on my CI Server to reduce
workload on Gerrit. Having a built-in to support submodules would be
nice.  Currently my script does this:

MIRROR=/path/to/local/mirror
NEW=ssh://gerrit-server
git clone ${MIRROR}/project && cd project

#-- Init/update submodules from our local mirror if possible
git submodule update --recursive --init

#-- Switch to the remote server URL
git config remote.origin.url $(git config remote.origin.url|sed -e
"s|^${MIRROR}|${NEW}|")
git submodule sync #--recursive ; recursive not supported :-[

#-- Checkout remote updates
git pull --ff-only --recurse-submodules origin ${BRANCH}
git submodule update --recursive --init


Is that about the same as you are aiming for?


> 2)  Teach `git fetch` to read 'repocache.path' (or a better-named configuration), and use it to automatically activate borrowing.

Seems like this could be trouble if a local repo is coincidentally
named the same as some unrelated repo you want to clone.  But I can
see the value.

What about something similar to url.insteadOf?   Maybe
'url.${SERVER}.autoBorrow = ${MIRROR}', with replacement semantics
similar to insteadOf.

> 3)  For consistency, `git clone`, `git pull`, and `git submodule update` should probably all learn '--borrow', and forward it to `git fetch`.
>
> 4)  In some scenarios, it may be necessary to temporarily not automatically borrow, so `git fetch`, and everything that calls it may need an argument to do that.

--no-borrow

Phil
