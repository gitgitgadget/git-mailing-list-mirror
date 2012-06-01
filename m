From: nguyenhu@minatec.inpg.fr
Subject: Re: [PATCHv3] Read from XDG configuration file, not write
Date: Sat, 02 Jun 2012 00:07:13 +0200
Message-ID: <20120602000713.Horde.oEKVanwdC4BPyT0RI-CkWSA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; DelSp=Yes
Cc: git@vger.kernel.org, Lucien KONG <Lucien.Kong@ensimag.imag.fr>,
	Valentin DUPERRAY <Valentin.Duperray@ensimag.imag.fr>,
	Thomas NGUY <Thomas.Nguy@ensimag.imag.fr>,
	Franck JONAS <Franck.Jonas@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 02 00:07:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Saa0g-000365-7f
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jun 2012 00:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965503Ab2FAWHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 18:07:19 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:58570 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965479Ab2FAWHS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jun 2012 18:07:18 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id CC2561A0258;
	Sat,  2 Jun 2012 00:07:13 +0200 (CEST)
Received: from etu-189-20.vpn-inp.grenoble-inp.fr
 (etu-189-20.vpn-inp.grenoble-inp.fr [147.171.189.20]) by
 webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Sat, 02 Jun
 2012 00:07:13 +0200
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199027>

Junio C Hamano <gitster@pobox.com> wrote:
> Hrm, xdg_git_path() returns allocated memory, and each call site
> leaks its return value, no?
>
> I didn't mean a micro-helper function like xdg_git_path() when I
> suggested refactoring.  I meant a helper that figures out all the
> necessary bits in one go.  For example, can't the above call site
> look more like this?
>
>       static int get_value(const char *key_, const char *regex_)
>       {
>               int ret = -1;
>               char *global = NULL, *xdg = NULL, *repo_config = NULL;
>               const char *system_wide = NULL, *local;
>               struct config_include_data inc = CONFIG_INCLUDE_INIT;
>               config_fn_t fn;
>               void *data;
>
>               local = given_config_file;
>               if (!local) {
>                       local = repo_config = git_pathdup("config");
>                       if (git_config_system())
>                               system_wide = git_etc_gitconfig();
>                       home_config_paths(&global, &xdg);
>               }
>               ...
>
> And then the config.c::home_config_paths() may look like:
>
>       void home_config_paths(char **global, char **xdg)
>       {
>               char *xdg_home = getenv("XDG_CONFIG_HOME");
>               char *home = getenv("HOME");
>               char *to_free = NULL;
>
>               if (!home) {
>                       *global = NULL;
>               } else {
>                       if (!xdg_home) {
>                               to_free = strdup(mkpath("%s/.config", home));
>                               xdg_home = to_free;
>                       }
>                       *global = xstrdup(mkpath("%s/.gitconfig", home));
>               }
>
>               if (!xdg_home)
>                       *xdg = NULL;
>               else
>                       *xdg = xstrdup(mkpath("%s/git/config", xdg_home));
>               free(to_free);

We adapted this code to allow reuse and introduce default values to
core.excludesfile and core.attributesfile in the XDG directory too,
in our V4 version.
