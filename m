From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Updated status to show 'Not currently on any branch'
	in red
Date: Thu, 15 May 2008 22:05:42 -0400
Message-ID: <20080516020541.GA14727@sigill.intra.peff.net>
References: <612A0CE5-9482-4D27-B2E4-D55F7511A1C2@edendevelopment.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Chris Parsons <chris@edendevelopment.co.uk>
X-From: git-owner@vger.kernel.org Fri May 16 04:06:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwpLA-00023f-Vg
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 04:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbYEPCFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 22:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbYEPCFq
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 22:05:46 -0400
Received: from peff.net ([208.65.91.99]:4360 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751285AbYEPCFp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 22:05:45 -0400
Received: (qmail 16386 invoked by uid 111); 16 May 2008 02:05:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 15 May 2008 22:05:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 May 2008 22:05:42 -0400
Content-Disposition: inline
In-Reply-To: <612A0CE5-9482-4D27-B2E4-D55F7511A1C2@edendevelopment.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82250>

On Thu, May 15, 2008 at 08:37:52PM +0100, Chris Parsons wrote:

> Hi all, first post and patch, please be gentle :)

Hi, and welcome.

But as Miklos pointed out, please separate "cover letter" material from
the commit message by putting it under the "---" cut.

> I'm a fairly new user to git and have more than once been burnt by  
> checking out an arbitrary commit and then checking in code on top of that 
> commit. If you realise your mistake quickly, you can reset and reapply the 
> commit to a branch, but if you checkout another branch your commit can 
> disappear and become hard to find.
>
> Therefore as a help to new users I've turned the 'Not currently on any  
> branch' red on 'git status' so that it's harder to miss the fact.

I think this is definitely a good change overall, but I have some
specific comments on the implementation below.

> Perhaps git should not allow commits in this case? I'm too much of a  
> novice to know whether that's ever needed, but perhaps someone has a good 
> reason for allowing it.

There was much discussion of this when the detached HEAD feature was
introduced, but it was decided that allowing commits was useful. I think
putting the text in red is a nice way to highlight a potential mistake,
though.

>  static const char use_add_msg[] =
> @@ -315,7 +316,8 @@ void wt_status_print(struct wt_status *s)
>  {
>  	unsigned char sha1[20];
>  	s->is_initial = get_sha1(s->reference, sha1) ? 1 : 0;
> -
> +  const char* branch_color = color(WT_STATUS_HEADER);
> +

Indentation?

> -		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER),
> +		color_fprintf_ln(s->fp, branch_color,
>  			"# %s%s", on_what, branch_name);

This makes the whole line red; I think it would look nicer matching the
red / green files last on in the file list by coloring just the message
part. IOW,

  color_fprintf(s->fp, color(WT_STATUS_HEADER), "# ");
  color_fprintf_ln(s->fp, branch_color, %s%s", on_what, branch_name);


And two final points on missing items:

  1. This should probably be configurable. You'd need to update
     parse_status_slot, as well as the documentation in config.txt.

  2. Note that this just covers the colorization of status sent to the
     terminal or pager. What is seen in the editor while writing the
     commit message (which is a likely place to want to warn the user)
     is colorized by the editor itself. In that case, you might want to
     either make a patch or a suggestion to the author of your favorite
     editor's colorization package.

-Peff
