From: Pang Yan Han <pangyanhan@gmail.com>
Subject: Re: [PATCH/RFCv3 2/2] receive-pack: don't pass non-existent refs to
 post-{receive,update} hooks in push deletions
Date: Thu, 29 Sep 2011 07:08:09 +0800
Message-ID: <20110928230809.GA1798@myhost>
References: <20110928153935.GA7800@myhost>
 <7vsjngxphv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sitaram Chamarty <sitaramc@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 29 01:11:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R93HR-0005Xj-Bw
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 01:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932770Ab1I1XLB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 19:11:01 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:55310 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511Ab1I1XLA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 19:11:00 -0400
Received: by ywb5 with SMTP id 5so19704ywb.19
        for <git@vger.kernel.org>; Wed, 28 Sep 2011 16:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=AE54owUg0TTHNpw7FI3Uaa9xvmswyLq02xpdrV1pmrQ=;
        b=m5NOjWCDs4mcGe434MZMKMJlpMoQYEHWC4ZMrYxykrvedjNjiiecjPlusMj+WMBtk7
         hX5hl0JLP28H9sk+LMOXuXQVkgxRo9CS1XOM1cU2S59lxwpKJufZqEx5ebrQkKOYEr4R
         RZpPFdHdYXcyQVPokDub9MYHgnxS11PN4q3/s=
Received: by 10.236.180.167 with SMTP id j27mr17646130yhm.109.1317251459252;
        Wed, 28 Sep 2011 16:10:59 -0700 (PDT)
Received: from localhost (bb116-14-107-203.singnet.com.sg. [116.14.107.203])
        by mx.google.com with ESMTPS id n3sm989743anl.6.2011.09.28.16.10.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Sep 2011 16:10:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vsjngxphv.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182370>

On Wed, Sep 28, 2011 at 03:37:32PM -0700, Junio C Hamano wrote:
> Pang Yan Han <pangyanhan@gmail.com> writes:
> 
> > +/* For invalid refs */
> > +static struct command **invalid_delete;
> > +static size_t invalid_delete_nr;
> > +static size_t invalid_delete_alloc;
> 
> Do you have to have these separately only to keep track of the corner case
> errors?  I would have expected that it would be more natural to mark them
> by adding a single bitfield to "struct command".

Yes they are purely for keeping track of deleting non-existent refs.
Ok I will add the bitfield to struct command.

> 
> > @@ -447,6 +467,8 @@ static const char *update(struct command *cmd)
> >  		if (!parse_object(old_sha1)) {
> >  			rp_warning("Allowing deletion of corrupt ref.");
> >  			old_sha1 = NULL;
> > +			if (!ref_exists((char *) name))
> > +				invalid_delete_append(cmd);
> 
> This is not an "invalid" delete but deleting a non-existing ref.  Perhaps
> you would want to move the warning and optionally reword it as well, e.g.
> 
> 	if (!parse_object(old_sha1)) {
>         	old_sha1 = NULL;
>                 if (ref_exists(name)) {
> 			rp_warning("Allowing deletion of corrupt ref.");
> 		} else {
> 			rp_warning("Deleting a ref that does not exist.");
> 			cmd->did_not_exist = 1;
> 		}
> 		...

Sure thing.

I am unable to reply this until much later, but are the tests in this patch ok?
It's the first time I'm writing test cases for git.

Thanks for the feedback!
