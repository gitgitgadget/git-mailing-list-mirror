From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [MAKESHIFT PATCH] Cope better with a _lot_ of packs
Date: Fri, 15 May 2009 12:17:35 -0700
Message-ID: <20090515191735.GG30527@spearce.org>
References: <alpine.DEB.1.00.0905152000520.4449@intel-tinevez-2-302> <7vmy9etey8.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0905152040590.26154@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 15 21:17:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M52ud-0008IY-3c
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 21:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122AbZEOTRf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 15:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752736AbZEOTRe
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 15:17:34 -0400
Received: from george.spearce.org ([209.20.77.23]:48014 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032AbZEOTRe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 15:17:34 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 49B1A381D5; Fri, 15 May 2009 19:17:35 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0905152040590.26154@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119284>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> You might end up with a situation where you have tons of pack files, e.g.
> when using hg2git.  In this situation, all kinds of operations may 
> end up with a "too many files open" error.  Let's recover gracefully from 
> that.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Yea, this looks right to me.  JGit had a similar problem and now
maintains a core.packedGitOpenFiles parameter, set to 128 by default,
as one of the rules it uses to limit the size of its pack cache area.

> diff --git a/sha1_file.c b/sha1_file.c
> index 28bd908..bd5edd8 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -720,6 +720,8 @@ static int open_packed_git_1(struct packed_git *p)
>  		return error("packfile %s index unavailable", p->pack_name);
>  
>  	p->pack_fd = open(p->pack_name, O_RDONLY);
> +	while (p->pack_fd < 0 && errno == EMFILE && unuse_one_window(p, -1))
> +		p->pack_fd = open(p->pack_name, O_RDONLY);
>  	if (p->pack_fd < 0 || fstat(p->pack_fd, &st))
>  		return -1;
>  
> @@ -937,6 +939,8 @@ static void prepare_packed_git_one(char *objdir, int local)
>  	sprintf(path, "%s/pack", objdir);
>  	len = strlen(path);
>  	dir = opendir(path);
> +	while (!dir && errno == EMFILE && unuse_one_window(packed_git, -1))
> +		dir = opendir(path);
>  	if (!dir) {
>  		if (errno != ENOENT)
>  			error("unable to open object pack directory: %s: %s",
> @@ -2339,6 +2343,8 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
>  
>  	filename = sha1_file_name(sha1);
>  	fd = create_tmpfile(tmpfile, sizeof(tmpfile), filename);
> +	while (fd < 0 && errno == EMFILE && unuse_one_window(packed_git, -1))
> +		fd = create_tmpfile(tmpfile, sizeof(tmpfile), filename);
>  	if (fd < 0) {
>  		if (errno == EACCES)
>  			return error("insufficient permission for adding an object to repository database %s\n", get_object_directory());
> -- 

-- 
Shawn.
