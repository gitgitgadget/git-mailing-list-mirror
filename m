From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-update-cache: allow dot-files
Date: Tue, 24 May 2005 17:12:34 -0700
Message-ID: <7vhdgstb7x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 02:11:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DajUC-00027N-SI
	for gcvg-git@gmane.org; Wed, 25 May 2005 02:11:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbVEYAMj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 20:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbVEYAMj
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 20:12:39 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:41679 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S262177AbVEYAMg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 20:12:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050525001235.UTCX1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 24 May 2005 20:12:35 -0400
To: torvalds@osdl.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus, I think this is wrong.  GIT_DIR could be something other
than ".git".  I'd rather allow everything other than . and .. in
the core layer, and have Porcelain layer ignore-paths logic to
deal with "^.git/" (only when GIT_DIR is .git; otherwise
ignore-path configuration file for that particular tree needs to
say what to ignore).

    git-update-cache: allow dot-files

    diff --git a/update-cache.c b/update-cache.c
    --- a/update-cache.c
    +++ b/update-cache.c
    @@ -238,13 +238,42 @@ static int refresh_cache(void)

     /*
      * We fundamentally don't like some paths: we don't want
    - * dot or dot-dot anywhere, and in fact, we don't even want
    - * any other dot-files (.git or anything else). They
    - * are hidden, for chist sake.
    + * dot or dot-dot anywhere, and for obvious reasons don't
    + * want to recurse into ".git" either.
      *
      * Also, we don't want double slashes or slashes at the
      * end that can make pathnames ambiguous.
      */
    +static int verify_dotfile(const char *rest)
    +{
    +	/*

