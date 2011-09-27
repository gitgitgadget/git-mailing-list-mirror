From: Pang Yan Han <pangyanhan@gmail.com>
Subject: Re: [PATCH/RFC 0/2] Teach receive-pack not to run update hook for
 corrupt/non existent ref
Date: Wed, 28 Sep 2011 06:55:46 +0800
Message-ID: <20110927225546.GA1648@myhost>
References: <1316927182-14212-1-git-send-email-pangyanhan@gmail.com>
 <CAMK1S_hadzaqixaW3Fx81pf=hVsvAMpVvVGqVtZ8ncfUsie_9w@mail.gmail.com>
 <20110925094822.GA1702@myhost>
 <CAMK1S_h3ufrK29_ajpcSSW7HV6ZA8z8ZVHvhHr2bx5Cga5FAKQ@mail.gmail.com>
 <7vwrcuzy44.fsf@alter.siamese.dyndns.org>
 <CAMK1S_gR6U=OxzGsjTD8LbvZFS125=p1fQ8Af7aRD2XSsRur_Q@mail.gmail.com>
 <7voby6zwxg.fsf@alter.siamese.dyndns.org>
 <7vd3emzw8n.fsf@alter.siamese.dyndns.org>
 <20110927090225.GA1493@myhost>
 <7vhb3xyld7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 28 00:58:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8gbn-0005cG-DB
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 00:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239Ab1I0W6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 18:58:34 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:44945 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104Ab1I0W6d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 18:58:33 -0400
Received: by yib18 with SMTP id 18so5772716yib.19
        for <git@vger.kernel.org>; Tue, 27 Sep 2011 15:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=SDIyDfTwahgOsbls9aVaWNni3lwMnWT7RCyLNU9GsLQ=;
        b=qimRJGBwmvEsnhhZvAYXD71uKLuRQtUr86I4a2Kuz9gYziA/t2CZ+OTxUfGac6itff
         8UPFXcJLbX1nGZ2Z29xnwSo/gd2YyLbJc4GMZ7HHhB1P2rpIbNtnM0y1uwUHr0oD4h1f
         Jhb4qki8c2hiidEWpodCqwjbY1CpiUwuHizGw=
Received: by 10.150.48.40 with SMTP id v40mr7657478ybv.380.1317164313095;
        Tue, 27 Sep 2011 15:58:33 -0700 (PDT)
Received: from localhost (bb220-255-243-30.singnet.com.sg. [220.255.243.30])
        by mx.google.com with ESMTPS id h1sm920091ybi.2.2011.09.27.15.58.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Sep 2011 15:58:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vhb3xyld7.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182273>

On Tue, Sep 27, 2011 at 09:56:52AM -0700, Junio C Hamano wrote:
> [offtopic: where does that annoying M-F-T header come from? It even seems
> to be pointless in this case as it lists the same people as are already on
> To/Cc/From of the message.]

Sorry, it's due to my lack of familiarity with mutt.

> 
> Pang Yan Han <pangyanhan@gmail.com> writes:
> 
> > Should I reroll this patch with this behaviour:
> >
> > - Everything as usual for valid ref updates and deletes
> > - For deleting corrupt (dangling?) ref, post-receive and post-update hooks
> >   also receive the same args as per valid update / delete
> 
> Suonds sensible.
> 
> > - For deleting non-existent refs:
> >   - post-receive shall have empty stdin for those refs
> >   - post-update shall have an empty arg for those refs
> 
> I do not think these hooks should see names of refs that ended up being a
> no-op. If the push is only about attempting to delete a ref that did not
> exist, these hooks should not even get called. If there were other refs
> that got updated, these hooks have to be called, but they should not be
> told about the no-op.  IOW
> 
>     $ git push $there :no-such-ref master:refs/remotes/origin/master
> 
> should:
> 
>  (1) not call the post-* hooks if the refs/remotes/origin/master was
>      already pointing at the same commit; or
> 
>  (2) invoke the post-* hooks if refs/remotes/origin/master is updated, but
>      should tell hooks only about the update of refs/remotes/origin/master.
> 
> That is pretty much in line with how a normal attempt to push the same
> commit to an already up-to-date ref works.  For example, if you:
> 
>     $ git push $there master next
> 
> when 'master' is lagging and 'next' is already up-to-date, post-update and
> post-receive hooks run and told only about 'master' and not 'next'.

Thanks, I will reroll this later.
