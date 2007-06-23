From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH]: tree-walk.h: Warning fix
Date: Fri, 22 Jun 2007 23:19:55 -0700
Message-ID: <7v1wg39oqc.fsf@assigned-by-dhcp.pobox.com>
References: <20070619231127.7ffe273b@gnut>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
X-From: git-owner@vger.kernel.org Sat Jun 23 08:20:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1yyi-0003vQ-Km
	for gcvg-git@gmane.org; Sat, 23 Jun 2007 08:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbXFWGT6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 02:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbXFWGT6
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 02:19:58 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:51526 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbXFWGT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 02:19:57 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070623061956.XRCQ17635.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sat, 23 Jun 2007 02:19:56 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id EuKw1X0051kojtg0000000; Sat, 23 Jun 2007 02:19:56 -0400
In-Reply-To: <20070619231127.7ffe273b@gnut> (Luiz Fernando N. Capitulino's
	message of "Tue, 19 Jun 2007 23:11:27 -0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50720>

"Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
writes:

> diff --git a/tree-walk.h b/tree-walk.h
> index ee747ab..625198f 100644
> --- a/tree-walk.h
> +++ b/tree-walk.h
> @@ -22,7 +22,7 @@ static inline const unsigned char *tree_entry_extract(struct tree_desc *desc, co
>  
>  static inline int tree_entry_len(const char *name, const unsigned char *sha1)
>  {
> -	return (char *)sha1 - (char *)name - 1;
> +	return (const char *)sha1 - (const char *)name - 1;
>  }
>  
>  void update_tree_entry(struct tree_desc *);

Grumble.  Incoming "name" is already (const char*), isn't it?
I'd cast only the sha1 side and apply.

However, I think -Wcast-qual is a pretty useless option.  

The nastiest one, if you care, is exec_cmd.c::execv_git_cmd()
where we never muck with "const char **argv" ourselves, but we
have to call execve(), which takes (char**) as its second
parameter.  We cast away constness for that call; otherwise you
would then get prototype mismatch.
