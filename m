From: Pang Yan Han <pangyanhan@gmail.com>
Subject: Re: [PATCH/RFC 0/2] Teach receive-pack not to run update hook for
 corrupt/non existent ref
Date: Tue, 27 Sep 2011 17:02:25 +0800
Message-ID: <20110927090225.GA1493@myhost>
References: <1316927182-14212-1-git-send-email-pangyanhan@gmail.com>
 <CAMK1S_hadzaqixaW3Fx81pf=hVsvAMpVvVGqVtZ8ncfUsie_9w@mail.gmail.com>
 <20110925094822.GA1702@myhost>
 <CAMK1S_h3ufrK29_ajpcSSW7HV6ZA8z8ZVHvhHr2bx5Cga5FAKQ@mail.gmail.com>
 <7vwrcuzy44.fsf@alter.siamese.dyndns.org>
 <CAMK1S_gR6U=OxzGsjTD8LbvZFS125=p1fQ8Af7aRD2XSsRur_Q@mail.gmail.com>
 <7voby6zwxg.fsf@alter.siamese.dyndns.org>
 <7vd3emzw8n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sitaram Chamarty <sitaramc@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pang Yan Han <pangyanhan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 11:05:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8TbM-0000p2-WF
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 11:05:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113Ab1I0JFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 05:05:14 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:55626 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082Ab1I0JFN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 05:05:13 -0400
Received: by ywb5 with SMTP id 5so5093457ywb.19
        for <git@vger.kernel.org>; Tue, 27 Sep 2011 02:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=z0eWLw75b6mlq6QtB45Q/7ACMRuUgE76lBs3VhjWU8I=;
        b=FacVOI+sM4pPGpPmTXaHjuskOmubtoEw3w+wqiWqEWcjB7H2Pq6FTWjrAh+zQxQEKS
         tZYToyYcxmUTG+xy7ROXlPECvIvCS5KJGI1dG03Y0xdc+2CsUqmuh4BItGHjvyhcYv+s
         zIlz3J/64LXfeSrXy5LdEETGcxA3joq5uwWVU=
Received: by 10.236.180.105 with SMTP id i69mr45671088yhm.64.1317114312515;
        Tue, 27 Sep 2011 02:05:12 -0700 (PDT)
Received: from localhost (bb121-6-158-86.singnet.com.sg. [121.6.158.86])
        by mx.google.com with ESMTPS id d5sm29543108yhl.19.2011.09.27.02.05.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Sep 2011 02:05:11 -0700 (PDT)
Mail-Followup-To: Pang Yan Han <pangyanhan@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sitaram Chamarty <sitaramc@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <7vd3emzw8n.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182225>

Hi Junio,

Should I reroll this patch with this behaviour:

- Everything as usual for valid ref updates and deletes
- For deleting corrupt (dangling?) ref, post-receive and post-update hooks
  also receive the same args as per valid update / delete
- For deleting non-existent refs:
  - post-receive shall have empty stdin for those refs
  - post-update shall have an empty arg for those refs

Thanks.

On Mon, Sep 26, 2011 at 05:04:24PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Sitaram Chamarty <sitaramc@gmail.com> writes:
> >
> >>> In that case (if "non-existent-ref" was indeed non-existent, and not just
> >>> pointing at a dangling commit), I would say the post anything hook should
> >>> not be called for that ref. These hooks of course need to run if there
> >>> are _other_ refs that were updated, though, to handle these _other_ refs,
> >>> but I do not think they should be told about the no-op.
> >>
> >> Question is what happens if none of them existed.  It's a difference
> >> between not calling the hook at all, versus calling it with no
> >> arguments/empty stdin (as the case may be) -- which would you do?
> >
> > In case it was unclear, I was trying to say the hooks should not run with
> > empty input.
> 
> If the purpose of "post-update" (or "post-receive") hooks were to trigger
> every time anybody attempted to push into the repository, then it would
> make perfect sense for them to trigger when "push origin :no-such-branch"
> were attempted. But if that were the purpose of these hooks, they should
> also trigger when "push origin master" is run and "master" is already at
> the right commit, as that is the same kind of no-op -- the pushed into
> repository was already up-to-date with respect to the wish of the pusher.
> 
> I do not mind, and I do prefer, these hooks to run when somebody deleted
> an existing ref that points at a corrupt or non-existent object, as that
> is _not_ a no-op but is a meaningful event that has an effect that is
> observable from the outside world (e.g. ls-remote).
