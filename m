From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v3 0/8] Fix GIT_CEILING_DIRECTORIES that contain symlinks
Date: Sun, 28 Oct 2012 17:15:29 -0700
Message-ID: <CAJDDKr4ki+NjSeuZpAU6bM=YAQ_3mdHCtawstdCqe9Ewvp=arQ@mail.gmail.com>
References: <1350799057-13846-1-git-send-email-mhagger@alum.mit.edu>
	<7v7gqkgvxe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	David Reiss <dreiss@facebook.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	"Lars R. Damerow" <lars@pixar.com>, Jeff King <peff@peff.net>,
	Marc Jordan <marc.jordan@disneyanimation.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 29 01:15:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSd15-0006n2-Ba
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 01:15:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756140Ab2J2APb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 20:15:31 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:38614 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612Ab2J2APa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2012 20:15:30 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so4793672vbb.19
        for <git@vger.kernel.org>; Sun, 28 Oct 2012 17:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Xqns10Qufrz6jiZRe/SWN4kWeQqTe3KI7FwW51c/igs=;
        b=ArcaASEUcKTQU65eNTGFDUVK4iTu5PqaRBKm+NH7mpdldNgL0t607ka5LzPvlRBktL
         JBANuT15ZA7oORpT6w0UZGIB4sCVgJURk95wK07leHmluXCiQcxew0k8D05tnLJJldQb
         JRpIUh35BNVHJzZe0+EklVbC5PGQM3xkgpqsn8el9cQEpGuLT3qU6CR2VLUwi76BYlX5
         rrzpzNBMEEBgQCpsS3pi3+07uqI6k0vQNL7PVu0VcRu3VD0WuoLzPyDnHsQONw797125
         LjtZUbWW2lJvnuVHauP+VeWAke1yo+FbjpYJKj/0H8TF62vpALjIQIX9pvsZ1bRFukJa
         9pzQ==
Received: by 10.52.98.200 with SMTP id ek8mr38223870vdb.90.1351469729643; Sun,
 28 Oct 2012 17:15:29 -0700 (PDT)
Received: by 10.58.182.10 with HTTP; Sun, 28 Oct 2012 17:15:29 -0700 (PDT)
In-Reply-To: <7v7gqkgvxe.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208579>

On Sat, Oct 20, 2012 at 11:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> This patch series has the side effect that all of the directories
>> listed in GIT_CEILING_DIRECTORIES are accessed *unconditionally* to
>> resolve any symlinks that are present in their paths.  It is
>> admittedly odd that a feature intended to avoid accessing expensive
>> directories would now *intentionally* access directories near the
>> expensive ones.  In the above scenario this shouldn't be a problem,
>> because /home would be the directory listed in
>> GIT_CEILING_DIRECTORIES, and accessing /home itself shouldn't be
>> expensive.
>
> Interesting observation.  In the last sentence, "accessing /home"
> does not exactly mean accessing /home, but accessing / to learn
> about "home" in it, no?
>
>> But there might be other scenarios for which this patch
>> series causes a performance regression.
>
> Yeah, after merging this to 'next', we should ask people who care
> about CEILING to test it sufficiently.
>
> Thanks for rerolling.

GIT_CEILING_DIRECTORIES was always about trying to avoid
hitting them at all; they can be (busy) NFS volumes there.

Here's the description from the 1.6.0 release notes:

* A new environment variable GIT_CEILING_DIRECTORIES can be used to stop
  the discovery process of the toplevel of working tree; this may be useful
  when you are working in a slow network disk and are outside any working tree,
  as bash-completion and "git help" may still need to run in these places.

In 8030e44215fe8f34edd57d711a35f2f0f97a0423 Lars added
GIT_ONE_FILESYSTEM to fix a related issue.
Do you guys have GIT_CEILING_DIRECTORIES set too?

We use GIT_CEILING_DIRECTORIES and I'm pretty sure
we don't want every git command hitting them, so this would
be a regression when seen from the POV of our current usage
of this variable, which would be a bummer.

Is there another way to accomplish this without the performance hit?
Maybe something that can be solved with configuration?

I'd be happy to lend a hand if you guys have some ideas
on how we can help keep it fast.  Thoughts?

Original patches for those just joining us:
http://thread.gmane.org/gmane.comp.version-control.git/208102
-- 
David
