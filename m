From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] branch: optionally setup branch.*.merge from upstream
 local branches
Date: Tue, 19 Feb 2008 14:01:17 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802191400560.30505@racer.site>
References: <1203386832-43969-1-git-send-email-jaysoffian@gmail.com>  <76718490802181819o4cf742edi92bbcd9039f0cdac@mail.gmail.com>  <alpine.LSU.1.00.0802191054070.30505@racer.site> <76718490802190559m3f5def8ej667d4d4a1ae8e6c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 15:02:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRT32-0008Cy-DK
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 15:02:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755806AbYBSOBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 09:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755767AbYBSOBe
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 09:01:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:42781 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755606AbYBSOBd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 09:01:33 -0500
Received: (qmail invoked by alias); 19 Feb 2008 14:01:31 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp040) with SMTP; 19 Feb 2008 15:01:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19bVUEdlrpbFRQpYSoo9oAYB/pnLXTV5C/fGSkC66
	xvPO4+pXjT/oCm
X-X-Sender: gene099@racer.site
In-Reply-To: <76718490802190559m3f5def8ej667d4d4a1ae8e6c7@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74408>

Hi,

On Tue, 19 Feb 2008, Jay Soffian wrote:

> On Feb 19, 2008 5:55 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >
> > Ah, yes.  But I still maintain that xstrdup()ing orig_ref only to free 
> > it later is ugly.  Why not have the "tracking.src ? tracking.src : 
> > orig_ref" as I suggested?  The free() obviously can stay, since it 
> > will say "free(NULL)" in the case of tracking.matches == 0.
> 
> How about this?
> 
> static int setup_tracking(const char *new_ref, const char *orig_ref,
>                           enum branch_track track)
> {
> 	char key[1024];
> 	struct tracking tracking;
> 
> 	if (strlen(new_ref) > 1024 - 7 - 7 - 1)
> 		return error("Tracking not set up: name too long: %s",
> 				new_ref);
> 
> 	memset(&tracking, 0, sizeof(tracking));
> 	tracking.spec.dst = (char *)orig_ref;
> 	if (for_each_remote(find_tracked_branch, &tracking))
> 		return 1;
> 
> 	if (!tracking.matches && track != BRANCH_TRACK_ALWAYS)
> 		return 1;
> 
> 	if (tracking.matches > 1)
> 		return error("Not tracking: ambiguous information for ref %s",
> 				orig_ref);
> 
> 	sprintf(key, "branch.%s.remote", new_ref);
> 	git_config_set(key, tracking.remote ?  tracking.remote : ".");
> 	sprintf(key, "branch.%s.merge", new_ref);
> 	git_config_set(key, tracking.src ? tracking.src : orig_ref);
> 	free(tracking.src);
> 	printf("Branch %s set up to track %s branch %s.\n", new_ref,
> 		tracking.remote ? "remote" : "local", orig_ref);
> 
> 	return 0;
> }

I like it.

Ciao,
Dscho
