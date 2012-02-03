From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Git performance results on a large repository
Date: Fri, 3 Feb 2012 15:56:35 +0100
Message-ID: <CACBZZX4BsFZxB6A-Hg-k37FBavgTV8SDiQTK_sVh9Mb9iskiEw@mail.gmail.com>
References: <CB5074CF.3AD7A%joshua.redstone@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Redstone <joshua.redstone@fb.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 15:57:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtKZR-0002vs-IU
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 15:57:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756667Ab2BCO45 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 09:56:57 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:64153 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756433Ab2BCO44 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Feb 2012 09:56:56 -0500
Received: by lagu2 with SMTP id u2so1886970lag.19
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 06:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=NF7rjHr7w3PGo3I/Lcxf4KI8oKYvy7KD3OcwrH0P+HE=;
        b=utfH2v9AyvYEjGo+1RSrYTyYVtzuphczCuAlchKvKbH+DD4KTZhX0pw4nBjZsVAQfQ
         RJdCm/dl4cUQ5nA0vKFRb2KSTfRlfpHeBYRpkGgkytaCKLDjMmmbK7yBbW+Kf385IDU/
         Psxu3m6O80XJ9DbyHrKPMsMpZUXpVTJdYkwP4=
Received: by 10.152.123.10 with SMTP id lw10mr4224796lab.35.1328281015187;
 Fri, 03 Feb 2012 06:56:55 -0800 (PST)
Received: by 10.112.21.231 with HTTP; Fri, 3 Feb 2012 06:56:35 -0800 (PST)
In-Reply-To: <CB5074CF.3AD7A%joshua.redstone@fb.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189780>

On Fri, Feb 3, 2012 at 15:20, Joshua Redstone <joshua.redstone@fb.com> =
wrote:

> We (Facebook) have been investigating source control systems to meet =
our
> growing needs. =C2=A0We already use git fairly widely, but have notic=
ed it
> getting slower as we grow, and we want to make sure we have a good st=
ory
> going forward. =C2=A0We're debating how to proceed and would like to =
solicit
> people's thoughts.

Where I work we also have a relatively large Git repository. Around
30k files, a couple of hundred thousand commits, clone size around
half a GB.

You haven't supplied background info on this but it really seems to me
like your testcase is converting something like a humongous Perforce
repository directly to Git.

While you /can/ do this it's not a good idea, you should split up
repositories at the boundaries code or data doesn't directly cross
over, e.g. there's no reason why you need HipHop PHP in the same
repository as Cassandra or the Facebook chat system, is there?

While Git could better with large repositories (in particular applying
commits in interactive rebase seems to be to slow down on bigger
repositories) there's only so much you can do about stat-ing 1.3
million files.

A structure that would make more sense would be to split up that giant
repository into a lot of other repositories, most of them probably
have no direct dependencies on other components, but even those that
do can sometimes just use some other repository as a submodule.

Even if you have the requirement that you'd like to roll out
*everything* at a certain point in time you can still solve that with
a super-repository that has all the other ones as submodules, and
creates a tag for every rollout or something like that.
