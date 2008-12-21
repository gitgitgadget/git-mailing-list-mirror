From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] fast-import: add special '-' blob reference to use
	the previous one.
Date: Sun, 21 Dec 2008 14:11:49 -0800
Message-ID: <20081221221149.GB17355@spearce.org>
References: <1229825502-963-1-git-send-email-felipe.contreras@gmail.com> <1229825502-963-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 21 23:13:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEWXs-0005MJ-VC
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 23:13:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbYLUWLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 17:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbYLUWLu
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 17:11:50 -0500
Received: from george.spearce.org ([209.20.77.23]:49866 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbYLUWLu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 17:11:50 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9973538200; Sun, 21 Dec 2008 22:11:49 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1229825502-963-2-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103718>

Felipe Contreras <felipe.contreras@gmail.com> wrote:
> @@ -1862,7 +1864,7 @@ static void file_change_m(struct branch *b)
>  	const char *endp;
>  	struct object_entry *oe = oe;
>  	unsigned char sha1[20];
> -	uint16_t mode, inline_data = 0;
> +	uint16_t mode, inline_data = 0, empty_blob = 0;

Its not the empty blob, its the inherited/assumed blob...
  
> @@ -1893,6 +1895,10 @@ static void file_change_m(struct branch *b)
>  	} else if (!prefixcmp(p, "inline")) {
>  		inline_data = 1;
>  		p += 6;
> +	} else if (!prefixcmp(p, "- ")) {
> +		hashclr(sha1);
> +		empty_blob = 1;
> +		p += 1;

Hmph, so if create a new path with a blob of "-" the repository
will be corrupt because the zero id was used and error was produced.

Actually I think you have the same bug in the prior patch with the
mode being inherited.  I wonder if we shouldn't put error checking
in too to validate that versions[0] describes a file entry.

-- 
Shawn.
