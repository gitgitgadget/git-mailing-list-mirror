From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH/RFC v2 15/16] update-index.c: add a force-rewrite option
Date: Wed, 8 Aug 2012 09:31:40 +0200
Message-ID: <20120808073140.GC867@tgummerer.surfnet.iacbox>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
 <1344203353-2819-16-git-send-email-t.gummerer@gmail.com>
 <7vfw80233w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pclouds@gmail.com, robin.rosenberg@dewire.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 09:32:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sz0kJ-0003AD-Lc
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 09:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757850Ab2HHHbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 03:31:45 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:58020 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757515Ab2HHHbo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 03:31:44 -0400
Received: by wgbdr13 with SMTP id dr13so444846wgb.1
        for <git@vger.kernel.org>; Wed, 08 Aug 2012 00:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=fb4X8BGAcsCxzkLlR7E9zHzdo5wWNHRY/x02GLMJRNo=;
        b=JBuEeXOQgJYQ/gKoLBnb/ZPUpmj5/fFkOv1s+mliEhWHVmsnYyA4H8k7DhLOMgJdsO
         7E1ZwO69MgpMfg2WROTHrrw1T1wZb/vMiTHrhe1UVHEUv51bQ+L/uFmEPZEOxec0+fTt
         OIkUKIW9z7ZjyBtp/pdOzp/VDNSjEkc+URzQ9v3kQuG17d3o/fny60LFpemAsRFPvUnn
         AblYlZzBoanUewOJunwe5CYGLLqlKTG4tzePeZLorcFi9/U2WNFcm+xG9F7tB4X+KFB7
         Npdm4aPTQ+7h1ypswZnxCkkzR1ce/YnD7ppNyPXhzYT73epfZmvb+y8eBidyOuV5uMRj
         OcGA==
Received: by 10.180.100.131 with SMTP id ey3mr223093wib.15.1344411103101;
        Wed, 08 Aug 2012 00:31:43 -0700 (PDT)
Received: from localhost ([46.18.27.126])
        by mx.google.com with ESMTPS id t8sm3750286wiy.3.2012.08.08.00.31.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Aug 2012 00:31:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vfw80233w.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203066>

On 08/05, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > Add a force-rewrite option to update-index, which allows the user
> > to rewrite the index, even if there are no changes. This can be used
> > to do performance tests of both the reader and the writer.
> >
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> >  builtin/update-index.c |    5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> I do not think this is wrong per-se, but is a new command that needs
> to be documented?  If it is only for benchmarking and debugging, it
> might be sufficient to make "--index-version <n>" always rewrite the
> index.

The command is only for benchmarking, I don't see another case where
it makes sense for anyone to rewrite the whole index, without changing
anything. I've made --index-version rewrite the index for the re-roll.

> > diff --git a/builtin/update-index.c b/builtin/update-index.c
> > index 4ce341c..7fedc8f 100644
> > --- a/builtin/update-index.c
> > +++ b/builtin/update-index.c
> > @@ -24,6 +24,7 @@ static int allow_remove;
> >  static int allow_replace;
> >  static int info_only;
> >  static int force_remove;
> > +static int force_rewrite;
> >  static int verbose;
> >  static int mark_valid_only;
> >  static int mark_skip_worktree_only;
> > @@ -728,6 +729,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
> >  		OPT_BIT(0, "unmerged", &refresh_args.flags,
> >  			"refresh even if index contains unmerged entries",
> >  			REFRESH_UNMERGED),
> > +		OPT_SET_INT(0, "force-rewrite", &force_rewrite,
> > +			"force a index rewrite even if there is no change", 1),
> >  		{OPTION_CALLBACK, 0, "refresh", &refresh_args, NULL,
> >  			"refresh stat information",
> >  			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
> > @@ -886,7 +889,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
> >  		strbuf_release(&buf);
> >  	}
> >  
> > -	if (active_cache_changed) {
> > +	if (active_cache_changed || force_rewrite) {
> >  		if (newfd < 0) {
> >  			if (refresh_args.flags & REFRESH_QUIET)
> >  				exit(128);
