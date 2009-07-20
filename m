From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] help.c: don't blame an user's typo when the system is at fault
Date: Mon, 20 Jul 2009 16:17:47 +0200
Message-ID: <200907201617.48168.trast@student.ethz.ch>
References: <alpine.DEB.2.00.0907201309150.5423@ds9.cixit.se> <200907201545.06030.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 16:18:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MStgv-0008As-QB
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 16:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbZGTORz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 10:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbZGTORy
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 10:17:54 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:18363 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779AbZGTORy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 10:17:54 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 20 Jul 2009 16:17:53 +0200
Received: from thomas.localnet ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 20 Jul 2009 16:17:52 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.23-0.1-default; KDE/4.2.96; x86_64; ; )
In-Reply-To: <200907201545.06030.barra_cuda@katamail.com>
X-OriginalArrivalTime: 20 Jul 2009 14:17:52.0848 (UTC) FILETIME=[DE7A8D00:01CA0944]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123603>

Michele Ballabio wrote:
> Is the call to strerror() useless anyway?
[...]
> +	if (!strcmp(cmd, main_cmds.names[0]->name))
> +		die("Failed to run command '%s': %s\n",
> +			cmd, strerror(errno));

The invocation of help_unknown_cmd comes from

	while (1) {
		// ...
		was_alias = run_argv(&argc, &argv);
		if (errno != ENOENT)
			break;
		// ... side branch with an exit() ...
		if (!done_help) {
			cmd = argv[0] = help_unknown_cmd(cmd);

so errno is always ENOENT when help_unknown_cmd() is called.
(Furthermore, the function itself uses git_config() and
load_command_list(), both of which _probably_ clobber errno, I don't
really have the time for an in-depth check.)

It also seems that the 'errno != ENOENT' check was intended to catch
the case where the command failed for any reason other than that it
does not exist, but this collides with the kernel reporting ENOENT if
the _interpreter_ does not exist.  Perhaps run_argv should
differentiate the case where a command executable exists but cannot be
run?


[I started writing a reply because I wanted to ask for a conversion to
die_errno() in the spirit of d824cbb (Convert existing die(...,
strerror(errno)) to die_errno(), 2009-06-27).  Please keep that in
mind if you put in another die() that mentions errno.]

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
