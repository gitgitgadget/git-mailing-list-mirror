From: Wayne Davison <wayne@opencoder.net>
Subject: Re: [PATCH] Add compat/vsnprintf.c for systems that returns -1 on maxsize reached
Date: Wed, 5 Mar 2008 07:54:12 -0800
Message-ID: <20080305155412.GA19295@herod.dreamhost.com>
References: <200803041459.29000.michal.rokos@nextsoft.cz> <200803051455.57148.michal.rokos@nextsoft.cz> <47CEAE20.1030707@viscovery.net> <200803051600.06605.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, GIT <git@vger.kernel.org>
To: Michal Rokos <michal.rokos@nextsoft.cz>
X-From: git-owner@vger.kernel.org Wed Mar 05 16:56:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWvxX-0007HR-Qf
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 16:55:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755160AbYCEPy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 10:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755011AbYCEPy0
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 10:54:26 -0500
Received: from smarty.dreamhost.com ([208.113.175.8]:43155 "EHLO
	smarty.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754894AbYCEPyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 10:54:25 -0500
X-Greylist: delayed 57768 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Mar 2008 10:54:25 EST
Received: from herod.dreamhost.com (herod.dreamhost.com [208.113.239.72])
	by smarty.dreamhost.com (Postfix) with ESMTP id C4F05EE2B4;
	Wed,  5 Mar 2008 07:54:21 -0800 (PST)
Received: by herod.dreamhost.com (Postfix, from userid 130321)
	id DD1BD60311; Wed,  5 Mar 2008 07:54:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200803051600.06605.michal.rokos@nextsoft.cz>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76234>

On Wed, Mar 05, 2008 at 04:00:06PM +0100, Michal Rokos wrote:
> +		[[char buf[1];
> +		  if (test_vsnprintf(buf, 1, "%s", "12345") != 5) return 1;
> +		  if (snprintf(buf, 1, "%s", "12345") != 5) return 1]])],

I'd suggest using a longer buf, requesting a longer length (e.g. 3
instead of 1), and then making sure that the resulting buf is right
(e.g. "12" instead of "123").

		[[char buf[6];
		  if (test_vsnprintf(buf, 3, "%s", "12345") != 5
		   || strcmp(buf, "12") != 0) return 1;
		  if (snprintf(buf, 3, "%s", "12345") != 5
		   || strcmp(buf, "12") != 0) return 1]])],

Then, set a define that snprintf is bogus and use a version of
snprintf() based on this instead:

http://rsync.samba.org/ftp/unpacked/rsync/lib/snprintf.c

That defines rsync_snprintf() and rsync_vsnprintf() functions (which
could be renamed for git).  Then, in a global .h file, add something
like this:

#if !defined HAVE_VSNPRINTF || !defined HAVE_C99_VSNPRINTF
#define vsnprintf rsync_vsnprintf
int vsnprintf(char *str, size_t count, const char *fmt, va_list args);
#endif

#if !defined HAVE_SNPRINTF || !defined HAVE_C99_VSNPRINTF
#define snprintf rsync_snprintf
int snprintf(char *str, size_t count, const char *fmt,...);
#endif

Just be sure to put those that after the various system includes so that
they are not adversely affected.

..wayne..
