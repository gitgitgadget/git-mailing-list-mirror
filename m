From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] Fix relative built-in paths to be relative to the command invocation
Date: Mon, 14 Jul 2008 08:55:57 +0200
Message-ID: <1216018557.487af87d7bd28@webmail.eunet.at>
References: <7v1w1yupn4.fsf@gitster.siamese.dyndns.org> <1215981083-10815-1-git-send-email-johannes.sixt@telecom.at> <1215981083-10815-2-git-send-email-johannes.sixt@telecom.at> <1215981083-10815-3-git-send-email-johannes.sixt@telecom.at> <1215981083-10815-4-git-send-email-johannes.sixt@telecom.at> <alpine.DEB.1.00.0807132141130.8950@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 14 08:57:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIHzb-0006wi-Ov
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 08:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892AbYGNG4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 02:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753045AbYGNG4D
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 02:56:03 -0400
Received: from smtp1.srv.eunet.at ([193.154.160.119]:41278 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575AbYGNG4B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 02:56:01 -0400
Received: from webmail01.si.eunet.at (webmail01.srv.eunet.at [193.154.180.195])
	by smtp1.srv.eunet.at (Postfix) with ESMTPS id C72A6348D1;
	Mon, 14 Jul 2008 08:55:58 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by webmail01.si.eunet.at (8.13.1/8.13.1) with ESMTP id m6E6tvbo024337;
	Mon, 14 Jul 2008 08:55:57 +0200
Received: from cm56-163-160.liwest.at (cm56-163-160.liwest.at [86.56.163.160]) 
	by webmail.eunet.at (IMP) with HTTP 
	for <johsixt@mbox.eunet.at>; Mon, 14 Jul 2008 08:55:57 +0200
In-Reply-To: <alpine.DEB.1.00.0807132141130.8950@racer>
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 86.56.163.160
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88388>

Zitat von Johannes Schindelin <Johannes.Schindelin@gmx.de>:

> Hi,
>
> On Sun, 13 Jul 2008, Johannes Sixt wrote:
>
> > diff --git a/Makefile b/Makefile
> > index 4796565..2bdb9bf 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1301,7 +1301,7 @@ remove-dashes:
> >  ### Installation rules
> >
> >  ifeq ($(firstword $(subst /, ,$(template_dir))),..)
> > -template_instdir = $(gitexecdir)/$(template_dir)
> > +template_instdir = $(shell cd '$(bindir_SQ)/$(template_dir_SQ)' && pwd)
>
> What is this for?  Did the original line stop working?

I could just have changed $(gitexecdir) to $(bindir), but in the
make-execpath-relative patch we will need the normalized gitexec_instdir
because its value is compared to $(bindir). So the extra $(shell...) in
_this_ patch is only that the final result looks consistent.

> > diff --git a/exec_cmd.c b/exec_cmd.c
> > index 8899e31..45f92eb 100644
> > --- a/exec_cmd.c
> > +++ b/exec_cmd.c
> > @@ -5,6 +5,7 @@
> >
> >  extern char **environ;
> >  static const char *argv_exec_path;
> > +static const char *argv0_path;
> >
> >  static const char *builtin_exec_path(void)
> >  {
> > @@ -42,14 +43,19 @@ static const char *builtin_exec_path(void)
> >
> >  const char *system_path(const char *path)
> >  {
> > -	if (!is_absolute_path(path)) {
> > +	if (!is_absolute_path(path) && argv0_path) {
> >  		struct strbuf d = STRBUF_INIT;
> > -		strbuf_addf(&d, "%s/%s", git_exec_path(), path);
> > +		strbuf_addf(&d, "%s/%s", argv0_path, path);
> >  		path = strbuf_detach(&d, NULL);
> >  	}
> >  	return path;
> >  }
> >
> > +void git_set_argv0_path(const char *path)
> > +{
> > +	argv0_path = path;
> > +}
> > +
> >  void git_set_argv_exec_path(const char *exec_path)
> >  {
> >  	argv_exec_path = exec_path;
> > @@ -84,7 +90,7 @@ static void add_path(struct strbuf *out, const char
> *path)
> >  	}
> >  }
> >
> > -void setup_path(const char *cmd_path)
> > +void setup_path(void)
>
> It seems to me that this patch would not do anything different, but with
> less code change, if setup_path() would set argv0_path, and not a new
> function was introduced.

This is just to play a safe game. I had it that way, but I decided to have
the call to the new git_set_argv0_path() early in git.c because the call
to setup_path() in git.c is very late, and it could happen that we call
system_path() (which needs argv0_path) before that. Although I didn't audit
the code whether this really happens.

-- Hannes
