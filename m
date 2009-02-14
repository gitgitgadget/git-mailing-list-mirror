From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] config: Use parseopt.
Date: Sat, 14 Feb 2009 23:32:12 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902142328530.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0902141230250.10279@pacific.mpi-cbg.de>  <1234612989-32297-1-git-send-email-felipe.contreras@gmail.com>  <alpine.DEB.1.00.0902142041370.10279@pacific.mpi-cbg.de> <94a0d4530902141231t143067e5n872558a4e515be4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 23:32:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYT45-0008OK-5O
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 23:32:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668AbZBNWbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 17:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752516AbZBNWbT
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 17:31:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:40100 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752477AbZBNWbT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 17:31:19 -0500
Received: (qmail invoked by alias); 14 Feb 2009 22:31:17 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp045) with SMTP; 14 Feb 2009 23:31:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19otrpsWLdojnmHwk9jkg00eCfWReEOt5zMpVx5rU
	PWZjiASQcsPdnx
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <94a0d4530902141231t143067e5n872558a4e515be4a@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109943>

Hi,

On Sat, 14 Feb 2009, Felipe Contreras wrote:

> On Sat, Feb 14, 2009 at 9:59 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > On Sat, 14 Feb 2009, Felipe Contreras wrote:
> >
> >> @@ -231,7 +264,7 @@ static int get_diff_color_found;
> >>  static int git_get_colorbool_config(const char *var, const char *value,
> >>               void *cb)
> >>  {
> >> -     if (!strcmp(var, get_color_slot)) {
> >> +     if (!strcmp(var, get_colorbool_slot)) {
> >>               get_colorbool_found =
> >>                       git_config_colorbool(var, value, stdout_is_tty);
> >>       }
> >
> > Name changes like this make it harder to read the patch; can you separate
> > that change out into its own patch?
> 
> In that case I couldn't use OPT_STRING to store that value; I would
> have to change --get-color* to use OPT_BOOLEAN or OPT_SET_INT and
> store check the argc (since OPT_STRING isn't doing that anymore) and
> save argv[1] to get_color_slot,

What I meant was: have a patch renaming get_color_slot to 
get_colorbool_slot _before_ the (already large) parseoptification.

> >> +                     die("unable to read config file %s: %s", file,
> >> +                         strerror(errno));
> >
> > Do we really only want to die() in case we know the file name?  AFAICT at
> > this point we have no idea in which of the possibly three files the error
> > occurred.  And there need not be any errno set, for example when there was
> > a parse error.
> 
> Yes, there should be an error even if 'file' is not set. But if the
> file is set what's wrong with that die command?

I think we should die() in all cases, not just one, and we might want to 
skip the "file" parameter (and the "errno") parameter, as the file 
containing the error could be different from "file".

> >> +     else if (actions & ACTION_EDIT) {
> >> +             const char *config_filename;
> >> +             if (config_exclusive_filename)
> >> +                     config_filename = config_exclusive_filename;
> >> +             else
> >> +                     config_filename = git_path("config");
> >
> > Why not reuse config_exclusive_filename here?
> 
> You mean:
> if (!config_exclusive_filename)
>   config_exclusive_filename = git_path("config");

Yes.

> >> +     else if (actions & ACTION_ADD) {
> >> +             check_argc(argc, 2, 2);
> >
> > BTW what about check_argc() in the previous two cases?
> 
> You mean fail if -e or -l have extra arguments?

Yes.

> >> +             return git_config_set_multivar(argv[0], value, "^$", 0);
> >
> > Now that I see this, there is another idea for a possible cleanup 
> > after the parseoptification: cmd_config() should not return -1, as 
> > that will be turned into the exit status.  So maybe prefix the return 
> > value with "!!"?
> >
> > Or maybe even better: set a variable "ret" and at the end of 
> > cmd_config(), "return !!ret;"?
> 
> Huh? So git commands don't return negative error values?

AFAICT an exit status is supposed to be between 0 and 127.

Ciao,
Dscho
