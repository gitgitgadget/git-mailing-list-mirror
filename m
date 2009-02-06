From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: [PATCH] Offer to print changes while running git-mergetool
Date: Fri, 6 Feb 2009 19:08:47 +0000
Message-ID: <57518fd10902061108k6a7691c5r13b2782baf3bfde3@mail.gmail.com>
References: <1233930745-77930-1-git-send-email-jon.delStrother@bestbefore.tv>
	 <57518fd10902060641pa789ffbjceccbf013864e0a5@mail.gmail.com>
	 <7vocxf5ufu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 20:10:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVW5h-00024q-EL
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 20:10:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296AbZBFTIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 14:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753083AbZBFTIu
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 14:08:50 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:41964 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752970AbZBFTIt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 14:08:49 -0500
Received: by fg-out-1718.google.com with SMTP id 16so592537fgg.17
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 11:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=hRYsm2SpQDL19hC6Y9Rf1s0WISWsxgst1ZU0BH+gia4=;
        b=mAefZ7Njj1JhWlpE9mxpZWKeDZZ9oJCg7oTn+9T/LwUw0D3flLFatWdR77pFO3+m48
         Cp1LUxYrYFK7MXAhhhUldiPz97qRuE+BbG7VIn+me+IbhJ8T0Pv/tx5ukkXo+jPA6AGb
         qbKndBjPcU23eWFshrcQc1jG1zmvAXZ10lLSs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=vEkLwkkpTB9SufGjbZM+9fb/S6k6V6kLuDs9mAj3mxiJOed3Il4g7STh5ngFIUSyy2
         wlK1I/yfxbWpAkV7uc0IL6HN5T5NmQMRne40LPSR7xplXI8YfvnO7zpUujCMyVMzifzJ
         mXdUJHiKJsXYNsS01thi1OuS9TgwmheStY63Y=
Received: by 10.223.109.200 with SMTP id k8mr173536fap.44.1233947327815; Fri, 
	06 Feb 2009 11:08:47 -0800 (PST)
In-Reply-To: <7vocxf5ufu.fsf@gitster.siamese.dyndns.org>
X-Google-Sender-Auth: a2e04263cc481501
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108772>

On Fri, Feb 6, 2009 at 5:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan del Strother <maillist@steelskies.com> writes:
>
>> On Fri, Feb 6, 2009 at 2:32 PM, Jonathan del Strother
>> <jon.delStrother@bestbefore.tv> wrote:
>>> Add a "Show changes" option to each prompt in mergetool. This prints the conflicted changes on the current file, using 'git log -p --merge <file>'
>>
>> Just discovered that this doesn't work so well when resolving merges
>> resulting from "git stash apply" - it produces "fatal: --merge without
>> MERGE_HEAD".  Should git-stash be setting MERGE_HEAD in this case,
>
> No no no, please absolutely don't.  MERGE_HEAD is an instruction to the
> eventual commit to create a merge commit and use the commits recorded
> there as other parents when it does so.  You do *NOT* want to end up with
> a merge with random state after unstashing.  None among cherry-pick,
> rebase, checkout -m (branch switching), nor am -3 should.
>
> I'd suggest making the new action conditionally available, by using the
> presense of MERGE_HEAD as a cue.
>
> The thing is, these commands that can potentially end in conflict operate
> only at the tree level, and not at the level of commit ancestry graph.
> "log --merge" is all about following the commit ancestry graph, and for
> conflicts left by these commands it is not a useful way to review.
>

Maybe I'm misunderstanding the issue, but it seems like showing the
conflicted changes somehow could still be useful.  eg If I've made
changes on branch A, stash, switch to branch B, apply the stash and
get conflicts, I'd still like to see the commits that produced those
conflicts.
Obviously for a stash 'merge', one side of the merge isn't that
interesting : it's just going to be all the stuff from my working copy
before it was stashed.  But wouldn't the other side of the merge (ie
changes made on branch B since A & B diverged) produce useful
information?

Off the top of my head, I guess I want something like  "git log -p
^stash HEAD", but obviously that doesn't work when dealing with, say,
"git stash apply stash@{2}".

Or is this not workable for some reason I'm not thinking of?
