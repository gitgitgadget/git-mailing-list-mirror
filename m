From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] add GIT_FAST_STAT mode for Cygwin
Date: Tue, 23 Sep 2008 13:17:39 -0700
Message-ID: <20080923201739.GK3669@spearce.org>
References: <20080923140144.GN21650@dpotapov.dyndns.org> <20080923153148.GI3669@spearce.org> <20080923171209.GP21650@dpotapov.dyndns.org> <20080923190637.GJ3669@spearce.org> <20080923200456.GR21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>,
	Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 22:18:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiELQ-0006uO-UF
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 22:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753042AbYIWURl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 16:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753964AbYIWURl
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 16:17:41 -0400
Received: from george.spearce.org ([209.20.77.23]:42197 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbYIWURk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 16:17:40 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 15A843835F; Tue, 23 Sep 2008 20:17:39 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080923200456.GR21650@dpotapov.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96589>

Dmitry Potapov <dpotapov@gmail.com> wrote:
> Do I understand you correctly that you propose to add the code like
> this in compat/cygwin.c:

Yes.  But with minor changes (see below):
 
> static int native_stat;

static int native_stat = -1;

> static int git_cygwin_config(const char *var, const char *value, void
> *cb)
> {
> 	if (!strcmp(var, "core.cygwinnativestat"))
> 		cygwin_native_stat = git_config_bool(var, value);
> 	return 0;
> }
> 
> static void init_stat(void)
> {
> 	git_config(git_cygwin_config, NULL);
> 	cygwin_stat_fn = native_stat ? cygwin_stat : stat;
> 	cygwin_lstat_fn = native_stat ? cygwin_lstat : lstat;

if (native_stat < 0 && have_git_dir()) {
	native_stat = 0;
	git_config(git_cygwin_config, NULL);
	cygwin_stat_fn = native_stat ? cygwin_stat : stat;
	cygwin_lstat_fn = native_stat ? cygwin_lstat : lstat;
}

and then you have to define have_git_dir() inside environment.c as:

int have_git_dir(void)
{
	return !!git_dir;
}
 
> static int cygwin_stat_choice(const char *file_name, struct stat *buf)
> {
> 	init_stat();
> 	return (*cygwin_stat_fn)(file_name, buf);
> }
> 
> static int cygwin_lstat_choice(const char *file_name, struct stat *buf)
> {
> 	init_stat();
> 	return (*cygwin_lstat_fn)(file_name, buf);
> }

-- 
Shawn.
