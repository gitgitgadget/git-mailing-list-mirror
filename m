From: Junio C Hamano <gitster@pobox.com>
Subject: Re: storing cover letter of a patch series?
Date: Fri, 11 Sep 2015 15:24:20 -0700
Message-ID: <xmqq37ykzjaj.fsf@gitster.mtv.corp.google.com>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
	<xmqqh9n241el.fsf@gitster.mtv.corp.google.com>
	<18979417.pyyHNUINeQ@mfick1-lnx>
	<xmqqzj0u2k5m.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Git List <git@vger.kernel.org>, repo-discuss@googlegroups.com
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Sat Sep 12 00:26:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaWk7-0002Ht-RB
	for gcvg-git-2@plane.gmane.org; Sat, 12 Sep 2015 00:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753936AbbIKWYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 18:24:23 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34320 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556AbbIKWYW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 18:24:22 -0400
Received: by padhy16 with SMTP id hy16so86033008pad.1
        for <git@vger.kernel.org>; Fri, 11 Sep 2015 15:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=sP1oZvZ4LjE03smiCv8mzdoQRzqmhXSLdyhfVHsYvAI=;
        b=sh5A4Q7/4hPhrng+N6B/qLKlCv5Sk39+w2TKdmk4Q4rlC28+WLh848bcW2hQHhPLVg
         eGpKn1Gx59JuIpU1LCltrm5yu2Ubx54njZ+RSQxlEQl3kInuHvxJeqx7ZhuCdg633ZrF
         YITmjSZDRIaVtUcZNdwCJ9DTx/Db1fbRkiycMu3jnp/f4TfLcHSQp0VmoBvVUifuUPAc
         KwyQXJFw3uBDMRVSV2jvoCMiF0aAiHHDnyESoQpzMOZb2bJw6ZZmTCet+vgLquPV7RBq
         E7PvApe1QdbbcKvlH7i9u9vnT8mnZlBmENukOVd7AZOnUXVU2+0RhlZ/glFN2q7q85Yl
         eICQ==
X-Received: by 10.68.162.99 with SMTP id xz3mr2440220pbb.134.1442010262041;
        Fri, 11 Sep 2015 15:24:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7504:ea92:c75a:a933])
        by smtp.gmail.com with ESMTPSA id jf10sm2232903pbd.64.2015.09.11.15.24.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 11 Sep 2015 15:24:21 -0700 (PDT)
In-Reply-To: <xmqqzj0u2k5m.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 10 Sep 2015 11:39:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277702>

Junio C Hamano <gitster@pobox.com> writes:

> Ideally, I would think that you want that information when the
> series is fully cooked and gets merged to a more permanent place in
> the log message of the merge commit.  At that point, where the
> series started may become more clear from the topology (i.e. the set
> difference X^..X for the resulting merge is what got merged).  One
> possible "hacky" convention could be
>
>  - Developers keep rerolling with the "empty commit with cover
>    letter material at the tip".  topic@{upstream}..topic~1 are the
>    real changes, topic~0 is an empty "cover letter material".
>
>  - When the series is fully cooked, a new "git merge" option notices
>    that the topic is structured in a "strange" way, uncaps its tip
>    commit and merges the remainder of the series and adds the cover
>    letter material when presenting the editor to record the merge
>    commit.  That is
>
> 	$ git merge --cover-at-tip topic
>
>    would work roughly by doing the following:
>
>     - verify that "git rev-parse topic^^{tree} topic^{tree}" shows that
>       they record the same tree; otherwise it will error out, saying
>       the tip is not a pure cover.
>
>     - verify that "git rev-list ..topic^" shows that there is
>       something to merge after the tip is removed; otherwise it will
>       error out, saying that there is nothing to merge.
>
>     - run "git merge --no-ff --edit topic^1" but with the log
>       message of topic^{commit} in the editor's template.

To complement the above, if we want to pursue this approach, the
following would also help.

 - (obvious) "git pull" would learn the same "--cover-at-tip" option
   and would pass it to "git merge".

 - "git am --cover-at-tip" would make the incoming cover-letter
   material into a non-tree-changing commit at the tip of the
   resulting topic.

 - "git format-patch" would notice a topic branch in such a shape
   and would use the log message of the non-tree-changing commit at
   the tip as part of the cover letter.

Then the overall workflow would become:

 * A developer works on a topic and concludes it by writing a
   summary that should appear in the final merge to the trunk as a
   log message of a non-tree-changing commit at the tip.

 * In "request-to-pull" workflow, the developer requests the topic
   to be pulled.  The integrator uses "git pull --cover-at-tip" and
   the resulting merge commit will carry the summary written by the
   original developer.

 * In e-mail workflow, the developer runs "git format-patch"; the
   cover-letter is populated with the summary the developer wrote.

 * The integrator uses "git am --cover-at-tip" on a new branch,
   which recreates the topic branch the developer created at the
   first step above.

 * The integrator merges the topic with "git merge --cover-at-tip"
   to the trunk, and the resulting merge commit will carry the
   summary written by the original developer.
