From: Doug Kelly <dougk.ff7@gmail.com>
Subject: Re: Question: .idx without .pack causes performance issues?
Date: Fri, 7 Aug 2015 16:36:34 -0500
Message-ID: <CAEtYS8SGnFFHM5BFzAo+Z2BzUGbp47AibA3v6qm_uEboRmfaNQ@mail.gmail.com>
References: <CAEtYS8QWCg5_DtrJw-e+c50vcG0OpciR6LWon-3GgyngGn+0pQ@mail.gmail.com>
	<xmqq4mkxwd77.fsf@gitster.dls.corp.google.com>
	<xmqqzj2puxu2.fsf@gitster.dls.corp.google.com>
	<xmqqtwsxtey8.fsf@gitster.dls.corp.google.com>
	<CAEtYS8QEuEA6d13FH_0_ZbT9YbJ_UdvhkSBYq1xyGCAuznh-GQ@mail.gmail.com>
	<CAEtYS8SNksc0m5rn_tRk8bGLBeq_8QcBLHyHo=cOfZ+aE6n0gA@mail.gmail.com>
	<xmqqk2tb6dxc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri Aug 07 23:36:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNpJi-0007Ka-Mv
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 23:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946272AbbHGVgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 17:36:37 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36774 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946205AbbHGVgg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 17:36:36 -0400
Received: by igbij6 with SMTP id ij6so39053440igb.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2015 14:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:cc
         :content-type;
        bh=eYaULTTR2JID+kjAaC1RuhNfPKB5zXljaSveFU7c2Ow=;
        b=ZFn/f6rtF5dO7+6Hqtys249OeDoUf7HebjW728MBjIbLW1diUDba9bjV/iYIMaROO6
         W58qh55+JERop/x9BN/pJrnsZBhIRwx14xYp2JsHIAWe9bLWjt9o2KSBbJEcidSkLVOl
         N13yr1aLdxit9/eVdV5Ca4Bb1pFbumo4lzT30pVy9cw/HGTVui2Q+ugILzMZEsGuHEoT
         7QV/VnwSUdoBdaHYchluHZW0hcA2gnl1C2YpVFsrC5FEj+h9xKao3F66Ef5g2ULqaYaE
         fpqMmNcqDuTPdlVGXi8bob7gFUMSoJfFEf1RiKcuI8OANpsElovGlmmjps3x10+FqaEw
         bK8A==
X-Received: by 10.50.8.39 with SMTP id o7mr230347iga.23.1438983394586; Fri, 07
 Aug 2015 14:36:34 -0700 (PDT)
Received: by 10.79.91.133 with HTTP; Fri, 7 Aug 2015 14:36:34 -0700 (PDT)
In-Reply-To: <xmqqk2tb6dxc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275493>

On Mon, Aug 3, 2015 at 8:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Doug Kelly <dougk.ff7@gmail.com> writes:
>
>> Here's a change to prune.c that at least addresses the issue by removing
>> .idx files without an associated pack, but it's by no means pretty.  If anyone
>> has any feedback before I turn this into a formal patch, it's more than welcome!
>
> I'd hesitate to see removal of a file (for that matter, a creation
> too) inside a "while (de = readdir)" loop.  As the original function
> is about temporary files, and the new thing is not about temporary
> files at all, I'd further prefer that we do not do it in the same
> loop.
>
> I am wondering if we can add a new mode to report_pack_garbage() in
> sha1_file.c to allow it to remove stale and lone ".idx".  Most of
> the time we are accessing packs read-only, and I do not want the
> function to unconditionally remove lone ".idx", but perhaps we
> can teach "prune" to set a custom report_garbage() routine and
> react to a call to its custom report_garbage()?
>
> Perhaps that custom report_garbage() can make a list of ".idx"
> files, iterate over it to pick the lone one without ".pack" and
> remove them.  Or the custom report_garbage() can make a list of lone
> ".idx" files, if you tweak the interface to report_garbage() to
> contain th seen_bits value, avoiding the need to check the existence
> of ".pack" for the second time.

Yeah, I didn't think this was the cleanest solution, and I wasn't even
thinking about removing while inside the readdir loop, but I can see
how that might be a very bad idea.  In any case, thanks for the
suggestions... I'll be completely blunt in saying I'm far less than
well-versed in the Git internals.  Looking at the implementation of
report_pack_garbage(), it does look like seen_bits already has this
logic, and indeed, git count-objects -v reports the files as garbage.

So, I think you're right: prune would need to set report_garbage
appropriately, then call count-objects to clean that up.  If we wanted
it to *only* care for lone idx files, we would have to string match on
the message (seems fragile), but perhaps a more observant approach
would be to add a custom flag to prune to clean *all* garbage in the
repository, as passed to report_garbage?  Probably wouldn't want to be
enabled by default, but only on invocation or with careful
consideration and setting an appropriate config flag.

Thoughts?
