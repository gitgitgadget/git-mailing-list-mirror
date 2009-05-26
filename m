From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v3] diff: generate prettier filenames when using GIT_EXTERNAL_DIFF
Date: Tue, 26 May 2009 10:37:29 -0700
Message-ID: <20090526173726.GA5528@gmail.com>
References: <1243316165-99065-1-git-send-email-davvid@gmail.com> <4A1B85B8.1050907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	markus.heidelberg@web.de, nick@incise.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 26 19:47:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M90k0-0003Nr-Oc
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 19:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755000AbZEZRrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2009 13:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754356AbZEZRq7
	(ORCPT <rfc822;git-outgoing>); Tue, 26 May 2009 13:46:59 -0400
Received: from mailgate1.disneyanimation.com ([12.188.26.101]:18467 "EHLO
	mailgate1.disneyanimation.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754091AbZEZRq6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 May 2009 13:46:58 -0400
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 May 2009 13:46:58 EDT
X-IronPort-AV: E=Sophos;i="4.41,253,1241420400"; 
   d="scan'208";a="1242820"
Received: from unknown (HELO mailgate1.disneyanimation.com) ([172.30.246.101])
  by mailgate1.disneyanimation.com with ESMTP; 26 May 2009 10:37:31 -0700
X-IronPort-AV: E=Sophos;i="4.41,253,1241420400"; 
   d="scan'208";a="1242818"
Received: from unknown (HELO mailhub.fa.disney.com) ([172.30.246.239])
  by mailgate1.disneyanimation.com with SMTP; 26 May 2009 10:37:30 -0700
Received: from warlord.local (unknown [172.30.157.163])
	by mailhub.fa.disney.com (Postfix) with ESMTP id 61BDC1253C2;
	Tue, 26 May 2009 10:37:29 -0700 (PDT)
Received: by warlord.local (Postfix, from userid 2573)
	id 4FC9A25AE4C; Tue, 26 May 2009 10:37:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A1B85B8.1050907@gmail.com>
User-Agent: Mutt/1.4.2.3i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120007>

On Mon, May 25, 2009 at 11:01:28PM -0700, Stephen Boyd wrote:
> David Aguilar wrote:
> > -	fd = git_mkstemp(temp->tmp_path, PATH_MAX, ".diff_XXXXXX");
> > +	if (pretty_filename) {
> > +		struct strbuf pretty_name = STRBUF_INIT;
> > +		char *pathdup = xstrdup(path);
> > +		char *base = basename(pathdup);
> > +		char *dot = strchr(base, '.');
> > +		int suffix_len = 0;
> > +
> > +		if (dot) {
> > +			/* path has an extension, e.g. "foo.txt";
> > +			 * generate "foo.XXXX.txt".
> > +			 */
> > +			*dot = '\0';
> > +			strbuf_addstr(&pretty_name, base);
> > +			*dot = '.';
> > +			strbuf_addstr(&pretty_name, ".XXXXXX");
> > +			suffix_len = strlen(dot);
> > +			strbuf_addstr(&pretty_name, dot);
> 
> This *dot business annoys me. Would it be better to use strbuf_add()
> with some pointer math thrown in? Also, what happens with files such as
> "foo.bar.txt"? Do we want "foo.XXXXX.bar.txt"?


That was intentional; "foo.tar.gz" becomes "foo.XXXXXX.tar.gz",
which is what I considered better behavior when writing it.

Thanks for the note about using strbuf_add().  I'll see if we
can simplify things by using it instead of strbuf_addstr().

I should probably split the "add compat/mkstemps" and
"use it in git_mkstemps()" parts into separate commits since
we're going to want to use the native mkstemps implementation if
it's available.

-- 
		David
